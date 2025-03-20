class AskAi
  def self.ask(instructions, prompt)
    start_time = Time.now.to_i
    chat = RubyLLM.chat
    chat.add_message role: :system, content: instructions
    chat.ask chat_prompt
    answer = JSON.parse(chat.messages.select{|m| m.role == :assistant}.first.content)

    response = HTTParty.get(
      "https://api.openai.com/v1/organization/costs?start_time=#{start_time}&end_time=#{end_time}",
      headers: {
        'Authorization' => "Bearer #{ENV['OPENAI_API_KEY_ADMIN']}",
        'Content-Type' => 'application/json'
      }
    )
    fee = response.dig("data", 0, "results", 0, "amount")

    {answer: answer, fee: fee}
  end
end
