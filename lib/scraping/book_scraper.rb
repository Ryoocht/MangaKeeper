class MangaKeeper::BookScraper
    SEARCH_URL = "https://www.viz.com/read/read/section/70220/more"
    SERIES_URL = "https://www.viz.com"

    def get_page(url)
        uri = URI.parse(url)
        Nokogiri::HTML(uri.open)
    end

    #Manga List
    def create_manga_list
        doc = get_page(SEARCH_URL)
        manga_list = doc.css("div.pad-x-rg.pad-y-md.type-sm.type-rg--sm.type-md--lg.type-center.line-tight").map.with_index(1) do |title, i|
            manga_title = title.text.strip
            {id: i, manga_title: manga_title}
        end
        make_manga_list(manga_list)
    end

    def make_manga_list(manga_list)
        manga_list.map{|manga| MangaKeeper::List.new(manga)}
    end

    #Manga Series (1st level)
    def get_all_manga(manga_title)
        doc = get_page("#{SERIES_URL}/#{manga_title}")
        series_details = doc.css("#series-intro").map do |detail|
            print "="
            title = detail.css("h2#page_title").text.strip
            subtitle = detail.css("p.type-md").text.strip
            author = detail.css("span.disp-bl--bm").text.gsub("Created by", "").strip
            {title: title, subtitle: subtitle, author: author}
        end
        url = doc.css("div.section_see_all a").attribute("href").value.strip
        book_details = get_all_manga_details(url)
        make_manga(series_details[0], book_details)
    end

    #Manga Book Details (2nd level)
    def get_all_manga_details(url)
        book_details = get_document_with_url(url).css("div.shelf article").map do |detail|
            book_title = detail.css("h4 a").text.strip
            likes = detail.css("figure a span").children.text.strip.gsub("+", "♥ ")
            book_url = detail.css("a.product-thumb").attribute("href").value.strip
            book_content = get_each_manga(book_url)
            {book_title: book_title, likes: likes, book_content: book_content}
        end
    end

    #Each Manga Book Detail (3rd level)
    def get_each_manga(url)
        details = get_document_with_url(url).css("div#product_row").map do |detail|
            release_day = detail.css("div.o_release-date").text.gsub("Release", "").strip
            price = detail.css("table.purchase-table span").text.gsub("*", "").strip
            {release_day: release_day, price: price}
        end
    end

    def get_document_with_url(url)
        manga_url = url.include?(SERIES_URL)? url : "#{SERIES_URL}#{url}"
        doc = get_page(manga_url)
    end

    def make_manga(series, books)
        MangaKeeper::Series.new(**series)
        books.map {|book| MangaKeeper::Manga.new(**book)}
    end
end