# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can(:browse, Section, user:) # all users can auto-defaulted browse Sections
    can(:browse, Course, user:) # all users can auto-defaulted browse Courses

    if user.instructor?
      can(:Recommend, InstructorRec, user:) # Instructors can add recommendation forms
      can(:create, Evaluation, user:) # Instructors can create evaluations
    end


    can :submit_forms, [StudentApp, StudentSchedule, StudentCoursesTaken] if user.student?

    return unless user.admin?

    can :manage, :all # admins can do everything
  end
end
