require "cuba"
require "cuba/render"
require "tilt/haml"
require "pry-byebug"
require "fileutils"

require "./controller"

use Rack::Static,
  urls: ["/upload", "/css", "/javascript"],
  root: "./public"
use Rack::Session::Cookie,
  secret: "secret_of_session"

run Cuba
