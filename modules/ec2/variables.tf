variable "ami_id" {
  description = "AMI ID selected by the user"
  type        = string
}

variable "instance_name" {
  description = "EC2 Name tag"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
}

variable "ebs_volumes" {
  description = "Optional additional EBS volumes"
  type = list(object({
    device_name = string
    size        = number
    type        = optional(string, "gp3")
  }))
  default = []
}

variable "encrypt_ebs" {
  description = "Whether additional EBS volumes should be encrypted"
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "Existing KMS key ARN. Null/blank creates a key when encryption is enabled."
  type        = string
  default     = null
}

variable "public_key" {
  description = "SSH public key"
  type        = string
}

variable "key_name" {
  description = "AWS EC2 key pair name"
  type        = string
  default     = "devops-key"
}
