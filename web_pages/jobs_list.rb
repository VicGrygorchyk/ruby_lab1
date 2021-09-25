# encoding utf-8

class JobsLists

    def initialize(browser_agent)
        @browser_agent = browser_agent
    end

    def goto_vacancies()
        @browser_agent.open_url('https://djinni.co/jobs/')
        puts "After go to vacancies the latest opened page is #{@browser_agent.get_latest_opened_page().uri}"

    end

end