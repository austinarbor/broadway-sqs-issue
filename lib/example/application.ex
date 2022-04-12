defmodule Example.Application do
  use Application
  alias Broadway.Message
  require Logger

  def start(_type, _args) do
    children = [queueing_child_spec()]
    opts = [strategy: :one_for_one, name: Exam]
    Supervisor.start_link(children, opts)
  end

  defp queueing_child_spec() do
    %{
      id: Example.Queuing.Producer,
      start: {Example.Queuing.Producer, :start_link, [broadway_config()]},
      type: :supervisor
    }
  end

  defp broadway_config() do
    [
      producer: [
        module: {
          BroadwaySQS.Producer,
          queue_url: "http://localhost:4566/000000000000/my_queue.fifo",
          on_failure: :ack,
          wait_time_seconds: 20,
          max_number_of_messages: 10,
          receive_interval: 10,
          attribute_names: :all,
          config: [
            host: "localhost",
            port: 4566,
            scheme: "http://",
            region: "us-east-1",
            access_key_id: "x",
            secret_access_key: "x"
          ]
        },
        concurrency: 1
      ],
      processors: [
        default: [
          concurrency: 75,
          max_demand: 1,
          partition_by: &partition/1
        ]
      ],
      batchers: [
        default: [
          # the max size of each batch to ack in a request
          batch_size: 100,
          # the max amount of time to wait before flushing
          batch_timeout: 20,
          # the number of batchers to run
          concurrency: 3
        ]
      ]
    ]
  end

  defp partition(%Message{
         metadata: %{
           attributes: %{
             "message_group_id" => message_group_id
           }
         }
       }) do
    Logger.info("partitioning")
    :erlang.phash2(message_group_id)
  end
end
