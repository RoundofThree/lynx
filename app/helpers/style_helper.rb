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
    current_style&.navbar_md.presence || '<span style="position: relative; top: 9px;"><a href="/" class="p-2 text-dark">Banking</a>
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
    current_style&.home_main_marketing_message_1.presence || "Transfer and Withdraw Easily with Lynx Bank."
  end

  def home_main_marketing_card_image_1
    if current_style.home_main_marketing_card_image_1.attached?
      url_for(current_style.home_main_marketing_card_image_1)
    else
      "/savings.jpg"
    end
  end

  def home_main_marketing_text_1
    current_style&.home_main_marketing_text_1.presence || "You can easily manage your
    financial operations with an Lynx Bank account. Lynx IBAN accounts support up
    to 25 different currencies. The most affordable rates and fees found anywhere online for banking services. We provide simple, smart, and flexible solutions for our customers. Open your account today!"
  end

  def home_main_marketing_message_2
    current_style&.home_main_marketing_message_2.presence || "Enjoy the Benefits of Lynx Bank."
  end

  def home_main_marketing_card_image_2
    if current_style.home_main_marketing_card_image_2.attached?
      url_for(current_style.home_main_marketing_card_image_2)
    else
      "/plan.jpg"
    end
  end

  def home_main_marketing_text_2
    current_style&.home_main_marketing_text_2.presence || "We are aim to build a delightful experience for customers and make banking easier. You can spend more consciously,
    save up to your goals easily. A positive and enthusiastic spirit is what we want customer to feel. We will make our customer to feel supported and address their needs."
  end

  def home_main_marketing_message_3
    current_style&.home_main_marketing_message_3.presence || "The Story About Us."
  end

  def home_main_marketing_card_image_3
    if current_style.home_main_marketing_card_image_3.attached?
      url_for(current_style.home_main_marketing_card_image_3)
    else
      "/success.jpg"
    end
  end

  def home_main_marketing_text_3
    current_style&.home_main_marketing_text_3.presence || "Lynx Bank is focus
    on building a secure bank service that brings great experience to our customers.
    We believe that customer come first – whether face to face or in our app. We are rated No.1 for our digital services in the global banking service quality survey. We act transparently and always do what is right for customer."
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

  #this function apply both login logo and signup logo
  def login_sigup_logo_image
    if current_style.login_sigup_logo_image.attached?
      url_for(current_style.login_sigup_logo_image)
    else
      "/llogo.png"
    end
  end

  #signup
  def sign_up_head_size
    current_style&.sign_up_head_size.presence || "50"
  end

  # make payment page

  def make_payment_page_style
    current_style&.make_payment_page_style.presence || "background: linear-gradient(to right, #add8e6, white);"
  end

  def make_payment_image
    if current_style.make_payment_image.attached?
      url_for(current_style.make_payment_image)
    else
      "/payment.png"
    end
  end

  def make_payment_md
    current_style&.make_payment_md.presence || ""
  end

  def make_payment_title
    current_style&.make_payment_title.presence || "Transfer to any part of the world"
  end

  def make_payment_subtitle
    current_style&.make_payment_subtitle.presence || "...and do it securely"
  end

  # show payment page

  def show_payment_page_style
    current_style&.show_payment_page_style.presence || "background: linear-gradient(to right, #add8e6, white);"
  end

  def show_payment_image
    if current_style.show_payment_image.attached?
      url_for(current_style.show_payment_image)
    else
      "/payment.png"
    end
  end

  def show_payment_md
    current_style&.make_payment_md.presence || ""
  end

  def dealer_image
    if current_style.dealer_image.attached?
      url_for(current_style.dealer_image)
    else
      "https://logosandtypes.com/wp-content/uploads/2020/07/ashmolean.svg"
    end
  end

  #account
  def account_table_color (count = 0)
    if count % 2 == 0
      current_style&.account_table_color.presence || ""
    else
      ""
    end
  end


  # navbar_color
  # home_background_color
  # transaction
  # payment

  def current_style
    Style.first
  end
end
