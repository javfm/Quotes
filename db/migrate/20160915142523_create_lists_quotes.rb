class CreateListsQuotes < ActiveRecord::Migration[5.0]
  def change
    create_table :lists_quotes, id: false do |t|
      t.integer :quote_id, index: true
      t.integer :list_id, index: true
    end
  end
end
