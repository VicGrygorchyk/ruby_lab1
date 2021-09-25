# encoding utf-8
require 'open-uri'
require 'nokogiri'

class ParserToJson

    def initialize(web_site_url)
        @html = open(web_site_url)
        @html_document = Nokogiri::HTML(@html)
    end

    attr_reader :html_document


end
