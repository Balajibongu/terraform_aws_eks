variable "project"{
    default="roboshop"
}

variable "environment"{
    default="dev"
}

variable "sg_names"{
    default=["mongodb","redis","mysql","rabbitmq",
    /*"catalogue","user","cart","payment","shipping","frontend","backend_lb",*/
    "bastion","ingress_alb","vpn","eks_control_plane","eks_node"]
}