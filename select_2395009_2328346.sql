set search_path to BookingSystem;

-- Find all the canceled appointments
select date,
       start_time,
       end_time,
       status,
       appointment.p_type as appointment_type,
       mi.name          as medical_institute_name,
       p.name           as patient_name
from appointment
         join m_institute mi on mi.m_institute_id = appointment.m_institute_id
         join patient p on p.patient_id = appointment.patient_id
where status = 'canceled';

-- Find how many appointments for each day.
select date, count(appointment_id) as n_appointments
from appointment
group by date;

-- Find the professional's name and patient's name assigned for each appointment, date, start time and end time should be
 -- listed as well.
select date, start_time, end_time, p.name as professional, mi.name as medical_institute_name, p2.name as patient_name
from appointment
         join professional p on appointment.m_institute_id = p.m_institute_id
         join m_institute mi on mi.m_institute_id = appointment.m_institute_id
         join patient p2 on p2.patient_id = appointment.patient_id;

-- Find the availability for each professional
select date, start_time, end_time, p.name as professional_name, mi.name as medical_institute_name
from availability
         join professional p on p.professional_id = availability.professional_id
         join m_institute mi on mi.m_institute_id = p.m_institute_id
order by p.name;

-- Find how many clients does each insurance type have
select i_type, count(p.patient_id) as n_clients
from insurance
         left join i_coverage ic on insurance.insurance_id = ic.insurance_id
         left join patient p on p.patient_id = ic.patient_id
group by i_type;

-- Find all the patients without any insurance
select name, email, phone
from patient
         left join i_coverage ic on patient.patient_id = ic.patient_id
where ic.patient_id is null;

-- Find all the patients who live in city other than Montreal.
select patient.name, city
from patient
         join address a on a.address_id = patient.address_id
where city not ilike 'Montreal';

-- Find the services covered by each insurance type
select insurance_provider, i_type, service_name
from insurance
         left join i_service i on insurance.insurance_id = i.insurance_id;

-- Find all the services covered by the public insurance
select service_name
from insurance
         left join i_service i on insurance.insurance_id = i.insurance_id
where i_type = 'public';

-- Find all the patients with no canceled appointments, list the time, date and the place as well.
select patient.name as patient_name, date, start_time, end_time, status, mi.name as medical_institute_name
from patient
         left join appointment a on patient.patient_id = a.patient_id
         join m_institute mi on mi.m_institute_id = a.m_institute_id
where appointment_id is not null
  and status != 'canceled';

-- Find all the patients names without any appointments
select patient.name as patient_name
from patient
         left join appointment a on patient.patient_id = a.patient_id
where appointment_id is null;

-- Find the city that has the highest number of patients in the this health system.
with t as (select city, count(patient.patient_id) as n_patients
           from patient
                    inner join address a on patient.address_id = a.address_id
           group by city
           order by city)
select *
from t
where n_patients = (select n_patients from t limit 1);

-- How many patients have public insurance?
select count(patient.patient_id) as n_patients
from patient
         inner join i_coverage ic on patient.patient_id = ic.patient_id
         inner join insurance i on i.insurance_id = ic.insurance_id
where i.i_type = 'public';

-- Find the names and specialities of professionals
select professional.name, professional.speciality
from professional
         left join login l on professional.professional_id = l.professional_id;

-- Find the patient with the highest number of appointments
with t as (select patient.name, count(patient.patient_id) as n_appointments
           from patient
                    join appointment a on patient.patient_id = a.patient_id
           group by patient.name
           order by n_appointments DESC)
select *
from t
where n_appointments = (select n_appointments from t limit 1);

-- Find the medical speciality the most required by patients
with t as (select speciality, count(a.appointment_id) as n_appointments
           from patient
                    join appointment a on patient.patient_id = a.patient_id
                    join m_institute mi on mi.m_institute_id = a.m_institute_id
                    join professional p on mi.m_institute_id = p.m_institute_id
           group by speciality
           order by n_appointments DESC)
select *
from t
where n_appointments = (select n_appointments from t limit 1);

-- Find the medical institute with the highest rating
with t as (select mi.name, sum(value) as rating
           from rating
                    join m_institute mi on mi.m_institute_id = rating.m_institute_id
           group by mi.name
           order by rating DESC)
select *
from t
where rating = (select rating from t limit 1);

-- Find the medical history for the patient 'Anna Smith'
select name, age, m_history
from patient
         join medical_history mh on patient.patient_id = mh.patient_id
where name = 'Anna Smith';
