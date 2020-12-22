class Admin::StylesController < Admin::ApplicationController
  before_action :set_styles

  # GET /admin/styles/edit
  def edit; end

  # PATCH/PUT /admin/styles
  def update
    if @styles.update(styles_params)
      redirect_to admin_styles_edit_path, notice: 'Style changes successfully applied.'
    else
      flash[:error] = 'Failed to save changes.'
      redirect_to admin_styles_edit_path
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
                                  :dashboard_action_head_color,
                                  :dashboard_action_head_font_color,
                                  :dashboard_static_text_color,
                                  :dashboard_head_text_color,
                                  :dashboard_main_text_1,
                                  :dashboard_main_text_2,
                                  :login_sigup_logo_image,
                                  :login_background_image,
                                  :signup_background_image,
                                  :account_table_color,
                                  :account_table_color,
                                  :sign_up_head_size,
                                  :sign_up_text_1,
                                  :sign_up_text_2,
                                  :make_payment_page_style,
                                  :make_payment_md,
                                  :make_payment_title,
                                  :make_payment_subtitle,
                                  :make_payment_image,
                                  :show_payment_page_style,
                                  :show_payment_md,
                                  :show_payment_image,
                                  :dealer_image,
                                  home_links_1: [],
                                  home_links_2: [])
  end
end
