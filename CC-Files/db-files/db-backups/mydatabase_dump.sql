--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5
-- Dumped by pg_dump version 15.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: occupancy; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA occupancy;


ALTER SCHEMA occupancy OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Employee; Type: TABLE; Schema: occupancy; Owner: postgres
--

CREATE TABLE occupancy."Employee" (
    username character varying(30) NOT NULL,
    first_name character varying(15) NOT NULL,
    last_name character varying(15) NOT NULL,
    password character varying(40) NOT NULL,
    email character varying(40) NOT NULL
);


ALTER TABLE occupancy."Employee" OWNER TO postgres;

--
-- Name: Employee_Check_Study_Room; Type: TABLE; Schema: occupancy; Owner: postgres
--

CREATE TABLE occupancy."Employee_Check_Study_Room" (
    employee_username character varying(30) NOT NULL,
    room_num integer NOT NULL,
    room_hall character varying(40) NOT NULL,
    date_corrected timestamp without time zone NOT NULL
);


ALTER TABLE occupancy."Employee_Check_Study_Room" OWNER TO postgres;

--
-- Name: Hall; Type: TABLE; Schema: occupancy; Owner: postgres
--

CREATE TABLE occupancy."Hall" (
    hall_name character varying(40) NOT NULL,
    num_of_rooms integer DEFAULT 0 NOT NULL
);


ALTER TABLE occupancy."Hall" OWNER TO postgres;

--
-- Name: Schedule_Room; Type: TABLE; Schema: occupancy; Owner: postgres
--

CREATE TABLE occupancy."Schedule_Room" (
    schedule_id integer NOT NULL,
    username character varying(30) NOT NULL,
    scheduled_time tsrange NOT NULL,
    room_num integer NOT NULL,
    room_hall character varying(40) NOT NULL
);


ALTER TABLE occupancy."Schedule_Room" OWNER TO postgres;

--
-- Name: Student; Type: TABLE; Schema: occupancy; Owner: postgres
--

CREATE TABLE occupancy."Student" (
    username character varying(30) NOT NULL,
    first_name character varying(15) NOT NULL,
    last_name character varying(15) NOT NULL,
    email character varying(40) NOT NULL,
    password character varying(40)
);


ALTER TABLE occupancy."Student" OWNER TO postgres;

--
-- Name: Study_Room; Type: TABLE; Schema: occupancy; Owner: postgres
--

CREATE TABLE occupancy."Study_Room" (
    room_num integer NOT NULL,
    hall_name character varying(40) NOT NULL,
    occupied boolean NOT NULL,
    flag boolean NOT NULL
);


ALTER TABLE occupancy."Study_Room" OWNER TO postgres;

--
-- Name: Study_Room_History; Type: TABLE; Schema: occupancy; Owner: postgres
--

CREATE TABLE occupancy."Study_Room_History" (
    room_num integer NOT NULL,
    hall_name character varying(40) NOT NULL,
    date_time timestamp without time zone NOT NULL,
    occupied boolean NOT NULL,
    flag boolean NOT NULL
);


ALTER TABLE occupancy."Study_Room_History" OWNER TO postgres;

--
-- Data for Name: Employee; Type: TABLE DATA; Schema: occupancy; Owner: postgres
--

COPY occupancy."Employee" (username, first_name, last_name, password, email) FROM stdin;
grayds	David	Gray	C3n7r@l!23	grayds@dukes.jmu.edu
beecrowr	Robbie	Beecroft	ce^tra1!123	beecrowr@dukes.jmu.edu
tucke2ce	Chayse	Tucker	C3ferffrd	tucke2ce@dukes.jmu.edu
\.


--
-- Data for Name: Employee_Check_Study_Room; Type: TABLE DATA; Schema: occupancy; Owner: postgres
--

COPY occupancy."Employee_Check_Study_Room" (employee_username, room_num, room_hall, date_corrected) FROM stdin;
\.


--
-- Data for Name: Hall; Type: TABLE DATA; Schema: occupancy; Owner: postgres
--

COPY occupancy."Hall" (hall_name, num_of_rooms) FROM stdin;
EnGeo	2
King	2
Phys/Chem	2
\.


--
-- Data for Name: Schedule_Room; Type: TABLE DATA; Schema: occupancy; Owner: postgres
--

COPY occupancy."Schedule_Room" (schedule_id, username, scheduled_time, room_num, room_hall) FROM stdin;
\.


--
-- Data for Name: Student; Type: TABLE DATA; Schema: occupancy; Owner: postgres
--

COPY occupancy."Student" (username, first_name, last_name, email, password) FROM stdin;
zakaratx	Teo	Zakaraia	zakaratx@dukes.jmu.edu	P@ssword!23
hodgkiar	Austin	Hodgkiss	hodgkiar@dukes.jmu.edu	hello@it23
mpassyhv	Holly	Mpassy	mpassyhv@dukes.jmu.edu	ch3ck0u7!23
suskojr	Jacob	Susko	suskojr@dukes.jmu.edu	P@assword!23
gardn3mx	May	Gardner	gardn3mx@dukes.jmu.edu	P@assword!23
fake	fkae	fake	fake@gmail.com	123
\.


--
-- Data for Name: Study_Room; Type: TABLE DATA; Schema: occupancy; Owner: postgres
--

COPY occupancy."Study_Room" (room_num, hall_name, occupied, flag) FROM stdin;
2020	EnGeo	t	f
2037	EnGeo	f	t
357	King	t	t
358	King	f	f
101	Phys/Chem	f	t
202	Phys/Chem	t	t
\.


--
-- Data for Name: Study_Room_History; Type: TABLE DATA; Schema: occupancy; Owner: postgres
--

COPY occupancy."Study_Room_History" (room_num, hall_name, date_time, occupied, flag) FROM stdin;
\.


--
-- Name: Employee_Check_Study_Room Employee_Check_Study_Room_pkey; Type: CONSTRAINT; Schema: occupancy; Owner: postgres
--

ALTER TABLE ONLY occupancy."Employee_Check_Study_Room"
    ADD CONSTRAINT "Employee_Check_Study_Room_pkey" PRIMARY KEY (employee_username, room_num, room_hall);


--
-- Name: Employee Employee_pkey; Type: CONSTRAINT; Schema: occupancy; Owner: postgres
--

ALTER TABLE ONLY occupancy."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY (username);


--
-- Name: Hall Hall_pkey; Type: CONSTRAINT; Schema: occupancy; Owner: postgres
--

ALTER TABLE ONLY occupancy."Hall"
    ADD CONSTRAINT "Hall_pkey" PRIMARY KEY (hall_name);


--
-- Name: Student Student_pkey; Type: CONSTRAINT; Schema: occupancy; Owner: postgres
--

ALTER TABLE ONLY occupancy."Student"
    ADD CONSTRAINT "Student_pkey" PRIMARY KEY (username);


--
-- Name: Study_Room_History Study_Room_History_pkey; Type: CONSTRAINT; Schema: occupancy; Owner: postgres
--

ALTER TABLE ONLY occupancy."Study_Room_History"
    ADD CONSTRAINT "Study_Room_History_pkey" PRIMARY KEY (room_num, hall_name, date_time);


--
-- Name: Study_Room Study_Room_pkey; Type: CONSTRAINT; Schema: occupancy; Owner: postgres
--

ALTER TABLE ONLY occupancy."Study_Room"
    ADD CONSTRAINT "Study_Room_pkey" PRIMARY KEY (room_num, hall_name);


--
-- Name: Schedule_Room pk_schedule_id; Type: CONSTRAINT; Schema: occupancy; Owner: postgres
--

ALTER TABLE ONLY occupancy."Schedule_Room"
    ADD CONSTRAINT pk_schedule_id PRIMARY KEY (schedule_id);


--
-- Name: Employee_Check_Study_Room fk_employee; Type: FK CONSTRAINT; Schema: occupancy; Owner: postgres
--

ALTER TABLE ONLY occupancy."Employee_Check_Study_Room"
    ADD CONSTRAINT fk_employee FOREIGN KEY (employee_username) REFERENCES occupancy."Employee"(username) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Study_Room fk_hall; Type: FK CONSTRAINT; Schema: occupancy; Owner: postgres
--

ALTER TABLE ONLY occupancy."Study_Room"
    ADD CONSTRAINT fk_hall FOREIGN KEY (hall_name) REFERENCES occupancy."Hall"(hall_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Schedule_Room fk_room_id; Type: FK CONSTRAINT; Schema: occupancy; Owner: postgres
--

ALTER TABLE ONLY occupancy."Schedule_Room"
    ADD CONSTRAINT fk_room_id FOREIGN KEY (room_num, room_hall) REFERENCES occupancy."Study_Room"(room_num, hall_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Employee_Check_Study_Room fk_study_room; Type: FK CONSTRAINT; Schema: occupancy; Owner: postgres
--

ALTER TABLE ONLY occupancy."Employee_Check_Study_Room"
    ADD CONSTRAINT fk_study_room FOREIGN KEY (room_num, room_hall) REFERENCES occupancy."Study_Room"(room_num, hall_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Study_Room_History fk_study_room; Type: FK CONSTRAINT; Schema: occupancy; Owner: postgres
--

ALTER TABLE ONLY occupancy."Study_Room_History"
    ADD CONSTRAINT fk_study_room FOREIGN KEY (room_num, hall_name) REFERENCES occupancy."Study_Room"(room_num, hall_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Schedule_Room fk_username; Type: FK CONSTRAINT; Schema: occupancy; Owner: postgres
--

ALTER TABLE ONLY occupancy."Schedule_Room"
    ADD CONSTRAINT fk_username FOREIGN KEY (username) REFERENCES occupancy."Student"(username) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

