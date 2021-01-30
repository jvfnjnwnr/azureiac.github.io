resource "aws_cloudformation_stack" "network" {
  name = "networking-stack"

  parameters = {
    BucketName = "QuickCloudPOCCloudFormationDemoBucket"
  }

  template_body = file("CloudFormationTemplates/S3.yaml")
}