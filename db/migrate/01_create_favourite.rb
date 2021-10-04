class CreateFavourite < ActiveRecord::Migration[4.2]
    def change
        create_table :favourite do |t|
            t.string :book_title
        end
    end
end