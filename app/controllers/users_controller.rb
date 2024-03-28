# frozen_string_literal: true

class UsersController < ApplicationController
  # approve a user
  def approve
    # approve the user
    @user = User.find(params[:email])
    @user.approve
    # send an email to the user but do not wait for it to complete before continuing
    ApplicationMailer.with(user: @user).approve_email.deliver_later
    # refresh page to reflect update
    redirect_to '/approve', notice: 'User approved.'
  end

  # deny a user and delete their account
  def deny
    # find the user and send them an email
    @user = User.find(params[:email])
    ApplicationMailer.with(user: @user).deny_email.deliver_now
    # delete the account
    @user.destroy
    redirect_to '/approve', notice: 'User denied.'
  end

  # shows a single user
  def show
    authorize! :manage, :all
    @user = InstructorRec.find(params[:id])
  end

  # shows all users
  def index
    authorize! :manage, :all
    @user = User.all
    @pagy, @user = pagy(@user)
  end

  # delete to user
  def remove
    authorize! :manage, :all

    @user = User.find(params[:email])
    if @user.destroy
      redirect_to users_path, notice: 'User Deleted!'
    else
      render users_path, notice: 'Unsuccessful Deletion...'
    end
  end
end
