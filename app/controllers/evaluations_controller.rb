# frozen_string_literal: true

class EvaluationsController < ApplicationController
  before_action :set_eval, only: %i[show destroy]

  # display all evaluations
  def index
    authorize! :create, Evaluation
    @evaluations = Evaluation.all
    @pagy, @evaluations = pagy(@evaluations)
  end

  # display an evaluation
  def show
    authorize! :create, Evaluation
  end

  # display a form creating a new evaluation
  def new
    authorize! :create, Evaluation
    @evaluation = Evaluation.new
  end

  # create a new evaluation
  def create
    authorize! :create, Evaluation
    evaluation_params[:instructor_email] = current_user.email
    @evaluation = Evaluation.new(evaluation_params)
    if @evaluation.save
      redirect_to @evaluation
    else
      render(:new, status: :unprocessable_entity, notice: 'Unsuccessful...')
    end
  end

  # detroy an evaluation
  def destroy
    authorize! :manage, :all
    @evaluation.destroy
    redirect_to evaluations_path
  end

  private

  def set_eval
    @evaluation = Evaluation.find(params[:id])
  end

  def evaluation_params
    params.require(:evaluation).permit(:instructor_email, :student_email, :rating, :grader_name, :comments,
                                       :course_id)
  end
end
