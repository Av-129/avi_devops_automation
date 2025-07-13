# modules/msk/msk-configuration.tf
resource "aws_msk_configuration" "msk_config" {
  name           = "${var.namespace}-msk-config"
  kafka_versions = ["3.8.x"]  # Must match cluster version format

  server_properties = <<EOF
# Server Properties (comments must be on separate lines)
auto.create.topics.enable=false
default.replication.factor=2
num.partitions=3
min.insync.replicas=2
log.retention.hours=168
allow.everyone.if.no.acl.found=false
EOF
}