variable "duration" {
  default     = 3600
  description = "The duration of the inspector run."
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

variable "tags" {
  description = "The tags on your EC2 Instance to run Inspector on."
  type        = "map"
}