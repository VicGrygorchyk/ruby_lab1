# encoding utf-8

require 'rubygems'
require 'mechanize'

class BrowserAgent

    def initialize()
        @browser_agent = Mechanize.new { |agent|
            agent.user_agent = 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.159 Safari/537.36'
        }
        @latest_opened_page = nil
    end

    attr_reader :browser_agent

    def get_latest_opened_page()
        @latest_opened_page
    end

    def get_current_page_uri()
        @browser_agent.current_page.uri
    end

    def open_url(url)
        @latest_opened_page = @browser_agent.get(url)
    end

    def click_link(css_selector)
        link = @latest_opened_page.link_with(css: css_selector)
        @latest_opened_page = link.click
    end

    def get_form(form_css)
        form = @latest_opened_page.form_with(css: form_css)
        form
    end

    def submit_form(form)
        @latest_opened_page = form.submit
    end
end