module StyleHelper
  def bank_name
    current_style&.bank_name.presence || "Lynx"
  end 
  
  def current_style 
    Style.first
  end 
end 