require "cuba"
require "cuba/render"
require "haml"

require "./controller"
require "./service"

Cuba.plugin Cuba::Render
Cuba.plugin Service

Cuba.settings[:render][:template_engine] = "haml"
Cuba.settings[:render][:views] = "./views"

run Cuba
