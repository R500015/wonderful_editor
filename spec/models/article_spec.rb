# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  status     :integer          default("draft"), not null
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


  # やりたいこと
  # statusに draft が定義されているとき(status: :draft)、 下書き記事として保存することができる。

  # context "下書き(draft)を指定しているとき" do
  #   let(:article) { create(:article, title: "foo", status: :draft) }

  #   it "下書き記事として保存することができる" do
  #     expect(article.draft?).to eq true
  #     expect(article.status).to eq "draft"
  #   end
  # end

  context "status: draft を指定したとき" do
    article = Article.new
    article.title = "foo"
    article.status = :draft

    it "下書き記事の保存に成功する" do
      expect(article.draft?).to eq true
      expect(article.status).to eq "draft"
      expect(article.save).to be_truthy
    end
  end

  # やりたいこと
  # statusに draft が定義されていないとき(status: :published)、 下書き記事としての保存に失敗する。
  # context "下書き(draft)を指定していないとき" do
  #   article = Article.new
  #   article.status = :published

  #   it "下書き記事としての保存に失敗する" do
  #     expect(article.draft?).to eq false
  #     expect(article.status).to eq "published"
  #     expect(article.save).to be_falsey
  #   end
  # end

  context "status: published を指定したとき" do
    article = Article.new
    article.title = "hoge"
    article.status = :published

    it "公開記事の保存に成功する" do
      expect(article.published?).to eq true
      expect(article.status).to eq "published"
      expect(article.save).to be_truthy
    end
  end

  context "status を指定しないとき" do
    fit "記事の保存に失敗する" do
      article = Article.new
      article.title = "hoge"
      binding.pry
      # expect(article).to be_valid
      # binding.pry
    end
  end
end
