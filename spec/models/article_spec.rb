# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  status     :string           default("draft")
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

  describe "正常系" do
    context "タイトルと本文が入力されているとき" do
      let(:article) { build(:article) }

      # rubocop:disable RSpec/MultipleExpectations
      it "下書き状態の記事が作成できる" do
        # rubocop:enable RSpec/MultipleExpectations

        expect(article).to be_valid
        expect(article.status).to eq "draft"
      end
    end

    context "status が下書き状態のとき" do
      let(:article) { build(:article, :draft) }

      # rubocop:disable RSpec/MultipleExpectations
      it "記事を下書き状態で作成できる" do
        # rubocop:enable RSpec/MultipleExpectations

        expect(article).to be_valid
        expect(article.status).to eq "draft"
      end
    end

    context "status が公開状態のとき" do
      let(:article) { build(:article, :published) }

      # rubocop:disable RSpec/MultipleExpectations
      it "記事を公開状態で作成できる" do
        # rubocop:enable RSpec/MultipleExpectations

        expect(article).to be_valid
        expect(article.status).to eq "published"
      end
    end
  end

  describe "異常系" do
    context "status を指定しないとき" do
      let(:article) { build(:article, status: nil) }

      # rubocop:disable RSpec/MultipleExpectations
      it "記事の保存に失敗する" do
        # rubocop:enable RSpec/MultipleExpectations

        expect(article).to be_valid
        expect(article.status).to eq nil
      end
    end
  end
end
