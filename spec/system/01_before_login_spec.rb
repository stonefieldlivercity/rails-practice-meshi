# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザーログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end
  end

  context "表示内容が正しい" do
    it 'URLが正しい' do
      expect(current_path).to eq '/'
    end
  end

end