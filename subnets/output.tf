output "server_public_ip" {
  value = aws_eip.one.public_ip
}
output "nic_bastian_id" {
  value = aws_network_interface.bastian-nic.id
}
output "nic_jenkins_id" {
  value = aws_network_interface.jenkins-nic.id
}
output "nic_manager_id" {
  value = aws_network_interface.manager-nic.id
}
output "nat_gateway" {
	value = aws_nat_gateway.nat
}

output "public_subnet_id" {
	value = aws_subnet.subnet-public.id
}
output "private_subnet_id" {
	value = aws_subnet.subnet-private.id
}

