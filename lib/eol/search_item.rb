require 'eol/page'
require 'forwardable'

module Eol
  class SearchItem
    extend Forwardable
    def_delegators :@page, :identifier,
                           :scientific_name,
                           :data_objects,
                           :images,
                           :vernacular_name,
                           :name

    attr_reader :id, :title, :content, :scientific_name

    DEFAULT_IMAGE_COUNT = 7

    def initialize(api, item, page)
      @id      = item['id']
      @title   = item['title']
      @link    = item['link']
      @content = item['content']
      @page    = page
    end
  end
end
