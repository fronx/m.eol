require 'eol/data_object'
require 'eol/data_types'
require 'eol/image'

module Eol
  class Page
    EMPTY_PARAMS =
      {
        :images       => 0,
        :videos       => 0,
        :sounds       => 0,
        :text         => 0,
        :iucn         => false,      # include the IUCN Red List status object
        :subjects     => 'overview', #
        :licenses     => 'all',      # cc-by, cc-by-nc, cc-by-sa, cc-by-nc-sa, pd [public domain], na [not applicable], all
        :details      => true,       # include all metadata for data objects
        :common_names => true,       # return all common names for the page's taxon
        :vetted       => 1,          # If 'vetted' is given a value of '1', then only trusted content will be returned. If 'vetted' is '2', then only trusted and unreviewed content will be returned (untrusted content will not be returned).
      }

    def self.path(id)
      "pages/1.0/#{id}.json"
    end

    # returns a hash
    def self.multi_load(api, ids, params)
      api.multi_get(
        ids.map { |id| path(id) }, EMPTY_PARAMS.merge(params)
      ).map do |json|
        Page.new(json)
      end
    end

    def self.load(api, id, params)
      Page.new(
        api.get(path(id), EMPTY_PARAMS.merge(params))
      )
    end

    attr_reader :identifier, :scientific_name, :richness_score, :data_objects

    def initialize(page)
      @identifier       = page['identifier'] # same as search item id
      @scientific_name  = page['scientificName']
      @richness_score   = page['richness_score']
      @vernacular_names = page['vernacularNames']
      @data_objects =
        page['dataObjects'].map do |json|
          case json['dataType']
          when DataTypes.image
            Image.new(json).debug
          else
            DataObject.new(json)
          end
        end
    end

    def images
      @data_objects.select do |data_object|
        data_object.data_type == DataTypes.image
      end.
        uniq(&:url).debug("images")
    end

    def image_by_id(id)
      images.detect do |image|
        image.identifier.to_s == id.to_s
      end
    end

    def vernacular_name(lang)
      result =
        @vernacular_names.detect do |name_hash|
          (name_hash['language'] == lang.downcase) &&
            (name_hash['eol_preferred'] == true)
        end
      result['vernacularName'] if result
    end

    def name(lang)
      vernacular_name(lang) || scientific_name
    end
  end
end
