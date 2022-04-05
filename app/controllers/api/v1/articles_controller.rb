module Api::V1
  class ArticlesController < BaseApiController
    before_action :authenticate_user!, only: [:create, :update, :destroy]

    def index
      binding.pry
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
      # 投稿ボタンを押下した場合
      # if params[:post]
      #   if @post_recipe.save(context: :publicize)
      #     redirect_to post_recipe_path(@post_recipe), notice: "レシピを投稿しました！"
      #   else
      #     render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      #   end

      # 下書きボタンを押下した場合
      # else
      #   if @post_recipe.update(is_draft: true)
      #     redirect_to user_path(current_user), notice: "レシピを下書き保存しました！"
      #   else
      #     render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      #   end
      # end

      article = current_user.articles.new(article_params)
      # 投稿ボタンを押下した場合
      # if params[:article]
      #   if article.save!(status: "published")
      #     redirect_to api_v1_articles_path(article), notice: "記事を公開しました!"
        if article.save!(status: "published")
          render json: article, serializer: Api::V1::ArticleSerializer
        end

      # binding.pry
      # article = current_user.articles.create!(article_params)
      # binding.pry
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
        params.require(:article).permit(:title, :body)
      end
  end
end
