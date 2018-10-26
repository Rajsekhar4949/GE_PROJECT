resource "aws_sqs_queue" "main" {
  name = "${var.queue_name}"
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
  value = "${aws_sqs_queue.sqsmain.arn}"
}
