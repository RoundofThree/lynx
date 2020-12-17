class Admin::StylesController < Admin::ApplicationController
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
  # Always the first row and the only row
  def set_styles
    @styles = Style.first
  end

  # all customizable elements
  def styles_params
    params[:style][:home_links_1] = deserialize(params[:style][:home_links_1]) if params[:style][:home_links_1].present?
    params[:style][:home_links_1] = [] if params[:style][:home_links_1].blank?
    params[:style][:home_links_2] = deserialize(params[:style][:home_links_2]) if params[:style][:home_links_2].present?
    params[:style][:home_links_2] = [] if params[:style][:home_links_2].blank?
    params.require(:style).permit(:bank_name,
                                  :header_logo,
                                  :font_family,
                                  :navbar_md,
                                  :home_main_marketing_image,
                                  :home_main_marketing_title,
                                  :home_main_marketing_subtitle,
                                  :home_main_marketing_message_1,
                                  :home_main_marketing_text_1,
                                  :home_main_marketing_card_image_1,
                                  :home_main_marketing_message_2,
                                  :home_main_marketing_text_2,
                                  :home_main_marketing_card_image_2,
                                  :home_main_marketing_message_3,
                                  :home_main_marketing_text_3,
                                  :home_main_marketing_card_image_3,
                                  :home_footer_md,
                                  :home_footer_text_color,
                                  :home_background_color,
                                  :dashboard_color,
                                  :login_background_image,
                                  :home_links_1 => [],
                                  :home_links_2 => [])
  end

end
