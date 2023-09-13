/* ---------------------------------------------------------
    FILE: variables.tf @ lambda-nba-players module

    This file has all variables definitions for all
    submodules defined in this IaC project. For each one,
    a different section splitted by super comments will be
    provided in order to improve code organization.
--------------------------------------------------------- */

variable "layers_path" {
  description = "A local path in this Terraform project where ZIP files for Lambda layers are stored"
  type        = string
}

variable "s3_layers_bucket_name" {
  description = "A S3 bucket name to store Lambda layers in ZIP format"
  type        = string
}

variable "s3_layers_bucket_prefix" {
  description = "A bucket prefix to store Lambda layers"
  type        = string
  default     = "lambda/layers"

  validation {
    condition     = substr(var.s3_layers_bucket_prefix, -1, -1) != "/"
    error_message = "The prefix information must NOT end with a '/' char"
  }
}
