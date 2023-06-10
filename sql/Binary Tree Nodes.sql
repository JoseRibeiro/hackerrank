/* Other way is to use connect by. */
select distinct b2.n,
                DECODE(b2.p, null, 'Root', DECODE(b1.n, null, 'Leaf', 'Inner'))
from bst b1
         right join bst b2 on b1.p = b2.n
         left join bst b3 on b2.p = b3.n
order by b2.n
;