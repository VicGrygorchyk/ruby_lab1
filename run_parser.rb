# encoding utf-8

=begin
This programm parses a web page and saves it to json and csv
=end
require_relative "csv_converter.rb"
require_relative "parser_to_json.rb"
require_relative "browser_agent.rb"
require_relative "web_pages/login_page.rb"
require_relative "web_pages/jobs_list.rb"


def main()
    json_file_path = './jobs.json'
    csv_file_path = './jobs.csv'
    agent = BrowserAgent.new
    # login
    login_page = LoginPage.new(agent)
    login_page.login_to_site(website_url='https://djinni.co/', email='hryhorchuk.viktor@chnu.edu.ua', password='R@ndom12345')
    # find a web page with vacancies
    job_list = JobsLists.new(agent)
    job_list.goto_vacancies
    # parse vacancies
    jobs = ParserToJson.parse_html_by_url(agent.get_current_page_uri)
    # save to json
    ParserToJson.save_to_json(json_file_path, jobs)
    # save to csv
    CSVConverter.convert_to_csv(csv_file_path, jobs)
end

main()
