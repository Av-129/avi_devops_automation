variable "secrets" {
  description = "Map of secrets to create in SSM Parameter Store."
  type = map(object({
    name        = string
    description = string
    type        = string
    value       = string
    key_id      = string
  }))
  default = {


    #############################################################################################

#                         
#
#    #############################################################################################
 
#############################################################################################

  "hesv2 parsing service abc" = {
      name        = "service"
      description = " service"
      type        = "SecureString"
value       = <<EOF
{

}
EOF
      key_id      = "alias/aws/ssm"
    }


  }
}

variable "common_tags" {
  description = "Tags to apply to all SSM parameters."
  type        = map(string)
  default = {
    Environment = "abc"
    ManagedBy   = "Terraform"
    map-migrated = "mig70U3Z9VNAJ"

  }
}
