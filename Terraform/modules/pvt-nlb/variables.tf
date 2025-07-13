variable "nlb_name" {
  description = "The name of the Network Load Balancer"
  type        = string
  default     = "abc-pvt-nlb"
}

variable "internal" {
  description = "Set to true for a private NLB, false for a public NLB"
  type        = bool
}


variable "private_subnet_ids" {
  description = "List of subnet IDs where the ALB will be deployed"
  type        = list(string)
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable or disable cross-zone load balancing for the NLB"
  type        = bool
  default     = true
}

variable "idle_timeout" {
  description = "Time (in seconds) before an idle connection is closed"
  type        = number
  default     = 60
}

variable "tcp_listener_port" {
  description = "Port for the TCP listener on the NLB"
  type        = number
  default     = 4059
}

variable "udp_listener_port" {
  description = "Port for the UDP listener on the NLB"
  type        = number
  default     = 4059
}

variable "target_group_health_check_path" {
  description = "The health check path for the target group"
  type        = string
  default     = "/"
}

variable "target_group_health_check_port" {
  description = "The health check port for the target group"
  type        = string
  default     = "traffic-port"
}

variable "target_group_protocol" {
  description = "The protocol for the target group (TCP, UDP, or both)"
  type        = string
  default     = "TCP"
}

variable "tags" {
  description = "Tags to apply to the NLB"
  type        = map(string)
  default     = {}
}


variable "vpc_id" {
  description = "The VPC ID for the target group"
  type        = string
}