class Plan < ActiveRecord::Base
  has_many :users

  scope :basic, -> { Plan.find_by_name("Basic") }
  scope :pro, -> { Plan.find_by_name("Pro") }
end