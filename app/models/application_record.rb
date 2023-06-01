# The base class for all models in the application.
# Provides common functionality and configuration for models.
class ApplicationRecord < ActiveRecord::Base
    def current_user
      @current_user = User.first
    end
end
