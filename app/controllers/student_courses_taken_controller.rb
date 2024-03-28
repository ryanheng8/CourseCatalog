# frozen_string_literal: true

class StudentCoursesTakenController < ApplicationController
  before_action :set_student_courses_taken, only: %i[edit update destroy]
  before_action -> { check_user(@student_courses_taken.student_email) }, only: %i[edit update destroy]

  # get one course taken
  def show
    authorize! :submit_forms, StudentCoursesTaken
  end

  # get an update page for an course taken
  def edit
    authorize! :submit_forms, StudentCoursesTaken

    @student_courses_taken = StudentCoursesTaken.find(params[:id])
  end

  # update the course taken
  def update
    authorize! :submit_forms, StudentCoursesTaken

    if @student_courses_taken.update(student_courses_taken_params)
      redirect_to student_courses_taken_show_path, notice: 'Successful courses taken update.'
    else
      render(:edit, status: :unprocessable_entity, notice: 'Unsuccessful update')
    end
  end

  # delete the course taken
  def destroy
    authorize! :submit_forms, StudentCoursesTaken

    @student_courses_taken = StudentCoursesTaken.find(params[:id])
    if @student_courses_taken.destroy
      redirect_to student_courses_taken_show_path, notice: 'Course deleted successfully.'
    else
      render :edit, notice: 'Unsuccessful Deletion...'
    end
  end

  # display all student courses taken
  def index
    @student_courses_takens = StudentCoursesTaken.all
  end

  # create a new course taken
  def create
    authorize! :submit_forms, StudentCoursesTaken

    @user = User.find(current_user.id)
    @student_courses_taken = @user.student_courses_takens.new(student_courses_taken_params)
    if @student_courses_taken.save
      redirect_to student_courses_taken_show_path, notice: 'Successful course submission.'
    else
      render(:new, status: :unprocessable_entity, notice: 'Unsuccessful...')
    end
  end

  # get to page for a new couse taken (creation)
  def new
    authorize! :submit_forms, StudentCoursesTaken

    @student_courses_taken = StudentCoursesTaken.new
  end

  private

  # get a specific couse taken by its id
  def set_student_courses_taken
    @student_courses_taken = StudentCoursesTaken.find(params[:id])
  end

  def student_courses_taken_params
    params.require(:student_courses_taken).permit(:student_email, :course, :grade)
  end
end
