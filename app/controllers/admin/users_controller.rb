class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, raise: false
  before_action :user_is_admin?
  # GET /admin/users (or .json)
  def index
    @users = User.search(params[:search])
    sort_users if !@users.empty?
  end


  # sort users by last_sign_in_at, created_at
  def sort_users
    if params[:sort_by].present?
      criteria = params[:sort_by]
      if criteria == "last_sign_in_at"
        @users = @users.order("last_sign_in_at desc")
      elsif criteria == "last_created_at"
        @users = @users.order("created_at desc")
      else
        @users = @users.order("created_at asc")
      end
    else # default sorting
      @users = @users.order("last_sign_in_at desc")
    end

  end

  # GET /admin/users/1
  def show
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_url(@user), notice: 'User was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    respond_to do |format|

      if @user.update(user_params)
        format.html { redirect_to admin_users_url(@user), notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/users/1
  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: 'User was successfully destroyed.'

    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:firstname, :lastname, :email,:is_female,
        :phone, :birth_date, :password, :password_confirmation,:postcode, :country,
         :address_line_1,:address_line_2)
    end
