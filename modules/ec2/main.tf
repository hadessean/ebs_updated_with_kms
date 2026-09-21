resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = var.public_key

  tags = {
    Name = var.key_name
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.selected.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.this.key_name

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = var.instance_name
  }
}

resource "aws_ebs_volume" "data" {
  for_each = local.ebs_volumes_by_device

  availability_zone = aws_instance.this.availability_zone
  size              = each.value.size
  type              = each.value.type

  encrypted  = var.encrypt_ebs
  kms_key_id = local.ebs_kms_key_arn

  tags = {
    Name = "${var.instance_name}-${replace(each.key, "/dev/", "")}"
  }
}

resource "aws_volume_attachment" "data" {
  for_each = local.ebs_volumes_by_device

  device_name = each.value.device_name
  volume_id   = aws_ebs_volume.data[each.key].id
  instance_id = aws_instance.this.id
}
