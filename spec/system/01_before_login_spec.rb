# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザーログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context "表示内容が正しい" do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
    end

    context 'リンクの確認' do
      it 'アバウトリンクが存在しているか' do
        expect(page).to have_link 'アバウト', href: about_path
      end
      it '新規登録リンクが存在しているか' do
        expect(page).to have_link '新規登録', href: new_user_registration_path
      end
      it 'ログインリンクが存在しているか' do
        expect(page).to have_link 'ログイン', href: new_user_session_path
      end
    end
  end

  describe 'アバウト画面のテスト' do
    before do
      visit about_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/about'
      end
    end
  end

  describe 'ユーザー新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「Sign up」と表示される' do
        expect(page).to have_content 'Sign up'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_button 'Sign up'
      end
    end
  end
end