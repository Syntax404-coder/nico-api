# frozen_string_literal: true

class RenameStateToProvince < ActiveRecord::Migration[8.1]
  def change
    rename_column :users, :state, :province
    change_column_default :users, :country, 'Philippines'
  end
end
