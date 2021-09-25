# encoding utf-8

=begin
This programm parses a web page and saves it to json
=end
require_relative "parser_to_json.rb"
require_relative "browser_agent.rb"
require_relative "web_pages/login_page.rb"


def main()
    agent = BrowserAgent.new
    login_page = LoginPage.new(agent)
    login_page.login_to_site('https://djinni.co/')
end

main()
