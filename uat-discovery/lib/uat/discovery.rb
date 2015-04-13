require 'diplomat'
require 'uri'

Dir["#{File.dirname(__FILE__)}/discovery/interfaces/**/*.rb"].each { |f| require(f) }
Dir["#{File.dirname(__FILE__)}/discovery/**/*.rb"].each { |f| require(f) }