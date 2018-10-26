provider "aws" {
  region = "${var.aws_region}"
}

#Cognito Identity Pool
resource "aws_cognito_identity_pool" "main" {
  identity_pool_name               = "${var.identity_pool_name}"
  allow_unauthenticated_identities = "${var.allow_unauthenticated_identities}"
}

#Identity Pool Role attachment
resource "aws_iam_role" "authenticated" {
  name               = "${var.iam_role_name}"
  assume_role_policy = "${file("${path.module}/authenticated_assume_policy.json")}"
}

resource "aws_iam_role_policy" "authenticated" {
  name   = "${var.iam_role_policy_name}"
  role   = "${aws_iam_role.authenticated.id}"
  policy = "${file("${path.module}/authenticated_role_policy.json")}"
}

resource "aws_cognito_identity_pool_roles_attachment" "main" {
  identity_pool_id = "${aws_cognito_identity_pool.main.id}"

  roles {
    "authenticated" = "${aws_iam_role.authenticated.arn}"
  }
}

#Cognito User pool
resource "aws_cognito_user_pool" "main" {
  name = "${var.user_pool_name}"
}

#User Group
resource "aws_iam_role" "group-role" {
  name               = "${var.user_group-role_name}"
  assume_role_policy = "${file("../cognito/group-role-policy.json")}"
}

resource "aws_cognito_user_group" "main" {
  name         = "${var.user_group_name}"
  user_pool_id = "${aws_cognito_user_pool.main.id}"
  role_arn     = "${aws_iam_role.group-role.arn}"
}

#User Pool Client
resource "aws_cognito_user_pool_client" "client" {
  name         = "${var.user_pool_client_name}"
  user_pool_id = "${aws_cognito_user_pool.main.id}"
}

#User Pool domain
resource "aws_cognito_user_pool_domain" "main" {
  domain       = "${var.user_pool_domain}"
  user_pool_id = "${aws_cognito_user_pool.main.id}"
}

#Outputs
output "identity_pool_id" {
  value = "${aws_cognito_identity_pool.main.id}"
}

output "user_pool_id" {
  value = "${aws_cognito_user_pool.main.id}"
}

output "user_pool_arn" {
  value = "${aws_cognito_user_pool.main.arn}"
}

output "user_pool_creation_date" {
  value = "${aws_cognito_user_pool.main.creation_date}"
}

output "user_pool_last_modified" {
  value = "${aws_cognito_user_pool.main.last_modified_date}"
}

output "user_pool_client_id" {
  value = "${aws_cognito_user_pool_client.client.id}"
}
