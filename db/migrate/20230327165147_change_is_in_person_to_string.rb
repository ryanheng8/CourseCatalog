# frozen_string_literal: true

class ChangeIsInPersonToString < ActiveRecord::Migration[7.0]
  def change
    change_column(:sections, :is_in_person, :string)
  end
end
