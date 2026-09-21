variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID selected by the user. The module verifies that it uses HVM virtualization."
  type        = string
}

variable "instance_name" {
  description = "Name tag for EC2 instance"
  type        = string
  default     = "ec2-with-optional-ebs"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "root_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
  default     = 20
}

variable "ebs_volumes" {
  description = "Optional additional EBS volumes. Use [] for no additional volumes."
  type = list(object({
    device_name = string
    size        = number
    type        = optional(string, "gp3")
  }))
  default = []
}

variable "encrypt_ebs" {
  description = "Encrypt additional EBS volumes. If true and kms_key_arn is blank/null, Terraform creates a KMS key."
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "Existing KMS key ARN. Leave null or blank to create one when encrypt_ebs=true."
  type        = string
  default     = null
}

variable "key_name" {
  description = "AWS EC2 key pair name"
  type        = string
  default     = "devops-key"
}
