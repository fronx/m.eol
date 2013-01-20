$: << File.expand_path('.')
require 'spec_setup'
require 'eol/search_results'
require 'eol/api'

describe Eol::SearchResults do
  let(:gorilla_results) do
    { "totalResults" => 46,
      "startIndex"   =>  1,
      "itemsPerPage" => 30,
      "results"      => [
          {"id"=>326447, "title"=>"Gorilla gorilla", "link"=>"http://eol.org/pages/326447/overview", "content"=>"gorilla"},
          {"id"=>42003, "title"=>"Gorilla", "link"=>"http://eol.org/pages/42003/overview", "content"=>"Gorilla I. Geoffroy Saint-Hilaire, 1852; gorilla; Gorilla Geoffroy 1852; Gorilla I. Geoffroy, 1852"},
          {"id"=>2923523, "title"=>"Gorilla beringei", "link"=>"http://eol.org/pages/2923523/overview", "content"=>"Mountain gorilla; highland gorilla"},
          {"id"=>4454095, "title"=>"Gorilla gorilla gorilla", "link"=>"http://eol.org/pages/4454095/overview", "content"=>"Gorilla gorilla gorilla (Savage and Wyman, 1847).; Gorilla gorilla gorilla; Gorilla gorilla gorilla (Savage, 1847); Gorilla gorilla gorilla Savage, 1847; Gorilla gorilla ssp. gorilla (Savage, 1847); Gorilla gorilla gorilla Savage and Wyman 1847"},
          {"id"=>10372989, "title"=>"Gorilla gorilla diehli", "link"=>"http://eol.org/pages/10372989/overview", "content"=>"Gorilla gorilla (Nigerian stock)"},
          {"id"=>10372987, "title"=>"Gorilla gorilla graueri", "link"=>"http://eol.org/pages/10372987/overview", "content"=>"Gorilla graueri Matschie, 1914; Gorilla beringei graueri; Gorilla gorilla ssp. graueri Matschie, 1914; Gorilla gorilla rexpygmaeorum Schwarz 1927"},
          {"id"=>10551052, "title"=>"Homininae", "link"=>"http://eol.org/pages/10551052/overview", "content"=>"Homo/Pan/Gorilla group"},
          {"id"=>200764, "title"=>"Chirodropus gorilla Haeckel, 1880", "link"=>"http://eol.org/pages/200764/overview", "content"=>"Chirodropus gorilla Haeckel, 1880; Chirodropus gorilla"},
          {"id"=>143587, "title"=>"Catharsius gorilla THOMSON, 1858", "link"=>"http://eol.org/pages/143587/overview", "content"=>"Catharsius gorilla THOMSON, 1858"},
          {"id"=>20862066, "title"=>"Gorilla gorilla gorilla adenovirus 1", "link"=>"http://eol.org/pages/20862066/overview", "content"=>"Gorilla gorilla gorilla adenovirus 1"},
          {"id"=>20862067, "title"=>"Gorilla gorilla gorilla adenovirus 2", "link"=>"http://eol.org/pages/20862067/overview", "content"=>"Gorilla gorilla gorilla adenovirus 2"},
          {"id"=>20864179, "title"=>"Gorilla gorilla gorilla polyomavirus 1", "link"=>"http://eol.org/pages/20864179/overview", "content"=>"Gorilla gorilla gorilla polyomavirus 1"},
          {"id"=>8615332, "title"=>"Gorilline herpesvirus 1", "link"=>"http://eol.org/pages/8615332/overview", "content"=>"Gorilla herpesvirus; Herpesvirus gorilla; Pongine herpesvirus 3; Gorilline herpesvirus 1"},
          {"id"=>11608786, "title"=>"Gorilla gorilla lymphocryptovirus 1", "link"=>"http://eol.org/pages/11608786/overview", "content"=>"Gorilla gorilla lymphocryptovirus 1"},
          {"id"=>11608820, "title"=>"Gorilla gorilla lymphocryptovirus 2", "link"=>"http://eol.org/pages/11608820/overview", "content"=>"Gorilla gorilla lymphocryptovirus 2"},
          {"id"=>12138061, "title"=>"Gorilla gorilla uellensis", "link"=>"http://eol.org/pages/12138061/overview", "content"=>"Gorilla gorilla uellensis"},
          {"id"=>11608862, "title"=>"Gorilla rhadinovirus 1", "link"=>"http://eol.org/pages/11608862/overview", "content"=>"Gorilla gorilla rhadinovirus 1; Gorilla rhadinovirus 1"},
          {"id"=>11608289, "title"=>"Gorilla papillomavirus", "link"=>"http://eol.org/pages/11608289/overview", "content"=>"Gorilla papillomavirus"},
          {"id"=>20864167, "title"=>"Gorilla polyomavirus", "link"=>"http://eol.org/pages/20864167/overview", "content"=>"Gorilla polyomavirus"},
          {"id"=>11608701, "title"=>"Gorilla gorilla cytomegalovirus 1.1", "link"=>"http://eol.org/pages/11608701/overview", "content"=>"Gorilla gorilla cytomegalovirus 1.1"},
          {"id"=>11608702, "title"=>"Gorilla gorilla cytomegalovirus 2.1", "link"=>"http://eol.org/pages/11608702/overview", "content"=>"Gorilla gorilla cytomegalovirus 2.1"},
          {"id"=>11608703, "title"=>"Gorilla gorilla cytomegalovirus 2.2", "link"=>"http://eol.org/pages/11608703/overview", "content"=>"Gorilla gorilla cytomegalovirus 2.2"},
          {"id"=>20861821, "title"=>"Gorilla gorilla adenovirus B10", "link"=>"http://eol.org/pages/20861821/overview", "content"=>"Gorilla gorilla adenovirus B10"},
          {"id"=>20861822, "title"=>"Gorilla gorilla adenovirus B7", "link"=>"http://eol.org/pages/20861822/overview", "content"=>"Gorilla gorilla adenovirus B7"},
          {"id"=>20861823, "title"=>"Gorilla gorilla adenovirus B8", "link"=>"http://eol.org/pages/20861823/overview", "content"=>"Gorilla gorilla adenovirus B8"},
          {"id"=>20861824, "title"=>"Gorilla gorilla adenovirus B9", "link"=>"http://eol.org/pages/20861824/overview", "content"=>"Gorilla gorilla adenovirus B9"},
          {"id"=>20862062, "title"=>"Gorilla gorilla beringei adenovirus 3", "link"=>"http://eol.org/pages/20862062/overview", "content"=>"Gorilla gorilla beringei adenovirus 3"},
          {"id"=>20862063, "title"=>"Gorilla gorilla beringei adenovirus 4", "link"=>"http://eol.org/pages/20862063/overview", "content"=>"Gorilla gorilla beringei adenovirus 4"},
          {"id"=>20862064, "title"=>"Gorilla gorilla beringei adenovirus 5", "link"=>"http://eol.org/pages/20862064/overview", "content"=>"Gorilla gorilla beringei adenovirus 5"},
          {"id"=>20862065, "title"=>"Gorilla gorilla beringei adenovirus 6", "link"=>"http://eol.org/pages/20862065/overview", "content"=>"Gorilla gorilla beringei adenovirus 6"}
        ],
      "first"=>"http://eol.org/api/search/gorilla.json?page=1",
      "self"=>"http://eol.org/api/search/gorilla.json?page=1",
      "next"=>"http://eol.org/api/search/gorilla.json?page=2",
      "last"=>"http://eol.org/api/search/gorilla.json?page=2"
    }
  end

  let(:api) do
    Eol::Api.new
  end

  let(:search_results) do
    Eol::SearchResults.new(api, gorilla_results, {}, nil)
  end

  it "has items" do
    item = search_results.items.first
    item.should be_an(Eol::SearchItem)
    item.id.should              == 326447
    item.title.should           == 'Gorilla gorilla'
    item.content.should         == 'gorilla'
    item.scientific_name.should == 'Gorilla gorilla (Savage and Wyman, 1847)'
    item.names(%w[ en de es ], ' | ').should == 'Western gorilla | Gorilla gorilla'
  end

  it "allows to iterate over search items" do
    search_results.each do |item|
      item.should be_an(Eol::SearchItem)
    end
  end
end
