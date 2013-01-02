$: << File.expand_path('.')
require 'spec_setup'
require 'view_helpers/route'

describe Route do
  it "fills in parameters" do
    Route.new("/search/:mode").to_s({:mode => 'list', :q => 'bee'}).should == '/search/list?q=bee'
    Route.new("/search/:mode").to_s({:mode => 'grid'}).should == '/search/grid'
  end
end
