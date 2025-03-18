RubyLLM.configure do |config|
  config.openai_api_key = ENV['OPENAI_API_KEY']
  config.default_model = 'gpt-4o-mini'               # Default chat model
end

ENV['RUBYLLM_DEBUG'] = 'true'
