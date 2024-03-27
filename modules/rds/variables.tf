variable "db_sg_id" {}
variable "pri_sub_db_id" {}
variable "pri_sub_app_id" {}
variable "db_username" {}
variable "db_password" {}
variable "db_sub_name" {
  default = "ahl-db-subnet"
}
variable "db_name" {
  default = "ahl-db"
}
