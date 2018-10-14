#between 1 & 293

require 'nokogiri'
require 'open-uri'
require 'pry'
require 'csv'


links = [
            {
                url: "",
                pages: 1,
                filename: ""
            },
        ]

def scrape(search_url, pages, filename)
    current_page = 0
    big_array = []

    while current_page <= pages - 1

        html = open("#{search_url}&page=#{current_page}")
        doc = Nokogiri::HTML(html)

        column_count = 0
        columns = doc.css("div.content-region").css("div.column").length
        while column_count < columns
            company = doc.css("div.content-region").css("div.column")[column_count].css("span.field-title").text
            product = doc.css("div.content-region").css("div.column")[column_count].css("div.products").css("span").children.children.text
            url = doc.css("div.content-region").css("div.column a")[column_count].values[0]
            column_count += 1
            big_array << [company, "Cause Type", "cause", "cause", "+/-", "Justification Name", "urldomain#{url}",product]
            puts company
        end
        current_page += 1
    end


    CSV.open("#{filename}.csv", "w") do |csv|
        big_array.each do |justification|
            csv << justification
        end        
    end

end

links.each do |link|
    scrape(link[:url], link[:pages], link[:filename])
end