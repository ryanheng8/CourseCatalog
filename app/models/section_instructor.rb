# frozen_string_literal: true

class SectionInstructor < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'instructor_email', optional: false
  belongs_to :section

  # validates that the user and section exist
  validates :user, presence: true
  validates :section, presence: true
  validates_uniqueness_of :section, scope: :user
end
