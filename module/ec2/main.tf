# creating ssh key
resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf"
  public_key = file("${path.module}/id_rsa.pub")
}


provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "tftestecmy_instance" {
  depends_on      = [aws_security_group.allow_tls]
  ami             = var.ami
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  tags = {
    Name = "tfinstance1"
  }

}
