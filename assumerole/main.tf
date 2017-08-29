variable "srv" {}

/*
variable "map" {
  default = {
    codepipeline = "codepipeline"
    codebuild    = "codebuild"
    lambda       = "lambda"
    ec2          = "ec2"
    ecs          = "ecs"
    ecs-tasks    = "ecs-tasks"
  }
}
*/

data "aws_iam_policy_document" "doc" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      //identifiers = ["${lookup(var.map,var.srv)}.amazonaws.com"]
      identifiers = ["${var.srv}.amazonaws.com"]
    }
  }
}

output "json" {
  value = "${data.aws_iam_policy_document.doc.json}"
}
