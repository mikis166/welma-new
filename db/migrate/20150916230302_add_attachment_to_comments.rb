class AddAttachmentToComments < ActiveRecord::Migration
  def up
    add_attachment :comments, :attachment
  end

  def down
    remove_attachment :comments, :attachment
  end
end
