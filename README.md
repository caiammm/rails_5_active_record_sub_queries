# README

This is to show a possible issue in rails 5.2.
Please compare the queries bellow

```
rails c
```
puts Comment.where(article_id: [1,2]).latest_by_article.to_sql
```
```
SELECT "comments".*
FROM "comments"
WHERE "comments"."article_id" IN (1, 2) AND "comments"."id"
IN (
=> SELECT DISTINCT ON (article_id) article_id
=> FROM "comments"
=> WHERE "comments"."article_id" IN (1, 2)
=> ORDER BY article_id, article.created_at DESC
)
```
puts Comment.where(article_id: [1,2]).latest_by_article_with_unscoped.to_sql
```
```
SELECT "comments".*
FROM "comments"
WHERE "comments"."article_id" IN (1, 2) AND "comments"."id"
IN (
=> SELECT DISTINCT ON (article_id) article_id
=> FROM "comments"
=> ORDER BY article_id, article.created_at DESC
)

```
