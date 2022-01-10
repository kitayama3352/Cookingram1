class AddBodyToInquiries < ActiveRecord::Migration[5.2]
  def change
    add_column :inquiries, :body, :text
  end
end
