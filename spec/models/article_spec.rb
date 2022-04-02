# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  status     :integer          default(0), not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Article, type: :model do
  context "記事のタイトルが指定されているとき" do
    let(:user) { create(:user) }
    let(:article) { build(:article) }

    it "記事が作られる" do
      expect(article).to be_valid
    end
  end

  context "タイトルを入力していないとき" do
    let(:article) { build(:article, title: nil) }

    it "記事作成に失敗する" do
      expect(article).not_to be_valid
    end
  end

  # enum state: { draft: 0, published: 1, deleted: 2 }
  # article = Article.new(status: :draft)
  # Article.statuses # => { draft: 0, published: 1 }
  # article = Article.new(status: Article.statuses[:draft]) のように使える

  # やりたいこと
  # statusに draft が定義されているとき(status: :draft)、 下書き記事として保存することができる。
  # enum state: { draft: 0, published: 1 }
  # user = FactoryBot.create(:user)
  # let(:user) { create(:user) }
  context "下書き(draft)を指定しているとき" do
    # let!(:article) { build(:article) }
    # binding.pry
    # let(:article) { create(:article, title: "foo", status: :draft) }

    fit "下書き記事として保存することができる" do
      # article = build(:article, status: :draft)
      # article = Article.create!(title: "foo", status: :draft)
      article = Article.new(title: "foo", status: 0)
      binding.pry
      # expect(article.draft?).to eq true
      expect(0).to eq 0

      # expect(article.status).to eq true
      # expect(user.valid?).to eq true
      # user = build(:user, account: "foo")
      # article = Article.new(status: :draft)
      # expect(article).to be_valid
    end
  end


  # やりたいこと
  # statusに draft が定義されていないとき(status: :published)、 下書き記事としての保存に失敗する。
  # enum state: { draft: 0, published: 1 }
  # context "下書き(draft)を指定していないとき" do
  #   let(:user) { create(:user) }
  #   let(:article) { build(:article) }

  #   it "下書き記事としての保存に失敗する" do
  #     expect(article).to be_valid
  #   end
  # end


  # やりたいこと
  # statusに published が定義されているとき(status: :published)、 公開記事として保存することができる。
  # enum state: { draft: 0, published: 1 }
  # context "公開(published)を指定しているとき" do
  #   let(:user) { create(:user) }
  #   let(:article) { build(:article) }

  #   it "公開記事として保存することができる" do
  #     expect(article).to be_valid
  #   end
  # end


  # やりたいこと
  # statusに published が定義されていないとき(status: :published)、 公開記事としての保存に失敗する。
  # enum state: { draft: 0, published: 1 }
  # context "公開(published)を指定していないとき" do
  #   let(:user) { create(:user) }
  #   let(:article) { build(:article) }

  #   it "公開記事としての保存に失敗する" do
  #     expect(article).to be_valid
  #   end
  # end
end
