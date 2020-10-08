require 'rails_helper'
RSpec.describe Post, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  describe 'バリデーションのテスト' do
    context '投稿のタイトルが空の場合' do
      it 'バリデーションに引っかかる' do
        post = Post.new(title: '', music: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/velvet_extended.mp3')), music_type: 'Tune', genre: 'Hiphop', user_id: user.id)
        expect(post).not_to be_valid
      end
    end
    context '投稿の音楽が空の場合' do
      it 'バリデーションに引っかかる' do
        post = Post.new(title: 'test', music: '', music_type: 'Tune', genre: 'Hiphop', user_id: user.id)
        expect(post).not_to be_valid
      end
    end
    context 'music_typeが空の場合' do
      it 'バリデーションに引っかかる' do
        post = Post.new(title: 'test', music: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/velvet_extended.mp3')), music_type: '', genre: 'Hiphop', user_id: user.id)
        expect(post).not_to be_valid
      end
    end
  end
end
