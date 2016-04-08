require "cuba"
require "cuba/render"
require "haml"
require "pry-byebug"
require "fileutils"

require "./controller"

use Rack::Static,
  urls: ["/upload", "/css"],
  root: "./public"
use Rack::Session::Cookie,
  secret: "secret_of_session"

run Cuba
