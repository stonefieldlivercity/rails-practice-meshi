require 'rails_helper'

describe 'ユーザーログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post_image) { create(:post_image, user: user) }
  let!(:other_post_image) { create(:post_image, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit post_images_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/post_images'
      end
      it 'ユーザーページのリンクが正しい' do
        expect(page).to have_link '', href: user_path(post_image.user)
      end
      it '投稿詳細ページへのリンクが正しい' do
        expect(page).to have_link post_image.shop_name, href: post_image_path(post_image)
        expect(page).to have_link other_post_image.shop_name, href: post_image_path(other_post_image)
      end
      it '投稿の概要の表示' do
        expect(page).to have_content post_image.caption
        expect(page).to have_content other_post_image.caption
      end
    end
  end
  describe '投稿詳細のテスト' do
    before do
      visit post_image_path(post_image)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/post_images/' + post_image.id.to_s
      end
    end
  end

  describe '新規投稿のテスト' do
    before do
      visit new_post_image_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/post_images/new'
      end
      it 'ショップ名フォーム' do
        expect(page).to have_field 'post_image[shop_name]'
      end
      it '説明フォーム' do
        expect(page).to have_field 'post_image[caption]'
      end
      it '投稿ボタンがある' do
        expect(page).to have_button '投稿'
      end
    end

    context '投稿成功のテスト' do
      before do
        fill_in 'post_image[shop_name]', with: Faker::Lorem.characters(number: 6)
        fill_in 'post_image[caption]', with: Faker::Lorem.characters(number: 10)
        attach_file 'post_image[image]', File.join(Rails.root, 'spec/fixtures/no_image.jpg')
      end

      it '投稿内容が保存されるか' do
        expect { click_button '投稿' }.to change(user.post_images, :count).by(1)
      end
    end
  end
end