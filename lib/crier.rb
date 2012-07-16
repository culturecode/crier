# Load the crier fiels
require 'crier/acts_as_crier'
require 'crier/listening'
require 'crier/notification'

# FIXME: This doesn't seem to connect to the database correctly
# Load the rake tasks
# require 'rails'
# module Crier
#   class Railtie < Rails::Railtie
#     railtie_name :crier

#     rake_tasks do
#       load "tasks/crier_tasks.rake"
#     end
#   end
# end

# Load the act method
ActiveRecord::Base.send :extend, Crier::ActMethod