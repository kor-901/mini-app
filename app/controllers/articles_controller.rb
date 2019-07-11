class ArticlesController < ApplicationController
	before_action :move_to_index, except: [:index, :show]
	before_action :set_article, only: [:show, :edit, :update, :destroy]

	def index
		@articles = Article.includes(:user).order("created_at DESC")
	end

	def new
		@article = Article.new
	end

	def create
		Article.create(title: article_params[:title], text: article_params[:text], user_id: current_user.id)
		redirect_to action: :index
	end

	def edit
	end

	def update
		@article.update(article_params) if @article.user_id == current_user.id
		redirect_to action: :index
	end

	def destroy
		@article.destroy if @article.user_id == current_user.id
		redirect_to action: :index
	end

	def show
	end

	private
	def article_params
		params.require(:article).permit(:title, :text)
	end

	def move_to_index
		redirect_to action: :index unless user_signed_in?
	end

	def set_article
		@article = Article.find(params[:id])
	end
end
