data "aws_iam_group" "group_name" {
  group_name = var.name_group
}

resource "aws_iam_user" "kihara_user" {
  name = "kihara_devops_user"
}


resource "aws_iam_access_key" "access_key" {
  user = aws_iam_user.kihara_user.name
}

resource "aws_iam_group_membership" "admin" {
  name  = data.aws_iam_group.group_name.group_name
  users = ["${aws_iam_user.kihara_user.name}"]
  group = data.aws_iam_group.group_name.group_name
}

