class AddLanguageToChallenge < ActiveRecord::Migration[7.2]
  def change
    add_column :challenges, :language, :string
  end
end
