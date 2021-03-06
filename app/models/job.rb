class Job < ActiveRecord::Base
  has_many :candidates
  before_save :save_html

  def save_html
  	md  = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new, extensions = {})
  	write_attribute :description, md.render(description)
  end
end
