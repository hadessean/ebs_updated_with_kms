resource "aws_kms_key" "ebs" {
  count = var.encrypt_ebs && (
    var.kms_key_arn == null || var.kms_key_arn == ""
  ) ? 1 : 0

  description             = "Shared KMS key for all EBS volumes"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name = "shared-ebs-kms"
  }
}


resource "aws_kms_alias" "ebs" {
  count = var.encrypt_ebs && (
    var.kms_key_arn == null || var.kms_key_arn == ""
  ) ? 1 : 0

  name          = "alias/shared-ebs-kms"
  target_key_id = aws_kms_key.ebs[0].key_id
}
# ============================================================
# OORIKE CHECKING KOSAM
# ============================================================


# ============================================================
# SELECT KMS KEY
# ============================================================

locals {
  shared_kms_key_arn = var.encrypt_ebs ? (
    var.kms_key_arn != null && var.kms_key_arn != ""
    ? var.kms_key_arn
    : aws_kms_key.ebs[0].arn
  ) : null
}
module "ec2" {
  source = "./modules/ec2"

  ami_id           = var.ami_id
  instance_name    = var.instance_name
  instance_type    = var.instance_type
  root_volume_size = var.root_volume_size

  ebs_volumes = var.ebs_volumes
  encrypt_ebs = var.encrypt_ebs
  kms_key_arn = var.kms_key_arn

  key_name = var.key_name
}
