require 'eol/data_object'
require 'eol/data_types'
require 'eol/image'
require 'eol/hierarchy_entry'

module Eol
  class Page
    SUBJECTS =
      %w[
        Overview
        Distribution
      ]
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
      pages =
        api.multi_get(
          Array(ids).map { |id| path(id) }, EMPTY_PARAMS.merge(params)
        ).map do |json|
          Page.new(api, json)
        end
      HierarchyEntry.multi_load_for_pages!(api, pages)
      pages
    end

    def self.load(api, id, params)
      Page.new(
        api,
        api.get(path(id), EMPTY_PARAMS.merge(params))
      )
    end

    attr_reader :identifier,
                :scientific_name,
                :richness_score,
                :data_objects,
                :hierarchy_entry,
                :raw

    def initialize(api, page)
      @api = api
      @raw = page
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
      @taxon_concepts = page['taxonConcepts']
    end

    def images
      @data_objects.select do |data_object|
        data_object.data_type == DataTypes.image
      end.
        uniq(&:url)
    end

    def texts(langs)
      @data_objects.select do |data_object|
        (data_object.data_type == DataTypes.text) &&
          (data_object.mime_type == 'text/html') &&
            langs.include?(data_object.language)
      end
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

    def first_taxon_concept_id
      @taxon_concepts.first['identifier'] if @taxon_concepts.any?
    end

    def taxon_ranks
      @taxon_concepts.map { |tc| tc['taxonRank'] }.uniq.compact
    end

    def hierarchy_entries
      HierarchyEntry.multi_load(
        @api,
        @taxon_concepts.map { |tc| tc['identifier'] }
      )
    end

    def hierarchy_entry=(entry)
      @hierarchy_entry = entry
    end

    def hierarchy_entry
      @hierarchy_entry ||=
        HierarchyEntry.load(
          @api,
          @taxon_concepts.first['identifier']
        )
    end

    def path
      @hierarchy_entry.path
    end

    def str_path
      @hierarchy_entry.str_path
    end

    def names(langs, separator=nil)
      result = langs.map do |lang|
        name = vernacular_name(lang)
        if name && block_given?
          yield(name, lang)
        else
          name
        end
      end.compact
      result = [ scientific_name ] if result.empty?
      separator ? result.join(separator) : result
    end
  end
end

<<'RUBY'
require 'pp'
require 'eol/api'
require 'eol/page'

page = Eol::Page.load(Eol::Api.new, 326447, {:text => 2})

RUBY