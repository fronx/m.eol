%w[
  .
  ./lib
  ./app
  ./app/models
].each do |path|
  $: << File.expand_path(path)
end

require 'thin'
require 'rack'
require 'haml'
require 'mysql'

require 'eol/core_ext'
require 'app'
