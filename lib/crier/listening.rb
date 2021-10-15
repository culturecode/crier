module Crier
  # If a notification has listeners, the notification is considered private and only available to those listeners
  class Listening < ActiveRecord::Base
    self.table_name = 'crier_listenings'

    belongs_to :notification
    belongs_to :user
  end
end
