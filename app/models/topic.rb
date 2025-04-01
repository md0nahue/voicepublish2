class Topic < ApplicationRecord
  after_create :generate_questions
  has_many :interview_sections
  has_many :questions, through: :interview_sections

  def add_fee(fee)
    # Initialize fees array if nil
    self.fees ||= []
    # Add new fee to array
    self.fees << fee
    save
  end

  def total_fee
    self.fees.sum
  end

  def self.run
    prompt = <<-PROMPT
    My father died last year. I just want to reflect on my relationship with him
    He was in the national guard,
    my parents divorced when I was 5, we went skiing a lot, he was in Iraq with halliburton
    he moved to salt lake city...
    PROMPT
    topic = Topic.create(body: prompt)

    topic.interview_sections.each do |sect|
      sect.generate_questions
    end
  end

  def generate_questions
    instructions = <<-INSTRUCTIONS
    You are an AI assistant that responds in a structured JSON format. Always return an array of strings in your responses. Example:
    ["string1", "string2", "string3"]
    INSTRUCTIONS

    prompt = <<-PROMPT
      Brainstorm an list of exactly 15 high-level topics for an interview
      about the topic listed below:
      #{body}
    PROMPT

    response = AskAi.ask(instructions, prompt)
    answer = response[:answer]
    fee = response[:fee]
    add_fee(fee)
    answer.each do |_body|
      InterviewSection.create(body: _body, topic: self)
    end
  end
end
