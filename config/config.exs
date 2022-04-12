use Mix.Config

config :ex_aws,
  secret_access_key: "development_secret",
  access_key_id: "development_key"

config :ex_aws, :sqs,
  host: "localhost",
  port: 4566,
  scheme: "http://",
  region: "us-east-1"
