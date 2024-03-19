-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://github.com/pgadmin-org/pgadmin4/issues/new/choose if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS occupancy."Employee"
(
    username character varying(30) COLLATE pg_catalog."default" NOT NULL,
    first_name character varying(15) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(15) COLLATE pg_catalog."default" NOT NULL,
    password character varying(40) COLLATE pg_catalog."default" NOT NULL,
    email character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Employee_pkey" PRIMARY KEY (username)
);

CREATE TABLE IF NOT EXISTS occupancy."Employee_Check_Study_Room"
(
    employee_username character varying(30) COLLATE pg_catalog."default" NOT NULL,
    room_num integer NOT NULL,
    room_hall character varying(40) COLLATE pg_catalog."default" NOT NULL,
    date_corrected timestamp without time zone NOT NULL,
    CONSTRAINT "Employee_Check_Study_Room_pkey" PRIMARY KEY (employee_username, room_num, room_hall)
);

CREATE TABLE IF NOT EXISTS occupancy."Hall"
(
    hall_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    num_of_rooms integer NOT NULL DEFAULT 0,
    CONSTRAINT "Hall_pkey" PRIMARY KEY (hall_name)
);

CREATE TABLE IF NOT EXISTS occupancy."Schedule_Room"
(
    schedule_id integer NOT NULL DEFAULT nextval('occupancy.occupancy_schedule_room_id_seq'::regclass),
    username character varying(30) COLLATE pg_catalog."default" NOT NULL,
    scheduled_time tsrange NOT NULL,
    room_num integer NOT NULL,
    room_hall character varying(40) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_schedule_id PRIMARY KEY (schedule_id)
);

CREATE TABLE IF NOT EXISTS occupancy."Student"
(
    username character varying(30) COLLATE pg_catalog."default" NOT NULL,
    first_name character varying(15) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(15) COLLATE pg_catalog."default" NOT NULL,
    email character varying(40) COLLATE pg_catalog."default" NOT NULL,
    password character varying(40) COLLATE pg_catalog."default",
    CONSTRAINT "Student_pkey" PRIMARY KEY (username)
);

CREATE TABLE IF NOT EXISTS occupancy."Study_Room"
(
    room_num integer NOT NULL,
    hall_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    occupied boolean NOT NULL,
    flag boolean NOT NULL,
    CONSTRAINT "Study_Room_pkey" PRIMARY KEY (room_num, hall_name)
);

CREATE TABLE IF NOT EXISTS occupancy."Study_Room_History"
(
    room_num integer NOT NULL,
    hall_name character varying(40) COLLATE pg_catalog."default" NOT NULL,
    date_time timestamp without time zone NOT NULL,
    occupied boolean NOT NULL,
    flag boolean NOT NULL,
    CONSTRAINT "Study_Room_History_pkey" PRIMARY KEY (room_num, hall_name, date_time)
);

CREATE TABLE IF NOT EXISTS occupancy."Watch_Room"
(
    watch_id serial NOT NULL,
    username character varying(30) COLLATE pg_catalog."default" NOT NULL,
    weekday integer NOT NULL,
    room_num integer NOT NULL,
    room_hall character varying(40) COLLATE pg_catalog."default" NOT NULL,
    watch_time time without time zone,
    CONSTRAINT pk_watch_id PRIMARY KEY (watch_id)
);

ALTER TABLE IF EXISTS occupancy."Employee_Check_Study_Room"
    ADD CONSTRAINT fk_employee FOREIGN KEY (employee_username)
    REFERENCES occupancy."Employee" (username) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS occupancy."Employee_Check_Study_Room"
    ADD CONSTRAINT fk_study_room FOREIGN KEY (room_num, room_hall)
    REFERENCES occupancy."Study_Room" (room_num, hall_name) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS occupancy."Schedule_Room"
    ADD CONSTRAINT fk_room_id FOREIGN KEY (room_num, room_hall)
    REFERENCES occupancy."Study_Room" (room_num, hall_name) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS occupancy."Schedule_Room"
    ADD CONSTRAINT fk_username FOREIGN KEY (username)
    REFERENCES occupancy."Student" (username) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS occupancy."Study_Room"
    ADD CONSTRAINT fk_hall FOREIGN KEY (hall_name)
    REFERENCES occupancy."Hall" (hall_name) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS occupancy."Study_Room_History"
    ADD CONSTRAINT fk_study_room FOREIGN KEY (room_num, hall_name)
    REFERENCES occupancy."Study_Room" (room_num, hall_name) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS occupancy."Watch_Room"
    ADD CONSTRAINT fk_room_id FOREIGN KEY (room_num, room_hall)
    REFERENCES occupancy."Study_Room" (room_num, hall_name) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS occupancy."Watch_Room"
    ADD CONSTRAINT fk_username FOREIGN KEY (username)
    REFERENCES occupancy."Student" (username) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE CASCADE;

END;