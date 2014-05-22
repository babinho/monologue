require 'active_support/concern'

module Monologue
  module ControllerHelpers
    module Auth
      extend ActiveSupport::Concern

      included do
        before_action :authenticate_monologue_user!
        skip_before_action :authenticate_user!
        helper_method :monologue_current_user
      end

      private
      def authenticate_monologue_user!
        if monologue_current_user.nil?
          redirect_to monologue.admin_login_url, alert: I18n.t("monologue.admin.login.need_auth")
        end
      end
      def monologue_current_user
        @monologue_current_user ||= Monologue::User.find(session[:monologue_user_id]) if session[:monologue_user_id]
      end
    end
  end
end
