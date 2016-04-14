require "cuba"
require "cuba/render"
require "tilt/haml"
require "fileutils"

require "./controller"

use Rack::Static,
  urls: ["/upload", "/css", "/javascript"],
  root: "./public",
  header_rules: [
    [:all, { 'Cache-Control' => 'public, max-age=31536000' }],
    [%w(txt), { 'Content-Type' => 'text/html; charset=utf-8' }]
  ]

use Rack::Session::Cookie,
  secret: ENV['SECRET'] || "secret_of_session"

run Cuba
