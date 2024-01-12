resource "aws_sqs_queue" "factures_queue" {
    name = "${var.environment}-factures-queue"

    redrive_policy = jsonencode({
        deadLetterTargetArn = aws_sqs_queue.factures_queue_dlq.arn
        maxReceiveCount     = 3
    })

    
}

resource "aws_sqs_queue" "factures_queue_dlq" {
    name = "${var.environment}-factures-queue-dlq"
}