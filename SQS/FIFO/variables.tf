variable "queue_name" {
  description = "This is the human-readable name of the queue."
  default     = "fifo_sqs_main.fifo"
}

variable "max_message_size" {
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it"
  default     = "2048"
}

variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)."
  default     = "86400"
}
