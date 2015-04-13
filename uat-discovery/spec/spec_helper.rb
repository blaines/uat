# lib = File.expand_path('../lib', __FILE__)
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'uat/discovery'
require 'ipaddress'

Dir["#{File.dirname(__FILE__)}/system/support/**/*.rb"].each { |f| require(f) }