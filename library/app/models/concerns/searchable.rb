module Searchable
 extend ActiveSupport::Concern

 included do
   include Elasticsearch::Model
   include Elasticsearch::Model::Callbacks

   def as_indexed_json(_options = {})
     as_json(only: %i[name description price image_url created_date])
     #as_json(
      #  #only: [:name, :description]
     #)
   end

#   settings settings_attributes do
#     mappings dynamic: false do
#       indexes :name, type: 'text', analyzer: 'autocomplete'
#       indexes :description, type: :keyword
#     end
#   end
    settings index: { number_of_shards: 1 } do
      mappings dynamic: 'false' do
        indexes :name, type: 'text'
        indexes :description, type: :keyword
        indexes :price, type: :keyword
        indexes :image_url, type: :keyword
        indexes :created_date, type: :keyword
      end
    end

   def self.search(query, filters)
   
   	set_filters = lambda do |context_type, filter|
       @search_definition[:query][:bool][context_type] |= [filter]
     end

     @search_definition = {
       #size: 5,
       query: {
         bool: {
           must: [],
           should: [],
           filter: []
         }  
       }
     }

     if query.blank?
       set_filters.call(:must, match_all: {})
     else
       set_filters.call(
         :must,
         match: {
           name: {
             query: query,
             fuzziness: 1
           }
         }
       )
     end

     #if filters[:level].present?
     #  set_filters.call(:filter, term: { level: filters[:level] })
     #end

     __elasticsearch__.search(@search_definition)
     
   end
 end

 class_methods do

   def settings_attributes
     {
       index: {
         analysis: {
           analyzer: {
             autocomplete: {
               type: :custom,
               tokenizer: :standard,
               filter: %i[lowercase autocomplete]
             }
           },
           filter: {
             autocomplete: {
               type: :edge_ngram,
               min_gram: 2,
               max_gram: 25
             }
           }
         }
       }
     }
   end
 end
end