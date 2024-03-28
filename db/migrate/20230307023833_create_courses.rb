# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :credit_hours
      t.integer :num_sections
      t.boolean :has_lab
      t.string :academic_career
      t.integer :class_level

      t.timestamps
    end
  end
end
