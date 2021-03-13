#!/usr/bin/ruby
require_relative './app'

catch :ctrl_c do
  trap("SIGINT") do
    puts "Exit form the app\n"
    throw :ctrl_c 
  end
  app = App.new
  app.handle
end
