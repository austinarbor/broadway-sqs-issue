defmodule Example.Queuing.Producer do
  use Broadway
  alias Broadway.Message
  require Logger

  def start_link(opts) do
    Broadway.start_link(
      __MODULE__,
      Keyword.merge([name: __MODULE__], opts)
    )
  end

  @impl true
  def prepare_messages(messages, _context) do
    Logger.info("preparing #{length(messages)} message")
    messages
  end

  @impl true
  def handle_message(producer, message, context) do
    Logger.info("handle message")
    do_work(message)
    message
  end

  defp do_work(message) do
    difficulty = :rand.uniform(1500)
    :timer.sleep(difficulty)
  end

  @impl true
  def handle_batch(batcher, messages, batch_info, context) do
    Logger.info("handle batch")
    messages
  end
end
