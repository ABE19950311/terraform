import boto3

def lambda_handler(event, context):
    target_for_launch_list = []
    instance_id = None
    ec2 = None
    action = None
    
    # 起動対象インスタンスID
    target_for_launch_list = ['']
    
    # イベント発生時のインスタンスIDを取得(起動用)
    #instance_id = event['detail']['instance-id']
    # イベント発生時のインスタンスIDを取得(再起動用)
    instance_id = event['detail']['configuration']['metrics'][0]['metricStat']['metric']['dimensions']['InstanceId']
    
    ec2 = boto3.client('ec2', region_name='ap-northeast-1')
    
    # インスタンスの状態変化を取得(起動用)
    #action = event['detail']['state']
    # インスタンスの状態変化を取得(再起動用)
    action = event['detail']['configuration']['metrics'][0]['metricStat']['metric']['name']
    
    print(str(event))
    print(str(instance_id))
    print(str(action))
    
    # インスタンスが停止した かつ 起動対象のインスタンスIDであれば起動する
    #if action == 'stopped' and instance_id in target_for_launch_list:
    
    # インスタンスが停止した かつ 起動対象のインスタンスIDであれば起動する
    if action == 'StatusCheckFailed' and instance_id in target_for_launch_list:
        try:
            #インスタンス起動
            #ec2.start_instances(InstanceIds=[instance_id])
            #インスタンス再起動
            ec2.reboot_instances(InstanceIds=[instance_id])
            print('Successful instance launch: ' + str(instance_id))
        except Exception as e:
            print('Failed to launch instance: ' + str(e))
    else:
        print('No need to launch instance')