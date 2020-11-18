class Api::ApiController < ApplicationController
  include ActionController::ImplicitRender # if you need render .jbuilder
  include ActionView::Layouts # if you need layout for .jbuilder
  include Pundit
  before_action :authenticate_user!
  protect_from_forgery with: :null_session
end
