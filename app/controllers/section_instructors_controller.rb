# frozen_string_literal: true

class SectionInstructorsController < ApplicationController
  include SectionInstructorsHelper

  before_action :set_section_instructor, only: %i[show edit update destroy]

  # get one section instructor
  def show
    authorize! :manage, :all

    @section_instructor = SectionInstructor.find_by(section_id: params[:section_id],
                                                    instructor_email: params[:instructor_email])
  end

  # get an update page for a section instructor
  def edit
    authorize! :manage, :all

    @section_instructor = SectionInstructor.find_by(section_id: params[:section_id],
                                                    instructor_email: params[:instructor_email])
  end

  # update the section instructor
  def update
    authorize! :manage, :all

    @previous_section_id = @section_instructor.section_id
    @new_section_id = section_instructor_params[:section_id]

    if check_graders(@new_section_id)
      decrement_num_graders(@new_section_id)
      if @section_instructor.update(section_instructor_params)
        increment_num_graders(@previous_section_id)
        ApplicationMailer.with(user: User.find(@section_instructor.instructor_email), course: Course.find(Section.find(@section_instructor.section_id).course_id), section: Section.find(@section_instructor.section_id)).grader_hired_email.deliver_later
        redirect_to section_instructor_show_path(section_id: @section_instructor.section_id, instructor_email: @section_instructor.instructor_email),
                    notice: 'Success!'
      else
        increment_num_graders(@new_section_id)
        redirect_to section_instructor_edit_path(section_id: @section_instructor.section_id, instructor_email: @section_instructor.instructor_email),
                    notice: 'Unsuccessful update'
      end
    else
      redirect_to section_instructor_edit_path(section_id: @section_instructor.section_id, instructor_email: @section_instructor.instructor_email),
                  notice: 'This section does not need graders'
    end
  end

  # delete the section instructor
  def destroy
    authorize! :manage, :all

    @section_instructor = SectionInstructor.find_by(section_id: params[:section_id],
                                                    instructor_email: params[:instructor_email])
    increment_num_graders(@section_instructor.section_id)
    if @section_instructor.destroy
      redirect_to section_instructor_index_path, notice: 'Section instructor deleted successfully.'
    else
      decrement_num_graders(@section_instructor.section_id)
      redirect_to section_instructor_index_path, notice: 'Unsuccessful Deletion...'
    end
  end

  # display all section instructors
  def index
    authorize! :manage, :all
    @section_instructors = SectionInstructor.order(section_id: :asc)
    @pagy, @section_instructors = pagy(@section_instructors)
  end

  # create a new section instructor
  def create
    authorize! :manage, :all

    @section_instructor = SectionInstructor.new(section_instructor_params)
    if check_graders(@section_instructor.section_id)
      decrement_num_graders(@section_instructor.section_id)
      if @section_instructor.save
        ApplicationMailer.with(user: User.find(@section_instructor.instructor_email), course: Course.find(Section.find(@section_instructor.section_id).course_id), section: Section.find(@section_instructor.section_id)).grader_hired_email.deliver_later
        redirect_to section_instructor_show_path(section_id: @section_instructor.section_id, instructor_email: @section_instructor.instructor_email),
                    notice: 'Success!'
      else
        increment_num_graders(@section_instructor.section_id)
        redirect_to section_instructor_new_path(section_id: @section_instructor.section_id, instructor_email: @section_instructor.instructor_email),
                    notice: 'Unsuccessful. User may not exist or is already be assigned to this section'
      end
    else
      redirect_to section_instructor_new_path(section_id: @section_instructor.section_id, instructor_email: @section_instructor.instructor_email),
                  notice: 'This section does not need graders.'
    end
  end

  # get to page for a new section instructor (creation)
  def new
    authorize! :manage, :all

    @section_instructor = SectionInstructor.new
    @section_id = params.fetch(:section_id, @section_instructor.section_id)
    @instructor_email = params.fetch(:instructor_email, @section_instructor.instructor_email)
  end

  private

  # get a specific section instructor by its id
  def set_section_instructor
    @section_instructor = SectionInstructor.find_by(section_id: params[:section_id],
                                                    instructor_email: params[:instructor_email])
  end

  def section_instructor_params
    section_instructor_params = params.require(:section_instructor).permit(:section_id, :instructor_email)
  end
end
