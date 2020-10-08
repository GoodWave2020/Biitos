require 'rails_helper'
RSpec.describe 'フォロー機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:other_user) }
  before do
    visit new_user_session_path
    fill_in :user_email, with: 'test@email.com'
    fill_in :user_password, with: 'password'
    click_on "Log in"
  end
  describe 'フォロー機能' do
    context '他のユーザーをフォローした場合' do
      it 'フォローしているユーザーが表示される' do
        visit user_path(other_user.id)
        click_on :follow
        visit following_path(user.id)
        expect(page).to have_content 'other'
      end
    end
    context '他のユーザーにフォローされた場合' do
      it 'フォローされているユーザーが表示される' do
        Relationship.create(follower_id: other_user.id, followed_id: user.id)
        visit followers_path(user.id)
        expect(page).to have_content 'other'
      end
    end
    context '他のユーザーのフォローを解除した場合' do
      it 'フォローしているユーザーにそのユーザーが表示されない' do
        Relationship.create(follower_id: user.id, followed_id: other_user.id)
        visit user_path(other_user.id)
        click_on :unfollow
        visit following_path(user.id)
        expect(page).not_to have_content 'other'
      end
    end
    context '他のユーザーにフォロー解除された場合' do
      it 'フォローされているユーザーにそのユーザーが表示されない' do
        relationship = Relationship.create(follower_id: other_user.id, followed_id: user.id)
        relationship.delete
        visit followers_path(user.id)
        expect(page).not_to have_content 'other'
      end
    end
  end
end
