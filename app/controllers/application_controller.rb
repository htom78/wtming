class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user
  include ApplicationHelper
  
  #rescue_from CanCan::AccessDenied do |exception|
    #flash[:error] = "Access denied."
    #redirect_to root_url
  #end

  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    render_422
  end
  
  protected
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to login_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_back_or_default root_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end
    
    def redirect_back_or_default(default)
      redirect_to(params[:return_to] || session[:return_to] || default)
      session[:return_to] = nil
    end

    def render_404(exception = nil)
      if exception
        logger.info "Rendering 404 with exception: #{exception.message}"
      end

      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found, :layout => false }
        format.xml  { head :not_found }
        format.any  { head :not_found }
      end
    end

    def render_422(exception = nil)
      if exception
        logger.info "Rendering 422 with exception: #{exception.message}"
      end

      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/422.html", :status => :unprocessable_entity, :layout => false }
        format.xml  { header :unprocessable_entity }
        format.xml  { header :unprocessable_entity }
      end
    end


end
