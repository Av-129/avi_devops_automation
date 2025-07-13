variable "secrets" {
  description = "List of secrets to create. Each object includes name, description, and secret_data as a map."
  type = list(object({
    name         = string
    description  = string
    secret_data  = map(string)
  }))
  default = [
    {
#      name         = "/prod/abc/firmware-upgrade-service"
#      description  = "Credentials for firmware-upgrade-service abc"
#      secret_data  = {
#  "S3_BUCKET": "hes-firmware-files-abc",
#  "REDIS_HOST": "write.redis.hes.abc.internal",
#  "REDIS_DB": 3,
#  "MQTT_BROKER_URL": "broker.abcmvvnl.in",
#  "MQTT_USERNAME": "abcuser",
#  "MQTT_BROKER_PORT": 1883,
#  "MQTT_PASSWORD": "SYRdD27384!!",
#  "MQTT_CLIENT_ID": "dcu-fw-ug-service"
#}
#    }
    // add "," and create more secrets like above
 
  ]
}

variable "tags" {
  description = "Tags for the secrets."
  type        = map(string)
  default     = {
    "Environment" = "Production"
  }
}

# variable "region" {
#   description = "AWS region for CLI commands"
#   type        = string
#   default     = "ap-south-2"
# }

