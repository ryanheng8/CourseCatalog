# frozen_string_literal: true

class Evaluation < ApplicationRecord
  belongs_to :course
  belongs_to :user, class_name: 'User', foreign_key: 'instructor_email', optional: true
  belongs_to :user, class_name: 'User', foreign_key: 'student_email', optional: false

  validates :student_email, presence: true
  validates :course_id, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
