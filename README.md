# BroadwayIssue

## Steps To Reproduce
1. In `docker` folder, run `docker compose up`
    1. This will run localstack / sqs and create a test queue. Wait for initialization to complete
1. CD to parent folder
1. Run `mix deps.get`
1. Run `iex -S mix`
1. In iex shell that appears, Run `Example.Queuing.Sender.generate_messages()`


## Behavior
1. Multiple messages are fetched from SQS in batch
1. Messages are processed one at a time
1. Instead of immediately working on next message that has already been fetched, it appears to instead try and re-fetch messages from SQS. Since no messages are on the queue, it waits the full 20 seconds before working on the next available message
