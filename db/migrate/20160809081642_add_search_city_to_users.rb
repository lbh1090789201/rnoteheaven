class AddSearchCityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :search_city, :string # 搜索城市
  end
end
