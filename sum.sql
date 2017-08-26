SELECT
  CASE WHEN c5 like '%懇親会%' then '懇親会'
    WHEN c5 like "%ビデオ参加%" then "ビデオ参加"
    WHEN c5 = "【スーパー早割】一般" then "会場参加"
    WHEN c5 = "【早割】一般" then "会場参加"
    WHEN c5 = "【スーパー早割】学生" then "会場参加"
    ELSE c5
 END as type
 , SUM(c6) as n
FROM -
GROUP BY type
ORDER BY n DESC
-- SELECT c5, SUM(c6)
-- FROM -
-- GROUP BY c5
-- c5 チケットの種類
-- c6 チケットの枚数
