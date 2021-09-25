# encoding utf-8
require 'open-uri'
require 'nokogiri'

class ParserToJson

    def initialize(web_site_url)
        @html = open(web_site_url)
        @web_site_url = web_site_url
    end

    attr_accessor :web_site_url

end
