require_relative 'questions_database.rb'
require 'sqlite3'

class Questionfollow
  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?
    SQL

    Questionfollow.new(data[0])
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        fname, lname
      FROM
        users
      JOIN
        question_follows ON follower_id = users.id
      JOIN
        questions ON question_id = questions.id
      WHERE
        questions.id = ?
    SQL

    followers
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_follows
      JOIN
        questions ON question_id = questions.id
      WHERE
        follower_id = ?
    SQL

    questions
  end

  def initialize(opt)
    @id = opt["id"]
    @question_id = opt["question_id"]
    @follower_id = opt["follower_id"]
  end


end
