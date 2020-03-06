require 'rubygems'
require 'json'
require 'nokogiri'   
require 'open-uri'
#require "google_drive"


#array = []
#mairie = Hash.new

page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))   


get_townhall_email = page.css('a[class = "lientxt"]').map{|a| "http://annuaire-des-mairies.com/"+ a["href"].gsub("./","")}

array = Array.new
mairie = Hash.new



get_townhall_email.each {|x| 

    url = Nokogiri::HTML(open(x)) 
    email = url.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").map{|e| e.text}
    town = url.xpath("/html/body/div/main/section[1]/div/div/div/h1").map{|v| v.text.downcase.capitalize}

     mairie = Hash[town.zip(email)]
    array << mairie

}




File.open("email.json","w") do |f|
  f.write(array.to_json)
 
end

# session = GoogleDrive::Session.from_config("config.json")

#session.upload_from_file("/email.JSON/email.rb", "email.rb", convert: false)