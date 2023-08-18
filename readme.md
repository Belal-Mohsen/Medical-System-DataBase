# <u>Project Description:</u>
### Title: Medical Appointment Booking System
This database system is designed to be linked to a web and/or mobile-based application and has been built to simplify managing and scheduling medical appointment in a country. 
The user can book an appointment with doctors in a specific medical institute based on their needs, healthcare insurance, location, and more. 
The main goal of this system is to provide a user-friendly platform for users (patients, doctors, and other healthcare providers) and help the healthcare providers to deliver their services in efficient way.

The basic features of this application include: 
- User accounts: patients and professionals can create an account and manage their accounts and their personal information.
- Search: Patients can search for a doctor/healthcare provider based on the location, availability, specialty, type of the healthcare insurance.
- Appointments (scheduling, rescheduling and canceling): patients can book an appointment based on the doctor/healthcare-provider schedule/availability. They can also reschedule or cancel appointments, allowing other users to book those time slots and reducing no-shows.
- Notifications: patients can receive a confirmation and reminder notifications in different ways from the system.
- Review and rating: patients can write a review and rate medical institutes allowing others to know the quality of the offered services at these institutes.
- Medical history records: healthcare providers can access their patients’ medical history to provide better services. 
- Patients can check the services offered by the medical institutes, names of the professionals, and their availabilities and specialities.
- Medical institutes can check patients' insurance and the services covered by these different insurances.
- Medical institutes can access some of their patients' personal information like their age, emails, phone numbers and addresses.

### Real-Life Similar Systems:
- [Quebec-Medical-Appointment-Scheduler](https://www.rvsq.gouv.qc.ca/accueil/index-en.html).
- [Ontario Medical-Appointment-Scheduler](https://www.ontariohealth.ca/system-planning/digital-standards/online-appointment-booking)
- [Quebec HUB](https://www.quebechub.ca/)
- [Clic Santé - Quebec](https://portal3.clicsante.ca/)

### Project's Data Overview
- Login credentials: usernames, passwords for patients and healthcare providers.
- Patient: ID, name, age, address, email, phone number. 
- Professionals: ID, name, details about healthcare providers, including their specialties, contact information, availability, and associated clinics or hospitals.
- medical institutes: details about clinics and hospitals where healthcare providers practice, including names, locations, contact information, and business hour. 
- Services offered: laboratory tests, vaccines, non-urgent medical consultation, physiotherapy session (with Clinics/Hospitals).
- Appointments: information about scheduled appointments, including appointment ID, patient details, healthcare provider details, date, time, and status (canceled, rescheduled), type of appointment (in-person, video, or telephone). 
- Notifications: data stored for notifications sent to patients and healthcare providers regarding appointment reminders, updates, and other important information. User preference for receiving notifications: email, SMS, app notification, call.
- Review/Ratings: patients can review/rating the professionals and local (clinics).
- Insurance information: patient with public/private insurance, services covered by this insurance.
- Medical history: patients will be asked about/give access to their general health, including allergies to food/animals, current medication, and previous surgeries.

# <u>Queries</u>

- Find all the canceled appointments

```postgresql
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
```

| date       | start\_time | end\_time | status   | appointment\_type | medical\_institute\_name  | patient\_name |
|:-----------|:------------|:----------|:---------|:------------------|:--------------------------|:--------------|
| 2023-06-08 | 12:00:00    | 13:00:00  | canceled | telephone         | Montreal General Hospital | Alex Clark    |
| 2023-06-14 | 10:00:00    | 11:00:00  | canceled | in-person         | Clinique Médicale Verdun  | Anna Smith    |

- Find how many appointments for each day.

```postgresql
select date, count(appointment_id) as n_appointments
from appointment
group by date;
```

| date       | n\_appointments |
|:-----------|:----------------|
| 2023-06-08 | 1               |
| 2023-06-10 | 2               |
| 2023-06-12 | 1               |
| 2023-06-13 | 1               |
| 2023-06-07 | 1               |
| 2023-06-14 | 1               |

- Find the professional's name and patient's name assigned for each appointment, date, start time and end time should be
  listed as well.

```postgresql
select date, start_time, end_time, p.name as professional, mi.name as medical_institute_name, p2.name as patient_name
from appointment
         join professional p on appointment.m_institute_id = p.m_institute_id
         join m_institute mi on mi.m_institute_id = appointment.m_institute_id
         join patient p2 on p2.patient_id = appointment.patient_id;
```

| date       | start\_time | end\_time | professional          | medical\_institute\_name     | patient\_name |
|:-----------|:------------|:----------|:----------------------|:-----------------------------|:--------------|
| 2023-06-07 | 08:00:00    | 09:00:00  | Dr. Sarah Johnson     | City General Hospital        | John Campbell |
| 2023-06-08 | 12:00:00    | 13:00:00  | Dr. David Chen        | Montreal General Hospital    | Alex Clark    |
| 2023-06-10 | 17:00:00    | 18:00:00  | Dr. Michael Rodriguez | Clinique Médicale Saint-Jean | Anna Smith    |
| 2023-06-10 | 17:00:00    | 18:00:00  | Dr. Emily Taylor      | Clinique Médicale Saint-Jean | Anna Smith    |
| 2023-06-12 | 16:00:00    | 17:00:00  | Dr. Jennifer Lee      | Clinique Médicale Verdun     | Lindsey Jones |
| 2023-06-13 | 15:00:00    | 16:00:00  | Dr. Sarah Johnson     | City General Hospital        | John Campbell |
| 2023-06-14 | 10:00:00    | 11:00:00  | Dr. Jennifer Lee      | Clinique Médicale Verdun     | Anna Smith    |

- Find the availability for each professional

```postgresql
select date, start_time, end_time, p.name as professional_name, mi.name as medical_institute_name
from availability
         join professional p on p.professional_id = availability.professional_id
         join m_institute mi on mi.m_institute_id = p.m_institute_id
order by p.name;
```

| date       | start\_time | end\_time | professional\_name    | medical\_institute\_name     |
|:-----------|:------------|:----------|:----------------------|:-----------------------------|
| 2023-06-07 | 13:30:00    | 17:00:00  | Dr. David Chen        | Montreal General Hospital    |
| 2023-06-08 | 09:00:00    | 11:30:00  | Dr. Emily Taylor      | Clinique Médicale Saint-Jean |
| 2023-06-10 | 15:00:00    | 15:30:00  | Dr. Emily Taylor      | Clinique Médicale Saint-Jean |
| 2023-06-09 | 14:00:00    | 16:30:00  | Dr. Michael Rodriguez | Clinique Médicale Saint-Jean |
| 2023-06-06 | 08:00:00    | 08:15:00  | Dr. Sarah Johnson     | City General Hospital        |

- Find how many clients does each insurance type have

```postgresql
select i_type, count(p.patient_id) as n_clients
from insurance
         left join i_coverage ic on insurance.insurance_id = ic.insurance_id
         left join patient p on p.patient_id = ic.patient_id
group by i_type;

```

| type    | n\_clients |
|:--------|:-----------|
| private | 4          |
| public  | 1          |

- Find all the patients without any insurance

```postgresql
select name, email, phone
from patient
         left join i_coverage ic on patient.patient_id = ic.patient_id
where ic.patient_id is null;
```

| name             | email                | phone    |
|:-----------------|:---------------------|:---------|
| Michael Williams | williams@example.com | 555-9012 |
| Sarah Davis      | davis@example.com    | 555-3456 |
| Robert Taylor    | taylor@example.com   | 555-7890 |

- Find all the patients who live in city other than Montreal.

```postgresql
select patient.name, city
from patient
         join address a on a.address_id = patient.address_id
where city not ilike 'Montreal';
```

| name           | city   |
|:---------------|:-------|
| Irene Tremblay | Quebec |

- Find the services covered by each insurance type

```postgresql
select insurance_provider, i_type, service_name
from insurance
         left join i_service i on insurance.insurance_id = i.insurance_id;
```

| insurance\_provider | type    | service\_name         |
|:--------------------|:--------|:----------------------|
| Quebec insurance    | public  | X-ray Imaging         |
| Manuvie             | private | Physiotherapy session |
| Desjardins          | private | Acupuncture           |
| SunLife             | private | Optometric services   |
| Blue Cross          | private | Blood test            |
| SunLife             | private | Blood test            |
| Manuvie             | private | Blood test            |
| Quebec insurance    | public  | Optometric services   |
| Manuvie             | private | X-ray Imaging         |
| SunLife             | private | X-ray Imaging         |
| Quebec insurance    | public  | Acupuncture           |
| Manuvie             | private | Acupuncture           |

- Find all the services covered by the public insurance

```postgresql
select service_name
from insurance
         left join i_service i on insurance.insurance_id = i.insurance_id
where i_type = 'public';
```

| service\_name       |
|:--------------------|
| X-ray Imaging       |
| Optometric services |
| Acupuncture         |

- Find all the patients with no canceled appointments, list the time, date and the place as well.

```postgresql
select patient.name as patient_name, date, start_time, end_time, status, mi.name as medical_institute_name
from patient
         left join appointment a on patient.patient_id = a.patient_id
         join m_institute mi on mi.m_institute_id = a.m_institute_id
where appointment_id is not null
  and status != 'canceled';
```

| patient\_name | date       | start\_time | end\_time | status      | medical\_institute\_name     |
|:--------------|:-----------|:------------|:----------|:------------|:-----------------------------|
| John Campbell | 2023-06-07 | 08:00:00    | 09:00:00  | scheduled   | City General Hospital        |
| Robert Smith  | 2023-06-10 | 14:00:00    | 15:00:00  | rescheduled | Hôpital Sainte-Catherine     |
| Anna Smith    | 2023-06-10 | 17:00:00    | 18:00:00  | scheduled   | Clinique Médicale Saint-Jean |
| Lindsey Jones | 2023-06-12 | 16:00:00    | 17:00:00  | scheduled   | Clinique Médicale Verdun     |
| John Campbell | 2023-06-13 | 15:00:00    | 16:00:00  | rescheduled | City General Hospital        |

- Find all the patients names without any appointments

```postgresql
select patient.name as patient_name
from patient
         left join appointment a on patient.patient_id = a.patient_id
where appointment_id is null;
```

| patient\_name    |
|:-----------------|
| Irene Tremblay   |
| Robert Taylor    |
| Michael Williams |
| John Taylor      |
| Sarah Davis      |

- Find the city that has the highest number of patients in the this health system.

```postgresql
with t as (select city, count(patient.patient_id) as n_patients
           from patient
                    inner join address a on patient.address_id = a.address_id
           group by city
           order by city)
select *
from t
where n_patients = (select n_patients from t limit 1);

```

| city     | n\_patients |
|:---------|:------------|
| Montreal | 9           |

- How many patients have public insurance?

```postgresql
select count(patient.patient_id) as n_patients
from patient
         inner join i_coverage ic on patient.patient_id = ic.patient_id
         inner join insurance i on i.insurance_id = ic.insurance_id
where i.i_type = 'public';
```

| n\_patients |
|:------------|
| 1           |

- Find the names and specialities of professionals

```postgresql
select professional.name, professional.speciality
from professional
         left join login l on professional.professional_id = l.professional_id;
```

| name                  | speciality                |
|:----------------------|:--------------------------|
| Dr. Sarah Johnson     | Cardiology                |
| Dr. David Chen        | Pediatrics                |
| Dr. Emily Taylor      | Dermatology               |
| Dr. Michael Rodriguez | Orthopedics               |
| Dr. Jennifer Lee      | Obstetrics and Gynecology |

- Find the patient with the highest number of appointments

```postgresql
with t as (select patient.name, count(patient.patient_id) as n_appointments
           from patient
                    join appointment a on patient.patient_id = a.patient_id
           group by patient.name
           order by n_appointments DESC)
select *
from t
where n_appointments = (select n_appointments from t limit 1);
```

| name          | n\_appointments |
|:--------------|:----------------|
| John Campbell | 2               |
| Anna Smith    | 2               |

- Find the medical speciality the most required by patients

```postgresql
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

```

| speciality                | n\_appointments |
|:--------------------------|:----------------|
| Cardiology                | 2               |
| Obstetrics and Gynecology | 2               |

- Find the medical institute with the highest rating

```postgresql
with t as (select mi.name, sum(value) as rating
           from rating
                    join m_institute mi on mi.m_institute_id = rating.m_institute_id
           group by mi.name
           order by rating DESC)
select *
from t
where rating = (select rating from t limit 1);
```

| name                      | rating |
|:--------------------------|:-------|
| Montreal General Hospital | 5      |

- Find the medical history for the patient 'Anna Smith'

```postgresql
select name, age, m_history
from patient
         join medical_history mh on patient.patient_id = mh.patient_id
where name = 'Anna Smith';
```

| name       | age | m\_history                                                                                                                                                      |
|:-----------|:----|:----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Anna Smith | 56  | {"allergies": \["a1", "a2", "a3"\], "medication": \["m1", "m2", "m3"\], "chronic\_diseases": \["c1", "c2", "c3"\], "previous\_surgeries": \["s1", "s2", "s3"\]} |
