class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.string :folder
      t.string :batch_number
      t.string :url
    end
  end
end
