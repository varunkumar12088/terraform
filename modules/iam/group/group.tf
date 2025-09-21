
resource "aws_iam_group" "admin_group" {
  name = var.admin_group_name
  
}

resource "aws_iam_group_policy_attachment" "admin_group_attachment" {
  group      = aws_iam_group.admin_group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


