with questions as (

select
	json_array_elements(sd.pages::json)->'questions' qus from tap_surveymonkey.survey_details sd
),

qus as(
	select
		array_to_json(array[to_json(json_array_elements(qus)->'id'::TEXT)])->>0 question_id,
		json_array_elements(qus)->'headings' headings
	from questions
)

select
	question_id,
	array_to_json(array[to_json(json_array_elements(headings)->'heading'::TEXT)])->>0  as heading
from qus