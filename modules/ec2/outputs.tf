output "instance_id" {
  value = aws_instance.this.id
}

output "public_ip" {
  value = aws_instance.this.public_ip
}

output "private_ip" {
  value = aws_instance.this.private_ip
}

output "ebs_volume_ids" {
  value = { for device, volume in aws_ebs_volume.data : device => volume.id }
}

output "kms_key_arn" {
  value = local.ebs_kms_key_arn
}
