class CreateEnquiries < ActiveRecord::Migration
  def self.up
    create_table :enquiries do |t|
      t.string :email
      t.string :phone
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :enquiries
  end
end
