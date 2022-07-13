resource "aws_iam_group" "dev_group" {
    name = "dev"
}

resource "aws_iam_group_membership" "dev_group_membership" {

    name = aws_iam_group.dev_group.name

    users = [
        aws_iam_user.terraform_kukim_test.name
    ]

    group = aws_iam_group.dev_group.name
}