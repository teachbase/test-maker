require "cuba"
require "cuba/render"
require "haml"
require "pry-byebug"

require "./controller"

Cuba.plugin Cuba::Render

Cuba.settings[:render][:template_engine] = "haml"
Cuba.settings[:render][:views] = "./views"

run Cuba
