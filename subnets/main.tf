resource "aws_subnet" "subnet-public" {
  vpc_id            = var.vpc_id
  cidr_block        = "15.0.1.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "subnet-private" {
  vpc_id            = var.vpc_id
  cidr_block        = "15.0.2.0/24"
  availability_zone = "eu-west-1b"
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-public.id
  route_table_id = var.public_route_id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet-private.id
  route_table_id = var.private_route_id
}

resource "aws_network_interface" "jenkins-nic" {
  subnet_id       = aws_subnet.subnet-public.id
  private_ips     = ["15.0.1.50"]
  security_groups = [var.sec_web_id, var.sec_jenkins_id, var.sec_internal_ssh_id]
}

resource "aws_network_interface" "bastian-nic" {
  subnet_id       = aws_subnet.subnet-public.id
  private_ips     = ["15.0.1.51"]
  security_groups = [var.sec_web_id, var.sec_jenkins_id, var.sec_ssh_id]
}
resource "aws_network_interface" "manager-nic" {
  subnet_id       = aws_subnet.subnet-private.id
  private_ips     = ["15.0.2.50"]
  security_groups = [var.sec_web_id, var.sec_jenkins_id, var.sec_internal_ssh_id, var.sec_docker_swarm_id]
}
resource "aws_network_interface" "nat-gateway" {
  subnet_id       = aws_subnet.subnet-public.id
  private_ips	  = ["15.0.1.34"]
}
resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.jenkins-nic.id
  associate_with_private_ip = "15.0.1.50"
  depends_on                = [var.internet_gate]
}
resource "aws_eip" "eip_bastian" {
  vpc                       = true
  network_interface         = aws_network_interface.bastian-nic.id
  associate_with_private_ip = "15.0.1.51"
  depends_on                = [var.internet_gate]
}
resource "aws_eip" "eip_nat_gateway" {
  vpc                       = true
  depends_on                = [var.internet_gate]
}

resource "aws_nat_gateway" "nat" {
  allocation_id     = aws_eip.eip_nat_gateway.id
  subnet_id         = aws_subnet.subnet-public.id
  depends_on        = [var.internet_gate]  
}
