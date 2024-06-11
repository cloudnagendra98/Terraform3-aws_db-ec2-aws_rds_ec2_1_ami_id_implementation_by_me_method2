variable "vpc_cidr_range" {
  type        = string
  default     = "10.0.0.0/16"
  description = "This is virtual private network"

}

# variable "subnet_cidr_ranges" {
#   type        = string
#   default     = "10.0.%g.0/24"
#   description = "These are subnet cidr ranges"

# }

variable "subnet_tags" {
  type        = list(string)
  default     = ["web1", "web2", "app1", "app2", "db1", "db2"]
  description = "These are subnet names"

}

variable "app_subnet_name" {
  type        = string
  default     = "app1"
  description = "This is app subnet"

}

variable "subnet_azs" {
  type        = list(string)
  default     = ["us-west-1b", "us-west-1c", "us-west-1b", "us-west-1c", "us-west-1b", "us-west-1c"]
  description = "These are availability zones"

}

variable "db_names" {
  type        = list(string)
  default     = ["db1", "db2"]
  description = "These are database names "

}


variable "webnsg_config" {
  type = object({
    name        = string
    description = string
    rules = list(object({
      type       = string
      from_port  = string
      to_port    = string
      protocol   = string
      cidr_block = string

    }))
  })
  default = {
    name        = "webnsg"
    description = "This is web security group"
    rules = [{
      type       = "ingress"
      from_port  = "80"
      to_port    = "80"
      protocol   = "tcp"
      cidr_block = "0.0.0.0/0"
      },
      {
        type       = "ingress"
        from_port  = "22"
        to_port    = "22"
        protocol   = "tcp"
        cidr_block = "0.0.0.0/0"

      },
      {
        type       = "egress"
        from_port  = "0"
        to_port    = "65535"
        protocol   = "-1"
        cidr_block = "0.0.0.0/0"

    }]
  }

}

variable "appnsg_config" {
  type = object({
    name        = string
    description = string
    rules = list(object({
      type       = string
      from_port  = string
      to_port    = string
      protocol   = string
      cidr_block = string

    }))
  })
  default = {
    name        = "appnsg"
    description = "This is web security group"
    rules = [{
      type       = "ingress"
      from_port  = "8080"
      to_port    = "8080"
      protocol   = "tcp"
      cidr_block = "0.0.0.0/0"
      },
      {
        type       = "ingress"
        from_port  = "22"
        to_port    = "22"
        protocol   = "tcp"
        cidr_block = "0.0.0.0/0"

      },
      {
        type       = "ingress"
        from_port  = "5000"
        to_port    = "5000"
        protocol   = "tcp"
        cidr_block = "10.0.0.0/16"

      },
      {
        type       = "egress"
        from_port  = "0"
        to_port    = "65535"
        protocol   = "-1"
        cidr_block = "0.0.0.0/0"

    }]
  }

}

variable "dbnsg_config" {
  type = object({
    name        = string
    description = string
    rules = list(object({
      type       = string
      from_port  = string
      to_port    = string
      protocol   = string
      cidr_block = string

    }))
  })
  default = {
    name        = "dbnsg"
    description = "This is web security group"
    rules = [{
      type       = "ingress"
      from_port  = "3306"
      to_port    = "3306"
      protocol   = "tcp"
      cidr_block = "10.0.0.0/16"
      },
      {
        type       = "ingress"
        from_port  = "22"
        to_port    = "22"
        protocol   = "tcp"
        cidr_block = "0.0.0.0/0"

      },
      {
        type       = "egress"
        from_port  = "0"
        to_port    = "65535"
        protocol   = "-1"
        cidr_block = "0.0.0.0/0"

    }]
  }

}

variable "db_info" {
  type = object({
    allocated_storage = string
    db_name           = string
    engine            = string
    engine_version    = string
    instance_class    = string
    username          = string
    password          = string
    identifier        = string

  })
  default = {
    allocated_storage = "20"
    db_name           = "employer"
    engine            = "mysql"
    engine_version    = "8.0"
    instance_class    = "db.t3.micro"
    username          = "user"
    password          = "rootroot"
    identifier        = "mydatabasefromtf"
  }

}

# variable "public_key_path" {
#   type        = string
#   default     = "~/.ssh/id_rsa.pub"
#   description = "This is public key pair path"

# }

# variable "key_name" {
#   type        = string
#   default     = "ntier"
#   description = "This is key pair name"
# }

# variable "ubuntu_ami" {
#   type        = string
#   default     = "ami-08012c0a9ee8e21c4"
#   description = "This is amazon machine id"
# }

# variable "ec2_instance_size" {
#   type        = string
#   default     = "t2.micro"
#   description = "This is instance type"

# }

variable "appserver_config" {
  type = object({
    key_name        = string
    public_key_path = string
    #ubuntu_ami_id     = string
    ec2_instance_size = string
  })
  default = {
    key_name        = "ntier"
    public_key_path = "~/.ssh/id_rsa.pub"
    #ubuntu_ami_id     = "ami-08012c0a9ee8e21c4"
    ec2_instance_size = "t2.micro"
  }

}