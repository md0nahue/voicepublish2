class InterviewSection < ApplicationRecord
  belongs_to :topic

  def generate_questions
    instructions = <<-INSTRUCTIONS
    You are an AI assistant that responds in a structured JSON format. Always return an array of strings in your responses. Example:
    ["string1", "string2", "string3"]
    INSTRUCTIONS

    prompt = <<-PROMPT
      Brainstorm an list of interview questions about: #{body} for #{topic}
      Generate at least 40 unique questions
    #{body}
    PROMPT

    { answer:, fee: } = AskAi.ask(instructions, prompt)

    answer.each do |_body|
      Question.create(body: _body, interview_section: self)
    end
  end

end
