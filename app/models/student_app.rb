# frozen_string_literal: true

class StudentApp < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'student_email', optional: false
end
