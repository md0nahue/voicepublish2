class Question < ApplicationRecord
  belongs_to :interview_section
  belongs_to :topic

  after_create :generate_audio_url

  private

  def generate_audio_url
    polly = Aws::Polly::Client.new
    response = polly.synthesize_speech({
      output_format: "mp3",
      text: body,
      voice_id: "Joanna"
    })

    # Generate a unique filename
    filename = "questions/#{id}_#{Time.now.to_i}.mp3"
    
    # Save the audio stream to a file
    File.open(filename, "wb") do |file|
      file.write(response.audio_stream.read)
    end

    # Upload to S3 and get URL
    s3 = Aws::S3::Resource.new
    bucket = s3.bucket(ENV['AWS_BUCKET'])
    obj = bucket.object(filename)
    obj.upload_file(filename)

    # Save the URL
    update(url: obj.public_url)

    # Clean up local file
    File.delete(filename)
  end
end
