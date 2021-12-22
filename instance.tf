resource "aws_instance" "instance" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id = "${aws_subnet.subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  
  # the Public SSH key
  # key_name = "${aws_key_pair.kp.id}"

  # pull 'k8s_pre' role from ansible-galaxy
  provisioner "local-exec" {
    command = "ansible-galaxy install zivlederer.k8s_pre_role"
  }

  # run 'k8s_pre'- k8s pre installation role
  provisioner "local-exec" {
    command = "sudo ansible localhost -m include_role -a name=zivlederer.k8s_pre_role --become"
  }

  tags = {
    Name  = "Terraform-${count.index + 1}"
  }
}

# TODO: kp
# resource "aws_key_pair" "kp" {
#   key_name   = "terra-key"
#   public_key = "ssh-rsa AAAA  B3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
# }