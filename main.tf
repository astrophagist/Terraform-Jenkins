provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "foo" {
  ami           = "ami-0427090fd1714168b" # us-east-1
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
