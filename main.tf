terraform {
  required_version = ">= 0.12.1"
}
resource "aws_lambda_function" "this" {
    function_name   =   "${var.owner}-${var.env}-${var.project}"
    s3_bucket       =   "${var.source_bucket}"
    s3_key          =   "${var.source_prefix}"
    filename        =   "${var.filename}"
    source_code_hash=   "${var.filename  == null ? null : filebase64sha256(var.filename)}"
    role            =   "${var.role_lambda}"
    handler         =   "${var.handler}"
    runtime         =   "${var.runtime}"
    timeout         =   "${var.timeout}"
    memory_size     =   "${var.memory_size}"

    dynamic "environment" {
    for_each = var.environment_variables == null ? {} : var.environment_variables
    content {
      variables = "${var.environment_variables}"
      }
    }

}