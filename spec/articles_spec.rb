require "rails_helper"

RSpec.describe "Api::V1::Articles", type: :request do
  describe "GET /api/v1/articles" do
    subject { get(api_v1_articles_path) }

    let!(:article1) { create(:article, updated_at: 1.days.ago) }
    let!(:article2) { create(:article, updated_at: 2.days.ago) }
    let!(:article3) { create(:article) }

    it "記事の一覧が取得できる" do
      subject
      res = JSON.parse(response.body)

      expect(res.map {|d| d["id"] }).to eq [article3.id, article1.id, article2.id]
    end
  end

  describe "GET /api/v1/articles/:id" do
    subject { get(api_v1_article_path(article_id)) }

    context "指定した idの記事 が存在するとき" do
      let(:article_id) { article.id }
      let(:article) { create(:article) }

      it "その記事のレコードが取得できる" do
        subject

        res = JSON.parse(response.body)
        expect(res["id"]).to eq article.id
      end
    end

    context "指定した idの記事 が存在しないとき" do
      let(:article_id) { 77777 }

      it "その記事が見つからない" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
