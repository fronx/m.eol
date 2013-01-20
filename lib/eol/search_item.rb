require 'eol/page'
require 'forwardable'

module Eol
  class SearchItem
    extend Forwardable
    def_delegators :@page, :identifier,
                           :scientific_name,
                           :data_objects,
                           :images,
                           :names,
                           :path,
                           :str_path,
                           :hierarchy_entry,
                           :taxon_ranks,
                           :richness_score

    attr_reader :id,
                :title,
                :content,
                :raw

    DEFAULT_IMAGE_COUNT = 7

    def initialize(api, item, page)
      @raw = item
      @id      = item['id']
      @title   = item['title']
      @link    = item['link']
      @content = item['content']
      @page    = page
    end

    def inspect
      "#<Eol::SearchItem:" <<
        [
          @raw.inspect,
          @page.raw.inspect,
          @page.path.inspect,
        ].join(', ') << ">"
    end
  end
end
