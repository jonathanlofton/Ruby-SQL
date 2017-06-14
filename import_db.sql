DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT,
  body TEXT NOT NULL,
  author INTEGER,

  FOREIGN KEY (author) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  follower_id INTEGER,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(follower_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  author_id INTEGER NOT NULL,

  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(parent_id) REFERENCES replies(id),
  FOREIGN KEY(author_id) REFERENCES users(id)

);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  user_id INTEGER NOT NULL,
  liked_question_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(liked_question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Keith', 'Wong'),
  ('Jonathan', 'Lofton'),
  ('Zachary', 'Gr8HAUS'),
  ('Malik', 'Hamburrrger'),
  ('LOL', 'Likealots'),
  ('Shabang', 'Likes');

INSERT INTO
  questions (title, body, author)
VALUES
  ('Q1', 'What does the fox say?', '2'),
  ('Q2', 'What is a cherry tree?', '2');

INSERT INTO
  question_follows (question_id, follower_id)
VALUES
  (1, 1),
  (2, 1);

INSERT INTO
  replies (body, question_id, parent_id, author_id)
VALUES
  ('Nerd.', 1, NULL, 1),
  ('No, you', 1, 1, 2),
  ('Screw you', 1, 1, 1);
  --
  -- CREATE TABLE question_follows (
  --   id INTEGER PRIMARY KEY,
  --   question_id INTEGER NOT NULL,
  --   follower_id INTEGER,
  --
  --   FOREIGN KEY(question_id) REFERENCES questions(id),
  --   FOREIGN KEY(follower_id) REFERENCES users(id)
  -- );
INSERT INTO
  question_follows(question_id, follower_id)
VALUES
  (2, 2),
  (2, 4),
  (1, 3);
