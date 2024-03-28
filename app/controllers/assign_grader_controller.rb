# frozen_string_literal: true

class AssignGraderController < ApplicationController
  before_action :authenticate_user!

  # view all application information
  def all_applicant_info
    authorize! :manage, :all

    @applicants = User.joins(:student_app).distinct
    @pagy, @applicants = pagy(@applicants, items: 1)
  end

  # view available sections to assign the grader to
  def assign_to_section
    authorize! :manage, :all

    @sections = Section.where('num_graders_needed > ?', 0)
    @user = params.fetch(:id, nil)
    @user = User.find(params[:id]) if @user.present?
    @pagy, @sections = pagy(@sections)
  end
end
