module StyleHelper
  def bank_name
    current_style&.bank_name.presence || "Lynx"
  end

  def header_logo 
    if current_style.header_logo.attached?
      url_for(current_style.header_logo)
    else 
      "/logo.png"
    end
  end 

  def login_background_image
    if current_style.login_background_image.attached?
      url_for(current_style.login_background_image)
    else 
      "/bank3.jpg"
    end 
  end 

  # navbar_color
  # dashboard_background_color
  # home_background_color
  # account ||
  # login
  # signin
  # transaction
  # payment
  
  def current_style 
    Style.first
  end
end 