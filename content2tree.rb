# category.rb
#tr_id,tr_pid,tr_order,tc_id,tr_name_j,tr_name_e,tr_delcause,tr_entry,tr_modified,tr_e_openid,tr_m_openid,tr_abbr_j,tr_abbr_e,tr_order_j,tr_order_e
#
require 'rubygems'
require 'nokogiri'
require 'open-uri'
  array = []


1.upto(2) { |i|

uri = "http://oxfordjournals.org/nar/database/summary/#{i}"
begin
  html = open(uri)
  doc = Nokogiri::HTML(html)
  ct_id = tr_id = ct_entry = ct_modified = ct_e_openid = ct_m_openid = ""

	# ct_idはNARidに+10000とかにするか
  ct_name_j = doc.search('div.subcategory a').shift.content
if ct_name_j == nil then
  ct_name_j = doc.search('div.category a').shift.content
end

  ct_e_openid = ct_m_openid = "http://openid.dbcls.jp/user/wakuteka"  

  ct_entry = ct_modified = "2009-09-24 15:15:15"
array.push({"ct_id" => ct_id,
           "ct_id" => ct_id,
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
