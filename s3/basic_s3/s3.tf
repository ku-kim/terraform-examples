resource "aws_s3_bucket" "s3" {
    bucket = "terraform-kukim-bucket"

    tags = {
        Name = "terraform-kukim-bucket"
    }
}