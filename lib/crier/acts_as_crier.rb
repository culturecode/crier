module Crier
  module ActMethod
    def acts_as_crier(options = {})
      has_many :listenings, :class_name => 'Crier::Listening', :dependent => :delete_all
      has_many :private_notifications, :class_name => 'Crier::Notification', :source => :notification, :through => :listenings

      extend Crier::ClassMethods
      include Crier::InstanceMethods
    end      
  end

  module ClassMethods
  end

  module InstanceMethods
    def cry(message, metadata = {}, audience = nil)
      Notification.create! do |n|
        n.message   = message
        n.metadata  = metadata.reverse_merge(:crier => self, :subject => self)
        n.audience  = Array(audience)
        n.scope     = Crier::HelperMethods.scope_for(n.subject)
        n.private   = true if audience
      end
    end
  end

  module HelperMethods
    def self.scope_for(record)
      "#{record.class.name}##{record.id}"
    end
  end
end