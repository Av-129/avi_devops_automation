variable "user_pool_name" {
  description = "Name of the Cognito user pool"
  type        = string
  default     = "MyUserPool"
}

variable "auto_verified_attributes" {
  description = "List of user attributes to automatically verify"
  type        = list(string)
  default     = ["email"]
}

variable "password_policy_minimum_length" {
  description = "Minimum length for user passwords"
  type        = number
  default     = 8
}

variable "password_policy_require_uppercase" {
  description = "Should passwords require uppercase letters?"
  type        = bool
  default     = true
}

variable "password_policy_require_lowercase" {
  description = "Should passwords require lowercase letters?"
  type        = bool
  default     = true
}

variable "password_policy_require_numbers" {
  description = "Should passwords require numbers?"
  type        = bool
  default     = true
}

variable "password_policy_require_symbols" {
  description = "Should passwords require symbols?"
  type        = bool
  default     = false
}
