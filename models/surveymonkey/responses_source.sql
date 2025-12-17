with foo as (
  select
  id as response_id,
  json_array_elements(r.pages::json)->'questions' bar
 from tap_surveymonkey.responses r
),

buzz as (select
response_id,
array_to_json(array[to_json(json_array_elements(bar)->'id'::TEXT)])->>0 as question_id,
 json_array_elements(bar)->'answers' as choice from foo)

 select
 response_id,
 question_id,
 array_to_json(array[to_json(json_array_elements(choice)->'choice_id'::TEXT)])->>0 as choice_id
 from buzz