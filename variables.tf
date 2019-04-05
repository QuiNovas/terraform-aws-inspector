variable "assessment_run_enabled" {
  default     = false
  description = "If true, then the assessment will be run based on the provided interval."
  type        = "string"
}

variable "assessment_run_interval" {
  default     = 7
  description = "The interval, in days, to run the assessment. Defaults to 7"
  type        = "string"
}

variable "dead_letter_arn" {
  description = "The arn for the SNS topic that handles dead letters for the assessment runner lambda function."
  type        = "string"
}

variable "duration" {
  default     = 3600
  description = "The duration of the inspector run."
  type        = "string"
}

variable "install_aws_cli" {
  default     = false
  description = "Installs the AWS CLI module-local. AWS CLI is required to run this module."
  type        = "string"
}

variable "kms_key_arn" {
  description = "The arn of the KMS key used to encrypt the environment variables for the assessment runner lambda function."
  type        = "string"
}

variable "name" {
  description = "The name of the assessment template and target."
  type        = "string"
}

variable "os_name" {
  default     = "generic"
  description = "The os targeted by this inspector instance. Can be one of [amazon_linux, amazon_linux_2_lts_2017_12, amazon_linux_2012_2014, amazon_linux_2015_2018, centos, generic, linux, debian, rhel, ubuntu, ubuntu_14_16_lts, ubuntu_18_04_lts, windows, windows_server_2008_2012, windows_server_2016_base]"
  type        = "string"
}

variable "events" {
  default     = []
  description = "A list of events to fire to an SNS topic. May contain ASSESSMENT_RUN_STARTED, ASSESSMENT_RUN_COMPLETED, ASSESSMENT_RUN_STATE_CHANGED, and/or FINDING_REPORTED."
  type = "list"
}

variable "tags" {
  description = "The tags on your EC2 Instance to run Inspector on."
  type        = "map"
}