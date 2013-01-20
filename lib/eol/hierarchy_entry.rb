module Eol
  class HierarchyEntry
    DEFAULT_PARAMS = {
      :common_names => true,
      :synonyms     => false,
    }

    def self.path(id)
      # possible error result:
      # [
      #   {
      #     "error": "hierarchy_entry \"#{id}\" is no longer available"
      #   }
      # ]
      "hierarchy_entries/1.0/#{id}.json"
    end

    def self.load(api, id, params={})
      HierarchyEntry.new(
        api,
        api.get(path(id), DEFAULT_PARAMS.merge(params))
      )
    end

    def self.multi_load(api, ids, params={})
      api.multi_get(
        Array(ids).map { |id| path(id) }, DEFAULT_PARAMS.merge(params)
      ).map do |json|
        HierarchyEntry.new(api, json)
      end
    end

    def self.multi_load_for_pages!(api, pages)
      hierarchy_entries = multi_load(api, pages.map(&:first_taxon_concept_id).compact, {})
      pages.each do |page|
        page.hierarchy_entry =
          hierarchy_entries.detect do |entry|
            entry.identifier == page.identifier
          end
      end
    end

    DEFAULT_TAXON_RANK_FILTER = %w[
      superkingdom
      kingdom
      phylum
      class
      order
      family
      genus
    ]

    attr_reader :identifier,
                :scientific_name,
                :taxon_rank

    def initialize(api, json)
      @api = api
      @identifier      = json['taxonConceptID']
      @path            = json['ancestors']
      @taxon_rank      = json['taxonRank']
      @scientific_name = json['scientificName']
      # 'sourceIdentifier'
      # 'parentNameUsageID'
      # 'taxonConceptID'
      # 'scientificName'
      # 'taxonRank'
      # 'total_descendants'
      # 'total_trusted_text'
      # 'total_unreviewed_text'
      # 'total_descendants_with_text'
      # 'total_trusted_images'
      # 'total_unreviewed_images'
      # 'total_descendants_with_images'
    end

    def full_path
      @path
    end

    def path(taxon_rank_filter=DEFAULT_TAXON_RANK_FILTER)
      @path.select do |part|
        taxon_rank_filter.include?(part['taxonRank'])
      end
    end

    def str_path(taxon_rank_filter=DEFAULT_TAXON_RANK_FILTER)
      path(taxon_rank_filter).map do |part|
        part['scientificName']
      end
    end
  end
end
