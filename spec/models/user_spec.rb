require 'rails_helper'

RSpec.describe User, type: :model do
  context "name を指定しているとき" do
    it "ユーザーが作られる" do
      user = build(:user)
      expect(user).to be_valid
    end
  end

  context "name を指定していないとき" do
    it "ユーザー作成に失敗する" do
      user = build(:user, name: nil)
      expect(user).to be_invalid
      expect(user.errors.details[:name][0][:error]).to eq :blank
    end
  end
end
