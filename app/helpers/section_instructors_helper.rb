# frozen_string_literal: true

module SectionInstructorsHelper
  # check if the number of graders is greater than 0
  def check_graders(section_id)
    return unless Section.exists?(section_id)

    @section = Section.find(section_id)
    @section.num_graders_needed.positive?
  end

  # increment the number of graders on destroy
  def increment_num_graders(section_id)
    @section = Section.find(section_id)
    @section.update(num_graders_needed: @section.num_graders_needed + 1)
  end

  # decrement the number of graders on create
  def decrement_num_graders(section_id)
    @section = Section.find(section_id)
    @section.update(num_graders_needed: @section.num_graders_needed - 1)
  end
end
