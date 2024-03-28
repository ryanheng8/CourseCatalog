# frozen_string_literal: true

class SectionsController < ApplicationController
  before_action :set_section, only: %i[show edit update destroy]

  # get one section
  def show
    @section = Section.find(params[:id])
  end

  # get an update page for an section
  def edit
    authorize! :manage, :all
    @section = Section.find(params[:id])
  end

  # update the section
  def update
    authorize! :manage, :all

    if @section.update(section_params)
      redirect_to course_path(@section.course_id), notice: 'Section edited successfully.'
    else
      render(:edit, status: :unprocessable_entity, notice: 'Unsuccessful...')
    end
  end

  # delete the section
  def destroy
    authorize! :manage, :all

    @section = Section.find(params[:id])
    if @section.destroy
      redirect_to course_path(@section.course_id), notice: 'Section deleted successfully.'
    else
      render :edit, notice: 'Unsuccessful Deletion...'
    end
  end

  # display all section
  def index
    @sections = Section.all
  end

  # create a new section
  def create
    authorize! :manage, :all

    @section = Section.new(section_params)

    if @section.save
      redirect_to section_path(@section), notice: 'Success!'
    else
      render(:new, status: :unprocessable_entity, notice: 'Unsuccessful...')
    end
  end

  # get to page for a new section (creation)
  def new
    authorize! :manage, :all
    @section = Section.new
  end

  # get a specific section by its id
  def set_section
    @section = Section.find(params[:id])
  end

  private

  def section_params
    params.require(:section).permit(:course_id, :num_graders_needed, :end_time, :start_time, :day, :campus_name,
                                    :term, :is_in_person)
  end
end
