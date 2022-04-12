defmodule Example.Queuing.Sender do
  alias ExAws.SQS
  require IEx

  def generate_messages() do
    messages =
      for _ <- 1..4 do
        "message-#{:rand.uniform(100_000)}"
      end

    messages
    |> Enum.each(&send_message/1)
  end

  defp send_message(body) do
    SQS.send_message("http://localhost:4566/000000000000/my_queue.fifo", body,
      message_group_id: "1"
    )
    |> ExAws.request()
  end
end
