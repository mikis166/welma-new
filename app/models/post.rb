class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy

  before_validation :generate_permalink
  before_save :save_html

  validates :permalink, uniqueness: true

  has_attached_file :image, :styles => { :large => "400x300>", :medium => "230x150>" }, :default_url => "/images/:style/missing.png",
                    :storage => :dropbox,
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                    :dropbox_visibility => 'public'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def generate_permalink
  	self.permalink = title.parameterize
  end

  def save_html
  	md  = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new, extensions = {})
  	write_attribute :html, md.render(markdown)
  end

  def to_param
    permalink
  end

end
