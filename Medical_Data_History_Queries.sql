show databases;

use project_medical_data_history;

select * from patients;

--  1. Show first name, last name, and gender of patients whose gender is 'M'.

SELECT 
	first_name, 
    last_name, gender
FROM 
	patients
WHERE 
	gender = 'M';

-- 2. Show first name and last name of patients who do not have allergies.

SELECT
	first_name,
    last_name
FROM
	patients
WHERE 
	allergies is NULL;

--  3. Show first name of patients that start with the letter 'C'.

SELECT  
	first_name     --  count(first_name) :- to count the total 
FROM
	patients
WHERE
	first_name LIKE 'C%';

--  4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive).

SELECT 
	first_name, 
    last_name,
    weight
FROM
	patients 
WHERE
	weight BETWEEN 100 AND 120;

--  5.Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'.

UPDATE 
	patients
SET 
	allergies = 'NKA'
WHERE
	allergies IS NULL;

SELECT allergies FROM patients;

-- 6. Show first name and last name concatenated into one column to show their full name.


SELECT
	CONCAT(first_name, ' ', last_name) AS full_name
FROM 
	patients;


--  7. Show first name, last name, and the full province name of each patient.

select
	p.first_name,
    p.last_name,
    pn.province_name
FROM 
	patients p
join
	province_names pn
on 
	p.province_id = pn.province_id;


--  8. Show how many patients have a birth_date with 2010 as the birth year.

select 
	count(*) AS patients_dob_2010
FROM 
	patients                                          /* COUNT QUERY*/
WHERE 
	YEAR(birth_date) = 2010;

SELECT
	first_name,
    last_name                         /* TO KNOW THE NAMES OF THE PATIENTS*/ 
FROM 
	patients
WHERE 
	YEAR(birth_date) = 2010;

--  9. Show the first_name, last_name, and height of the patient with the greatest height.

SELECT
	first_name,
    last_name, height
FROM
	patients
ORDER BY 
	height DESC
LIMIT 1;

--  10.  Show all columns for patients who have one of the following patient_ids: 1 ,45, 534, 879, 1000  .

SELECT *
FROM patients 
where patient_id IN (1,45,534,879,1000);

--  11. Show the total number of admissions.
SELECT COUNT(*) AS total_admissions
FROM admissions;

-- 12. Show all the columns from admissions where the patient was admitted and discharged on the same day.
select * 
from admissions
where admission_date = discharge_date; 

-- 13. Show the total number of admissions for patient_id 579. 
select count(*) as total_number_of_admissions_by_patient
from admissions
where patient_id = 579;

select *
from admissions
where patient_id = 579;

-- 14.  Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
SELECT DISTINCT city
FROM patients
WHERE province_id = 'NS';

-- 15.  Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70.

select first_name,last_name,birth_date
from patients
where height > 160 AND weight >70;

-- 16. Show unique birth years from patients and order them by ascending.

select distinct Year(birth_date) as birth_year
FROM patients
order by birth_year ASC;

-- 17. Show unique first names from the patients table which only occurs once in the list.
select distinct first_name
from patients
group by first_name
HAVING COUNT(*) = 1 ;

-- 18.Show patient_id and first_name from patients where their first_name starts and ends with 's' and is at least 6 characters long.

SELECT patient_id, first_name
FROM patients
WHERE first_name LIKE 's%S' AND LENGTH(first_name) >= 6;

-- 19. Show patient_id, first_name, last_name from patients whose diagnosis is 'Dementia'. Primary diagnosis is stored in the admissions table.
SELECT p.patient_id, p.first_name, p.last_name,diagnosis
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
WHERE diagnosis = 'Dementia'
LIMIT 0, 1000;

-- 20. Display every patient's first_name. Order the list by the length of each name and then by alphabetically.

SELECT distinct  first_name				-- without Duplicates-- 
FROM patients  
ORDER BY LENGTH(first_name), first_name;

SELECT first_name						-- with Duplicates-- 
FROM patients  
ORDER BY LENGTH(first_name), first_name;

-- 21. Show the total number of male patients and the total number of female patients in the patients table. Display the two results in the same row.

select * from patients;

SELECT 'Male' AS gender,count(*) AS total_count
FROM patients where gender = 'M'
UNION 
SELECT 'Female' AS gender,count(*) AS total_count
FROM patients where gender = 'F';

-- 22. Show the total number of male patients and the total number of female patients in the patients table. Display the two results in the same row.

SELECT 'Male' AS gender,count(*) AS total_count
FROM patients where gender = 'M'
UNION  ALL
SELECT 'Female' AS gender,count(*) AS total_count
FROM patients where gender = 'F';


-- 23. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1
ORDER BY patient_id, diagnosis;


-- or ---
SELECT patient_id, diagnosis ,COUNT(*) AS admission_count
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1
ORDER BY patient_id, diagnosis;

-- 24.  Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.

SELECT city, COUNT(patient_id) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC, city ASC;


-- 25.  Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor".

select * from doctors;

select first_name,last_name,specialty
 from doctors;
			
				-- OR --------
 
  select first_name,last_name,diagnosis
 from patients p
 inner join admissions a 
 on p.patient_id = a.patient_id;
-- where allergies is not null ;
 
 
 -- 26.   Sow all allergies ordered by popularity. Remove NULL values from the query.
 SELECT allergies,count(allergies) as total_count
 FROM patients 
 where allergies is not null 
 group by allergies 
 order by total_count desc;
 
 -- 27.    Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
 
 select * from patients;
 
 select first_name,last_name,birth_date
 from patients 
 where extract(year from birth_date ) 
 between 1970 and 1980
 order by birth_date asc;
 
 
 
 -- 28. 
--  We want to display each patient's full name in a single column. Their
--  last_name in all upper letters must appear first, then first_name in all lower
-- case letters. Separate the last_name and first_name with a comma. Order the
-- list by the first_name in descending order EX: SMITH,jane.

select first_name,last_name,CONCAT(upper(last_name),' ,',lower(first_name) )AS full_name
from patients
order by first_name desc;


-- 29. Show the province_id(s), sum of height; where the total sum of its patient's  height is greater than or equal to 7,000
select *
from province_names;
 
select 
		province_id ,
        sum(height) as sum_of_height
from 
		patients
group by
		province_id
having 
		sum(height) >= 7000;


-- 30. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select last_name,max(weight) - min(weight) as weight_difference
from patients
WHERE last_name = 'Maroni';


-- 31. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.\\

SELECT DAY(admission_date) AS day_of_month, COUNT(*) AS admission_count
FROM admissions
GROUP BY DAY(admission_date)
ORDER BY admission_count DESC;

select * from admissions;

-- 32.   Show all of the patients grouped into weight groups. Show the total
-- 		number of patients in each weight group. Order the list by the weight group
-- 		descending. e.g. if they weigh 100 to 109 they are placed in the 100 weight
-- 		group, 110-119 = 110 weight group, etc.

SELECT first_name,weight,
    CASE
        WHEN weight BETWEEN 100 AND 109 THEN '100'
        WHEN weight BETWEEN 110 AND 119 THEN '110'
        WHEN weight BETWEEN 120 AND 129 THEN '120'
        WHEN weight BETWEEN 130 AND 139 THEN '130'
        WHEN weight BETWEEN 140 AND 149 THEN '140'
        ELSE 'Other'
    END AS weight_group,
    COUNT(*) AS total_patients
FROM 
    patients
 GROUP BY  weight,first_name,last_name
 ORDER BY 
    min(weight) DESC; 



SELECT 
	'Male' AS gender,
	 COUNT(*) AS total_count
FROM 
	patients 
WHERE
	 gender = 'M' UNION 
SELECT 
	'Female' AS gender, 
	COUNT(*) AS total_count
FROM 
	patients 
WHERE 
	 gender = 'F';








-- 33. Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m). Weight is in units kg. Height is in units cm

SELECT patient_id,weight,height,weight / ((height / 100.0) * (height / 100.0)) AS BMI,
CASE 
WHEN weight / ((height / 100.0) * (height / 100.0)) >= 30 THEN 1
else 0
end as isobese
FROM patients;



-- 34 . Show patient_id, first_name, last_name, and attending doctor's specialty.
 --     Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first
 --     name is 'Lisa'. Check patients, admissions, and doctors tables for required
--      information.

SELECT                                               
    p.patient_id,
    p.first_name,
    p.last_name,
    d.specialty
--    d. first_name,										-- if we need doctor 1st name and Diagnosis add d.first_name and a.diagonisis  in SELECT COMMAND
--    a.diagnosis
FROM 
    patients p
JOIN 
    admissions a ON p.patient_id = a.patient_id
JOIN 
    doctors d ON a.attending_doctor_id = d.doctor_id
WHERE 
    a.diagnosis = 'Epilepsy'
    AND d.first_name = 'Lisa';


-- 35.  All patients who have gone through admissions, can see their medical
-- 		documents on our site. Those patients are given a temporary password after
-- 		their first admission. Show the patient_id and temp_password.
-- 		The password must be the following, in order:- 
-- 			patient_id
-- 			the numerical length of patient's last_name
-- 			year of patient's birth_date

select * from admissions;

SELECT 
    p.patient_id,p.last_name,
    CONCAT(p.patient_id,LENGTH(p.last_name),EXTRACT(YEAR FROM p.birth_date)) AS temp_password
FROM 
    patients p
JOIN 
    admissions a ON p.patient_id = a.patient_id
GROUP BY 
    p.patient_id, p.last_name, p.birth_date;

