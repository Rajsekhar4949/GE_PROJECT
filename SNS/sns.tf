/*
#aws_sns_platform _application
resource "aws_sns_platform_application" "test_platform" {
  name = "${var.application_name}"

  #platform            = "${var.app_platform}"
  platform_credential = "${var.platform_credential}"
}
*/
#aws_sns_sms_preferences
resource "aws_sns_sms_preferences" "update_sms_prefes" {}

resource "aws_sns_topic" "main" {
  name         = "${var.name}"
  display_name = "${var.display_name}"
}

resource "aws_sns_topic_policy" "default" {
  arn = "${aws_sns_topic.main.arn}"

  policy = <<POLICY
 {
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:DeleteTopic",
        "SNS:GetTopicAttributes",
        "SNS:Publish",
        "SNS:RemovePermission",
        "SNS:AddPermission",
        "SNS:Receive",
        "SNS:SetTopicAttributes"
      ],
      "Resource": "${aws_sns_topic.main.arn}"
    }
  ]
 }
POLICY
}

resource "aws_sns_topic_subscription" "main" {
  topic_arn = "${aws_sns_topic.main.arn}"
  protocol  = "${var.protocol}"
  endpoint  = "${var.endpoint}"
}

output "id" {
  value = "${aws_sns_topic.main.id}"
}

output "sns_topic_arn" {
  value = "${aws_sns_topic.main.arn}"
}

output "subscription_id" {
  value = "${aws_sns_topic_subscription.main.id}"
}

output "subscription_arn" {
  value = "${aws_sns_topic_subscription.main.arn}"
}
