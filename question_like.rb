require_relative 'questions_database.rb'
require 'sqlite3'

class QuestionLike
  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL

    QuestionLike.new(data[0])
  end

  attr_accessor :user_id, :liked_question_id

  def initialize(opt)
    @user_id = opt['user_id']
    @liked_question_id = opt['liked_question_id']
  end
end
