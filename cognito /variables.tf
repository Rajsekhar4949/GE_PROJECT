variable "aws_region" {
  default = "us-east-1"
}

#Cognito Identity Pool
variable "identity_pool_name" {
  default     = "cognito identity pool"
  description = "The Cognito Identity Pool name"
}

variable "allow_unauthenticated_identities" {
  default     = "false"
  description = "Whether identity pool supports unauthenticated logins or not"
}

#Cognito Identity Pool Roles attachment
variable "iam_role_name" {
  default     = "cognito_authenticated"
  description = "The name for the role attached to the cognito authentication "
}

variable "iam_role_policy_name" {
  default     = "authenticated_policy"
  description = "The policy name attached to the IAM role"
}

#Cognito User Group
variable "user_pool_name" {
  default     = "identity_pool"
  description = "The name of the user pool"
}

variable "user_group_role_name" {
  default     = "user-group-role"
  description = "The name of user group role"
}

variable "user_group_name" {
  default     = "user-group"
  description = "The name of the user group"
}

variable "user_pool_id" {
  description = "The user pool ID"
}

#User Pool Client

variable "user_pool_client_name" {
  default     = "pool_client"
  description = "The anme of the application client"
}

#User Pool domain resource
variable "user_pool_domain" {
  description = "The domain string"
  default     = "ge-domain"
}
