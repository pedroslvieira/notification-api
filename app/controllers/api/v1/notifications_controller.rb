class Api::V1::NotificationsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  before_action :set_notification, only: [ :show, :update, :destroy ]

  def index
    @notifications = policy_scope(Notification)
    authorize Notification
  end

  def show
  end

  def update
    if @notification.update(notification_params)
      render :show
    else
      render_error
    end
  end

  def create
    @notification = Notification.new(notification_params)
    authorize @notification
    if @notification.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @notification.destroy
    head :no_content
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
    authorize @notification # For Pundit
  end

  def notification_params
    params.require(:notification).permit(:date, :title, :description)
  end

  def user_notification_params
    params.require(:user_notification).permit(ids: [])
  end

  def render_error
    render json: { errors: @notification.errors.full_messages },
      status: :unprocessable_entity
  end
end
