class Candidate < ActiveRecord::Base
  belongs_to :job
  belongs_to :profile

  validates_presence_of :description
  validates_presence_of :cv

  has_attached_file :cv,
                    :storage => :dropbox,
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                    :dropbox_visibility => 'public'
  validates_attachment_content_type :cv, :content_type => [
              "application/pdf",
              "application/msword",
              "application/vnd.openxmlformats-officedocument.wordprocessingml.document"]
end
