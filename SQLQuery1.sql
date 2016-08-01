select * 
from Tickets 
where OwnerID in (select follow from FollowTables where who = '332ac4c9-d37e-48fe-9075-a5e474877456')
or OwnerID = '332ac4c9-d37e-48fe-9075-a5e474877456';