class ArticlesController < ApplicationController
	before_action :move_to_index, except: [:index, :show]

	def index
		@articles = Article.all.order("created_at DESC")
	end

	def new
		@article = Article.new
	end

	def create
		Article.create(title: article_params[:title], text: article_params[:text], user_id: current_user.id)
		redirect_to action: :index
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		article = Article.find(params[:id])
		article.update(article_params) if article.user_id == current_user.id
		redirect_to action: :index
	end

	def destroy
		article = Article.find(params[:id])
		article.destroy if article.user_id == current_user.id
		redirect_to action: :index
	end

	def show
		@article = Article.find(params[:id])
	end

	private
	def article_params
		params.require(:article).permit(:title, :text)
	end

	def move_to_index
		redirect_to action: :index unless user_signed_in?
	end
end
