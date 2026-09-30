/*
resource "aws_security_group_rule" "bastion_group" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id=local.source_security_group
  security_group_id = local.security_group
}
*/

# resource "aws_security_group_rule" "bastion_catalogue" {
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.catalogue_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
# }
# resource "aws_security_group_rule" "catalogue_to_mongodb" {
#   type                     = "ingress"
#   from_port                = 27017
#   to_port                  = 27017
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.mongodb_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.catalogue_sg_id.value
# }
# resource "aws_security_group_rule" "backend-alb-to-catalogue" {
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.catalogue_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.backend_lb_sg_id.value
# }
# resource "aws_security_group_rule" "catalogue-to-backend_lb" {
#   type                     = "ingress"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.backend_lb_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.catalogue_sg_id.value
# }

# resource "aws_security_group_rule" "bastion_user" {
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.user_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
# }
# resource "aws_security_group_rule" "user_to_mongodb" {
#   type                     = "ingress"
#   from_port                = 27017
#   to_port                  = 27017
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.mongodb_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.user_sg_id.value
# }
# resource "aws_security_group_rule" "user_to_redis" {
#   type                     = "ingress"
#   from_port                = 6379
#   to_port                  = 6379
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.redis_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.user_sg_id.value
# }
# resource "aws_security_group_rule" "backend-alb-to-user" {
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.user_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.backend_lb_sg_id.value
# }
# resource "aws_security_group_rule" "user-to-backend_lb" {
#   type                     = "ingress"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.backend_lb_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.user_sg_id.value
# }

# resource "aws_security_group_rule" "bastion_cart" {
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.cart_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
# }
# resource "aws_security_group_rule" "cart_to_redis" {
#   type                     = "ingress"
#   from_port                = 6379
#   to_port                  = 6379
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.redis_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.cart_sg_id.value
# }
# resource "aws_security_group_rule" "backend-alb-to-cart" {
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.cart_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.backend_lb_sg_id.value
# }
# resource "aws_security_group_rule" "cart-to-backend_lb" {
#   type                     = "ingress"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.backend_lb_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.cart_sg_id.value
# }

# resource "aws_security_group_rule" "bastion_shipping" {
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.shipping_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
# }
# resource "aws_security_group_rule" "shipping_to_mysql" {
#   type                     = "ingress"
#   from_port                = 3306
#   to_port                  = 3306
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.mysql_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.shipping_sg_id.value
# }
# resource "aws_security_group_rule" "backend-alb-to-shipping" {
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.shipping_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.backend_lb_sg_id.value
# }
# resource "aws_security_group_rule" "shipping-to-backend_lb" {
#   type                     = "ingress"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.backend_lb_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.shipping_sg_id.value
# }

# resource "aws_security_group_rule" "bastion_payment" {
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.payment_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
# }
# resource "aws_security_group_rule" "payment_to_rabbitmq" {
#   type                     = "ingress"
#   from_port                = 5672
#   to_port                  = 5672
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.rabbitmq_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.payment_sg_id.value
# }
# resource "aws_security_group_rule" "backend-alb-to-payment" {
#   type                     = "ingress"
#   from_port                = 8080
#   to_port                  = 8080
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.payment_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.backend_lb_sg_id.value
# }
# resource "aws_security_group_rule" "payment-to-backend_lb" {
#   type                     = "ingress"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.backend_lb_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.payment_sg_id.value
# }

# /*
# resource "aws_security_group_rule" "cataloguet_to_bastion" {
#   type                     = "ingress"
#   from_port                = 27017
#   to_port                  = 27017
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.bastion_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.catalogue_sg_id.value
# }
# */

# resource "aws_security_group_rule" "fronted-to-backend_lb" {
#   type                     = "ingress"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.backend_lb_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.frontend_sg_id.value
# }

# resource "aws_security_group_rule" "fronted-to-bastion" {
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.frontend_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.bastion_sg_id.value
# }
# resource "aws_security_group_rule" "backend_lb-to-bastion" {
#   type                     = "ingress"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.bastion_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.backend_lb_sg_id.value
# }

# resource "aws_security_group_rule" "fronted-to-fronted_lb" {
#   type                     = "ingress"
#   from_port                = 80
#   to_port                  = 80
#   protocol                 = "tcp"
#   security_group_id        = data.aws_ssm_parameter.frontend_sg_id.value
#   source_security_group_id = data.aws_ssm_parameter.fronted_lb_sg_id.value
# }
resource "aws_security_group_rule" "bastion_mongodb" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"

  security_group_id        = local.mongodb_security_group
  source_security_group_id = local.source_security_group
}

resource "aws_security_group_rule" "laptop_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"

  security_group_id        = local.source_security_group
  source_security_group_id = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "bastion_redis" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"

  security_group_id        = local.redis_security_group
  source_security_group_id = local.source_security_group
}

resource "aws_security_group_rule" "bastion_rabbitmq" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"

  security_group_id        = local.rabbitmq_security_group
  source_security_group_id = local.source_security_group
}

resource "aws_security_group_rule" "bastion_mysql" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"

  security_group_id        = local.mysql_security_group
  source_security_group_id = local.source_security_group
}

resource "aws_security_group_rule" "internet-to-ingress-alb" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = local.ingress_alb_security_group
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "internet-to-vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = local.vpn_security_group
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "internet-to-vpn443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = local.vpn_security_group
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "internet-to-vpn943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  security_group_id = local.vpn_security_group
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "internet-to-vpn1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  security_group_id = local.vpn_security_group
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "eks-to-ingress-alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = local.eks_control_plane_security_group
  source_security_group_id = local.ingress_alb_security_group
}

resource "aws_security_group_rule" "eks-node-to-eks" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = local.eks_control_plane_security_group
  source_security_group_id = local.eks_node_security_group
}

resource "aws_security_group_rule" "eks-to-eks-node" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = local.eks_node_security_group
  source_security_group_id = local.eks_control_plane_security_group
}

resource "aws_security_group_rule" "eks-node-to-eks-node" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  security_group_id        = local.eks_node_security_group
  source_security_group_id = ["10.0.0.0/16"]
}

resource "aws_security_group_rule" "bastion-to-eks-node" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = local.eks_node_security_group
  source_security_group_id = local.source_security_group
}

resource "aws_security_group_rule" "bastion-to-eks" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = local.eks_control_plane_security_group
  source_security_group_id = local.source_security_group
}