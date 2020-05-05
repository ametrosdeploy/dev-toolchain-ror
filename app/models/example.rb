# == Schema Information
#
# Table name: examples
#
#  id         :bigint           not null, primary key
#  body       :text
#  data       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Example < ApplicationRecord
    require 'watson_nlu'
    include WatsonNlu

    has_many :concepts, as: :conceptable, dependent: :destroy
    has_many :keywords, as: :keywordable, dependent: :destroy
    has_many :entities, as: :entitable, dependent: :destroy

    def set_data
        self.data = watson(self.body).to_s
    end
    
    def convert_data_to_hash
        return eval(self.data) unless self.data.nil?
    end
    
    def extract_concepts
        watson_data = self.convert_data_to_hash
        watson_data.present? ? watson_data['concepts'].map { |concept| concept } : []
    end
    
    def extract_keywords
        watson_data = self.convert_data_to_hash
        watson_data.present? ? watson_data['keywords'].map { |keyword| keyword } : []
    end
    
    def extract_entities
        watson_data = self.convert_data_to_hash
        watson_data.present? ? watson_data['entities'].map { |entity| entity } : []
    end
    
    def generate_concepts
        self.extract_concepts.uniq.each do |concept|
            c = Concept.new
            c.label = concept['text']
            c.relevance = (concept['relevance'] * 100).to_i
            c.get_synonyms
            self.concepts << c
            c.save!
        end
    end
    
    def generate_keywords
        self.extract_keywords.uniq.each do |keyword|
            kw = Keyword.new
            kw.label = keyword['text']
            kw.relevance = (keyword['relevance'] * 100).to_i
            kw.get_synonyms
            self.keywords << kw
            kw.save
        end
    end
    
    def generate_entities
        self.extract_entities.uniq.each do |entity|
            ent = DialogicEntity.new
            ent.label = entity['text']
            ent.relevance = (entity['relevance'] * 100).to_i
            ent.get_synonyms
            self.entities << ent
            ent.save
        end
    end
    
    def create_all
        self.generate_concepts
        self.generate_entities
        self.generate_keywords
    end
end
