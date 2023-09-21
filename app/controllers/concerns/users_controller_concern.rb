module UsersControllerConcern
  extend ActiveSupport::Concern

  def check_password
    msg = ''
    if params[:password].nil?
      msg = 'Missing'
    elsif params[:password] != 'swEd05YQKIZ' #ENV['USERS_API_PASSWORD']
      msg = 'Incorrect'
    end
      
    if msg.present?
      return render json: { status: 'Error', message: "#{msg} password" }, status: :unauthorized
      # rubocop:disable Lint/UnreachableCode
      Rails.logger.error "UNAUTHORIZED: #{msg} password"
      # rubocop:enable Lint/UnreachableCode
    end
  end

  def check_params
    if params[:user].nil?
      return render json: { status: 'Error', message: "Missing required parameter: User" }, status: :bad_request
      # rubocop:disable Lint/UnreachableCode
      Rails.logger.error "BAD REQUEST: Missing required parameters: User"
      # rubocop:enable Lint/UnreachableCode
    end
  end

  def attach_images
    @user.profile_pic.attach(user_images_params[:profile_pic]) if params[:user].key?(:profile_pic)
  end
end
