/* Manhattan distance of two points. Not Euclidean, WGS84, sphere or eliptical. */
select round(max(lat_n) - min(lat_n) + max(long_w) - min(long_w), 4)
from station;
