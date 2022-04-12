# BroadwayIssue

## Steps To Reproduce
1. In `docker` folder, run `docker compose up`
  1. This will run localstack / sqs and create a test queue. Wait for initialization to complete
2. In parent folder, run `iex -S mix`
3. In iex that appears, Run `Example.Queuing.Sender.generate_messages()`
