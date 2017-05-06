class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :conversations

  def conversations
    if user_signed_in?
      p "current user id #{current_user.id}"
      p "this is the session before"
      p session[:conversations]
      session[:conversations] ||= []
      convs = Conversation.where("recipient_id = ? OR sender_id = ?", current_user.id, current_user.id)

      if !convs.empty?
        convs.each do |c|
          if c.someone_offline?
            p "entered offline"
            session[:conversations] << c.id if (!session[:conversations].include?(c.id) && c.offline_party_id == current_user.id)
            c.update(someone_offline?: false, offline_party_id: nil)
          end

          if c.add_recipient_to_session? && !c.someone_offline?
            p "entered session recipient"
            session[:conversations] << c.id if (!session[:conversations].include?(c.id) && (c.id_to_add_to_session == current_user.id))
            p "session after update"
            p session[:conversations]
            c.update(add_recipient_to_session?: false, id_to_add_to_session: nil)
          end

          if c.window_was_closed_for.length > 0 && c.window_was_closed_for.include?(current_user.id.to_s) && c.new_messages_available_for.include?(current_user.id.to_s)
            p "entered new message for user"

            session[:conversations] << c.id if (!session[:conversations].include?(c.id))
            c.window_was_closed_for = c.window_was_closed_for.delete_if{|i|i==current_user.id.to_s}
            c.new_messages_available_for = c.new_messages_available_for.delete_if{|i|i==current_user.id.to_s}
            c.update(window_was_closed_for: c.window_was_closed_for, new_messages_available_for: c.new_messages_available_for)
          end
        end
      end

      p "this is the session after"
      p session[:conversations]

      @users = User.all.where.not(id: current_user)
      @conversations = Conversation.includes(:recipient, :messages)
                                   .find(session[:conversations])
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit(:name, :stripe_card_token, :email, :password, :password_confirmation)
      end
    end

    def require_sign_in
      unless user_signed_in?
        redirect_to new_user_session_url, :notice => 'Please register/log in first'
      end
    end

    def admin_user?
      if user_signed_in? && current_user.admin?
        return true
      else
        redirect_to root_url, :notice => 'You do not have enough permissions to access this page'
      end
    end
end
