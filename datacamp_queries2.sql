WITH bins AS (
	SELECT generate_series(2200, 3050, 50) lower,
	       generate_series(2250, 3100, 50) AS upper,
				 dropbox AS (
					 SELECT question_count
					 FROM stackoverflow
					 WHERE tag='dropbox')
SELECT lower, upper, count(question_count)
FROM bins
LEFT JOIN dropbox
ON question_count >= lower AND question_count < upper
GROUP BY lower, upper
ORDER BY lower;
