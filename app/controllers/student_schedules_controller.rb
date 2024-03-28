# frozen_string_literal: true

class StudentSchedulesController < ApplicationController
  before_action :set_student_schedule, only: %i[edit update destroy]
  before_action -> { check_user(@student_schedule.student_email) }, only: %i[edit update destroy]

  # get one student_schedule
  def show
    authorize! :submit_forms, StudentSchedule
  end

  # get an update page for an student_schedule
  def edit
    authorize! :submit_forms, StudentSchedule

    @student_schedule = StudentSchedule.find(params[:id])
  end

  # update the student_schedule
  def update
    authorize! :submit_forms, StudentSchedule

    if @student_schedule.update(student_schedule_params)
      redirect_to student_schedule_show_path, notice: 'Successful schedule update.'
    else
      render(:edit, status: :unprocessable_entity, notice: 'Unsuccessful update')
    end
  end

  # delete the student_schedule
  def destroy
    authorize! :submit_forms, StudentSchedule

    @student_schedule = StudentSchedule.find(params[:id])
    if @student_schedule.destroy
      redirect_to student_schedule_show_path, notice: 'Application deleted successfully.'
    else
      render :edit, notice: 'Unsuccessful Deletion...'
    end
  end

  # display all student schedules
  def index
    @student_schedules = StudentSchedule.all
  end

  # create a new student_schedule
  def create
    authorize! :submit_forms, StudentSchedule

    @user = User.find(current_user.id)
    @student_schedule = @user.student_schedules.new(student_schedule_params)
    if @student_schedule.save
      redirect_to student_schedule_show_path, notice: 'Successful schedule submission.'
    else
      render(:new, status: :unprocessable_entity, notice: 'Unsuccessful...')
    end
  end

  # get to page for a new student_schedule (creation)
  def new
    authorize! :submit_forms, StudentSchedule

    @student_schedule = StudentSchedule.new
  end

  private

  # get a specific section by its id
  def set_student_schedule
    @student_schedule = StudentSchedule.find(params[:id])
  end

  def student_schedule_params
    params.require(:student_schedule).permit(:student_email, :day, :start_time, :end_time)
  end
end
