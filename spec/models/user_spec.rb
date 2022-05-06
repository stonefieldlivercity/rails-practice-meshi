require  'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でない' do
        user.name = ''
        is_expected.to eq false
      end
      it '一意性があること' do
        user.name = other_user.name
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'PostImageモデルとの関係' do
      it '1:nとなっている' do
        expect(User.reflect_on_association(:post_images).macro).to eq :has_many
      end
    end
  end
end