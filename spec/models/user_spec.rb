require 'rails_helper'
RSpec.describe User, 'ユーザーモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context '名前が空の場合' do
      it 'バリデーションにひっかかる' do
        user = User.new(name: '', email: 'test@test.com', password: 'password', password_confirmation: 'password', profile: 'test', artist_type: 'Tuner')
        expect(user).not_to be_valid
      end
    end
    context 'アーティストタイプが空の場合' do
      it 'バリデーションにひっかかる' do
        user = User.new(name: 'test', email: 'test@test.com', password: 'password', password_confirmation: 'password', profile: 'test', artist_type: '')
        expect(user).not_to be_valid
      end
    end
  end
end
