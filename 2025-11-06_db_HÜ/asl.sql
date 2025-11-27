select
question
from 
Question
where
question like 'Who %';

select
avg(opentdb_id)
from
Category
Where
name Like 'E%';

select
sum(finished_at)
from
_prisma_migrations
where 
started_at
like
'%6';

select
B
from
_IncorrectAnswers
where
B like 'cmfvala%';

select
answer
from
answer
where
answer like 'Ch%';