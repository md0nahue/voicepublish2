class Topic < ApplicationRecord

  after_create :generate_questions

  def generate_questions
  chat = RubyLLM.chat
  instructions = <<-INSTRUCTIONS
  You are an AI assistant that responds in a structured JSON format. Always return an array of strings in your responses. Example:
  ["string1", "string2", "string3"]
  INSTRUCTIONS

  chat_prompt = <<-PROMPT
  I need you to brainstorm an array of high-level topics for an interview that will help someone to explore the topic listed below:
  #{body}
  PROMPT

  chat.add_message role: :system, content: instructions
  chat.ask "What's your favorite programming language?"

  end
end
