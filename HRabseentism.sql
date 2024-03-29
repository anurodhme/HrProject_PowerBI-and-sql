select * from absent a
left join compensation b
on a.ID= b.ID
left join Reasons r on
a.Reason_for_absence= r.Number

--- find the healthiest

select * from absent
where Social_drinker = 0 and Social_smoker = 0 
and Body_mass_index<25 and 
Absenteeism_time_in_hours<(select AVG(Absenteeism_time_in_hours) from absent)

---compensation rate increase for non-smokers/.68 increase per hour
select count(*) as nonsmokers from absent
where Social_smoker=0

--optimize query
select 
a.ID,
r.Reason,
Month_of_absence,
Body_mass_index,
CASE WHEN Body_mass_index <18.5 then 'Underweight'
	 WHEN Body_mass_index between 18.5 and 25 then 'Healthy'
	 WHEN Body_mass_index between 25 and 30 then 'Overweight'
	 WHEN Body_mass_index >30 then 'Obese'
	 Else 'Unknown' end as BMI_Category,
		
CASE when Month_of_absence IN (12,1,2) Then 'Winter'
	 when Month_of_absence IN (3,4,5) Then 'Spring'
	 when Month_of_absence IN (6,7,8) Then 'Summer'
	 when Month_of_absence IN (9,10,11) Then 'Fall'
	 ELSE 'Unknown' End as Seasons,
Month_of_absence,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Pet,
Disciplinary_failure,
Age,
Work_load_Average_day,
Absenteeism_time_in_hours,
Social_smoker,
Social_drinker
from absent a
left join compensation b
on a.ID= b.ID
left join Reasons r on
a.Reason_for_absence= r.Number