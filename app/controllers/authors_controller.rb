class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :update, :destroy]
  before_action :set_replacement_author, only: :destroy

  def index
    @authors = Author.all

    render json: @authors
  end

  def show
    render json: @author
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      render json: @author, status: :created, location: @author
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  def update
    if @author.update(author_params)
      render json: @author
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  # DELETE /courses/1?replacement_author_id=?
  def destroy
    @author.courses.each do |course|
      course.update(author: @replacement_author)
    end
 
    @author.destroy!
    render json: { success: true }
  end

  private
    def set_author
      @author = Author.find(params[:id])
    end

    def set_replacement_author 
      @replacement_author = Author.find(params[:replacement_author_id])
    end

    def author_params
      params.require(:author).permit(:name)
    end
end
