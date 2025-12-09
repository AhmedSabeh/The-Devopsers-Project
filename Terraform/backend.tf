terraform {
  backend "s3" {
    bucket         = "devopsers-s3-bucket2"
    key            = "devopsers-statefile"
    region         = "us-east-1"
    encrypt        = true
  }
}
