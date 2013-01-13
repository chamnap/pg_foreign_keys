require 'spec_helper'

describe 'PgForeignKeys' do
  before(:each) do
    clean_database!
    @student_ids = [create(:student, name: 'chamnap'), create(:student, name: 'vorleak')].collect(&:id)
    @teacher_ids = [create(:teacher, name: 'darren'), create(:teacher, name: 'ben')].collect(&:id)
  end

  context '#students objects' do
    it 'should have students' do
      klass = Klass.new(student_ids: @student_ids, teacher_ids: @teacher_ids)

      klass.students.should eq(Student.find(@student_ids))
      klass.teachers.should eq(Teacher.find(@teacher_ids))
    end

    it 'should reload new associations' do
      klass = Klass.new(student_ids: @student_ids[0,1])
      klass.students.should eq([Student.find(@student_ids[0])])

      klass.student_ids = @student_ids
      klass.students.should eq(Student.find(@student_ids))
    end
  end

  context '#student_ids=' do
    it 'should not assign duplicate student_ids' do
      klass = Klass.new(student_ids: @student_ids.take(1)*2)

      klass.student_ids.should eq(@student_ids.take(1))
    end

    it 'should skip blank item' do
      klass = Klass.new(student_ids: @student_ids + [nil, ''])

      klass.student_ids.should eq(@student_ids)
    end

    it 'should fail validation if the student does not exist' do
      klass = Klass.new(student_ids: [@student_ids.first, -9999])

      klass.valid?
      klass.errors[:student_ids].length.should == 1
    end
  end

  context '#student_list' do
    it 'should assign student_list with array of student names' do
      record = Klass.new
      record.student_list = ['chamnap', 'vorleak']

      record.student_ids.should eq(@student_ids)
    end

    it 'should assign student_list with comma-separated student names' do
      record = Klass.new
      record.student_list = 'chamnap,vorleak'

      record.student_ids.should eq(@student_ids)
    end

    it 'should not assign duplicate student_ids' do
      record = Klass.new
      record.student_list = 'chamnap,vorleak,chamnap'

      record.student_ids.should eq(@student_ids)
    end

    it 'should ignore for student who does not exist' do
      record = Klass.new
      record.student_list = ['chamnap', 'no name']

      record.student_ids.should eq(@student_ids.take(1))
    end

    it '#student_list should return as comma-separated student names' do
      record = Klass.new(student_ids: @student_ids)

      record.student_list.should eq('chamnap,vorleak')
    end

    it '#student_lists should return as array of student names' do
      record = Klass.new(student_ids: @student_ids)

      record.student_lists.should eq(['chamnap', 'vorleak'])
    end
  end
end