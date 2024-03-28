# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to catalog_path, alert: 'You cannot access that page'
  end

  # updates devise controllers for sign up and update account to include additional fields
  # from https://hackernoon.com/using-devise-in-your-ruby-on-rails-application-a-step-by-step-guide-m92i3y5s
  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  # sets devise parameters
  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      # set approved to true automatically if user is a student, false otherwise, admin will need to aprove it later
      # u[:approved] = true unless u[:role] == :instructor or :admin
      u.permit(:role, :first_name, :last_name, :email, :password, :approved, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:role, :first_name, :last_name, :email, :password, :current_password, :password_confirmation)
    end
  end

  # checks if the user can access the student schedule
  def check_user(student_email)
    unless (current_user.email == student_email) || current_user.admin?
      redirect_to root_path, notice: 'You are not authorized to access this page'
    end
  end

  def index; end
end
