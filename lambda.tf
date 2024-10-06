resource "aws_iam_role" "lambda" {
  name               = "lambda"
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

//role引き受け許可
data "aws_iam_policy_document" "lambda" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "lambda01" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda02" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}

#ここまでiam

data "archive_file" "hello_zip" {
  type        = "zip"
  source_file = "lambdaFunction/hello/hello.mjs"
  output_path = "lambdaFunction/hello/hello.zip"
}

data "archive_file" "operation_zip" {
  type        = "zip"
  source_file = "lambdaFunction/operationInstance/operationInstance.py"
  output_path = "lambdaFunction/operationInstance/operationInstance.zip"
}

data "archive_file" "sns_zip" {
  type        = "zip"
  source_file = "lambdaFunction/sendMailSns/sendMailSns.py"
  output_path = "lambdaFunction/sendMailSns/sendMailSns.zip"
}

//handler(イベントハンドラ)は適切に設定すること
//filename.functionname
resource "aws_lambda_function" "hello" {
  depends_on    = [aws_iam_role.lambda]
  filename      = data.archive_file.hello_zip.output_path
  function_name = "hello"
  role          = aws_iam_role.lambda.arn
  handler       = "hello.handler"
  runtime       = "nodejs20.x"
}

resource "aws_lambda_function" "operation" {
  depends_on    = [aws_iam_role.lambda]
  filename      = data.archive_file.operation_zip.output_path
  function_name = "operationInstance"
  role          = aws_iam_role.lambda.arn
  handler       = "operationInstance.lambda_handler"
  runtime       = "python3.12"
}

resource "aws_lambda_function" "sns" {
  depends_on    = [aws_iam_role.lambda]
  filename      = data.archive_file.sns_zip.output_path
  function_name = "sendMailSns"
  role          = aws_iam_role.lambda.arn
  handler       = "sendMailSns.lambda_handler"
  runtime       = "python3.12"
}

#lambdaでhelloするにもinternal server error出る原因
#https://blog.kimizuka.org/entry/2023/03/03/215842