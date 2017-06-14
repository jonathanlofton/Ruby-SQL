require_relative 'questions_database.rb'
require 'sqlite3'

class User

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id = ?
    SQL

    User.new(data[0])
  end

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        users.fname = ? AND
        users.lname = ?
    SQL

    User.new(data[0])
  end

  attr_accessor :fname, :lname

  def initialize(opt)
    @id = opt['id']
    @fname = opt['fname']
    @lname = opt['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end


end
