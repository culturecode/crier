module Crier
  # If a notification has listeners, the notification is considered private and only available to those listeners
  class Listening < ActiveRecord::Base
    self.table_name = 'crier_listenings'
    
    belongs_to :notification
    belongs_to :user

    validates_presence_of :user_id, :notification_id
  end
end