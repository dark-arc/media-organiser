#!/usr/bin/env ruby
require 'httparty'

module API
  class OMDB
    include HTTParty
    base_uri 'http://www.omdbapi.com/'
    
    def initialize()
      
    end
    
    def search(keywords)
      self.class.get('/', query: {s: keywords})
    end
    
    def get(name)
      if name =~ /^tt/
        self.class.get('/', query: {i: name})
      else
        self.class.get('/', query: {t: name})
      end
    end
  end
end
