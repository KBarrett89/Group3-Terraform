resource "aws_instance" "bastian_host" {
  ami                  = "ami-0a8e758f5e873d1c1"
  instance_type        = "t2.nano"
  availability_zone    = "eu-west-1a"
  key_name             = "AWSKeyPair"

  network_interface {
	device_index         = 0
    network_interface_id = var.nic_bastian_id
  }

  tags = {
	Name = "bastain"	
  }
}

resource "aws_instance" "jenkins" {
  ami                  = "ami-0a8e758f5e873d1c1"
  instance_type        = "t2.medium"
  availability_zone    = "eu-west-1a"
  key_name             = "AWSKeyPair"
  user_data			   = "${file("installJenkins.sh")}"

  network_interface {
	device_index         = 0
    network_interface_id = var.nic_jenkins_id
  }

  tags = {
	Name = "jenkins"	
  }
}

resource "aws_instance" "manager" {
  ami                  = "ami-0a8e758f5e873d1c1"
  instance_type        = "t2.micro"
  availability_zone    = "eu-west-1b"
  key_name             = "AWSKeyPair"
  user_data			   = "${file("managerSetup.sh")}"

  network_interface {
	device_index         = 0
    network_interface_id = var.nic_manager_id
  }

  tags = {
	Name = "manager"	
  }
}
