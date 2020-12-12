class Admin::StylesController < ApplicationController
  skip_before_action :authenticate_user!, raise: false
  before_action :user_is_admin?
  before_action :set_styles

  # GET /admin/styles/edit
  def edit
  end 

  # PATCH/PUT /admin/styles
  def update 
    if @styles.update(styles_params)
      redirect_to admin_styles_edit_path, notice: "Style changes successfully applied."
    else 
      redirect_to admin_styles_edit_path, notice: "Failed to save changes."
    end
  end 

  private 
  # Always the first row 
  def set_styles 
    @styles = Style.first 
  end 
  
  # all customizable elements 
  def styles_params 
    params.require(:style).permit(:bank_name,
                                  :header_logo,
                                  :login_background_image)
  end 

end
