
# resource "aws_athena_database" "example" {
#     name   = "my_database"
#     bucket = aws_s3_bucket.hoge.bucket

#     properties = {
#         classification = "parquet"
#     }
# }

resource "aws_athena_workgroup" "example" {
    name = "my_workgroup"
    state = "ENABLED"

    configuration {
        enforce_workgroup_configuration    = true
        publish_cloudwatch_metrics_enabled = true

        result_configuration {
            output_location = "s3://${aws_s3_bucket.athena_query_results.bucket}/output/"
            #expected_bucket_owner = var.expected_bucket_owner

            acl_configuration {
                s3_acl_option = "BUCKET_OWNER_FULL_CONTROL"
            }

            encryption_configuration {
                encryption_option = "SSE_KMS"
                kms_key_arn       = aws_kms_key.test.arn
            }
        }    
    }
}

# resource "aws_athena_named_query" "example" {
#     name        = "my_query"
#     description = "An example named query"
#     database    = aws_athena_database.example.name
#     query       = "SELECT * FROM my_table LIMIT 10"
# }