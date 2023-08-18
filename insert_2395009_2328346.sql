set search_path to BookingSystem;

insert into address (street, city, province, country)
values ('123 Rue Principale', 'Montreal', 'QC', 'Canada'),
       ('456 Boulevard des Sources', 'Montreal', 'QC', 'Canada'),
       ('123 Rue Sainte-Catherine', 'Montreal', 'QC', 'Canada'),
       ('789 Avenue du Mont-Royal', 'Montreal', 'QC', 'Canada'),
       ('321 Rue Sherbrooke', 'Montreal', 'QC', 'Canada'),
       ('568 Rue Pare', 'Montreal', 'QC', 'Canada'),
       ('258 Avenue Notre-Dame', 'Montreal', 'QC', 'Canada'),
       ('3647 Boulevard Decarie', 'Montreal', 'QC', 'Canada'),
       ('745 Avenue Powell', 'Montreal', 'QC', 'Canada'),
       ('456 Boulevard Lucerne', 'Montreal', 'QC', 'Canada'),
       ('789 Oak Rd', 'Montreal', 'QC', 'Canada'),
       ('321 Elm Blvd', 'Montreal', 'QC', 'Canada'),
       ('654 Pine St', 'Montreal', 'QC', 'Canada'),
       ('123 Rue Du Verdier', 'Quebec', 'QC', 'Canada');

insert into m_institute (name, business_hours, m_type, address_id)
values ('City General Hospital', 'Monday-Friday 9:00 AM - 5:00 PM', 'Hospital', 1),
       ('Montreal General Hospital', 'Open 24/7', 'Hospital', 5),
       ('Hôpital Sainte-Catherine', 'Monday-Friday 9:00 AM - 5:00 PM', 'Hospital', 2),
       ('Clinique Médicale Saint-Jean', 'Monday-Saturday 9:00 AM - 7:00 PM', 'Clinic', 3),
       ('Clinique Médicale Verdun', 'Monday-Friday 9:00 AM - 5:00 PM', 'Clinic', 4);

insert into Service (service_name, description, m_institute_id)
values ('Dental Cleaning', 'Professional teeth cleaning and oral hygiene assessment.', 2),
       ('X-ray Imaging', 'Diagnostic imaging service using X-rays to visualize internal structures.', 3),
       ('Vaccination', 'Immunization services for preventive vaccines.', 4),
       ('Physical Therapy', 'Rehabilitation and therapy services to restore physical function and mobility.', 5),
       ('General Check-up', 'Comprehensive health check-up including physical examination and basic lab tests.', 1),
       ('X-ray Imaging', 'Diagnostic imaging service using X-rays to visualize internal structures.', 4);

insert into professional (name, speciality, phone, email, m_institute_id)
values ('Dr. Sarah Johnson', 'Cardiology', '555-1234', 'sjohnson@example.com', 1),
       ('Dr. David Chen', 'Pediatrics', '555-5678', 'dchen@example.com', 2),
       ('Dr. Emily Taylor', 'Dermatology', '555-9876', 'etaylor@example.com', 4),
       ('Dr. Michael Rodriguez', 'Orthopedics', '555-4321', 'mrodriguez@example.com', 4),
       ('Dr. Jennifer Lee', 'Obstetrics and Gynecology', '555-8765', 'jlee@example.com', 5);

insert into patient (name, age, email, phone, address_id)
values ('John Campbell', 38, 'jcampbell@example.com', '555-7895', 6),
       ('Anna Smith', 56, 'asmith@example.com', '333-9874', 7),
       ('Lindsey Jones', 20, 'ljones@example.com', '444-9874', 8),
       ('Robert Smith', 68, 'rsmith@example.com', '222-7456', 8),
       ('Alex Clark', 45, 'aclark@example.com', '777-9541', 10),
       ('Michael Williams', 28, 'williams@example.com', '555-9012', 11),
       ('Sarah Davis', 51, 'davis@example.com', '555-3456', 12),
       ('Robert Taylor', 39, 'taylor@example.com', '555-7890', 13),
       ('John Taylor', 43, 'john@example.com', '555-3455', 13),
       ('Irene Tremblay', 15, 'tremblay@example.com', '444-5321', 14);

insert into login (username, password, l_type, professional_id, patient_id)
values ('username1', 'password1', 'Patient', NULL, 1),
       ('username2', 'password2', 'Patient', NULL, 2),
       ('username3', 'password3', 'Patient', NULL, 3),
       ('username4', 'password4', 'Patient', NULL, 4),
       ('username5', 'password5', 'Patient', NULL, 5),
       ('username6', 'password6', 'professional', 1, NULL),
       ('username7', 'password7', 'professional', 2, NULL),
       ('username8', 'password8', 'professional', 3, NULL),
       ('username9', 'password9', 'professional', 4, NULL),
       ('username10', 'password10', 'professional', 5, NULL);

insert into availability (date, start_time, end_time, note, professional_id)
values ('2023-06-06', '08:00:00', '08:15:00', 'Morning availability', 1),
       ('2023-06-07', '13:30:00', '17:00:00', 'Afternoon availability', 2),
       ('2023-06-08', '09:00:00', '11:30:00', 'Limited availability', 3),
       ('2023-06-09', '14:00:00', '16:30:00', 'Evening availability', 4),
       ('2023-06-10', '15:00:00', '15:30:00', 'Extended availability', 3);

insert into review (content, m_institute_id, patient_id)
values ('I had a great experience at this clinic. The staff was friendly and the service was excellent. Highly recommended!',
        1, 1),
       ('The services provided at this clinic were top-notch. The doctors were knowledgeable and the facilities were clean and modern.',
        2, 5),
       ('I am very satisfied with the care I received at this clinic. The staff was attentive and the treatment was effective.',
        3, 3),
       ('I had a positive experience with this clinic. The waiting time was minimal and the doctor took the time to listen to my concerns.',
        4, 1),
       ('I would highly recommend this clinic for their excellent services. The staff was professional and caring, and the treatment I received was effective.',
        5, 2);

insert into rating (value, m_institute_id, patient_id)
values (4.5, 1, 4),
       (5.0, 2, 3),
       (4.0, 3, 1),
       (4.5, 4, 1),
       (4.8, 5, 2);

insert into appointment (date, start_time, end_time, status, p_type, m_institute_id, patient_id)
values ('2023-06-07', '08:00', '09:00', 'scheduled', 'in-person', 1, 1),
       ('2023-06-08', '12:00', '13:00', 'canceled', 'telephone', 2, 5),
       ('2023-06-10', '14:00', '15:00', 'rescheduled', 'video', 3, 4),
       ('2023-06-10', '17:00', '18:00', 'scheduled', 'telephone', 4, 2),
       ('2023-06-12', '16:00', '17:00', 'scheduled', 'video', 5, 3),
       ('2023-06-13', '15:00', '16:00', 'rescheduled', 'telephone', 1, 1),
       ('2023-06-14', '10:00', '11:00', 'canceled', 'in-person', 5, 2);

insert into notification (content, datetime, n_type, appointment_id)
values ('Appointment reminder', '2023-06-07 08:00:00', 'email', 1),
       ('Dear patient this call is an appointment reminder', '2023-06-08 12:00:00', 'call', 2),
       ('Appointment reminder', '2023-06-10 14:00:00', 'SMS', 3),
       ('Appointment reminder', '2023-06-10 17:00:00', 'email', 4),
       ('Dear patient this call is an appointment reminder', '2023-06-12 16:00:00', 'call', 5),
       ('Dear patient this call is an appointment reminder', '2023-06-13 15:00:00', 'call', 1),
       ('Appointment reminder', '2023-06-14 10:00:00', 'SMS', 2);

insert into insurance (insurance_provider, i_type)
values ('SunLife', 'private'),
       ('Quebec insurance', 'public'),
       ('Manuvie', 'private'),
       ('Desjardins', 'private'),
       ('Blue Cross', 'private');

insert into i_coverage (coverage_start_date, coverage_end_date, patient_id, insurance_id)
values ('2022-06-18', '2024-06-17', 1, 2),
       ('2020-10-20', '2025-10-19', 4, 1),
       ('2019-07-30', '2024-07-29', 2, 3),
       ('2023-02-07', '2026-02-06', 3, 4),
       ('2018-04-25', '2028-04-24', 5, 5);

insert into i_Service (service_name, description, insurance_id)
values ('X-ray Imaging', 'Diagnostic imaging service using X-rays to visualize internal structures', 2),
       ('Physiotherapy session', 'Help people affected by disability through movement and exercise', 3),
       ('Acupuncture', 'Insert fine needles into the skin to treat health problems', 4),
       ('Optometric services', NULL, 1),
       ('Blood test', 'Sample of blood to measure the amount of certain substances in the blood', 5),
       ('Blood test', 'Sample of blood to measure the amount of certain substances in the blood', 1),
       ('Blood test', 'Sample of blood to measure the amount of certain substances in the blood', 3),
       ('Optometric services', NULL, 2),
       ('X-ray Imaging', 'Diagnostic imaging service using X-rays to visualize internal structures', 3),
       ('X-ray Imaging', 'Diagnostic imaging service using X-rays to visualize internal structures', 1),
       ('Acupuncture', 'Insert fine needles into the skin to treat health problems', 2),
       ('Acupuncture', 'Insert fine needles into the skin to treat health problems', 3);

insert into medical_history (m_history, comment, patient_id)
values ('{
  "previous_surgeries": [
    "s1",
    "s2",
    "s3"
  ],
  "medication": [
    "m1",
    "m2",
    "m3"
  ],
  "allergies": [
    "a1",
    "a2",
    "a3"
  ],
  "chronic_diseases": [
    "c1",
    "c2",
    "c3"
  ]}',
        'comment', 1),
       ('{
  "previous_surgeries": [
    "s1",
    "s2",
    "s3"
  ],
  "medication": [
    "m1",
    "m2",
    "m3"
  ],
  "allergies": [
    "a1",
    "a2",
    "a3"
  ],
  "chronic_diseases": [
    "c1",
    "c2",
    "c3"
  ]}',
        'comment', 2),
       ('{
  "previous_surgeries": [
    "s1",
    "s2",
    "s3"
  ],
  "medication": [
    "m1",
    "m2",
    "m3"
  ],
  "allergies": [
    "a1",
    "a2",
    "a3"
  ],
  "chronic_diseases": [
    "c1",
    "c2",
    "c3"
  ]}',
        'comment', 3);
