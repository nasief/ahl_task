# When ready, export some values to other modules
output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "pub_sub_id" {
  value = aws_subnet.pub_sub.id
}

output "pri_sub_app_id" {
  value = aws_subnet.pri_sub_app.id
}

output "pri_sub_db_id" {
  value = aws_subnet.pri_sub_db.id
}

output "igw_id" {
  value = aws_internet_gateway.internet_gateway
}
