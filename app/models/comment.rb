class Comment < ApplicationRecord
  belongs_to :article

  scope :latest_by_article, -> {
    where(id: Comment.select("DISTINCT ON (article_id) id").
    order("article_id, comments.created_at DESC"))
  }

  scope :latest_by_article_with_unscoped, -> {
    where(id: Comment.unscoped.select("DISTINCT ON (article_id) id").
    order("article_id, comments.created_at DESC"))
  }

  # correct SQL from both scopes should be:
  # SELECT "comments".*
  # FROM "comments"
  # WHERE "comments"."id"
  # IN (
  #   SELECT DISTINCT ON (article_id) id
  #   FROM "comments"
  #   ORDER BY article_id, comments.created_at DESC
  # )
end

# puts Comment.where(article_id: [1,2]).latest_by_article.to_sql
# SELECT "comments".*
# FROM "comments"
# WHERE "comments"."article_id" IN (1, 2)
# AND "comments"."id" IN (
#   SELECT DISTINCT ON (article_id) id
#   FROM "comments"
#   WHERE "comments"."article_id" IN (1, 2)
#   ORDER BY article_id, comments.created_at DESC
# )

# puts Comment.where(article_id: [1,2]).latest_by_article_with_unscoped.to_sql
# SELECT "comments".*
# FROM "comments"
# WHERE "comments"."article_id" IN (1, 2)
# AND "comments"."id" IN (
#   SELECT DISTINCT ON (article_id) id
#   FROM "comments"
#   ORDER BY article_id, comments.created_at DESC
# )
