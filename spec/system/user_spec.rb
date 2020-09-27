require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  describe '新規作成機能' do
    context 'ユーザーを新規作成した場合' do
      it '作成したユーザーが表示される' do
        visit  new_user_registration_path
        fill_in :user_name, with: 'user'
        fill_in :user_email, with: 'user@user.com'
        attach_file('user_icon', 'app/assets/images/fallback/show_icon_default.png')
        choose 'user_artist_type_tuner'
        fill_in :user_profile, with: 'test'
        fill_in :user_password, with: 'password'
        fill_in :user_password_confirmation, with: 'password'
        click_on "Sign up"
        expect(page).to have_content 'user'
      end
    end
    context 'ユーザがログインせずユーザー詳細画面に飛ぼうとした場合' do
      it 'ログイン画面に遷移する' do
        visit user_path(user.id)
        expect(page).to have_content 'ログイン'
      end
    end
  end
  describe '編集機能' do
    context 'ユーザー編集画面に遷移したとき' do
      before do
        visit new_user_session_path
        fill_in :user_email, with: 'test@email.com'
        fill_in :user_password, with: 'password'
        click_on "Log in"
      end
      it '画面の遷移ができる' do
        visit edit_user_registration_path
        expect(page).to have_content 'Edit'
      end
      it 'タイトルの編集ができる。' do
        
      end
    end
  end
  describe 'ログイン機能' do
    context 'ログインした場合' do
      it 'ログインすることができる' do
        visit new_user_session_path
        fill_in :user_email, with: 'test@email.com'
        fill_in :user_password, with: 'password'
        click_on "Log in"
        expect(page).to have_content 'test_name'
      end
      it 'ユーザー詳細ページにアクセスできる' do
        visit new_user_session_path
        fill_in :user_email, with: 'test@email.com'
        fill_in :user_password, with: 'password'
        click_on "Log in"
        visit user_path(user.id)
        expect(page).to have_content 'プロフィール'
      end
      it 'ログアウトができる' do
        visit new_user_session_path
        fill_in :user_email, with: 'test@email.com'
        fill_in :user_password, with: 'password'
        click_on "Log in"
        click_on "ログアウト"
        expect(page).to have_content 'ログイン'
      end
    end
  end
end
