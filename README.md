# README

This is to show a possible issue in rails 5.2.
Please compare the queries bellow

```
rails c

puts Comment.where(article_id: [1,2]).latest_by_article.to_sql

puts Comment.where(article_id: [1,2]).latest_by_article_with_unscoped.to_sql
```
