resource "aws_s3_bucket" "test_bucket" {
  bucket = "${var.bucket_name}"
  acl    = "${var.bucket_acl}"
}

resource "aws_iam_role" "codepipeline_role" {
  name               = "${var.iam_role_name}"
  assume_role_policy = "${file("../code_pipeline/assume_policy.json")}"
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "${var.codepipeline_policy_name}"
  role = "${aws_iam_role.codepipeline_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketVersioning"
      ],
      "Resource": [
        "${aws_s3_bucket.test_bucket.arn}",
        "${aws_s3_bucket.test_bucket.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_codepipeline" "test_codepipeline" {
  name = "${var.pipeline_name}"

  artifact_store {
    location = "${aws_s3_bucket.test_bucket.bucket}"
    type     = "${var.artifact_location_type}"
  }

  stage {
    name = "${var.stage1_name}"

    action {
      name     = "${var.action1_name}"
      category = "${var.action1_category}"
      owner    = "${var.owner1}"
      provider = "${var.provider1}"
      version  = "${var.version1}"
    }
  }

  stage {
    name = "${var.stage2_name}"

    action {
      name            = "${var.action2_name}"
      category        = "${var.action2_category}"
      owner           = "${var.owner2}"
      provider        = "${var.provider2}"
      version         = "${var.version2}"
      input_artifacts = ["${var.input_artifacts}"]
    }
  }
}

#Outputs

output "pipeline_id" {
  value = "${aws_codepipeline.test_codepipeline.id}"
}

output "pipeline_arn" {
  value = "${aws_codepipeline.test_codepipeline.arn}"
}
