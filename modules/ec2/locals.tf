locals {
  ebs_volumes_by_device = {
    for volume in var.ebs_volumes : volume.device_name => volume
  }
}
