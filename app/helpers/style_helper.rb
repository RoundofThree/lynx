module StyleHelper
  # general
  def bank_name
    current_style&.bank_name.presence || "Lynx Bank"
  end

  def header_logo
    if current_style.header_logo.attached?
      url_for(current_style.header_logo)
    else
      "/logo.png"
    end
  end

  def font_family
    current_style&.font_family.presence || '"Assistant"'
  end

  def navbar_md
    current_style&.navbar_md.presence || '<span style="position: relative; top: 7px;"><a href="/" class="p-2 text-dark">Banking</a>
    <a href="/" class="p-2 text-dark">Investments</a>
    <a href="/" class="p-2 text-dark">Loans</a>
    <a href="/" class="p-2 text-dark">Mortgage</a>
    <a href="/" class="button small w-button">Book a call</a></span>'
  end

  # homepage
  def home_main_marketing_image
    if current_style.home_main_marketing_image.attached?
      url_for(current_style.home_main_marketing_image)
    else
      "/bank1.jpg"
    end
  end

  def home_main_marketing_title
    current_style&.home_main_marketing_title.presence || "Make Money move."
  end

  def home_main_marketing_subtitle
    current_style&.home_main_marketing_subtitle.presence || "Open a Checking or Saving Account today!"
  end

  def home_main_marketing_message_1
    current_style&.home_main_marketing_message_1.presence || "Build your savings without even trying."
  end

  def home_main_marketing_card_image_1
    if current_style.home_main_marketing_card_image_1.attached?
      url_for(current_style.home_main_marketing_card_image_1)
    else
      "/savings.jpg"
    end
  end

  def home_main_marketing_text_1
    current_style&.home_main_marketing_text_1.presence || "Turn on Round-up Rules and start saving up effortlessly. Whenever you make a purchase, Simple will
    round up what you spend to the next whole dollar amount. When the “change” from those transactions reaches or
    exceeds $5, Simple transfers it to your Protected Goals Account — so easy you won’t even feel it. It’s like a
    digital change jar... one that adds up to real money in the bank."
  end

  def home_main_marketing_message_2
    current_style&.home_main_marketing_message_2.presence || "Make plans for what to do, not what’s due."
  end

  def home_main_marketing_card_image_2
    if current_style.home_main_marketing_card_image_2.attached?
      url_for(current_style.home_main_marketing_card_image_2)
    else
      "/plan.jpg"
    end
  end

  def home_main_marketing_text_2
    current_style&.home_main_marketing_text_2.presence || "Set up your recurring expenses in our app, and we'll do the work of saving for them each month.
      When you know your bills are covered, you can focus on the fun parts of having money—like saving for a trip to
      Japan and buying that new bike."
  end

  def home_main_marketing_message_3
    current_style&.home_main_marketing_message_3.presence || "Save toward your goals, automatically."
  end

  def home_main_marketing_card_image_3
    if current_style.home_main_marketing_card_image_3.attached?
      url_for(current_style.home_main_marketing_card_image_3)
    else
      "/success.jpg"
    end
  end

  def home_main_marketing_text_3
    current_style&.home_main_marketing_text_3.presence || "Goals make it easy to save for the things you want or want to do. There’s no need for
      spreadsheets or extra apps to budget and track your money. It’s right there inside your Simple checking account,
      growing bit-by-bit until you’re ready to spend."
  end

  def home_footer_md
    current_style&.home_footer_md.presence || ""
  end

  def home_footer_text_color
    current_style&.home_footer_text_color.presence || "#02376D"
  end

  def home_background_color
    current_style&.home_background_color.presence || "#ffffff"
  end

  def home_links_1
    # first one is title
    current_style&.home_links_1.presence || ['Products', 'Bank account', 'Savings', 'Mortgage', 'Personal Loans', 'Credit Cards']
  end

  def home_links_2
    # first one is title
    current_style&.home_links_2.presence || ['Support & Security', 'Help and Support', 'Security and fraud', 'Accessibility', 'Online Terms and Services']
  end

  # dashboard
  def dashboard_action_head_color
    current_style&.dashboard_action_head_color.presence || "#3399ff"
  end

  def dashboard_action_head_font_color
    current_style&.dashboard_action_head_font_color.presence || "#ffffff"
  end

  def dashboard_summary_head_color
    current_style&.dashboard_summary_head_color.presence || "#f4f4f4"
  end

  def dashboard_summary_head_font_color
    current_style&.dashboard_summary_head_font_color.presence || "#000000"
  end
  # login
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
