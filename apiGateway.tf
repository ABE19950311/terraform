resource "aws_iam_role" "api" {
  name               = "api"
  assume_role_policy = data.aws_iam_policy_document.api.json
}

//role引き受け許可
data "aws_iam_policy_document" "api" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "api_logs" {
  role       = aws_iam_role.api.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_iam_role_policy_attachment" "api_lambda" {
  role       = aws_iam_role.api.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaRole"
}

#apiyobidasi
data "aws_iam_policy_document" "api_gateway_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["execute-api:Invoke"]
    resources = ["${aws_api_gateway_rest_api.hello.execution_arn}/*"]
  }
}

resource "aws_api_gateway_rest_api_policy" "policy" {
  rest_api_id = aws_api_gateway_rest_api.hello.id
  policy      = data.aws_iam_policy_document.api_gateway_policy.json
}

#ここまでiam
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api
#https://qiita.com/suzuki-navi/items/6a896a6577deaa858210
resource "aws_api_gateway_rest_api" "hello" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "hello"
      version = "1.0"
    }
    paths = {
      "/path1" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            payloadFormatVersion = "1.0"
            type                 = "AWS_PROXY"
            uri                  = aws_lambda_function.sns.invoke_arn
            credentials          = aws_iam_role.api.arn
          }
        }
      }
    }
  })

  name = "example"
}

resource "aws_api_gateway_deployment" "hello" {
  rest_api_id = aws_api_gateway_rest_api.hello.id
  depends_on  = [aws_api_gateway_rest_api.hello]

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.hello))
  }
}

#urlmitukaranai→ステージにdeployする処理がなかった→追記

resource "aws_api_gateway_stage" "hello" {
  deployment_id = aws_api_gateway_deployment.hello.id
  rest_api_id   = aws_api_gateway_rest_api.hello.id
  stage_name    = "hello"
}