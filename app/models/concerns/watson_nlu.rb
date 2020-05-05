module WatsonNlu
    require 'ibm_watson'
    include IBMWatson
    require "ibm_watson/authenticators"
    require "ibm_watson/natural_language_understanding_v1"
    require 'synonyms'
    include Synonyms 

    def tabulate(messages)
        responses = messages.map { |message| watson(message) }
        payload = sort_response(responses)
        return payload
    end

    def watson(msg)
        authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
            apikey: ENV['API_KEY'],
        )
         
        natural_language_understanding = NaturalLanguageUnderstandingV1.new(
            version: "2019-07-12",
            authenticator: authenticator
        )

        natural_language_understanding.service_url = ENV['API_URL']
        response = natural_language_understanding.analyze(
            text: msg,
            features: { 
                entities: {limit: 5},
                concepts: {limit: 5},
                keywords: {limit: 5},
                emotion: {},
                sentiment: {},
                semantic_roles: {}
            },
        )
        return response.result
    end

    def sort_response(responses)
        payload = {}
        payload[:concepts] = responses.map { |response| response['concepts'].map { |c| c['text'] } if response['concepts'].present? }.flatten.compact.each_with_object(Hash.new(0)) { |c,h| h[c] += 1 }
        payload[:keywords] = responses.map { |response| response['keywords'].map { |kw| kw['text'] }  if response['keywords'].present? }.flatten.compact.each_with_object(Hash.new(0)) { |kw,h| h[kw] += 1 }
        payload[:entities] = responses.map { |response| response['entities'].map { |ent| ent['text'] }  if response['entities'].present? }.flatten.compact.each_with_object(Hash.new(0)) { |e,h| h[e] += 1 }
        return payload
    end
end