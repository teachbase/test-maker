require_relative "../service"
require 'pry-byebug'

def file_path(name)
  "#{__dir__}/fixtures/#{name}.txt"
end
