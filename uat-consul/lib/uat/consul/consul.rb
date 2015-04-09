require 'diplomat'
require 'uri'

Dir["#{File.dirname(__FILE__)}/consul/interfaces/**/*.rb"].each { |f| require(f) }
Dir["#{File.dirname(__FILE__)}/consul/**/*.rb"].each { |f| require(f) }