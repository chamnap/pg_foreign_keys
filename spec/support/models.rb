class Klass < ActiveRecord::Base
  pg_foreign_keys :student_ids, :teacher_ids
end

class Student < ActiveRecord::Base
end

class Teacher < ActiveRecord::Base
end