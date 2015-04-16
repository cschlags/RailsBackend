class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.text :batches , default: nil
    end
  end
end
