
# localstack doesn't actually use access keys / secret keys, we are just passing values in
# to satiate the awscli
aws configure set aws_access_key_id development_key
aws configure set aws_secret_access_key development_secret
aws configure set region us-east-1

aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name my_queue.fifo --attributes file://queue-attributes.json
