variable "eks_subnet_ids" {
    type = list(string)
    default = [ "subnet-04f61a1a772b5299c","subnet-0f914a65aa3ea97fa" ]
}
variable "eks_instance_types" {
    type = list(string)
    default = ["t3.medium"]
  
}
variable "vpc_id" {
    type = string
    default = "vpc-0714d886b5aa7964d"
  
}
variable "vpc_cidr" {
    type = list(string)
    default = ["0.0.0.0/0"]
  
}
