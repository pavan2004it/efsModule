variable "app_subnet" {
  type = list(string)
}
variable "sg-id" {
  type = string
}
variable "efs-name" {
  type = string
}
variable "throughput_mode" {
  type = string
}
variable "transition_to_ia" {
  type = string
  default = "AFTER_90_DAYS"
}
variable "transition_out_of_ia" {
  type = string
  default = "AFTER_1_ACCESS"
}
variable "efs_access_point_path" {
  type = string
  default = "/"
}