# frozen_string_literal: true

class Course < ApplicationRecord
  has_many :sections, dependent: :destroy


  validates :catalog_number, :credit_hours, :class_level, :name, presence: true
  validates :catalog_number, length: { is: 4 }, numericality: true

  # create scopes for course searching
  scope :difficulty, ->(level) { where('courses.class_level == ?', level / 1000) }
  scope :time_commitment, ->(hours) { where('courses.credit_hours == ?', hours) }
  scope :career_path, ->(career) { where('courses.academic_career like ?', career) }
  scope :number, ->(number) { where('courses.catalog_number == ?', number) }
  # create scopes for joint search with sections table
  scope :offered_at, ->(campus) { joins(sections: [:course]).where('sections.campus_name like ?', campus).distinct }
  scope :offered_during, lambda { |term|
                           joins(sections: [:course]).where('sections.term like ?', "%#{term}%").distinct
                         }
  scope :in_person, lambda { |delivery|
                      joins(sections: [:course]).where('sections.is_in_person like ?', delivery).distinct
                    }
  # search courses with optional parameters and join it with sections table
  def self.search(params)
    courses = Course.all
    courses = courses.number(params[:search].to_f) if params[:search].present?
    courses = courses.difficulty(params[:select_level].to_f) if params[:select_level].present?
    courses = courses.time_commitment(params[:select_hours].to_f) if params[:select_hours].present?
    courses = courses.career_path(params[:select_career]) if params[:select_career].present?
    courses = courses.offered_at(params[:select_campus]) if params[:select_campus].present?
    courses = courses.offered_during(params[:select_term]) if params[:select_term].present?
    courses = courses.in_person(params[:select_mode]) if params[:select_mode].present?
    courses
  end
end
