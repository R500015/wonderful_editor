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
  context "コメントの本文が指定されているとき" do
    it "コメントが作られる" do
      user = create(:user)
      article = create(:article)
      comment = build(:comment)
      expect(comment).to be_valid
    end
  end

  context "body を指定していないとき" do
    it "コメント作成に失敗する" do
      comment = build(:comment, body: nil)
      expect(comment).to be_invalid
      expect(comment.errors.details[:body][0][:error]).to eq :blank
    end
  end
end
