variable "aws_region" {
  type        = string
  description = "AWS Provider region"
  default     = "us-east-1"
}

variable "instances_config" {
  type = map(object({
    name              = string
    type              = string
    ami               = string
    availability_zone = string
  }))
  description = "Instances Names, Types and AMI to create"
  default = {
    web = {
      name              = "Web server"
      type              = "t3.medium"
      ami               = "ami-08c40ec9ead489470" # Ubuntu 22.04 free tier
      availability_zone = "us-east-1a"
    }
    ci_cd = {
      name              = "CI/CD server"
      type              = "t3.micro"
      ami               = "ami-08c40ec9ead489470" # Ubuntu 22.04 free tier
      availability_zone = "us-east-1a"
    }
  }
}
