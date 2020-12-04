class Admin::StylesController < ApplicationController
  skip_before_action :authenticate_user!, raise: false
  before_action :user_is_admin?
end
