class ApplicationController < ActionController::Base
  before_action :authorize

  protected

    def authorize
      respond_to do |format|
        format.html {
          unless User.find_by(id: session[:user_id])
            redirect_to login_url, notice: "Please log in"
          end
        }
        format.any {
          authenticate_or_request_with_http_basic do |username, password|
            user = User.find_by(name: username)
            user && user.authenticate(password)
          end
        }
      end
    end
end