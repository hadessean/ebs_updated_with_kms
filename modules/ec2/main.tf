resource "tls_private_key" "this" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh

  tags = {
    Name = var.key_name
  }
}

resource "aws_secretsmanager_secret" "ssh_private_key" {
  name                    = "${var.instance_name}/ssh-private-key"
  description             = "SSH private key for ${var.instance_name}"
  recovery_window_in_days = 7

  tags = {
    Name = "${var.instance_name}-ssh-private-key"
  }
}

resource "aws_secretsmanager_secret_version" "ssh_private_key" {
  secret_id = aws_secretsmanager_secret.ssh_private_key.id

  secret_string = tls_private_key.this.private_key_openssh
}
resource "aws_instance" "this" {
  ami           = data.aws_ami.selected.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.this.key_name

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    delete_on_termination = true

    # Encrypt root volume with the shared KMS key
    encrypted  = var.encrypt_ebs
    kms_key_id = var.encrypt_ebs ? var.kms_key_arn : null
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

  # Encrypt additional volumes with the SAME shared KMS key
  encrypted  = var.encrypt_ebs
  kms_key_id = var.encrypt_ebs ? var.kms_key_arn : null

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
