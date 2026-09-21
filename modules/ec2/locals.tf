locals {
  provided_kms_key_arn = var.kms_key_arn == null ? null : (trimspace(var.kms_key_arn) == "" ? null : trimspace(var.kms_key_arn))

  create_kms_key = var.encrypt_ebs && local.provided_kms_key_arn == null && length(var.ebs_volumes) > 0

  ebs_kms_key_arn = var.encrypt_ebs ? (
    local.provided_kms_key_arn != null ? local.provided_kms_key_arn : (
      local.create_kms_key ? aws_kms_key.ebs[0].arn : null
    )
  ) : null

  ebs_volumes_by_device = {
    for volume in var.ebs_volumes : volume.device_name => volume
  }
}
