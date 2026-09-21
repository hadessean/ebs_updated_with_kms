data "aws_ami" "selected" {
  filter {
    name   = "image-id"
    values = [var.ami_id]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
