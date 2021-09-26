# encoding utf-8
require 'date'
require 'open-uri'
require 'nokogiri'
require 'json'

class ParserToJson

    def parse_jobs_items(web_site_url)
        # find all jobs on the page
        html = open(web_site_url)
        html_document = Nokogiri::HTML(html)

        jobs_items = []
        html_document.css('.list-jobs__item').each do |job_item|
            text_date = job_item.at_css('.text-date').text.strip  # convert to date time
            text_date.sub!(/today|сегодня|сьогодні/, Date.today.to_s)
            text_date.sub!(/yesterday|вчера|вчора/, (Date.today - 1).to_s)
            puts text_date

            title_element = job_item.at_css('.list-jobs__title')  # save href and if salary - $
            begin
                link = "https://djinni.co#{title_element.to_s[/href="[\w\-\/]+"/, 0].gsub(/href=|"/, '')}"
            rescue NoMethodError
                puts "Error while searching for job's link"
            end
            begin
                job_title = title_element.at_css('a').to_s[/<span>.*<\/span>/, 0].gsub(/<span>|<\/span>/, '')
            rescue NoMethodError
                puts "Error while searching for job title"
            end
            begin
                salary = title_element.at_css('.public-salary-item').to_s[/\$[0-9\-]+/, 0]
                # if no salary found
                unless salary
                    salary = 'no salary'
                end
            rescue NoMethodError
                salary = 'no salary'
            end
            puts job_title
            puts link
            puts salary

            descr = job_item.at_css('.list-jobs__description p').to_s.gsub(/<p>|<\/p>/, '')
            puts descr

            details = job_item.at_css('.list-jobs__details') # get location, experience, level
            begin
                location = details.at_css('.location-text').text.strip
            rescue NoMethodError
                location = 'no location found'
            end
            where_to_work = ''
            experience = ''
            level = ''
            # get info about experience, seniority level and where to work fron 'nobr' tag
            info = details.css('nobr').each do |element|
                if (element.to_s =~ /Office|Remote/)
                    where_to_work = element.text.strip.gsub(/^\s+|\n*/, '')
                end
                if (element.to_s =~ /досвід|опыт|experience/)
                    experience = element.text.strip.gsub(/^·\s/, '')
                end
                if (element.to_s =~ /Intermediate|Senior|Junior|Upper|Middle/)
                    level = element.text.strip.gsub(/^·\s/, '')
                end
            end
            puts location
            puts where_to_work
            puts experience
            puts level

            jobs_items.push(
              posting_date: text_date,
              job_title: job_title,
              link_to_post: link,
              salary: salary,
              city: location,
              remote_or_office: where_to_work,
              candidate_experince: experience,
              seniority_level: level
            )
        end
        jobs_items
    end

    def make_pretty_json(jobs_hash)
        JSON.pretty_generate(jobs_hash)
    end

    def save_parsed_jsobs_to_json(jobs_hash, file_path)
        # save the pretty json with parsed jobs to the file

        pretty_json = make_pretty_json(jobs_hash)
        File.open(file_path, "w+") do |json_file|
            json_file.write(pretty_json)
         end
    end

end
