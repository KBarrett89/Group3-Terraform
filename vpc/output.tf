output "vpc_id" {
    value = aws_vpc.prod-vpc.id
}
output "public_route_id" {
    value = aws_route_table.public_route_table.id
}
output "private_route_id" {
	value = aws_route_table.private_route_table.id
}
output "sec_web_id" {
    value = aws_security_group.allow_web.id
}
output "sec_jenkins_id"{
	value = aws_security_group.jenkins.id
}
output "sec_ssh_id"{
	value = aws_security_group.allow_ssh.id
}
output "sec_internal_ssh_id" {
	value = aws_security_group.allow_internal_ssh.id
}
output "sec_allow_docker_swarm_id" {
	value = aws_security_group.allow_docker_swarm.id
}
output "sec_allow_jenkins_to_manager_ssh_id"{
	value = aws_security_group.allow_jenkins_to_manager_ssh.id
}
output "sec_application_ports_id"{
	value = aws_security_group.application_ports.id
}
output "internet_gate" {
    value = aws_internet_gateway.gw
}
