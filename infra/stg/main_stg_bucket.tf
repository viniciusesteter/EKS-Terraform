terraform {
  
  backend "s3" {
    region="sa-east-1"
    profile="default"
    bucket="k8s-aws-admin"
    key="k8s-infra-state-stg"
  }
}