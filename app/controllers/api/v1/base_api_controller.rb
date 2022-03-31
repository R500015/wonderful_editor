class Api::V1::BaseApiController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!, except: [:index, :show]
  alias :authenticate_user! :authenticate_api_v1_user!

  def current_api_v1_user
  article = current_api_v1_user.articles
  end

  Api::V1::BaseApiController.new.create
  alias_method :current_user, :current_api_v1_user

  def create
    article = current_api_v1_user.articles.create!(article_params)
    render json: article, serializer: Api::V1::ArticleSerializer
  end

  Api::V1::BaseApiController.new.create
  alias_method :current_create, :create

  def update
    article = current_api_v1_user.articles.find(params[:id])
    article.update!(article_params)
    render json: article, serializer: Api::V1::ArticleSerializer
  end

  Api::V1::BaseApiController.new.update
  alias_method :current_update, :update

  def destroy
    article = current_api_v1_user.articles.find(params[:id])
    article.destroy!
    render json: article, serializer: Api::V1::ArticleSerializer
  end

  Api::V1::BaseApiController.new.destroy
  alias_method :current_destroy, :destroy
end
