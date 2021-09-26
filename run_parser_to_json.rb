# encoding utf-8

=begin
This programm parses a web page and saves it to json
=end
require_relative "parser_to_json.rb"
require_relative "browser_agent.rb"
require_relative "web_pages/login_page.rb"
require_relative "web_pages/jobs_list.rb"


def main()
    file_path = './jobs.json'
    agent = BrowserAgent.new
    login_page = LoginPage.new(agent)
    # login_page.login_to_site(website_url='https://djinni.co/', email='vvgrygorchuk@gmail.com', password='Random88_dji')

    job_list = JobsLists.new(agent)
    job_list.goto_vacancies

    parser = ParserToJson.new(agent.get_current_page_uri)
    jobs = parser.parse_jobs_items
    parser.save_parsed_jsobs_to_json(jobs, file_path)
end

main()
