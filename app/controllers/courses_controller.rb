# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]

  # get one course
  def show
    @course = Course.find(params[:id])
  end

  # get an update page for a course
  def edit
    authorize! :manage, :all
    @course = Course.find(params[:id])
  end

  # update the course
  def update
    authorize! :manage, :all

    if @course.update(course_params)
      redirect_to course_path(@course), notice: 'Success!'
    else
      render(:edit, status: :unprocessable_entity, notice: 'Unsuccessful...')
    end
  end

  # delete the course
  def destroy
    authorize! :manage, :all

    @course = Course.find(params[:id])
    if @course.destroy
      redirect_to :catalog, notice: 'Course Deleted!'
    else
      render :edit, notice: 'Unsuccessful Deletion...'
    end
  end

  # display all courses
  def index; end

  # create a new course
  def create
    authorize! :manage, :all

    @course = Course.new(course_params)

    if @course.save
      redirect_to course_path(@course), notice: 'Success!'
    else
      render(:new, status: :unprocessable_entity, notice: 'Unsuccessful...')
    end
  end

  # get to page for a new course (creation)
  def new
    authorize! :manage, :all
    @course = Course.new
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :credit_hours, :has_lab, :academic_career, :class_level, :catalog_number,
                                   :course_description)
  end
end
