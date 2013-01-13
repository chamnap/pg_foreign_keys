# PgForeignKeys

A simple gem that add supports on using Postgres ARRAY element as foreign keys. Check this for [more info](http://blog.2ndquadrant.com/postgresql-9-3-development-array-element-foreign-keys/).

## Installation

Rails 3.x

To use it, add it to your Gemfile:

    gem 'postgres_ext'
    gem 'pg_foreign_keys' 

And then execute:

    $ bundle

## Usage

    class Klass < ActiveRecord::Base
      pg_foreign_keys :students, :teachers
    end

    class Student < ActiveRecord::Base
    end

    class Teacher < ActiveRecord::Base
    end

    @klass = Klass.new(name: 'Algebra 101')
    @klass.student_list = "chamnap, vorleak, borey"
    @klass.teacher_list = "darren, ben"
    @klass.student_list # => ["chamnap", "vorleak", "borey"]
    @klass.teacher_list # => ["darren", "ben"]
    @klass.save

    @klass.students     # => [<Student name:"chamnap">,<Student name:"vorleak">,<Student name:"borey">]
    @klass.teachers     # => [<Teacher name:"darren">,<Teacher name:"ben">]

### Finding associated objects

`pg_foreign_keys` gem utilizes named_scopes to create an association for those foreign keys so that you can mix and match to filter down results and it works with
the [will_paginate](https://github.com/mislav/will_paginate) gem and the [kaminari](https://github.com/amatsuda/kaminari) gem.

    class Klass < ActiveRecord::Base
      pg_foreign_keys :students, :teachers
      scope :by_date, order("created_at DESC")
    end

    Klass.find_students("chamnap").by_date
    Klass.find_students("chamnap").by_date.paginate(:page => params[:page], :per_page => 20)

    # Find classes with matching all students, not just one
    Klass.find_students(["chamnap", "vorleak"], :match_all => true)

    # Find classes with any of the students:
    Klass.find_students(["chamnap", "vorleak"], :any => true)

    # Find classes that do not have 'chamnap' or 'vorleak':
    Klass.find_students(["chamnap", "vorleak"], :exclude => true)

    # Find classes with chaining
    Klass.find_students(['chamnap, vorleak'], :any => true).find_teachers(['darren', 'ben'], :any => true)

## Author

* [Chamnap Chhorn](https://github.com/chamnap)