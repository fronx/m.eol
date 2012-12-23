require './boot'

use Rack::Static, :root => "public", :urls => ["/css", "/img", "/js", "/fonts"]
use Rack::MethodOverride

# disable :protection # what was that for again?

run App
