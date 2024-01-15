resource "aws_launch_template" "lt-eks-ng" {
  name          = "${var.cluster_name}-eks-lt"
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 50
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      "Name" = "lt-eks-ng"
    }
  }
  image_id               = data.aws_ssm_parameter.eksami.value
  user_data              = base64encode(local.eks-node-private-userdata)
  vpc_security_group_ids = [aws_security_group.node-sg.id]

  lifecycle {
    create_before_destroy = true
  }
}