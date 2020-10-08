require 'rails_helper'
RSpec.describe Post, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user) }
  describe 'バリデーションのテスト' do
    context 'コメントが空の場合' do
      it 'バリデーションに引っかかる' do
        comment = Comment.new(body: '', user_id: user.id, post_id: post.id)
        expect(comment).not_to be_valid
      end
    end
  end
end
