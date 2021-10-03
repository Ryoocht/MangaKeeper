class MangaKeeper::BookScraper
    SEARCH_URL = "https://www.viz.com/read/read/section/70220/more"
    SERIES_URL = "https://www.viz.com"
    CATEGORY_URL = "https://www.viz.com/read"
    CALENDAR_URL = "https://www.viz.com/calendar/"

    def get_page(url)
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
            {book_title: book_title, likes: likes, book_content: book_content[0]}
        end
    end

    #Each Manga Book Detail (3rd level)
    def get_each_manga(url)
        details = get_document_with_url(url).css("div.bg-off-white").map do |detail|
            release_day = detail.css("div.o_release-date.mar-b-md").text.gsub("Release", "").strip
            price = detail.css("span.type-md.type-lg--md.type-xl--lg.line-solid.weight-bold").text.gsub("*", "").strip
            sleep 0.3
            {release_day: release_day, price: price}
        end
        puts details
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

    def create_release_list
        release_list = release_calendar.map do |date| 
            calendar_doc = get_page("#{CALENDAR_URL}#{date}")
            calendar_details = calendar_doc.css("article.g-3.g-3--md.mar-b-lg.bg-white.color-off-black.type-sm.type-rg--lg").map do |manga|
                book_title = manga.css("h4 a.color-off-black").text.strip
                likes = manga.css("span.o_votes-up.disp-ib.color-mid-gray.mar-l-sm.v-mid.type-sm").text.strip
                book_url = manga.css("a.product-thumb.ar-inner.type-center").attribute("href")
                book_content = get_each_manga(book_url)
                {book_title: book_title, likes: likes, book_content: book_content}
                puts book_content
            end
        end
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