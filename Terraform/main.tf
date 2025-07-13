provider "aws" {
  region = "ap-south-1"
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.11.0"
    }
  }
}

module "networking" {
  source = "./modules/networking"
}

# module "buckets-app" {
#   source = "./modules/buckets/app-bucket"
# }

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.networking.vpc_id
  #allowed_ssh_cidr = ["0.0.0.0/0"]

}

# module "iam_role" {
#   source = "./modules/iam_role"
# }

# module "compute" {
#   source            = "./modules/compute"
#   ami_id            = "ami-02d6425099ef07b5c"
#   instance_type     = "t4g.nano"
#   subnet_id         = module.networking.subnet_id
#   security_group_id = module.security_groups.security_group_id
#   iam_role_name     = module.iam_role.ec2_ssm_role_name
# }

# module "databases" {
#   source                = "./modules/database"
#   private_db_subnet_ids = module.networking.private_db_subnet_ids
#   security_group_id     = module.security_groups.security_group_id
# }

#    module "ecr_repositories" {
#      source = "./modules/ecr"  # Calls the ECR module
#    }




module "eks-cluster" {
  source             = "./modules/eks-cluster"
  security_group_id  = module.security_groups.security_group_id
  private_subnet_ids = module.networking.private_subnet_ids
  public_subnet_ids  = module.networking.public_subnet_ids
}


# module "sqs" {
#   source       = "./modules/sqs"
#   queue_name   = "abc-app-queue"
#   enable_dlq   = true
#   max_receive_count = 5
# }


# module "pvt-alb" {
#   source                           = "./modules/pvt-alb"
#   security_group_id                = module.security_groups.security_group_id
#   private_subnet_ids               = module.networking.private_subnet_ids
#   internal                         = true # Private ALB
#   certificate_arn                  = "arn:aws:acm:ap-south-2:668708:certificate/7d57503e-f406-406a-8ee6-16e142d694d7"
#   message                          = "Private ALB Default Response"
#   enable_cross_zone_load_balancing = true
#   enable_deletion_protection       = false
#   idle_timeout                     = 60
#   tags = {
#     Environment = "prod"
#     Name        = "Private ALB"
#   }
# }


# module "pvt-nlb" {
#   source             = "./modules/pvt-nlb"
#   nlb_name           = "abc-NLB"
#   internal                         = true # Private NLB
#   private_subnet_ids = module.networking.private_subnet_ids
#   vpc_id             = module.networking.vpc_id
# }


# module "msk" {
#   source                 = "./modules/msk"
#   namespace              = "abc"
#   kafka_version          = "3.8.x"
#   broker_instance_type   = "kafka.t3.small"
#   number_of_broker_nodes = 2
#   ebs_volume_size        = 1200
#   security_group_id      = module.security_groups.security_group_id  # Match variable name
#   private_subnet_ids     = module.networking.private_subnet_ids      # Match variable name
#   msk_sasl_username      = "abc_master"
#   msk_sasl_password      = "abc123"
#   secret_name            = "AmazonMSK_msk_auth_secret"
# }



#      module "secrets" {
#       source = "./modules/secrets"
#     }


# module "cicd" {
#   source = "./modules/codepipeline"
#   # artifact_bucket = module.buckets-app.bucket1_name
#   artifact_bucket = "codepipeline-ap-south-1-177920"
# 
# }




#   module "state_locking" {
#     source = "./modules/state_locking"
#     tags = {
#       Environment = "dev"
#     }
#   }
# 
terraform {
  backend "s3" {
    bucket = "terraform-state-remote-backend-poc"
    key    = "terraform.tfstate"
    region = "ap-south-1"
    # dynamodb_table = "terraform-state-lock"  # Must match the module's table_name
    encrypt      = true
    use_lockfile = true
  }
}


# module "cognito" {
#   source = "./modules/cognito"
# }


#      module "ssm_parameter" {
#        source = "./modules/ssm_parameter"
#      
#      }
