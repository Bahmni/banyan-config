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
   JOIN
  concept_name cn on
                   cn.name='Case Manager Review' and cn.concept_name_type = 'FULLY_SPECIFIED'
  left  JOIN obs o on o.person_id=pt.patient_id and cast(o.obs_datetime as DATE) between '#startDate#'and '#endDate#' and o.concept_id=cn.concept_id and o.voided=FALSE 

GROUP BY v.patient_id ORDER BY Count_Case_Reviews DESC;