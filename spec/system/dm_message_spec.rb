require 'rails_helper'
RSpec.describe 'DM機能(メッセージ機能)', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:other_user) }
  let!(:user_follow) {Relationship.create(follower_id: other_user.id, followed_id: user.id)}
  let!(:other_user_follow) {Relationship.create(follower_id: user.id, followed_id: other_user.id)}
  before do
    visit new_user_session_path
    fill_in :user_email, with: 'test@email.com'
    fill_in :user_password, with: 'password'
    click_on "Log in"
    visit friends_path(user.id)
    click_on :conversation_room
    expect(page).to have_content 'to other_name'
  end
  describe 'メッセージ機能' do
    context 'メッセージを送信した場合' do
      it 'メッセージが表示される' do
        fill_in :dm_message_body, with: 'new message'
        click_on 'send'
        expect(page).to have_content 'new message'
      end
    end
    context '音楽を送信した場合' do
      it '音楽ダウンロードボタンが表示される' do
        fill_in :dm_message_body, with: 'new message'
        attach_file :dm_message_collab_music, 'spec/fixtures/velvet_extended.mp3'
        click_on 'send'
        expect(page).to have_content 'download'
      end
    end
  end
end
