SELECT *
FROM v$reserved_words
WHERE reserved = 'Y';

ALTER SYSTEM FLUSH SHARED_POOL;

SELECT *
FROM v$sql
WHERE sql_text like