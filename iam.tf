# AWS IAM Instance Profile for the EC2 instance
resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = format("%s-%s-ec2-iam-instance-profile", var.service, var.environment)
  role = aws_iam_role.ec2_iam_role.id
}

# AWS IAM Role for the EC2 instance
resource "aws_iam_role" "ec2_iam_role" {
  name               = format("%s-%s-ec2-iam-role", var.service, var.environment)
  assume_role_policy = data.aws_iam_policy_document.iam_policy_document.json
}

# AWS IAM Policy Document for the EC2 instance
data "aws_iam_policy_document" "iam_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# AWS IAM Policy for the instance
resource "aws_iam_policy" "ssm_iam_policy" {
  name = "additional_ssm"
  path = "/"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateInstanceProfile",
                "iam:ListInstanceProfilesForRole",
                "iam:PassRole",
                "ec2:DescribeIamInstanceProfileAssociations",
                "iam:GetInstanceProfile",
                "ec2:DisassociateIamInstanceProfile",
                "ec2:AssociateIamInstanceProfile",
                "iam:AddRoleToInstanceProfile"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

# instance core managed policy attachment
resource "aws_iam_role_policy_attachment" "ssm_instance_core" {
  role       = "${aws_iam_role.ec2_iam_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# additional ssm iam policy attachment
resource "aws_iam_role_policy_attachment" "ssm_additional" {
  role       = "${aws_iam_role.ec2_iam_role.name}"
  policy_arn = "${aws_iam_policy.ssm_iam_policy.arn}"
}