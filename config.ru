require "cuba"
require "cuba/render"
require "haml"
require "pry-byebug"

require "./controller"

Cuba.plugin Cuba::Render

Cuba.settings[:render][:template_engine] = "haml"
Cuba.settings[:render][:views] = "./views"

use Rack::Static,
  urls: ["/upload"],
  root: "./public"

run Cuba
