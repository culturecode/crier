$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'active_record'
require 'logger'
require 'crier'

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger.level = Logger::INFO
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

ActiveRecord::Schema.define(:version => 0) do
  create_table :users, :force => true do |t|
    t.string :first_name
    t.string :last_name
  end

  create_table :subjects, :force => true do |t|
    t.string :title
  end

  create_table Crier::Notification.table_name, :force => true do |t|
      t.string :scope
      t.text :message
      t.integer :crier_id
      t.string :subject_type
      t.integer :subject_id
      t.string :action
      t.text :metadata
      t.boolean :private, :null => false, :default => false
      t.timestamps
    end

  create_table Crier::Listening.table_name, :force => true do |t|
    t.belongs_to :notification
    t.belongs_to :user
  end
end


class User < ActiveRecord::Base
   acts_as_crier
end

class Subject < ActiveRecord::Base
end
