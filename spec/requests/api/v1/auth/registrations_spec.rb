require "rails_helper"

RSpec.describe "Api::V1::Auth::Registrations", type: :request do
  describe "POST /api/v1/auth" do
    subject { post(api_v1_user_registration_path, params: params) }

    context "新規登録が上手くいく場合" do
      let(:params) { attributes_for(:user) }

      # rubocop:disable RSpec/MultipleExpectations
      it "正しい情報を入力すればユーザーは新規登録ができる" do
        # rubocop:enable RSpec/MultipleExpectations
        expect { subject }.to change { User.count }.by(1)
        expect(response).to have_http_status(:ok)
        res = JSON.parse(response.body)
        expect(res["data"]["name"]).to eq params[:name]
        expect(res["data"]["email"]).to eq(User.last.email)
      end

      # rubocop:disable RSpec/MultipleExpectations
      it "header 情報を取得することができる" do
        # rubocop:enable RSpec/MultipleExpectations
        subject
        header = response.header
        expect(header["access-token"]).to be_present
        expect(header["client"]).to be_present
        expect(header["expiry"]).to be_present
        expect(header["uid"]).to be_present
        expect(header["token-type"]).to be_present
      end
    end

    context "name が存在しないとき" do
      let(:params) { attributes_for(:user, name: nil) }

      # rubocop:disable RSpec/MultipleExpectations
      it "エラーする" do
        # rubocop:enable RSpec/MultipleExpectations
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["name"]).to include "can't be blank"
      end
    end

    context "email が存在しないとき" do
      let(:params) { attributes_for(:user, email: nil) }

      # rubocop:disable RSpec/MultipleExpectations
      it "エラーする" do
        # rubocop:enable RSpec/MultipleExpectations
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["email"]).to include "can't be blank"
      end
    end

    context "password が存在しないとき" do
      let(:params) { attributes_for(:user, password: nil) }

      # rubocop:disable RSpec/MultipleExpectations
      it "エラーする" do
        # rubocop:enable RSpec/MultipleExpectations
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["password"]).to include "can't be blank"
      end
    end
  end
end
