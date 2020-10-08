require 'rails_helper'
RSpec.describe User, 'ユーザーモデル機能', type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:other_user) }
  describe 'バリデーションのテスト' do
    context 'メッセージのbodyが空の場合' do
      it 'バリデーションに引っかかる' do
        conversation = Conversation.create(sender_id: user.id, recipient_id: other_user.id)
        message = DmMessage.new(body: '', conversation_id: conversation.id, user_id: user.id )
        expect(message).not_to be_valid
      end
    end
  end
end
