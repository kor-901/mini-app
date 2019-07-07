class ArticlesController < ApplicationController
	before_action :move_to_index, except: :index

	def index
		@articles = Article.all.order("created_at DESC")
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

	def move_to_index
		redirect_to action: :index unless user_signed_in?
	end
end
