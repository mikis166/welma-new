class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  has_attached_file :attachment, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png",
                    :storage => :dropbox,
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                    :dropbox_visibility => 'public'
  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/
end
