select concat(coalesce(pn.given_name,''),' ',coalesce(pn.middle_name,''),' ',coalesce(pn.family_name,''))as 'Provider Name',  count(DISTINCT(obs_id)) as 'Obsevation Count'
from provider pr
  join person p on pr.person_id = p.person_id and pr.provider_id not in (select provider_id from provider where name in ('Lab Manager', 'Lab System','Billing System','superman'))
  join person_name pn on pn.person_id = p.person_id and pn.person_id NOT in(select person_id from person_name where given_name in('Unknown','automation','Super'))
  left join encounter_provider ep on ep.provider_id = pr.provider_id
  LEFT JOIN obs o on o.encounter_id = ep.encounter_id
                     and cast(o.obs_datetime as DATE) between '#startDate#' and '#endDate#'
GROUP BY  pr.provider_id  ;