resource "aws_iam_role" "iam_role_name" {
  name               = "tf-jenkins-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags = {
    environment = "test"
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "jenkins_instance_profile"
  role = aws_iam_role.iam_role_name.name
}


resource "aws_iam_role_policy" "iam_role_policy" {
  name   = "tf-jenkins-role-policy"
  role   = aws_iam_role.iam_role_name.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action":"ecs:*",
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::terraform-infra-automation04"
        }
    ]
}
EOF
}
