class ApplicationController < ActionController::Base
  
  before_filter :authenticate_user!
  
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
end
