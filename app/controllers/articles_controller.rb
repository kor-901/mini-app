class ArticlesController < ApplicationController
	def index
		@articles = Article.all
	end

	def new
		@Article = Article.new
	end

	def create
		Article.create(title: article_params[:title], text: article_params[:text], user_id: 1)
		redirect_to action: :index
	end

	private
	def article_params
		params.require(:article).permit(:title, :text)
	end
end
