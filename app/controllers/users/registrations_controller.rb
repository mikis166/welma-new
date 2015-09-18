class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :select_plan, only: :new


  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_payment
        else
          resource.save
        end
      end
    end
  end
 

 private

  def select_plan
    return if params[:plan] && Plan.all.pluck(:id).include?(params[:plan].to_i)

    flash[:notice] = "Please select a membership plan to sign up."
    redirect_to root_url
  end 
end
