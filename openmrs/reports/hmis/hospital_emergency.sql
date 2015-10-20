select answer_concept_name.name as Name, count(distinct v.patient_id) as 'Count of Patients'
from visit v
  inner join patient pt on v.patient_id = pt.patient_id
        and v.voided = 0
        and v.uuid is not null
        and pt.voided = 0
  inner join person p on p.person_id = pt.patient_id
        and p.voided = 0
        and p.uuid is not null
  inner join obs o on o.person_id = p.person_id
        and cast(o.obs_datetime as DATE) between '#startDate#' and '#endDate#'
  inner join concept_name cn1 on o.concept_id=cn1.concept_id
        and cn1.name='Category'
        and cn1.concept_name_type='FULLY_SPECIFIED'
  left join concept_name cn2 on o.value_coded = cn2.concept_id
  right OUTER JOIN
    ( select concept_answer.answer_concept as answers
      from concept_answer
      inner join concept_name as question_concept_name on concept_answer.concept_id = question_concept_name.concept_id
            and question_concept_name.name = 'Category'
            and question_concept_name.concept_name_type = 'FULLY_SPECIFIED') as answer_list
  on value_coded = answer_list.answers
  inner join concept_name as answer_concept_name on answer_list.answers = answer_concept_name.concept_id
                                                    and answer_concept_name.concept_name_type = 'FULLY_SPECIFIED'
   group by answer_concept_name.name ;