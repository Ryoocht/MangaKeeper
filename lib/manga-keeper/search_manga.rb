require_relative './scraper.rb'

class SearchManga
    def show_all_result
        result =  Scraper.new.create_manga_list
        puts result
    end

    def search_by_freewords(search_word)
        
    end

    def search_by_alphabet(index_num)
        
    end

    def search_by_category(category)
        
    end
end