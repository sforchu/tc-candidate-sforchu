resource "aws_iam_role" "test_role" {
  name = "ec2_tf_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

    inline_policy  {
    name = "my_inline_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = [
            "kms:*",
            "s3:*",
            "dynamodb:*"
            ]
          Effect   = "Allow"
          Resource = [
           "*"
          ]
        },
      ]
    })
  }

  tags = {
    tag-key = "tag-value"
  }
}


output "iam_role_name" {
  value = aws_iam_role.test_role.name
}

output "iam_role_arn" {
  value = aws_iam_role.test_role.arn
}