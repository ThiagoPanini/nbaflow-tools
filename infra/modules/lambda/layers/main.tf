/* ---------------------------------------------------------
    FILE: main.tf @ lambda/layers module

    GOAL:
        Provide an unique way to build and create Lambda
        layers to be used in Lambda functions

    RESOURCES:
        - Lambda layer
--------------------------------------------------------- */

# Uploading zip files under a given path to S3
resource "aws_s3_object" "lambda_layers" {
  for_each = fileset(var.layers_path, "*.zip")
  bucket   = var.s3_layers_bucket_name
  key      = "${var.s3_layers_bucket_prefix}/${each.value}"
  source   = "${var.layers_path}/${each.value}"

  server_side_encryption = "aws:kms"
}

# Creating Lambda layers
resource "aws_lambda_layer_version" "nbaflow_layer" {
  for_each   = fileset(var.layers_path, "*.zip")
  s3_bucket  = var.s3_layers_bucket_name
  s3_key     = "${var.s3_layers_bucket_prefix}/${each.value}"
  layer_name = split(".", each.value)[0]

  compatible_architectures = ["x86_64"]
  compatible_runtimes      = ["python3.9"]

  depends_on = [
    aws_s3_object.lambda_layers
  ]
}

