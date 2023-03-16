class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotDestroyed, with: :handle_not_destroyed
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::RoutingError, with: :rescue_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
 
  def not_found
    render json: { error: 'Not found' }, status: :not_found
  end
  
  private
  
  def handle_not_destroyed(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def record_not_found(exception)
    render json: { errors: exception.message }, status: :unprocessable_entity
  end

  def rescue_not_found
    head :not_found
  end

  def handle_record_invalid(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
