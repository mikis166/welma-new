class PagesController < ApplicationController
  def home
      @basic_plan = Plan.basic
      @pro_plan = Plan.pro
  end

  def about

  end
end
