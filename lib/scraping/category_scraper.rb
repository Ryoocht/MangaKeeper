class MangaKeeper::CategoryScraper
    CATEGORY_URL = "https://www.viz.com/read"

    def get_page(url)
        uri = URI.parse(url)
        Nokogiri::HTML(uri.open)
    end
end