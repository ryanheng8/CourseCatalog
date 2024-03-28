# frozen_string_literal: true

class StudentCoursesTaken < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'student_email', optional: false

  validates :course, length: { is: 4 }, numericality: true
end
