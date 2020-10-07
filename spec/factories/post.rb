FactoryBot.define do
  factory :post do
    title { 'test_post' }
    music { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/velvet_extended.mp3')) }
    music_type { 'Voice' }
    genre { 'Hiphop' }
  end
end
