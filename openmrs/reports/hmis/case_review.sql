select pt.identifier as 'Patient ID',count(DISTINCT o.obs_id)As Count_Case_Reviews
from
  patient p
  inner JOIN
  visit v on v.patient_id=p.patient_id
             and (
                   ( cast(v.date_started as date) between '#startDate#' and '#endDate#')
                     or  (cast(v.date_stopped as date) between '#startDate#' and DATE(now())  or v.date_stopped is null
                     AND (cast(v.date_started as date) < '#startDate#'))
                    )
  left JOIN
patient_identifier pt on pt.patient_id=v.patient_id
 left  JOIN obs o on o.person_id=pt.patient_id and cast(o.obs_datetime as DATE) between '#startDate#'and '#endDate#'
left JOIN
  concept_name cn on o.concept_id=cn.concept_id
                     and cn.name='Case Manager Review' and cn.concept_name_type = 'FULLY_SPECIFIED'

GROUP BY v.patient_id order by Count_Case_Reviews desc;