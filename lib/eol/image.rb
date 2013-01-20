require 'eol/data_object'

module Eol
  class Image < DataObject
    attr_reader :url

    def initialize(json)
      super(json)
      # json.debug('image')
      @url           = json['eolMediaURL']
      @thumbnail_url = json['eolThumbnailURL'] # 98x68
    end

    FORMATS = {
      :small        => '_98_68',
      :small_square => '_88_88',
      :square       => '_130_130',
      :medium       => '_260_190',
    }

    def thumbnail_url(format=:square)
      @thumbnail_url.gsub(
        '_98_68',
        FORMATS[format.to_sym] || raise(ArgumentError)
      )
    end
  end
end
