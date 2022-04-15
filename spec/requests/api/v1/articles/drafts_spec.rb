require "rails_helper"

RSpec.describe "Drafts", type: :request do
  let(:current_user) { create(:user) }
  let(:headers) { current_user.create_new_auth_token }

  describe "GET /api/v1/articles/draft" do
    subject { get(api_v1_articles_drafts_path, headers: headers) }

    context "下書きページにアクセスするとき" do
      let!(:article) { create(:article, :draft, user: current_user) }
      let!(:other_article) { create(:article, :draft) }

      # rubocop:disable RSpec/MultipleExpectations
      it "自分（ログインしているユーザー）の書いた 下書き記事 が取得できる" do
        # rubocop:enable RSpec/MultipleExpectations

        subject
        res = JSON.parse(response.body)
        expect(res.count).to eq 1
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /api/v1/articles/draft/:id" do
    subject { get(api_v1_articles_draft_path(article_id), headers: headers) }

    context "指定した id の記事が存在して" do
      let(:article_id) { article.id }

      context "下書き（詳細）ページにアクセスするとき" do
        let(:article) { create(:article, :draft, user: current_user) }

        # rubocop:disable RSpec/MultipleExpectations
        it "自分（ログインしているユーザー）が書いた 任意の下書き記事 が取得できる" do
          # rubocop:enable RSpec/MultipleExpectations

          subject
          res = JSON.parse(response.body)
          expect(res["status"]).to eq "draft"
          expect(res["status"]).to eq article.status
        end
      end

      context "対象の記事が他のユーザーが書いた下書きのとき" do
        let(:article) { create(:article, :draft) }

        it "記事が見つからない" do
          expect { subject }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end
  end
end
