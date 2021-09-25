
require 'rubygems'
require 'mechanize'

class LoginPage

    def initialize(browser_agent)
        @browser_agent = browser_agent
    end

    def login_to_site(website_url)
        url = @browser_agent.open_url(website_url)
        @browser_agent.click_link('a[href="/login?from=frontpage_main"]')
        form = @browser_agent.get_form('form[method="post"]')
        form['email'] = 'vvgrygorchuk@gmail.com'
        form['password'] = 'Random88_dji'
        @browser_agent.submit_form(form)
        puts "After login the latest opened page is #{@browser_agent.get_latest_opened_page().uri}"
    end


end