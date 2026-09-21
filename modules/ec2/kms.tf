resource "aws_kms_key" "ebs" {
  count = local.create_kms_key ? 1 : 0

  description             = "KMS key for ${var.instance_name} additional EBS volumes"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name = "${var.instance_name}-ebs-kms"
  }
}

resource "aws_kms_alias" "ebs" {
  count = local.create_kms_key ? 1 : 0

  name          = "alias/${var.instance_name}-ebs"
  target_key_id = aws_kms_key.ebs[0].key_id
}
