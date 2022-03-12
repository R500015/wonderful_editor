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
  context "記事のタイトルが指定しているとき" do
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
end
