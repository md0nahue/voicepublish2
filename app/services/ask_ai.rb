class AskAi
  # def self.ask(instructions, prompt)
  #   start_time = Time.now.to_i
  #   chat = RubyLLM.chat
  #   chat.add_message role: :system, content: instructions
  #   chat.ask prompt
  #   answer = JSON.parse(chat.messages.select{|m| m.role == :assistant}.first.content)

  #   response = HTTParty.get(
  #     "https://api.openai.com/v1/organization/costs?start_time=#{start_time}&end_time=#{Time.now.to_i}",
  #     headers: {
  #       'Authorization' => "Bearer #{ENV['OPENAI_API_KEY_ADMIN']}",
  #       'Content-Type' => 'application/json'
  #     }
  #   )
  #   fee = response.dig("data", 0, "results", 0, "amount")

  #   {answer: answer, fee: fee}
  # end

  def self.ask(instructions, prompt)
    chat = RubyLLM.chat
    chat.add_message role: :system, content: instructions
    response = chat.ask prompt
    answer = JSON.parse(chat.messages.select{|m| m.role == :assistant}.first.content)

    model = RubyLLM.models.find(response.model_id)
    input_cost = response.input_tokens * model.input_price_per_million / 1_000_000
    output_cost = response.output_tokens * model.output_price_per_million / 1_000_000
    puts "Estimated cost: $#{(input_cost + output_cost).round(6)}"
    fee = (input_cost + output_cost)
    {answer: answer, fee: fee}
  end
end
