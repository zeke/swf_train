require 'rubygems'
require 'bundler/setup'
require 'active_support/all' # to get methods like blank? and starts_with?
require 'action_view'
require 'swf_train' # and any other gems you need

include ActionView::Helpers
include ActiveSupport
include SwfTrain

RSpec.configure do |config|
  # some (optional) config here
end