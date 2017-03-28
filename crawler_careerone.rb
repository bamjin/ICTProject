require 'nokogiri'
require 'open-uri'
require 'csv'

CSV.open('output2.csv', 'wb') do |csv|		# make csv file
	1.upto(277) do |c|											# read upto 277 pages
	doc = Nokogiri::HTML(open("http://www.careerone.com.au/job-search/search/page#{c}?lid[]=")) # open careerone
		doc.search('.job').each do |x|				# search job class on page
			jobs = []														# make a job as array
			jobs << x.css('.job_title//a').inner_text		# put job info into a job array
			jobs << x.css('.job_company').inner_text
			jobs << x.css('.job_location').inner_text
			jobs << x.css('.job_salary').inner_text
			csv << jobs													# save jobs array as a csv file
		end
	end
end
