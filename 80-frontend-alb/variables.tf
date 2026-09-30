variable "instance_type"{
    default="t3.micro"
}

variable "ingress_alb_tags"{
    type=map(string)
    default={}
}

variable "project"{
    default="roboshop"
}

variable "env"{
    default="dev"
}

variable "domain_name"{
    default="bongu.online"
}
