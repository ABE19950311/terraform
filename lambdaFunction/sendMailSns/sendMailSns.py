import boto3
client = boto3.client('sns')

def lambda_handler(event, context):
    
    params = {
    'TopicArn': 'arn:aws:sns:ap-northeast-1:403437267422:hoge',
    'Subject': 'hoge',
    'Message': 'hogeeee'
    }
    
    client.publish(**params)