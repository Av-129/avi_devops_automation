resource "aws_msk_cluster" "msk" {
  cluster_name           = "${var.namespace}-msk-cluster"
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type   = var.broker_instance_type
    client_subnets  = var.private_subnet_ids
    security_groups = [var.security_group_id]

    storage_info {
      ebs_storage_info {
        volume_size = var.ebs_volume_size
      }
    }
  }

  # Enable encryption at rest using your customer-managed KMS key:
  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.msk_kms.arn
  }

  client_authentication {
    sasl {
      scram = true
    }
  }


  configuration_info {
    arn      = aws_msk_configuration.msk_config.arn
    revision = aws_msk_configuration.msk_config.latest_revision
  }
}

resource "aws_msk_scram_secret_association" "msk_scram" {
  cluster_arn    = aws_msk_cluster.msk.arn
  secret_arn_list = [
    aws_secretsmanager_secret.msk_secret.arn,
  ]
}
