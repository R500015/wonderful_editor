# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
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
    it "記事が作られる" do
      user = FactoryBot.create(:user)
      article = build(:article)
      expect(article).to be_valid
    end
  end

  context "title を指定していないとき" do
    it "記事作成に失敗する" do
      article = build(:article, title: nil)
      expect(article).to be_invalid
      expect(article.errors.details[:title][0][:error]).to eq :blank
    end
  end
end
