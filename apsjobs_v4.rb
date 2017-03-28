require 'csv'

CSV.open('apsjobs_all.csv', 'wb') do |csv|	# make csv file
	files = Dir.glob("*.txt")                 # find directory
	i = 0                                     # initial value for while loop
	while i < files.count											          # count number of files
		file = files[i]
		job = []													          # select a file
		doc = File.read(file).split(/\r\n\r\n/) # read and devide by double space
		doc.each do |line|
			if (line =~ /Job Title/) && (line =~ /JobType/) && (line =~ /Salary/) && (line =~ /Location/) && (line =~ /Classification/)# Priority fields
				job = line.split(/\r\n/)    # devide by line
				job << file									# date = file name
				if job[0].include?("Title") == false
					job[0] = nil
				elsif job[1].include?("JobType") == false
					job[1] = nil
				elsif job[2].include?("Location") == false
					job[2] = nil
				elsif job[3].include?("Salary") == false
					job[3] = nil
				elsif job[4].include?("Classification") == false
					job[4] = nil
				elsif job[5].include?(".txt") == false
					job[5] = file
				end
			elsif line =~ /Job Description/
				job[6] = line
				csv << job
			end
		end
		i = i + 1
	end
end
