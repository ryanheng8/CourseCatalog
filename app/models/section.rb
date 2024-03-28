# frozen_string_literal: true

class Section < ApplicationRecord
  belongs_to :course

  has_many :instructor_recs, dependent: :destroy
  has_many :section_instructors, dependent: :destroy

  validates :day,
            format: { with: /\A(M)?(Tu)?(W)?(Th)?(F)?(Sa)?(Su)?\Z/,
                      message: 'Invalid input for section days: requires format of: MTuWThFSaSu' }

  # Validate that the number of graders needed greater than or equal to 0
  validates :num_graders_needed, numericality: { greater_than_or_equal_to: 0 }
end
