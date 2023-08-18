
-- Creating the schema and setting the path to it:
drop schema if exists BookingSystem CASCADE;
create schema if not exists BookingSystem;
set search_path to BookingSystem;



-- Creating the tables:
-- Create a domain
drop domain if exists email;
create domain email as text check ((length(value) >= 6) AND (value ~~* '%@%.%'::text));

-- Create the tables
create table address
(
    address_id integer generated always as identity
        primary key,
    street     text not null,
    city       text not null,
    province   text not null,
    country    text not null
);

create table m_institute
(
    m_institute_id integer generated always as identity
        primary key,
    name           text    not null,
    business_hours text    not null,
    m_type           text    not null,
    address_id     integer not null references address (address_id)
);
create table Service
(
    service_id     integer generated always as identity
        primary key,
    service_name   text    not null,
    description    text,
    m_institute_id integer not null references m_institute (m_institute_id)
);
create table professional
(
    professional_id integer generated always as identity
        primary key,
    name            text    not null,
    speciality      text    not null,
    phone           text    not null,
    email           email,
    m_institute_id  integer not null references m_institute (m_institute_id),
    unique (name, speciality)

);
create table availability
(
    availability_id integer generated always as identity
        primary key,
    date            date    not null,
    start_time      time    not null,
    end_time        time    not null,
    note            text,
    professional_id integer not null references professional (professional_id),
    constraint availability_check check (end_time >= start_time)
);

create table patient
(
    patient_id integer generated always as identity
        primary key,
    name       text    not null,
    age        integer not null,
    email      email   not null,
    phone      text    not null,
    address_id integer not null references address (address_id)
);

create table login
(
    login_id        integer generated always as identity
        primary key,
    username        varchar(16) not null unique
        constraint login_username_check
            check (length((username)::text) >= 3),
    password        varchar(16) not null
        constraint login_password_check
            check (length((password)::text) >= 8),
    l_type            text        not null,
    professional_id integer references professional (professional_id),
    patient_id      integer references patient (patient_id),
    constraint login_check
        check ((professional_id IS NOT NULL) OR (patient_id IS NOT NULL))
);
create table review
(
    review_id      integer generated always as identity
        primary key,
    content        text                    not null,
    datetime      timestamp default now() not null,
    m_institute_id integer not null references m_institute (m_institute_id),
    patient_id     integer                 not null references patient (patient_id)
);
create table rating
(
    rating_id      integer generated always as identity
        primary key,
    value          decimal(3, 2)           not null,
    datetime      timestamp default now() not null,
    m_institute_id integer not null references m_institute (m_institute_id),
    patient_id     integer                 not null references patient (patient_id)
);

create table medical_history
(
    medical_id integer generated always as identity
        primary key,
    m_history  jsonb,
    comment    text,
    patient_id integer not null references patient (patient_id)
);

create table appointment
(
    appointment_id integer generated always as identity
        primary key,
    date           date    not null,
    start_time     time    not null,
    end_time       time    not null,
    status         text    not null,
    p_type           text    not null,
    m_institute_id integer not null references m_institute (m_institute_id),
    patient_id     integer not null references patient (patient_id),
    constraint appointment_check check (end_time >= start_time)
);
create table notification
(
    notification_id integer generated always as identity
        primary key,
    content         text      not null,
    datetime        timestamp not null,
    n_type            text      not null,
    appointment_id  integer   not null references appointment (appointment_id)
);
create table insurance
(
    insurance_id       integer generated always as identity
        primary key,
    insurance_provider text not null,
    i_type               text not null
);
create table i_Service
(
    i_Service_id integer generated always as identity
        primary key,
    service_name text    not null,
    description  text,
    insurance_id integer not null references insurance (insurance_id)
);
create table i_coverage
(
    coverage_start_date date    not null,
    coverage_end_date   date    not null,
    patient_id          integer not null references patient (patient_id),
    insurance_id        integer not null references insurance (insurance_id),
    primary key (patient_id, insurance_id),
    constraint i_coverage_check check (coverage_end_date >= coverage_start_date)
);
