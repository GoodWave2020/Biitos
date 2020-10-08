require 'rails_helper'
RSpec.describe Label, type: :model do
  describe 'バリデーションのテスト' do
    context 'nameを空にした場合' do
      it 'バリデーションに引っかかる' do
        label = Label.new(name: '')
        expect(label).not_to be_valid
      end
    end
  end
end
