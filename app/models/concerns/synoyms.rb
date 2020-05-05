module Synonyms
    require 'unirest'

    def create_synonyms(word, types=['typeOf', 'similarTo', 'synonyms'])
        return types.map { |t| send_words_request(word, t) }.flatten(1).uniq.compact
    end

    def send_words_request(word, type)
        response = Unirest.get "https://wordsapiv1.p.rapidapi.com/words/#{word}/#{type}",
            "X-RapidAPI-Key" => ENV["WORDS_API"]
        return response.body[type]
    end

end