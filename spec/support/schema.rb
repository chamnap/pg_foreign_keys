ActiveRecord::Schema.define do
  self.verbose = false

  create_table :klasses, :force => true do |t|
    t.string  :name
    t.integer :student_ids, array: true
    t.integer :teacher_ids, array: true
    t.timestamps
  end

  create_table :students, :force => true do |t|
    t.string :name
    t.timestamps
  end

  create_table :teachers, :force => true do |t|
    t.string :name
    t.timestamps
  end
end