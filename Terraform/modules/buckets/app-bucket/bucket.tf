
resource "aws_s3_bucket" "bucket1" {
  bucket              = var.bucket1
  object_lock_enabled = true
    tags = {
    map-dba = "Divyanshu"
  }
}



resource "aws_s3_object" "dummy_object" {
  bucket  = aws_s3_bucket.bucket1.bucket
  key     = "dummy.txt"
  content = "dummy content"
  acl     = "private"
}


resource "aws_s3_bucket_versioning" "versioning_audit_bucket" {
  bucket = aws_s3_bucket.bucket1.id
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_logging" "logging_audit_bucket" {
  bucket        = aws_s3_bucket.bucket1.id
  target_bucket = var.bucket1
  target_prefix = "${var.bucket1}/Logs/"
}


#sns add on s3 bucket for sns notification

# resource "aws_s3_bucket_notification" "bucket1_notification" {
#   bucket = aws_s3_bucket.bucket1.id
#   topic {
#     topic_arn     = var.sns_s3_event_arn
#     events        = ["s3:ObjectRemoved:*", "s3:ObjectAcl:Put", "s3:LifecycleTransition", "s3:LifecycleExpiration:Delete"]
#     filter_prefix = var.bucket1
#     # id            = var.sns_s3_event_name
#   }
# }

resource "aws_s3_bucket_lifecycle_configuration" "bucket_1_policy" {
  bucket                = var.bucket1
  expected_bucket_owner = null
  rule {
    id     = "AuRetention"
    status = "Enabled"
    expiration {
      date                         = null
      days                         = 3650
      expired_object_delete_marker = false
    }
    filter {
      object_size_greater_than = null
      object_size_less_than    = null
      prefix                   = null
    }
    noncurrent_version_expiration {
      newer_noncurrent_versions = "100"
      noncurrent_days           = 3650
    }
  }
}


resource "aws_s3_bucket_policy" "bucket1_policy_https" {
  bucket = aws_s3_bucket.bucket1.id
  policy = file("./modules/buckets/app-bucket/bucket-ssl-policy.json")
}