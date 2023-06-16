resource "aws_eks_cluster" "eks" {
   
  name     = "my-cluster"
  role_arn = aws_iam_role.eks-iam-role.arn
  
  vpc_config {
    subnet_ids = var.eks_subnet_ids
    endpoint_public_access = true
    endpoint_private_access = false
    security_group_ids = [aws_security_group.eks_additional_sg.id]
  }

  depends_on = [
    aws_iam_role.eks-iam-role,
    aws_security_group.eks_additional_sg
  ]
  tags = {
    "kubernetes.io/cluster/dtdc-ewallet-prod" = "owned"
    "map-migrated" = "d-server-02hkxkc0dgeg3a"

  }
}

resource "aws_eks_node_group" "worker-node-group" {

  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "my-nodegroup"
  node_role_arn   = aws_iam_role.workernodes.arn
  subnet_ids      = var.eks_subnet_ids
  instance_types  = var.eks_instance_types
  ami_type        = "AL2_x86_64"
  tags = {
    "Name" = "my-nodegroup"
  }
  
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "eks_additional_sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = var.vpc_cidr
  }
}
