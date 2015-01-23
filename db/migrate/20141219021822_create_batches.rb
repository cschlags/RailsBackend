class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.text :folder , default: nil
    end
  end
end
