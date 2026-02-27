terraform {
  backend "s3" {
    bucket = "mon-projet-devops-tfstate-rothiam"
    key    = "mission1/terraform.tfstate"
    region = "eu-west-1"
  }
}