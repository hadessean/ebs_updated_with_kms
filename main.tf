module "ec2" {
  source = "./modules/ec2"

  ami_id           = var.ami_id
  instance_name    = var.instance_name
  instance_type    = var.instance_type
  root_volume_size = var.root_volume_size

  ebs_volumes = var.ebs_volumes
  encrypt_ebs = var.encrypt_ebs
  kms_key_arn = var.kms_key_arn

  key_name   = var.key_name
  public_key = file("${path.root}/keys/id_ed25519.pub")
}
