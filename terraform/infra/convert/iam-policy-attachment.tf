resource "aws_iam_policy_attachment" "convert_policy_attachment" {
  name       = "${var.environment}-convert_policy_attachment"
  roles      = ["${aws_iam_role.convert_iam_role.name}"]
  policy_arn = "${aws_iam_policy.convert_policy.arn}"
}