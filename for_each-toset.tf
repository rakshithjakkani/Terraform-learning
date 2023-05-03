locals {
  common_tags = {
    Environment = "dev"
    Team        = "backend"
  }

  custom_tags = {
    App  = "my-app"
    Tier = "web"
  }
# the merge function will merge the 2 maps which are defained at the locals 
  all_tags = merge(
    local.common_tags,
    local.custom_tags,
  )

  # tag_keys   = toset(keys(local.all_tags))
  # tag_values = toset(values(local.all_tags))
}


# resource block to create 2 ecr repos 
resource "aws_ecr_repository" "ecr_test" {
# toset function will make the each in a set["some","what"] and telling to toset function to deal with only keys of a map
# if i mention values in place of keys then ill get ecr repos with the names of a values of a map 
  for_each = toset(keys(local.all_tags))
  name = each.key
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

}


