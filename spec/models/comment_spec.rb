# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Comment, type: :model do
  context "コメントの本文が記述されているとき" do
    let(:user) { create(:user) }
    let(:article) { create(:article) }
    let(:comment) { build(:comment) }

    it "コメントが作られる" do
      expect(comment).to be_valid
    end
  end

  context "本文を入力していないとき" do
    let(:comment) { build(:comment, body: nil) }

    it "コメント作成に失敗する" do
      expect(comment).not_to be_valid
    end
  end
end
