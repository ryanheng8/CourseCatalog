# frozen_string_literal: true

class InstructorRecsController < ApplicationController
  before_action :set_instructor_rec, only: %i[show edit update destroy]

  # get one instructor_rec
  def show; end

  # get an update page for an instructor_rec
  def edit; end

  # update the instructor_rec
  def update; end

  # delete the instructor_rec
  def destroy
    authorize! :manage, :all

    @instructor_rec = InstructorRec.find(params[:id])
    if @instructor_rec.destroy
      redirect_to instructor_recs_path, notice: 'Instructor Rec Deleted!'
    else
      render instructor_recs_path, notice: 'Unsuccessful Deletion...'
    end
  end

  # display all instructor_recs
  def index
    authorize! :Recommend, InstructorRec
    @instructor_recs = InstructorRec.all
    @pagy, @instructor_recs = pagy(@instructor_recs)
  end

  # create a new instructor_rec
  def create
    authorize! :Recommend, InstructorRec

    # If there isnt a student user that is tried to get recommended
    user = User.find_by(email: instructor_rec_params[:student_email])

    # If the user doesn't exist, create a new user
    if user.nil?

      # Create a User with email being what the instructor typed in
      new_user = User.create(email: instructor_rec_params[:student_email], password: 'password',
                             password_confirmation: 'password', first_name: 'fname', last_name: 'lname', role: 0, approved: false)
    end

    @instructor_rec = InstructorRec.new(instructor_rec_params)

    if @instructor_rec.save
      if user.nil?
        mailer = ApplicationMailer.with(student_email: instructor_rec_params[:student_email]).non_existing_student_email
        mailer.deliver_now
      end
      redirect_to new_instructor_rec_path, notice: 'Success!'
    else
      render(:new, status: :unprocessable_entity, notice: 'Unsuccessful...')
    end
  end

  # get to page for a new instructor_rec (creation)
  def new
    authorize! :Recommend, InstructorRec
    @instructor_rec = InstructorRec.new
  end

  # get a specific instructor_rec by its id
  private

  def set_instructor_rec
    @instructor_rec = InstructorRec.find(params[:id])
  end

  def instructor_rec_params
    params.require(:instructor_rec).permit(:instructor_email, :specific_student_request_flag, :reason,
                                           :student_email, :section_id)
  end
end
