

resource "aws_security_group" "terra_sg" {
  name = "terra-sg"
  description = "terraform course security group"
  vpc_id = "vpc-0dda100268be3bfdd"

  ingress = [ 
    {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Inbound Terraform Security Group"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
    
  },
  {
    protocol = -1
    from_port = 0
    to_port = 0
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Outbound Terraform Security Group"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false 
  },
  {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Inbound Terraform Security Group"
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false 
  }
]

egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = []
  }

 tags = {
   "Environment" = "DEV"
 }
}

resource "aws_instance" "terra_ec2" {
    ami = "ami-02d7fd1c2af6eead0"
    instance_type = "t2.micro"
    key_name = "ec2_key_pair"
    subnet_id = "subnet-0d260ebfe3ece0ded"
    associate_public_ip_address = true
    availability_zone = "us-east-1e"
    vpc_security_group_ids = [aws_security_group.terra_sg.id]
    root_block_device {
      volume_size = 10
      volume_type = "gp2"
      delete_on_termination = true
    }
    user_data = <<-EOF
        #!/bin/bash
        sudo dnf update -y
        sudo dnf list | grep httpd
        sudo dnf install -y httpd.x86_64
        sudo systemctl start httpd.service
        sudo systemctl status httpd.service
        sudo systemctl enable httpd.service
        EOF

    tags = {
      "Name" = "terra-ec2"
    }

}
