module StyleHelper
  def bank_name
    current_style&.bank_name.presence || "Lynx"
  end

  def header_logo 
    if current_style.header_logo.attached?
      current_style.header_logo_path
    else 
      "/logo.png"
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