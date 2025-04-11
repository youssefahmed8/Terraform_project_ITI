/*
resource "aws_s3_bucket" "example" {
  bucket = "project-backup-on-s3"
}


resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "myDynamoForLock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}*/