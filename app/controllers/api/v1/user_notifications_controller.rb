class Api::V1::UserNotificationsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_user_notification, only: [ :show, :destroy ]
  before_action :set_notification, only: [ :create ]


  def show
    @user_notification.update(seen: true) unless current_user.admin
    # @notification = Notification.find(@user_notification.notification_id)
  end

  def create
    user_notification_params[:user_ids].each do |id|
      @user_notification = UserNotification.new(user_id: id)
      @user_notification.notification = @notification
      authorize @user_notification
      render_error unless @user_notification.save
    end
    # render "api/v1/notifications/show", status: :created
    render :show
  end

  def destroy
    @user_notification.destroy
    head :no_content
  end

  private

  def set_notification
    @notification = Notification.find(params[:notification_id])
    # authorize @notification # For Pundit
  end

  def set_user_notification
    @user_notification = UserNotification.find(params[:id])
    authorize @user_notification # For Pundit
  end

  def user_notification_params
    params.require(:user_notification).permit(user_ids: [])
  end

  def render_error
    render json: { errors: @user_notification.errors.full_messages },
      status: :unprocessable_entity
  end
end
