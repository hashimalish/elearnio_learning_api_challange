class TalentsController < ApplicationController
  before_action :set_talent, except: [:index, :create]
  before_action :set_course, only: :mark_course_completed
  before_action :set_learning_path, only: :assign_learning_path

  def index
    @talents = Talent.all

    render json: @talents
  end

  def show
    render json: @talent
  end

  def create
    @talent = Talent.new(talent_params)

    if @talent.save
      render json: @talent, status: :created, location: @talent
    else
      render json: @talent.errors, status: :unprocessable_entity
    end
  end

  def update
    if @talent.update(talent_params)
      render json: @talent
    else
      render json: @talent.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @talent.destroy
  end

  def assign_learning_path
    @talent.learning_paths << @learning_path

    render json: @talent
  end

  def mark_course_completed
    if @talent.is_course_completed?(@course)
      render json: { error: 'Course already completed' }, status: :unprocessable_entity
      return
    end

    @talent.mark_course_as_completed(@course)
    render json: { error: 'Course marked as completed for the talent' }, status: :ok
  end

  private
  
  def set_talent
    @talent = Talent.find(params[:id])
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_learning_path
    @learning_path = LearningPath.find(params[:learning_path_id])
  end

  def talent_params
    params.require(:talent).permit(:name)
  end
end
