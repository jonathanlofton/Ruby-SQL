require_relative 'questions_database.rb'
require 'sqlite3'

class Question

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      id == ?

    SQL
    data = data[0]
    Question.new(data)
  end

  def self.find_by_author_id(auth_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, auth_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author = ?
    SQL

    questions = []

    data.each do |question|
      questions << Question.new(question)
    end

    questions
  end



  attr_accessor :title, :body, :author

  def initialize(options)
    @id = options['id']
    @title = options["title"]
    @body = options["body"]
    @author = options["author"]
  end

  def authored_questions
    self.find_by_author_id(@id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end


end
