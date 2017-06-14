require_relative 'questions_database.rb'
require 'sqlite3'

class Reply

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    replies = []

    data.each do |reply|
      replies << Reply.new(reply)
    end

    replies
  end

  def self.find_by_question_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    replies = []

    data.each do |reply|
      replies << Reply.new(reply)
    end

    replies
  end

  def self.find_by_user_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    replies = []

    data.each do |reply|
      replies << Reply.new(reply)
    end

    replies
  end

  def initialize(opt)
    @id = opt["id"]
    @body = opt["body"]
    @question_id = opt["question_id"]
    @parent_id = opt["parent_id"]
    @author_id = opt["author_id"]
  end

  def author
    data = QuestionsDatabase.instance.execute(<<-SQL, @author_id)
        SELECT
          fname, lname
        FROM
          users
        WHERE
          id = ?
      SQL

    "#{data[0]["fname"]} #{data[0]["lname"]}"
  end

  def question
    question = QuestionsDatabase.instance.execute(<<-SQL, @question_id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

    question[0]
  end

  def parent_reply
    reply = QuestionsDatabase.instance.execute(<<-SQL, @parent_id)
      SELECT * FROM replies WHERE id = ?
    SQL

    reply[0]
  end

  def child_replies
    replies = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT * FROM replies WHERE parent_id = ?
    SQL

    replies
  end
end
