
class Profile < ActiveRecord::Base
	
  belongs_to :user
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png",
                    :storage => :dropbox,
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                    :dropbox_visibility => 'public'
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end