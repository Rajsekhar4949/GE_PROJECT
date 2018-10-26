data "aws_caller_identity" "current_user" {}

data "aws_region" "current" {
  current = true
}

resource "aws_lambda_permission" "with_sns" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.func.function_name}"
  principal     = "sns.amazonaws.com"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.func.function_name}"
  principal     = "events.amazonaws.com"
}

resource "aws_sns_topic" "default" {
  name = "call-lambda-maybe"
}

resource "aws_sns_topic_subscription" "lambda" {
  topic_arn = "${aws_sns_topic.default.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.func.arn}"
}

resource "aws_lambda_function" "func" {
  function_name    = "demo_lambda"
  handler          = "index.handler"
  runtime          = "nodejs4.3"
  filename         = "function.zip"
  source_code_hash = "${base64sha256(file("function.zip"))}"
  role             = "${aws_iam_role.default.arn}"
}

#aws_lambda_function
resource "aws_iam_role" "default" {
  name = "iam_for_lambda_with_sns"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

#aws_lambda_alias
resource "aws_lambda_alias" "test_alias" {
  name             = "ge_lamda_alias"
  function_name    = "${aws_lambda_function.func.arn}"
  function_version = "$LATEST"
}

output "lambda_function_name" {
  value = "${aws_lambda_function.func.function_name}"
}

output "lambda_invoke_arn" {
  value = "${aws_lambda_function.func.invoke_arn}"
}
