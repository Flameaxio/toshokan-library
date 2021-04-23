class AddPdfPathToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :pdf_path, :string
  end
end
