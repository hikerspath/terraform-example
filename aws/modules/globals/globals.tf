#
# Account all configuration is to reside in
#
variable "global_aws_account_id" {
  type        = string
  description = "This is the AWS AccountID for the account used througout.  Hard-coded to ensure proper authenticated account."
  default     = "161122428365"
}

output "global_aws_account_id" {
  value = var.global_aws_account_id
}
