/* PIVOT requires a agragate function, in this case, MAX(), but works with MIN() too. */
select d, p, s, a
from (select name, occupation, row_number() over (partition by occupation order by name) as rn
      from occupations)
    pivot
    (
    max(name) for occupation in ('Doctor' d, 'Professor' p, 'Singer' s, 'Actor' a)
    )
ORDER BY rn
;
