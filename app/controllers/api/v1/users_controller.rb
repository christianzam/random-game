class Api::V1::UsersController < ApplicationController
  include UsersControllerConcern

  # before_action :check_password
  before_action :load_user, only: %i(show update destroy)
  before_action :check_params, only: :update

  def index
    # GET api/v1/users?password=[USERS_API_PASSWORD]
    @users = User.all

    if @users.empty?
      render json: { status: 'Success', message: 'Table Users is empty' }, status: :ok
    else
      render json: @users, status: :ok
    end
  end

  def show
    render json: @user, status: :found if @user.present?
  end

  def update
    if @user.save
      render json: { status: 'Success', message: 'User updated successfully', user: @user }, status: :ok
    else
      Rails.logger.error "user validation errors: #{@user.errors.full_messages.to_sentence}"
      render json: { status: 'Error', message: @user.errors.full_messages.to_sentence.to_s }, status: :internal_server_error
    end
  end

  def destroy
    if @user.destroy
      render json: { status: 'Success', message: "User employee_id:#{@user.data["employee_id"]} destroyed succesfully" }, status: :ok
    else
      Rails.logger.error "User validation errors: #{@user.errors.full_messages.to_sentence}"
      render json: { status: 'Error', message: @user.errors.full_messages.to_sentence.to_s }, status: :internal_server_error
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
    return render json: { status: 'Error', message: 'User not found' }, status: :not_found if @user.nil?
  end

  def user_images_params
    params.require(:user).permit(:profile_pic)
  end

  def user_params
    params.require.(:user).permit(:name, :nick_name, :last_name, :interest)
  end
end
