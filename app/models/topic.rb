class Topic < ApplicationRecord

  after_create :generate_questions

  def generate_questions
    instructions = <<-INSTRUCTIONS
    You are an AI assistant that responds in a structured JSON format. Always return an array of strings in your responses. Example:
    ["string1", "string2", "string3"]
    INSTRUCTIONS

    prompt = <<-PROMPT
      Brainstorm an list of high-level topics for an interview
      about the topic listed below:
      Generate exactly 15 topics
    #{body}
    PROMPT

    { answer:, fee: } = AskAi.ask(instructions, prompt)

    answer.each do |_body|
      InterviewSection.create(body: _body, topic: self)
    end
  end
end
