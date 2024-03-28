# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def approve_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Your account has been approved')
  end

  def deny_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Your account has been denied')
  end

  def non_existing_student_email
    @email = params[:student_email]
    mail(to: @email, subject: 'You have been recommended as a cse grader')
  end

  def grader_hired_email
    @user = params[:user]
    @course = params[:course]
    @section = params[:section]
    mail(to: @user.email, subject: 'Your application has been accepted')
  end
end
