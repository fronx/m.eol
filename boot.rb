%w[
  .
  ./lib
  ./app
].each do |path|
  $: << File.expand_path(path)
end

require 'rack'
require 'haml'

require 'eol/core_ext'
require 'app'
