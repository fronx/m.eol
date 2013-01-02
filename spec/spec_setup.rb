require 'bundler'
Bundler.require :default
Bundler.require :test

%w[
  .
  ./lib
  ./app
].each do |path|
  $: << File.expand_path(path)
end
