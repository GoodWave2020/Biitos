require 'rails_helper'
RSpec.describe 'DM機能(トークルーム作成)', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:other_user) }
  before do
    visit new_user_session_path
    fill_in :user_email, with: 'test@email.com'
    fill_in :user_password, with: 'password'
    click_on "Log in"
  end
  describe 'トークルーム作成機能' do
    context '相互フォロー(友達)の場合' do
      it 'トークルームが作成できる' do
        Relationship.create(follower_id: other_user.id, followed_id: user.id)
        Relationship.create(follower_id: user.id, followed_id: other_user.id)
        visit friends_path(user.id)
        click_on :conversation_room
        expect(page).to have_content 'to other_name'
      end
    end
  end
end
