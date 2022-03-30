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

      # rubocop:disable RSpec/MultipleExpectations
      it "その記事のレコードが取得できる" do
        # rubocop:enable RSpec/MultipleExpectations
        subject
        res = JSON.parse(response.body)
        expect(res["id"]).to eq article.id
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(response).to have_http_status(:ok)
      end
    end

    context "指定した idの記事 が存在しないとき" do
      let(:article_id) { 77777 }

      it "その記事が見つからない" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "POST /api/v1/articles" do
    # subject { post(api_v1_articles_path, params: params, headers: headers) }
    subject { post(api_v1_articles_path, params: params, params, headers: headers) }

    let(:params) { { article: attributes_for(:article) } }
    let(:current_user) { create(:user) }
    # before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

    # rubocop:disable RSpec/MultipleExpectations
    fit "ユーザーのレコードが作成できる" do
      # rubocop:enable RSpec/MultipleExpectations
      binding.pry
      expect { subject }.to change { Article.where(user_id: current_user.id).count }.by(1)
      res = JSON.parse(response.body)
      expect(res["title"]).to eq params[:article][:title]
      expect(res["body"]).to eq params[:article][:body]
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH /api/v1/articles/:id" do
    subject { patch(api_v1_article_path(article.id), params: params) }

    let(:params) { { article: attributes_for(:article) } }
    let(:current_user) { create(:user) }
    before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

    context "自分が所持している記事のレコードを更新しようとするとき" do
      let(:article) { create(:article, user: current_user) }

      # rubocop:disable RSpec/MultipleExpectations
      it "記事を更新できる" do
        # rubocop:enable RSpec/MultipleExpectations
        expect { subject }.to change { article.reload.title }.from(article.title).to(params[:article][:title]) &
                              change { article.reload.body }.from(article.body).to(params[:article][:body])
        expect(response).to have_http_status(:ok)
      end
    end

    context "自分が所持していない記事のレコードを更新しようとするとき" do
      let(:other_user) { create(:user) }
      let!(:article) { create(:article, user: other_user) }

      it "更新できない" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "DELETE /api/v1/articles/:id" do
    subject { delete(api_v1_article_path(article_id)) }

    let(:current_user) { create(:user) }
    let(:article_id) { article.id }
    before { allow_any_instance_of(Api::V1::BaseApiController).to receive(:current_user).and_return(current_user) }

    context "自分の記事を削除しようとするとき" do
      let!(:article) { create(:article, user: current_user) }

      # rubocop:disable RSpec/MultipleExpectations
      it "記事を削除できる" do
        # rubocop:enable RSpec/MultipleExpectations
        expect { subject }.to change { Article.count }.by(-1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "他人が所持している記事のレコードを削除しようとするとき" do
      let(:other_user) { create(:user) }
      let!(:article) { create(:article, user: other_user) }

      it "記事を削除できない" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound) &
                              change { Article.count }.by(0)
      end
    end
  end
end
