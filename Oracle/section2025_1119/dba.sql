SELECT *
FROM v$reserved_words
WHERE reserved = 'Y';

SELECT *
FROM v$sql;