require 'rubygems'
require 'nokogiri'
require 'open-uri'
  array = []


3.upto(4) { |i|

uri = "http://oxfordjournals.org/nar/database/summary/#{i}"
begin
  html = open(uri)
  doc = Nokogiri::HTML(html)
  ct_title_j = ct_title_e = ct_url = ct_url_e = ct_desc_e =	ct_e_openid = ct_m_openid = ct_entry = ct_modified = ""

  doc.search('h1.summary').each do |line|
  ct_title_j = ct_title_e = line.content  
  end

  ct_url = ct_url_e = doc.search('div.bodytext a').shift.content

  ct_desc_e = open(uri).read.gsub("\n","").
		scan(/<h3 class=\"summary\">Database Description<\/h3>(.+?)<\/div>/).
		to_s.gsub(/<.+?>/,"")

  ct_e_openid = ct_m_openid = "http://openid.dbcls.jp/user/wakuteka"  

  ct_entry = ct_modified = "2009-09-30 13:15:15"
array.push({"ct_title_j" => ct_title_j, 
           "ct_title_e" => ct_title_e, 
           "ct_url" => ct_url,
           "ct_url_e" => ct_url_e, 
           "ct_desc_e" => ct_desc_e, 
           "ct_entry" => ct_entry, 
           "ct_modified" => ct_modified, 
           "ct_e_openid" => ct_e_openid,
           "ct_m_openid" => ct_m_openid })
rescue
  puts "fail"
end
}

puts array[0].keys.join(';')
array.each{|hash|
  puts hash.values.to_a.join(';')
}
