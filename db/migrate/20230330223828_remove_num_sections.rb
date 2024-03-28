# frozen_string_literal: true

class RemoveNumSections < ActiveRecord::Migration[7.0]
  def change
    remove_column :courses, :num_sections
    change_column(:courses, :has_lab, :string)
  end
end
