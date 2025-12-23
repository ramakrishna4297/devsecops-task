terraform {
  required_version = ">= 1.5"
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  name    = "eks-vpc"
  cidr    = "10.0.0.0/16"
  azs     = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "demo-eks"
  cluster_version = "1.29"
  subnet_ids      = module.vpc.private_subnets
}

