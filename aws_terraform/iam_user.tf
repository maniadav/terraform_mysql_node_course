# resource "aws_iam_user_policy_attachment" "s3_access_attachment" {
#   user       = "tf_mysql_node_user"
#   policy_arn = aws_iam_policy.s3_access_policy.arn
# }