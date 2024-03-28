# frozen_string_literal: true

class StudentSchedule < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'student_email', optional: false

  # Checks if the time formats are valid
  validates :start_time,
            format: { with: /\A(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9])\Z/,
                      message: 'Invalid input for start_time: requires format of: HH:MM' }
  validates :end_time,
            format: { with: /\A(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9])\Z/,
                      message: 'Invalid input for end_time: requires format of: HH:MM' }

  # Validates that the start and end times are valid and do not interfere with existing times
  validate :check_time
  validate :check_interfere

  private

  # Checks if the start_time is before the end_time
  def check_time
    return unless start_time.present? && end_time.present?

    start_hours, start_minutes = start_time.split(':').map(&:to_i)
    start_total_minutes = start_hours * 60 + start_minutes

    end_hours, end_minutes = end_time.split(':').map(&:to_i)
    end_total_minutes = end_hours * 60 + end_minutes

    return unless start_total_minutes >= end_total_minutes

    errors.add(:start_time, 'must be before end time')
  end

  # Checks if the times interfere with existing schedule times.
  def check_interfere
    return unless start_time.present? && end_time.present?

    existing_schedules = user.student_schedules.where.not(id:).where(
      '(start_time < :end_time) AND (end_time > :start_time) AND (day == :day)',
      start_time:,
      end_time:,
      day:
    )
    return unless existing_schedules.any?

    errors.add(:base, 'New schedule time interferes with existing schedule times')
  end
end
