# frozen_string_literal: true

class InstructorRec < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'instructor_email', optional: false
  belongs_to :student, class_name: 'User', foreign_key: 'student_email', optional: false
  belongs_to :section, optional: true
  validates :student_email, presence: true
  validates :section, presence: true, if: -> { section_id.present? }
  validate :section_id_validation


  private

  def section_id_validation
    return unless !specific_student_request_flag && section_id.present?

    errors.add(:section_id, "There can't be a section ID when not setting the flag")
  end
end
