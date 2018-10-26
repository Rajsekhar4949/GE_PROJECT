resource "aws_sqs_queue" "main" {
  name                              = "${var.queue_name}"
  fifo_queue                        = true
  content_based_deduplication       = true
  delay_seconds                     = "${var.delay_seconds}"
  max_message_size                  = "${var.max_message_size}"
  message_retention_seconds         = "${var.message_retention_seconds}"
  receive_wait_time_seconds         = "${var.receive_wait_time_seconds}"
  kms_master_key_id                 = "${var.kms_master_key_id}"
  kms_data_key_reuse_period_seconds = "${var.kms_data_key_reuse_period_seconds}"
  tags                              = "${var.tags}"
}

resource "aws_sqs_queue_policy" "main" {
  queue_url = "${aws_sqs_queue.main.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.main.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sqs_queue.main.arn}"
        }
      }
    }
  ]
}
POLICY
}

output "id" {
  value = "${aws_sqs_queue.main.id}"
}

output "arn" {
  value = "${aws_sqs_queue.main.arn}"
}
