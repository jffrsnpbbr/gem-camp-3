class PostsController < ApplicationController
  require 'csv'

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :validate_post_owner, only: %i[edit update destroy]

  def index
    @posts = Post.includes(:categories, :user).page params[:pages]
    respond_to do |format|
      format.html
      format.csv {
        csv_string = CSV.generate do |csv|
          csv << [
            User.human_attribute_name(:email),
            Post.human_attribute_name(:id),
            Post.human_attribute_name(:title),
            Post.human_attribute_name(:content),
            Post.human_attribute_name(:categories),
            Post.human_attribute_name(:created_at)
          ]

          @posts.each do |p|
            csv << [
              p.user&.email,
              p.id,
              p.title,
              p.content,
              p.categories.pluck(:name).join(','),
              p.created_at
            ]
          end
        end
        render plain: csv_string
      }
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def validate_post_owner
    return if @post.user == current_user

    flash[:notice] = 'the post not belongs to you'
    redirect_to posts_path
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, category_ids: [])
  end
end
