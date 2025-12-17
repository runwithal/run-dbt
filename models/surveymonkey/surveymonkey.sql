with questions as (
	select * from {{ ref('questions') }}
),

responses as (
	select * from {{ ref('responses_source') }}
),

survey_details as (
	select * from {{ ref('survey_details' ) }}
)

select 
	qu.heading,
	sd.choice_text,
	count(sd.choice_id)
from 
questions qu
join responses r on qu.question_id = r.question_id
join survey_details sd on sd.choice_id = r.choice_id
group by qu.heading, sd.choice_text
