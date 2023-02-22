module Error
  extend ActiveSupport::Concern

  included do

    rescue_from ActiveRecord::RecordNotFound do
      redirect_to posts_path, alert: 'No se ha encontrado!'
    end

  end
end