# frozen_string_literal: true

class ChangeInstructorRecAttributes < ActiveRecord::Migration[7.0]
  def change
    add_column :instructor_recs, :reason, :string
    add_column :instructor_recs, :section_id, :integer
    add_foreign_key :instructor_recs, :sections, column: 'section_id', primary_key: 'id'
  end
end
