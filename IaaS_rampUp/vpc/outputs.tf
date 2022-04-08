#Deixo a vpc visivel para os outros elementos
output "vpc_id" {
  value = aws_vpc.vpc-ramUp.id
}

#Deixo a internet gateway visivel
output "igw-id" {
  value = aws_internet_gateway.igw.id
}

#Deixo a tabla de ruteo visivel
output "public_route_table_id"{
  value =  aws_route_table.rt_public.id
}

#Deixo a publica subnet visivel
output "public_subnet" {
  value = aws_subnet.public_subnet_ebc.id
}