# class MangaKeeper::CategoryScraper
require 'open-uri'
require 'nokogiri'
require 'date'
class CategoryScraper
    CATEGORY_URL = "https://www.viz.com/read"
    SERIES_URL = "https://www.viz.com"  

    def get_page(url)
        uri = URI.parse(url)
        Nokogiri::HTML(uri.open)
    end

    def release_calendar
        addition = 0
        this_month = Date.today << 1
        five_month_calendar = []
        
        5.times {
            five_month_calendar << (this_month >> addition).strftime("%Y/%m")
            addition += 1
        }
        five_month_calendar
    end
end

result = CategoryScraper.new.release_calendar
puts result