module ApplicationHelper

  def validate_params
    params[:bid][:amount].to_i > 0
  end
end
