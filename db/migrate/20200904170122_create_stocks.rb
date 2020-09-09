class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.string :name
      t.decimal :last_price
      t.decimal :current_price
      t.decimal :dividend_yield
      t.date :ex_dividend_date
      t.timestamps
    end
  end
end
