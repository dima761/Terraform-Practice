provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "test" {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
   tags = {
     Name = "my-ec2-instance"
   }
resource "aws_security_group" "instance" {
  name = "terrafom-example-instance"
  

  ingress {
    from_port    = 8080
    to_port      = 8080
    protocol     = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }
}
