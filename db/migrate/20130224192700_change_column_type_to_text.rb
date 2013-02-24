class ChangeColumnTypeToText < ActiveRecord::Migration
  change_column :notes , :content , :text
end
