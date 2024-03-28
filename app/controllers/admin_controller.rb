# frozen_string_literal: true

class AdminController < ApplicationController
  before_action :authenticate_user!

  # view to see users awaiting approval
  def approve_users
    authorize! :manage, :all
    # only unaproved admin and instructors will appear on the list
    @users = User.where(approved: false, role: %i[admin instructor])
    @pagy, @users = pagy(@users)
  end
end
