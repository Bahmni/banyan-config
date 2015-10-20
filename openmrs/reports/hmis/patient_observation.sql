select pt.identifier as Patient_ID,concat(coalesce(pn.given_name,''),' ',coalesce(pn.middle_name,''),' ',coalesce(pn.family_name,'')) as Name,
count(DISTINCT obs_id) as 'Observation Count'
from patient_identifier pt
  inner JOIN
  person_name pn on pn.person_id=pt.patient_id
  inner join
  visit v on v.patient_id=pt.patient_id
             and (( cast(v.date_started as DATE) between '#startDate#' and '#endDate#')
                  or  ((cast(v.date_stopped as DATE) between  '#startDate#' and DATE(now())  or v.date_stopped is null) AND cast(v.date_started as DATE) < '#startDate#')
             )
  left  JOIN
  obs o on o.person_id=pt.patient_id and cast(o.obs_datetime as DATE) between '#startDate#' and '#endDate#'
group by pt.identifier;




