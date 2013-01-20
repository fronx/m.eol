# encoding: UTF-8
$: << File.expand_path('.')
require 'spec_setup'
require 'eol/page'
require 'eol/api'

describe Eol::Page do
  let(:gorilla_page_ids) do
    [ 326447, 42003, 20861821 ]
  end

  let(:pages_raw) do
    [
      { "identifier" => 326447, "scientificName" => "Gorilla gorilla", "richness_score" => 84.5995, "synonyms" => [],
        "vernacularNames" => [
          {"vernacularName" => "Western gorilla", "language" => "en", "eol_preferred" => true},
          {"vernacularName" => "gorilla", "language" => "en"},
          {"vernacularName" => "lowland gorilla", "language" => "en"},
          {"vernacularName" => "Gorilla gorilla", "language" => "es", "eol_preferred" => true},
          {"vernacularName" => "Gorila", "language" => "es"},
          {"vernacularName" => "Gorille", "language" => "fr", "eol_preferred" => true},
          {"vernacularName" => "Горилла", "language" => "ru", "eol_preferred" => true}
        ],
        "references" => [],
        "taxonConcepts" => [{"identifier" => 24935631, "scientificName" => "Gorilla gorilla", "nameAccordingTo" => "IUCN Red List (Species Assessed for Global Conservation)", "canonicalForm" => "Gorilla gorilla", "sourceIdentfier" => "IUCN-9404"}, {"identifier" => 39202250, "scientificName" => "Gorilla gorilla", "nameAccordingTo" => "NCBI Taxonomy", "canonicalForm" => "Gorilla gorilla", "sourceIdentfier" => "9593", "taxonRank" => "Species"}, {"identifier" => 46592319, "scientificName" => "Gorilla gorilla (Savage and Wyman, 1847)", "nameAccordingTo" => "Integrated Taxonomic Information System (ITIS)", "canonicalForm" => "Gorilla gorilla", "sourceIdentfier" => "573080", "taxonRank" => "Species"}, {"identifier" => 48130283, "scientificName" => "Gorilla gorilla (Savage and Wyman, 1847)", "nameAccordingTo" => "Species 2000 & ITIS Catalogue of Life: May 2012", "canonicalForm" => "Gorilla gorilla", "sourceIdentfier" => "6873735", "taxonRank" => "Species"}, {"identifier" => 49344958, "scientificName" => "Gorilla gorilla (Savage and Wyman, 1847)", "nameAccordingTo" => "Paleobiology Database", "canonicalForm" => "Gorilla gorilla", "sourceIdentfier" => "urn:paleodb:tn231497", "taxonRank" => "Species"}],
        "dataObjects" => [
          { "identifier"          => "fc532c615a2d8d7c5468bd4e13ef5762",
            "dataObjectVersionID" => 5670419,
            "dataType"            => "http://purl.org/dc/dcmitype/Text",
            "dataSubtype"         => "",
            "vettedStatus"        => "Trusted",
            "dataRating"          => 2.5,
            "subject"             => "http://rs.tdwg.org/ontology/voc/SPMInfoItems#TaxonBiology",
            "mimeType"            => "text/html",
            "title"               => "Biology",
            "language"            => "en",
            "license"             => "http://creativecommons.org/licenses/by-nc-sa/3.0/",
            "rights"              => "Copyright Wildscreen 2003-2008",
            "rightsHolder"        => "Wildscreen",
            "audience"            => ["General public"],
            "source"              => "http://www.arkive.org/western-gorilla/gorilla-gorilla/",
            "description"         =>
             "Western gorillas live in groups that vary in size between 2 and 20 individuals, composed of at least one male, several females and their offspring (2). A dominant male silverback heads the group, with younger males usually leaving the group when they reach maturity. Females transfer to another group before breeding, which begins at eight to nine years old; they care for their young infant for the first four to five years of its life (2). There is therefore a long interval between births, which partly explains the slow population growth rates that make the western gorilla so vulnerable to poaching (6). Due to the long gestation time, long period of parental care, and infant mortality, a female gorilla will only give birth to an offspring that survives to maturity every four to six years. Gorillas are long-lived and may survive for as long as 40 years in the wild (4).&nbsp;Fruit forms a large part of the western gorilla's diet and they will travel further each day in search of fruiting trees than their eastern relatives (2). The distance that gorillas travel each day while they are searching for fruit trees varies between one and four kilometres. A group's home range may be as large as 30 square kilometres (2).",
            "agents" => [
              { "full_name" => "ARKive",
                "homepage"  => "http://www.arkive.org/",
                "role"      => "provider"
              }
            ],
            "references" => []
          },
        ]
      },
      { "identifier" => 42003, "scientificName" => "gorilla", "richness_score" => 60.8969, "synonyms" => [], "vernacularNames" => [{"vernacularName" => "Gorillas", "language" => "en", "eol_preferred" => true}], "references" => [],
        "taxonConcepts" => [
          { "identifier" => 24935600, "scientificName" => "gorilla", "nameAccordingTo" => "IUCN Red List (Species Assessed for Global Conservation)", "canonicalForm" => "Gorilla", "taxonRank" => "Genus"
          },
          { "identifier" => 39202249, "scientificName" => "gorilla", "nameAccordingTo" => "NCBI Taxonomy", "canonicalForm" => "Gorilla", "sourceIdentfier" => "9592", "taxonRank" => "Genus"}, {"identifier" => 46592318, "scientificName" => "Gorilla I. Geoffroy Saint-Hilaire, 1852", "nameAccordingTo" => "Integrated Taxonomic Information System (ITIS)", "canonicalForm" => "Gorilla", "sourceIdentfier" => "572837", "taxonRank" => "Genus"
          },
          { "identifier" => 48130282, "scientificName" => "gorilla", "nameAccordingTo" => "Species 2000 & ITIS Catalogue of Life: May 2012", "canonicalForm" => "Gorilla", "sourceIdentfier" => "11104408", "taxonRank" => "Genus"
          },
          { "identifier" => 49344957, "scientificName" => "Gorilla Geoffroy 1852", "nameAccordingTo" => "Paleobiology Database", "canonicalForm" => "Gorilla", "sourceIdentfier" => "urn:paleodb:tn97178", "taxonRank" => "Genus"
          }
        ],
        "dataObjects" => []
      },
      { "identifier" => 20861821, "scientificName" => "Gorilla gorilla adenovirus B10", "richness_score" => 1.335, "synonyms" => [], "vernacularNames" => [], "references" => [],
        "taxonConcepts" => [
          { "identifier" => 38421984, "scientificName" => "Gorilla gorilla adenovirus B10", "nameAccordingTo" => "NCBI Taxonomy", "canonicalForm" => "Gorilla gorilla adenovirus", "sourceIdentfier" => "927251"
          }
        ],
        "dataObjects" => []
      }
    ]
  end

  let(:hierarchy_entries_raw) do
    [
      { "sourceIdentifier" => "IUCN-9404", "taxonID" => 24935631, "parentNameUsageID" => 24935600, "taxonConceptID" => 326447, "scientificName" => "Gorilla gorilla", "source" => "http://eol.org/pages/326447/hierarchy_entries/24935631/overview", "total_descendants" => 0, "total_trusted_text" => 39, "total_unreviewed_text" => 1, "total_descendants_with_text" => 1, "total_trusted_images" => 12, "total_unreviewed_images" => 35, "total_descendants_with_images" => 1, "nameAccordingTo" => ["IUCN Red List (Species Assessed for Global Conservation)"], "vernacularNames" => [], "synonyms" => [],
        "ancestors" => [{"taxonID" => 24913771, "parentNameUsageID" => 0, "taxonConceptID" => 1, "scientificName" => "Animalia", "taxonRank" => "kingdom", "source" => "http://eol.org/pages/1/hierarchy_entries/24913771/overview"}, {"taxonID" => 24913792, "parentNameUsageID" => 24913771, "taxonConceptID" => 694, "scientificName" => "Chordata", "taxonRank" => "phylum", "source" => "http://eol.org/pages/694/hierarchy_entries/24913792/overview"}, {"taxonID" => 24913813, "parentNameUsageID" => 24913792, "taxonConceptID" => 1642, "scientificName" => "Mammalia", "taxonRank" => "class", "source" => "http://eol.org/pages/1642/hierarchy_entries/24913813/overview"}, {"taxonID" => 24915812, "parentNameUsageID" => 24913813, "taxonConceptID" => 1645, "scientificName" => "Primates", "taxonRank" => "order", "source" => "http://eol.org/pages/1645/hierarchy_entries/24915812/overview"}, {"taxonID" => 24935599, "parentNameUsageID" => 24915812, "taxonConceptID" => 1653, "scientificName" => "Hominidae", "taxonRank" => "family", "source" => "http://eol.org/pages/1653/hierarchy_entries/24935599/overview"}, {"taxonID" => 24935600, "parentNameUsageID" => 24935599, "taxonConceptID" => 42003, "scientificName" => "Gorilla", "taxonRank" => "genus", "source" => "http://eol.org/pages/42003/hierarchy_entries/24935600/overview"}],
        "children" => []
      },
      { "taxonID" => 24935600, "parentNameUsageID" => 24935599, "taxonConceptID" => 42003, "scientificName" => "gorilla", "taxonRank" => "Genus", "source" => "http://eol.org/pages/42003/hierarchy_entries/24935600/overview", "total_descendants" => 2, "total_trusted_text" => 69, "total_unreviewed_text" => 3, "total_descendants_with_text" => 3, "total_trusted_images" => 18, "total_unreviewed_images" => 69, "total_descendants_with_images" => 3, "nameAccordingTo" => ["IUCN Red List (Species Assessed for Global Conservation)"], "vernacularNames" => [], "synonyms" => [],
        "ancestors" => [{"taxonID" => 24913771, "parentNameUsageID" => 0, "taxonConceptID" => 1, "scientificName" => "Animalia", "taxonRank" => "kingdom", "source" => "http://eol.org/pages/1/hierarchy_entries/24913771/overview"}, {"taxonID" => 24913792, "parentNameUsageID" => 24913771, "taxonConceptID" => 694, "scientificName" => "Chordata", "taxonRank" => "phylum", "source" => "http://eol.org/pages/694/hierarchy_entries/24913792/overview"}, {"taxonID" => 24913813, "parentNameUsageID" => 24913792, "taxonConceptID" => 1642, "scientificName" => "Mammalia", "taxonRank" => "class", "source" => "http://eol.org/pages/1642/hierarchy_entries/24913813/overview"}, {"taxonID" => 24915812, "parentNameUsageID" => 24913813, "taxonConceptID" => 1645, "scientificName" => "Primates", "taxonRank" => "order", "source" => "http://eol.org/pages/1645/hierarchy_entries/24915812/overview"}, {"taxonID" => 24935599, "parentNameUsageID" => 24915812, "taxonConceptID" => 1653, "scientificName" => "Hominidae", "taxonRank" => "family", "source" => "http://eol.org/pages/1653/hierarchy_entries/24935599/overview"}],
        "children" => [{"sourceIdentifier" => "IUCN-39994", "taxonID" => 24935601, "parentNameUsageID" => 24935600, "taxonConceptID" => 2923523, "scientificName" => "Gorilla beringei", "source" => "http://eol.org/pages/2923523/hierarchy_entries/24935601/overview"}, {"sourceIdentifier" => "IUCN-9404", "taxonID" => 24935631, "parentNameUsageID" => 24935600, "taxonConceptID" => 326447, "scientificName" => "Gorilla gorilla", "source" => "http://eol.org/pages/326447/hierarchy_entries/24935631/overview"}]
      },
      { "sourceIdentifier" => "927251", "taxonID" => 38421984, "parentNameUsageID" => 38421977, "taxonConceptID" => 20861821, "scientificName" => "Gorilla gorilla adenovirus B10", "source" => "http://eol.org/pages/20861821/hierarchy_entries/38421984/overview", "total_descendants" => 0, "total_trusted_text" => 0, "total_unreviewed_text" => 0, "total_descendants_with_text" => 0, "total_trusted_images" => 0, "total_unreviewed_images" => 0, "total_descendants_with_images" => 0, "nameAccordingTo" => ["NCBI Taxonomy"], "vernacularNames" => [], "synonyms" => [],
        "ancestors" => [{"sourceIdentifier" => "10239", "taxonID" => 38417494, "parentNameUsageID" => 0, "taxonConceptID" => 5006, "scientificName" => "Viruses", "taxonRank" => "superkingdom", "source" => "http://eol.org/pages/5006/hierarchy_entries/38417494/overview"}, {"sourceIdentifier" => "35237", "taxonID" => 38420957, "parentNameUsageID" => 38417494, "taxonConceptID" => 11605721, "scientificName" => "Dsdna viruses, no RNA stage", "source" => "http://eol.org/pages/11605721/hierarchy_entries/38420957/overview"}, {"sourceIdentifier" => "10508", "taxonID" => 38421916, "parentNameUsageID" => 38420957, "taxonConceptID" => 5048, "scientificName" => "Adenoviridae", "taxonRank" => "family", "source" => "http://eol.org/pages/5048/hierarchy_entries/38421916/overview"}, {"sourceIdentifier" => "10509", "taxonID" => 38421917, "parentNameUsageID" => 38421916, "taxonConceptID" => 80629, "scientificName" => "Mastadenovirus", "taxonRank" => "genus", "source" => "http://eol.org/pages/80629/hierarchy_entries/38421917/overview"}, {"sourceIdentifier" => "108098", "taxonID" => 38421973, "parentNameUsageID" => 38421917, "taxonConceptID" => 741034, "scientificName" => "Human adenovirus B", "taxonRank" => "species", "source" => "http://eol.org/pages/741034/hierarchy_entries/38421973/overview"}, {"sourceIdentifier" => "377612", "taxonID" => 38421977, "parentNameUsageID" => 38421973, "taxonConceptID" => 11606586, "scientificName" => "Unclassified Human adenovirus B", "source" => "http://eol.org/pages/11606586/hierarchy_entries/38421977/overview"}],
        "children" => []
      }
    ]
  end

  let(:api) do
    Eol::Api.new
  end

  it "" do
    api.should_receive(:multi_get).with(
      [ "pages/1.0/#{326447}.json"  ,
        "pages/1.0/#{42003}.json"   ,
        "pages/1.0/#{20861821}.json",
      ],
      Eol::Page::EMPTY_PARAMS
    ).and_return(pages_raw)
    api.should_receive(:multi_get).with(
      [ "hierarchy_entries/1.0/#{24935631}.json",
        "hierarchy_entries/1.0/#{24935600}.json",
        "hierarchy_entries/1.0/#{38421984}.json",
      ],
      Eol::HierarchyEntry::DEFAULT_PARAMS
    ).and_return([])
    pages = Eol::Page.multi_load(api, gorilla_page_ids, {})
    pages.map(&:identifier).should == gorilla_page_ids
    pages.map(&:taxon_ranks).should == [
      ['Species'],
      ['Genus'],
      [ ],
    ]
    pages.first.names(%w[ en fr es ], ' | ').should == 'Western gorilla | Gorille | Gorilla gorilla'
  end
end
