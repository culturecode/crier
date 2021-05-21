module Crier
  class Notification < ActiveRecord::Base
    self.table_name = 'crier_notifications'

    if ActiveRecord::VERSION::MAJOR <= 4
      belongs_to :crier, :class_name => 'User'
    else
      belongs_to :crier, :class_name => 'User', :optional => true
    end
    belongs_to :subject, :polymorphic => true

    has_many :listenings, :dependent => :delete_all
    has_many :audience, :through => :listenings, :source => :user # If any, this constitutes a private audience for this notification

    store :metadata

    scope :by,       lambda {|user| where(:crier_id => user) }
    scope :heard_by, lambda {|user| joins("LEFT OUTER JOIN #{Listening.table_name} ON #{Listening.table_name}.notification_id = #{table_name}.id").where("#{Listening.table_name}.user_id = #{user.id} OR NOT private")}
    scope :about,    lambda {|subject| where(:subject_id => subject.id, :subject_type => subject.class.name) }
    scope :in_scope, lambda {|scope| where(:scope => scope) }

    # Shortcut for creating a private audience for this notification
    def to(audience)
      self.update_column(:private, true)
      self.audience = (self.audience + Array(audience)).uniq

      return self
    end

    def to_others(audience)
      to(Array(audience) - [crier])
    end
  end
end
