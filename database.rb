require 'rubygems'
require 'nokogiri'
require 'open-uri'

f = File.open("nar_database2.csv", "w")

f.puts "NAR id, DB Name, URI, Database Description"

601.upto(1291) { |i|

narid = i.to_s

uri = 'http://oxfordjournals.org/nar/database/summary/'+ narid
begin
	doc = Nokogiri::HTML(open(uri))

	array = []
  tmp = []

	array.push(narid)

	doc.search('h1.summary').each do |line|
		array.push(line.content)
	end

	array.push(doc.search('div.bodytext a').shift.content)
	
 doc.search('div.bodytext').each do |line|
	 tmp.push(line.content)
 end

 description = tmp[tmp.index(tmp.select{|x| x =~ /Contact/}.to_s) + 1]
 array.push(description.gsub("\n",""))

	f.puts array.join(';')
	puts array.join(';')
	sleep 3
rescue
	next
end
}
f.close
