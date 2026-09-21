aws_region       = "us-east-1"
ami_id           = "ami-0fef201115eefe936"
instance_name    = "ec2-with-multiple-ebs"
instance_type    = "t3.micro"
root_volume_size = 20
key_name         = "devops-key"

ebs_volumes = [
  # ebs volumes vodhu anukunte just [] ivi matrame pettandi leka yenni kavalo anni volumes pettandi
  {
    device_name = "/dev/sdf"
    size        = 20
    type        = "gp3"
  },
  {
    device_name = "/dev/sdg"
    size        = 30
    type        = "gp3"
  }
]

# first type :nee daggara kms key unte ebs encrypt ni true chesi , kms key ni pettandi
# rendodhi  true + null pedethe kms key create ipothadi
# moododhi encryption lekunda create avuthai

encrypt_ebs = true
kms_key_arn = null
