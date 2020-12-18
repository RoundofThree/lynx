class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  # GET /admin/users
  def index
    @users = User.search(params[:search])
    sort_users unless @users.empty?
  end

  # sort users by last_sign_in_at, created_at
  def sort_users
    if params[:sort_by].present?
      criteria = params[:sort_by]
      @users = if criteria == 'last_sign_in_at'
                 @users.order('last_sign_in_at desc')
               elsif criteria == 'last_created_at'
                 @users.order('created_at desc')
               else
                 @users.order('created_at asc')
               end
    else # default sorting
      @users = @users.order('last_sign_in_at desc')
    end
  end

  # GET /admin/users/1
  def show; end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit; end

  # POST /admin/users
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: 'User was successfully created.'
    else
      flash[:error] = 'Error in creating user.'
      render :new
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'User was successfully updated.'
    else
      flash[:error] = 'Failed to save changes.'
      render :edit
    end
  end

  # DELETE /admin/users/1
  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    unless params[:user][:admin_passphrase].blank?
      params[:user][:admin_passphrase_digest] =
        Digest::SHA2.hexdigest(params[:user][:admin_passphrase])
    end
    params.require(:user).permit(:firstname, :lastname, :email, :is_female,
                                 :phone, :birth_date, :password, :password_confirmation,
                                 :postcode, :address_line_1, :address_line_2, :country,
                                 :admin, :admin_passphrase_digest)

  end
end
