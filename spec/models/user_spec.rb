require "rails_helper"

RSpec.describe User, type: :model do
  context "name を指定しているとき" do
    let(:user) { build(:user) }

    it "ユーザーが作られる" do
      expect(user).to be_valid
    end
  end

  context "名前を入力していないとき" do
    let(:user) { build(:user, name: nil) }

    it "ユーザー作成に失敗する" do
      expect(user).not_to be_valid
    end
  end

  context "名前のみ入力している場合" do
    let(:user) { build(:user, email: nil, password: nil) }

    it "エラーが発生する" do
      expect(user).not_to be_valid
    end
  end

  context "email がない場合" do
    let(:user) { build(:user, email: nil) }

    it "エラーが発生する" do
      expect(user).not_to be_valid
    end
  end

  context "password がない場合" do
    let(:user) { build(:user, password: nil) }

    it "エラーが発生する" do
      expect(user).not_to be_valid
    end
  end
end
