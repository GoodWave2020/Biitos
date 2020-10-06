require 'rails_helper'
RSpec.describe '投稿機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user) }
  before do
    visit new_user_session_path
    fill_in :user_email, with: 'test@email.com'
    fill_in :user_password, with: 'password'
    click_on "Log in"
  end
  describe '新規作成機能' do
    context '投稿を新規作成した場合' do
      it '作成した投稿が表示される' do
        visit new_post_path
        fill_in :post_title, with: 'test'
        attach_file :post_music, 'spec/fixtures/velvet_extended.mp3'
        select 'Voice', from: :post_music_type
        select 'Jazz', from: :post_genre
        click_on '登録する'
        expect(page).to have_content 'test'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みの投稿一覧が表示される' do
      end
    end
    context '投稿が作成日時の降順に並んでいる場合' do
      it '新しい投稿が一番上に表示される' do
      end
    end
    context 'ジャンルでソートをかけた場合' do
      it '他のジャンルの曲は表示されない' do
      end
    end
    context 'タイトルで検索した場合' do
      it '検索ワードの入っていないタイトルは表示されない' do
      end
    end
  end
end
