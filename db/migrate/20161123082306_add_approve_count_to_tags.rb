class AddApproveCountToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :approve_count, :integer, default: 0
    add_column :tags, :approved_user_id, :text, default: [], array: true
    add_column :tags, :approved_user_image, :text, default: [], array: true
  end
end
