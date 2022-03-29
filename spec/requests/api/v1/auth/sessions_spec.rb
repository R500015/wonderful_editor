require "rails_helper"

RSpec.describe "Api::V1::Auth::Sessions", type: :request do
  describe "POST /api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params) }

    context "メールアドレス、パスワードが正しいとき" do
      let(:current_user) { create(:user) }
      let(:params) { { email: current_user.email, password: current_user.password } }

      # rubocop:disable RSpec/MultipleExpectations
      it "ログインできる" do
        # rubocop:enable RSpec/MultipleExpectations

        subject
        expect(response.headers["uid"]).to be_present
        expect(response.headers["access-token"]).to be_present
        expect(response.headers["client"]).to be_present
        expect(response).to have_http_status(:ok)
      end
    end

    context "email が正しくないとき" do
      let(:current_user) { create(:user) }
      let(:params) { { email: "test@example.com", password: current_user.password } }

      # rubocop:disable RSpec/MultipleExpectations
      it "ログインができない" do
        # rubocop:enable RSpec/MultipleExpectations

        subject
        res = JSON.parse(response.body)
        expect(res["success"]).to be_falsey
        expect(res["errors"]).to include("Invalid login credentials. Please try again.")
        expect(response.headers["uid"]).to be_blank
        expect(response.headers["access-token"]).to be_blank
        expect(response.headers["client"]).to be_blank
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "password が正しくないとき" do
      let(:current_user) { create(:user) }
      let(:params) { { email: current_user.email, password: "12345678" } }

      # rubocop:disable RSpec/MultipleExpectations
      it "ログインができない" do
        # rubocop:enable RSpec/MultipleExpectations

        subject
        res = JSON.parse(response.body)
        expect(res["success"]).to be_falsey
        expect(res["errors"]).to include("Invalid login credentials. Please try again.")
        expect(response.headers["uid"]).to be_blank
        expect(response.headers["access-token"]).to be_blank
        expect(response.headers["client"]).to be_blank
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /api/v1/auth/sign_out" do
    subject { delete(destroy_api_v1_user_session_path, headers: headers) }

    context "ログアウトに必要な情報を送信したとき" do
      let(:current_user) { create(:user) }
      let(:headers) { current_user.create_new_auth_token }

      # rubocop:disable RSpec/MultipleExpectations
      it "ログアウトできる" do
        # rubocop:enable RSpec/MultipleExpectations
        subject
        res = JSON.parse(response.body)
        expect(res["success"]).to be_truthy
        expect(current_user.reload.tokens).to be_blank
        expect(response).to have_http_status(:ok)
      end
    end

    context "誤った情報を送信したとき" do
      let(:user) { create(:user) }
      let!(:headers) { { "access-token" => "", "token-type" => "", "client" => "", "expiry" => "", "uid" => "" } }

      # rubocop:disable RSpec/MultipleExpectations
      it "ログアウトできない" do
        # rubocop:enable RSpec/MultipleExpectations
        subject
        expect(response).to have_http_status(:not_found)
        res = JSON.parse(response.body)
        expect(res["errors"]).to include "User was not found or was not logged in."
      end
    end
  end
end
