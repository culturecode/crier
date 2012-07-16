module Crier
  class Notification < ActiveRecord::Base
    self.table_name = 'crier_notifications'
    store :metadata, :accessors => [:crier, :subject, :action]

    has_many :listenings, :dependent => :delete_all
    has_many :audience, :through => :listenings, :source => :user # If any, this constitutes a private audience for this notification

    scope :heard_by, lambda {|user| joins("LEFT OUTER JOIN #{Listening.table_name} ON #{Listening.table_name}.notification_id = #{table_name}.id").where(Listening.table_name => {:user_id => [user.id, nil]}) }
    scope :about, lambda {|scope| where(:scope => scope)}

    # Shortcut for creating a private audience for this notification
    def to(audience)
      self.audience = (self.audience + Array(audience)).uniq if audience
    end
  end
end