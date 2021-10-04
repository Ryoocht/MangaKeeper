class MangaKeeper::BookScraper
    SEARCH_URL = "https://www.viz.com/read/read/section/70220/more"
    SERIES_URL = "https://www.viz.com"
    CATEGORY_URL = "https://www.viz.com/read"
    CALENDAR_URL = "https://www.viz.com/calendar/"

    def get_page(url)
        sleep 2 
        uri = URI.parse(url)
        Nokogiri::HTML(uri.open)
    end

    #Manga and Genre List
    def create_manga_and_genre_list
        search_doc = get_page(SEARCH_URL)
        manga_list = search_doc.css("div.p-cs-tile").map do |title|
            manga_title = title.css("div.pad-x-rg").text.strip
            {manga_title: manga_title}
        end

        category_doc = get_page(CATEGORY_URL)
        genre_list = category_doc.css("a.g-3.g-4--md").map do |genre|
            genre_url = genre.attribute("href").value.strip
            genre_title = genre.css("h4").text.strip
            {genre_title: genre_title}
        end

        make_manga_list(manga_list)
        make_genre_list(genre_list)
    end

    def make_manga_list(manga_list)
        manga_list.map{|manga| MangaKeeper::List.new(manga)}
    end

    def make_genre_list(genre_list)
        genre_list.map{|genre| MangaKeeper::Genre.new(genre)}
    end

    #Manga Series (1st level)
    def get_all_manga_details(manga_title)
        doc = get_page("#{SERIES_URL}/#{manga_title}")
        series_details = doc.css("section.row.mar-y-lg.mar-b-xxl--md").map do |detail|
            title = detail.css("h2.type-lg.type-xl--md").text.strip
            subtitle = detail.css("p.type-md.type-lg--md.type-xl--lg").text.strip
            author = detail.css("span.disp-bl--bm.mar-b-md").text.gsub("Created by", "").strip
            {title: title, subtitle: subtitle, author: author}
        end
        if doc.css("div.section_see_all a").attribute("href") != nil
            url = doc.css("div.section_see_all a").attribute("href").value.strip
            book_details = get_manga_books(url)
            make_manga(series_details[0], book_details)
        else
            urls = doc.css("a.product-thumb.ar-inner.type-center").map do |url|
                url.attribute("href").value.strip
            end
            book_details = urls.map{|url| get_each_manga(url)}
            make_manga(series_details[0], book_details)
        end
    end

    #Manga Book Details (2nd level)
    def get_manga_books(url)
        book_details = get_document_with_url(url).css("a.product-thumb.ar-inner.type-center").map do |detail|
            book_url = detail.attribute("href").value.strip
            get_each_manga(book_url)
        end
    end

    #Each Manga Book Detail (3rd level)
    def get_each_manga(url)
        manga_data = {}
        manga_detail = get_document_with_url(url).css("div.g-8--md.g-6--lg.g-omega--md.g-omega--lg.mar-b-xl").map do |detail|
            book_title = detail.css("h2.type-lg").text.strip.gsub(",", "")
            likes = detail.css("span.o_votes-up").text.strip.gsub("+", "♥ ")
            price = detail.css("td span.type-md.type-lg--md.type-xl--lg.line-solid.weight-bold").text.gsub("*", "").strip
            manga_data = {book_title: book_title, likes: likes, price: price}
        end
        release_day = get_document_with_url(url).css("div.o_release-date.mar-b-md").text.gsub("Release", "").strip
        manga_data[:release_day] = release_day
        manga_data
    end

    def get_document_with_url(url)
        manga_url = url.include?(SERIES_URL)? url : "#{SERIES_URL}#{url}"
        doc = get_page(manga_url)
    end

    def make_manga(series, books)
        MangaKeeper::Series.new(**series)
        books.map {|book| MangaKeeper::Manga.new(**book)}
    end
    
    #Get each genre
    def get_categorised_manga(genre_url)
        doc = get_page("https://www.viz.com/read/#{genre_url}/section/12472/more")
        genre_details = doc.css("div.p-cs-tile").map do |title|
            manga_title = title.css("div.pad-x-rg").text.strip
            {manga_title: manga_title}
        end
        
        if genre_details == []
            genre_details = doc.css("div.clearfix.mar-t-md.mar-b-lg").map do |title|
                manga_title = title.css("h3").text.strip
                {manga_title: manga_title}
            end
        end
        make_genre_manga_list(genre_details)
    end

    #Instantiate GenreManga class
    def make_genre_manga_list(genre_details)
        genre_details.map{|manga| MangaKeeper::GenreManga.new(**manga)}
    end

    def create_release_list(calendar)
        release_list = calendar.map do |date| 
            calendar_doc = get_page("#{CALENDAR_URL}#{date}")
            calendar_details = calendar_doc.css("article.g-3.g-3--md.mar-b-lg.bg-white.color-off-black.type-sm.type-rg--lg").map do |manga|
                book_url = manga.css("a.product-thumb.ar-inner.type-center").attribute("href")
                book_content = get_each_manga(book_url)
                MangaKeeper::Manga.new(**book_content)
            end
        end
    end

    #Split released manga and coming manga by date
    def self.new_release_calendar
        prev_month = Date.today << 1
        this_month = Date.today
        two_month_calendar = prev_month.strftime("%Y/%m"), this_month.strftime("%Y/%m")
    end

    def self.coming_soon_calendar
        next_month = Date.today >> 1
        two_month = next_month >> 1
        two_month_calendar = next_month.strftime("%Y/%m"), two_month.strftime("%Y/%m")
    end
end