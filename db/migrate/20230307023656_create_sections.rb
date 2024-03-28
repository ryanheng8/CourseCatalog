# frozen_string_literal: true

class CreateSections < ActiveRecord::Migration[7.0]
  def change
    create_table :sections do |t|
      t.references :course, null: false, foreign_key: true
      t.integer :num_graders_needed, default: 1
      t.datetime :end_time
      t.datetime :start_time
      t.string :day
      t.string :campus_name
      t.string :term
      t.boolean :is_in_person

      t.timestamps
    end
  end
end
