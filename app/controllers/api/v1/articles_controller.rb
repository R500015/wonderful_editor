module Api::V1
  class ArticlesController < BaseApiController
    # before_action :authenticate_api_v1_user!, only: [:create, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    alias_method :devise_current_user, :current_user
    # before_action :authenticate_api_v1_user!
    # before_action :authenticate_user!

    def index
      articles = Article.order(updated_at: :desc)
      render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
    end

    def show
      article = Article.find(params[:id])
      render json: article, serializer: Api::V1::ArticleSerializer
    end

    def create
      binding.pry
      article = current_api_v1_user.articles.create!(article_params)
      binding.pry
      render json: article, serializer: Api::V1::ArticleSerializer
    end

    def update
      article = current_user.articles.find(params[:id])
      article.update!(article_params)
      render json: article, serializer: Api::V1::ArticleSerializer
    end

    def destroy
      article = current_user.articles.find(params[:id])
      article.destroy!
      render json: article, serializer: Api::V1::ArticleSerializer
    end

    def current_user
      user = User.create!(user_params)
      articles = current_user.articles
      #logic to get a handle on current user goes here
    end

    # alias_method current_user create
    # alias authenticate_user! authenticate_api_v1_user!
    # alias_method authenticate_user! authenticate_api_v1_user!
    # alias mse metroway

    private

      def article_params
        params.require(:article).permit(:title, :body)
      end

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
  end
end
