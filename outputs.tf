output "instance_id" {
  value = module.ec2.instance_id
}

output "public_ip" {
  value = module.ec2.public_ip
}

output "private_ip" {
  value = module.ec2.private_ip
}

output "ebs_volume_ids" {
  value = module.ec2.ebs_volume_ids
}

output "kms_key_arn" {
  value = module.ec2.kms_key_arn
}
