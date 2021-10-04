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
    
    def new_release_calendar
        prev_month = Date.today << 1
        this_month = Date.today
        two_month_calendar = prev_month.strftime("%Y/%m"), this_month.strftime("%Y/%m")
    end

    def coming_soon_calendar
        next_month = Date.today >> 1
        two_month = next_month >> 1
        two_month_calendar = next_month.strftime("%Y/%m"), two_month.strftime("%Y/%m")
    end
end

result = CategoryScraper.new.coming_soon_calendar
puts result