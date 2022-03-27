require "rails_helper"

RSpec.describe "Api::V1::Auth::Sessions", type: :request do
  describe "POST /api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params, headers: token) }

    context "ログインが上手くいく場合" do
      before { create(:user, name: "bbb", email: "bbb@example.com", password: "bbbbbbbb", password_confirmation: "bbbbbbbb") }
      # let!(:user) { { name: "bbb", email: "bbb@example.com", password: "bbbbbbbb" } }
      let(:params) { attributes_for(:user) }
      # binding.pry
      let(:token) { sign_in user }

      fit "正しい情報を入力すればユーザーはログインができる" do
        subject
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
