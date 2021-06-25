# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


def rand_word(length=(5..10))
  ('a'..'z').to_a.sample(rand(length)).join
end

def rand_title
  title = ''
  rand(3..5).times do
    title += rand_word(5..15).capitalize + ' '
  end
  title
end

def rand_sentence
  sentence = rand_word.capitalize
  rand(3..15).times do
    sentence += rand_word + ' '
  end
  sentence.rstrip!
  sentence += "."
end

def rand_body
  body = ''
  rand(15..36).times do
    body += rand_sentence + ' '
  end
  body
end

def rand_status
  ['public', 'private', 'archived'].sample
end

def rand_article
  Article.create(title: rand_title, body: rand_body, status: rand_status)
end

def rand_comment(article)
  article.comments.create(commenter: rand_word.capitalize, body: rand_body, status: rand_status)
end

def create_articles_with_comments(amount)
  amount.times do
    article = rand_article
    puts article.id
    rand(10..100).times do
      rand_comment(article)
    end
  end
end

create_articles_with_comments 100

