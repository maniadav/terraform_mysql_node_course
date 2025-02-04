resource "aws_iam_policy" "s3_access_policy" {
  name        = "tf_mysql_node_s3_access_policy"
  description = "Policy to allow S3 access"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "*"
      }
    ]
  })
}