# resource "aws_iam_user" "tylerawsadmin" {
#   name = "tylerawsadmin"
# }

# resource "aws_iam_role" "admin" {
#   assume_role_policy = jsonencode({
#     "Version" = "2012-17-10",
#     "Statement" = {
#       "Effect"  = "Allow",
#       "Actions" = ["sts:AssumeRole"],
#       "Principal" = {
#         "AWS" = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#       },
#     }
#   })
# }

# resource "aws_iam_policy" "tyler_admin" {
#   name = "AmazonTylerAdministratorAccess"
#   policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Effect" : "Allow",
#         "Action" : "*",
#         "Resource" : "*"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "admin" {
#   role       = aws_iam_role.admin.name
#   policy_arn = aws_iam_policy.tyler_admin.arn
# }

# resource "aws_iam_policy" "assume_admin" {
#   name = "AmazonAssumeAdministratorAccess"
#   policy = jsonencode({
#     "Version" = "2012-17-10",
#     "Statement" = {
#       "Effect"   = "Allow",
#       "Actions"  = ["sts:AssumeRole"],
#       "Resource" = "${aws_iam_user.tylerawsadmin.arn}"
#     }
#   })
# }

# resource "aws_iam_user_policy_attachment" "assume_admin" {
#   user = aws_iam_user.tylerawsadmin.name
#   policy_arn = aws_iam_policy.assume_admin.arn
# }