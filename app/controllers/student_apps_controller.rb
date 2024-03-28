# frozen_string_literal: true

class StudentAppsController < ApplicationController
  before_action :set_student_app, only: %i[edit update destroy]
  before_action -> { check_user(@student_app.student_email) }, only: %i[edit update destroy]

  # get one student_app
  def show
    authorize! :submit_forms, StudentApp
  end

  # get an update page for an student_app
  def edit
    authorize! :submit_forms, StudentApp

    @student_app = StudentApp.find(params[:id])
  end

  # update the student_app
  def update
    authorize! :submit_forms, StudentApp

    if @student_app.update(student_app_params)
      redirect_to student_app_show_path, notice: 'Successful application update.'
    else
      render(:edit, status: :unprocessable_entity, notice: 'Unsuccessful update')
    end
  end

  # delete the student_app
  def destroy
    authorize! :submit_forms, StudentApp

    @student_app = StudentApp.find(params[:id])
    if @student_app.destroy
      redirect_to student_app_show_path, notice: 'Application deleted successfully.'
    else
      render :edit, notice: 'Unsuccessful Deletion...'
    end
  end

  # display all student applications
  def index
    @student_apps = StudentApp.all
  end

  # create a new student_app
  def create
    authorize! :submit_forms, StudentApp

    @user = User.find(current_user.id)
    @student_app = @user.student_app.new(student_app_params)
    if @student_app.save
      redirect_to student_app_show_path, notice: 'Successful application submission.'
    else
      render(:new, status: :unprocessable_entity, notice: 'Unsuccessful...')
    end
  end

  # get to page for a new student_app (creation)
  def new
    authorize! :submit_forms, StudentApp

    @student_app = StudentApp.new
  end

  private

  # get a specific section by its id
  def set_student_app
    @student_app = StudentApp.find(params[:id])
  end

  def student_app_params
    params.require(:student_app).permit(:first_name, :last_name, :student_email, :campus_name, :term,
                                        :preferred_course)
  end
end
