

data "aws_iam_policy_document" "sqs_factures_policy" {
  statement {
    sid    = "First"
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.factures_queue.arn]
  
    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = ["arn:aws:lambda:us-east-1:734426407668:function:converter-lambda"]
    }
  }
}

resource "aws_sqs_queue_policy" "factures_policy_sqs" {
  queue_url = aws_sqs_queue.factures_queue.id
  policy    = data.aws_iam_policy_document.sqs_factures_policy.json
  depends_on = [ aws_sqs_queue.factures_queue ]
}