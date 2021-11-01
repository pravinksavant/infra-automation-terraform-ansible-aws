terraform {
  backend "s3" {
    bucket = "aws-tarraform-s3-backend"
	key = "terraform/backend"
	region = "ap-south-1"
  }
}
