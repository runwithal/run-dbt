with questions as (

select  json_array_elements(sd.pages::json)->'questions' qus from tap_surveymonkey.survey_details sd
),

answers as (
  select
  	json_array_elements(qus)->'answers' ans
  from questions
)


select
array_to_json(array[to_json(json_array_elements(ans->'choices')->'id'::TEXT)])->>0  as choice_id,
array_to_json(array[to_json(json_array_elements(ans->'choices')->'text'::TEXT)])->>0  as choice_text,
array_to_json(array[to_json(json_array_elements(ans->'choices')->'image'->'url'::TEXT)])->>0  as image_url
 from answers