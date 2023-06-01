# The base class for all models in the application.
# Provides common functionality and configuration for models.
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
