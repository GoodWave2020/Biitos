require 'rails_helper'
RSpec.describe '投稿機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user, title: 'first') }
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
        (all('.ui-widget-content')[1]).set('test')
        click_on '登録する'
        expect(page).not_to have_content 'test'
      end
    end
  end
  describe '一覧表示機能' do
    let!(:latest_post) {FactoryBot.create(:post, user: user, title: 'latest_post', genre: 'RnB' )}
    before do
      visit posts_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みの投稿一覧が表示される' do
        visit posts_path
        expect(page).to have_content 'first'
      end
    end
    context '投稿が作成日時の降順に並んでいる場合' do
      it '新しい投稿が一番上に表示される' do
        post_list = all('.post_contents')
        expect(post_list[0]).to have_content 'latest_post'
      end
    end
    context 'ジャンルでソートをかけた場合' do
      it '他のジャンルの曲は表示されない' do
        select 'RnB', from: :q_genre_eq
        click_on '検索'
        within '.col-md-8' do
          expect(page).to have_content 'RnB'
          expect(page).not_to have_content 'Hiphop'
        end
      end
    end
    context 'タイトルで検索した場合' do
      it '検索ワードの入っていないタイトルは表示されない' do
        fill_in :q_title_or_labels_name_cont_any, with: 'latest_post'
        click_on '検索'
        expect(page).not_to have_content 'first'
        expect(page).to have_content 'latest'
      end
    end
    context 'タグで検索した場合' do
      it '検索したタグ以外表示されない' do
        visit new_post_path
        fill_in :post_title, with: 'tag-test'
        attach_file :post_music, 'spec/fixtures/velvet_extended.mp3'
        select 'Voice', from: :post_music_type
        select 'Jazz', from: :post_genre
        (all('.ui-widget-content')[1]).set('ableton')
        click_on '登録する'
        fill_in :q_title_or_labels_name_cont_any, with: 'ableton'
        click_on '検索'
        expect(page).not_to have_content 'first'
        expect(page).to have_content 'tag-test'
      end
    end
  end
end
