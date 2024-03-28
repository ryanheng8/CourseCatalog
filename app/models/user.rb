# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates_presence_of :first_name, :last_name, :role
  validates_confirmation_of :password


  # define enum to represent student, instructor and admin in database
  enum role: { student: 0, instructor: 1, admin: 2 }
  has_many :student_courses_takens, class_name: 'StudentCoursesTaken', foreign_key: 'student_email', dependent: :destroy
  has_many :student_schedules, class_name: 'StudentSchedule', foreign_key: 'student_email', dependent: :destroy
  has_many :student_app, class_name: 'StudentApp', foreign_key: 'student_email', dependent: :destroy
  has_many :section_instructors, class_name: 'SectionInstructor', foreign_key: 'instructor_email', dependent: :destroy
  has_many :instructor_recs, class_name: 'InstructorRec', foreign_key: 'instructor_email', dependent: :destroy
  has_many :instructor_recs, class_name: 'InstructorRec', foreign_key: 'student_email', dependent: :destroy
  has_many :evaluations, class_name: 'Evaluation', foreign_key: 'instructor_email', dependent: :nullify
  has_many :evaluations, class_name: 'Evaluation', foreign_key: 'student_email', dependent: :destroy
  self.primary_key = 'email'

  # for updating a user to be approved
  def approve
    update(approved: true)
  end

  # define inactive_message for if user is not approved
  def inactive_message
    approved? ? super : :not_approved
  end

  def admin?
    role == 'admin' && approved == true
  end

  def student?
    role == 'student'
  end
end
