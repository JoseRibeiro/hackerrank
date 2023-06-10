-- Type of Triangle
select case
           when (A = B and B = C)
               then 'Equilateral'
           else case
                    when (A + B <= C or A + C <= B or B + C <= A)
                        then 'Not A Triangle'
                    else case
                             when (A = B or B = C or A = C)
                                 then 'Isosceles'
                             else 'Scalene' end
               end
           end
from triangles;