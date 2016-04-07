require_relative "../service"
require 'pry-byebug'

def file_path(name)
  "#{__dir__}/fixtures/#{name}.txt"
end

RSpec.configure do |config|
  config.after(:suite) do
    FileUtils.rm_rf file_path "result"
  end
end
