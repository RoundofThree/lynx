class Admin::DealersController < ApplicationController
  before_action :set_dealer, only: %i[show edit update destroy]
  # GET /admin/users
  def index
  end

  # sort users by last_sign_in_at, created_at
  def sort_dealers
  end

  # GET /admin/dealers/1
  def show; end

  # GET /admin/dealers/new
  def new
    @user = Dealer.new
  end

  # GET /admin/dealers/1/edit
  def edit; end

  # POST /admin/dealers
  def create
    @user = User.new(dealer_params)
    if @dealer.save
      redirect_to admin_dealers_url, notice: "Dealer was successfully created."
    else
      flash[:error] = "Error in creating user."
      render :new
    end
  end

  # PATCH/PUT /admin/dealers/1
  def update
    if @dealer.update(dealer_params)
      redirect_to admin_dealers_url, notice: "Dealer was successfully updated."
    else
      flash[:error] = "Failed to save changes."
      render :edit
    end
  end

  # DELETE /admin/dealers/1
  def destroy
    @dealer.destroy
    redirect_to admin_dealers_url, notice: "Dealer was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dealer
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def dealer_params
    params.require(:dealer).permit(:currency, :name, :account_number,
                                   :min_amount, :max_amout, :frequency,
                                   :is_vendor)
  end
end
