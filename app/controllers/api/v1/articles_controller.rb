module Api::V1
  class ArticlesController < BaseApiController
    before_action :authenticate_user!, only: [:create, :update, :destroy]

    def index
      articles = Article.order(updated_at: :desc)
      Article.where(status: "published").order(updated_at: :desc)
      render json: articles, each_serializer: Api::V1::ArticlePreviewSerializer
    end

    def show
      article = Article.find(params[:id])
      Article.where(status: "published").order(updated_at: :desc)
      render json: article, serializer: Api::V1::ArticleSerializer
    end

    def create
      article = current_user.articles.create!(article_params)
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

    private

      def article_params
        params.require(:article).permit(:title, :body, :status)
      end
  end
end
