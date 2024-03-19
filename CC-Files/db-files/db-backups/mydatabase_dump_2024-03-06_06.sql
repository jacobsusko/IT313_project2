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
-- Name: occupancy; Type: SCHEMA; Schema: -; Owner: centralteam
--

CREATE SCHEMA occupancy;


ALTER SCHEMA occupancy OWNER TO centralteam;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Employee; Type: TABLE; Schema: occupancy; Owner: centralteam
--

CREATE TABLE occupancy."Employee" (
    username character varying(30) NOT NULL,
    first_name character varying(15) NOT NULL,
    last_name character varying(15) NOT NULL,
    password character varying(40) NOT NULL,
    email character varying(40) NOT NULL
);


ALTER TABLE occupancy."Employee" OWNER TO centralteam;

--
-- Name: Employee_Check_Study_Room; Type: TABLE; Schema: occupancy; Owner: centralteam
--

CREATE TABLE occupancy."Employee_Check_Study_Room" (
    employee_username character varying(30) NOT NULL,
    room_num integer NOT NULL,
    room_hall character varying(40) NOT NULL,
    date_corrected timestamp without time zone NOT NULL
);


ALTER TABLE occupancy."Employee_Check_Study_Room" OWNER TO centralteam;

--
-- Name: Hall; Type: TABLE; Schema: occupancy; Owner: centralteam
--

CREATE TABLE occupancy."Hall" (
    hall_name character varying(40) NOT NULL,
    num_of_rooms integer DEFAULT 0 NOT NULL
);


ALTER TABLE occupancy."Hall" OWNER TO centralteam;

--
-- Name: Schedule_Room; Type: TABLE; Schema: occupancy; Owner: centralteam
--

CREATE TABLE occupancy."Schedule_Room" (
    schedule_id integer NOT NULL,
    username character varying(30) NOT NULL,
    scheduled_time tsrange NOT NULL,
    room_num integer NOT NULL,
    room_hall character varying(40) NOT NULL
);


ALTER TABLE occupancy."Schedule_Room" OWNER TO centralteam;

--
-- Name: Student; Type: TABLE; Schema: occupancy; Owner: centralteam
--

CREATE TABLE occupancy."Student" (
    username character varying(30) NOT NULL,
    first_name character varying(15) NOT NULL,
    last_name character varying(15) NOT NULL,
    email character varying(40) NOT NULL,
    password character varying(40)
);


ALTER TABLE occupancy."Student" OWNER TO centralteam;

--
-- Name: Study_Room; Type: TABLE; Schema: occupancy; Owner: centralteam
--

CREATE TABLE occupancy."Study_Room" (
    room_num integer NOT NULL,
    hall_name character varying(40) NOT NULL,
    occupied boolean NOT NULL,
    flag boolean NOT NULL
);


ALTER TABLE occupancy."Study_Room" OWNER TO centralteam;

--
-- Name: Study_Room_History; Type: TABLE; Schema: occupancy; Owner: centralteam
--

CREATE TABLE occupancy."Study_Room_History" (
    room_num integer NOT NULL,
    hall_name character varying(40) NOT NULL,
    date_time timestamp without time zone NOT NULL,
    occupied boolean NOT NULL,
    flag boolean NOT NULL
);


ALTER TABLE occupancy."Study_Room_History" OWNER TO centralteam;

--
-- Data for Name: Employee; Type: TABLE DATA; Schema: occupancy; Owner: centralteam
--

COPY occupancy."Employee" (username, first_name, last_name, password, email) FROM stdin;
grayds	David	Gray	C3n7r@l!23	grayds@dukes.jmu.edu
beecrowr	Robbie	Beecroft	ce^tra1!123	beecrowr@dukes.jmu.edu
tucke2ce	Chayse	Tucker	C3ferffrd	tucke2ce@dukes.jmu.edu
hello	hello	hello	hello	hello@gmail.com
\.


--
-- Data for Name: Employee_Check_Study_Room; Type: TABLE DATA; Schema: occupancy; Owner: centralteam
--

COPY occupancy."Employee_Check_Study_Room" (employee_username, room_num, room_hall, date_corrected) FROM stdin;
\.


--
-- Data for Name: Hall; Type: TABLE DATA; Schema: occupancy; Owner: centralteam
--

COPY occupancy."Hall" (hall_name, num_of_rooms) FROM stdin;
EnGeo	2
King	2
Phys/Chem	2
\.


--
-- Data for Name: Schedule_Room; Type: TABLE DATA; Schema: occupancy; Owner: centralteam
--

COPY occupancy."Schedule_Room" (schedule_id, username, scheduled_time, room_num, room_hall) FROM stdin;
\.


--
-- Data for Name: Student; Type: TABLE DATA; Schema: occupancy; Owner: centralteam
--

COPY occupancy."Student" (username, first_name, last_name, email, password) FROM stdin;
mpassyhv	Holly	Mpassy	mpassyhv@dukes.jmu.edu	ch3ck0u7!23
suskojr	Jacob	Susko	suskojr@dukes.jmu.edu	P@assword!23
gardn3mx	May	Gardner	gardn3mx@dukes.jmu.edu	P@assword!23
fake	fkae	fake	fake@gmail.com	123
MagicRaf	Rafael	Margary	margarrx@dukes.jmu.edu	Password
hodgkiar	Austin	Hodgkiss	Hodgkiar@dukes.jmu.edu	pass1234
zakaratx	Teo	Zakaraia	123@email.com	P@ssword!23
\.


--
-- Data for Name: Study_Room; Type: TABLE DATA; Schema: occupancy; Owner: centralteam
--

COPY occupancy."Study_Room" (room_num, hall_name, occupied, flag) FROM stdin;
202	Phys/Chem	f	f
358	King	f	t
101	Phys/Chem	f	f
2020	EnGeo	t	f
2037	EnGeo	f	f
357	King	f	f
\.


--
-- Data for Name: Study_Room_History; Type: TABLE DATA; Schema: occupancy; Owner: centralteam
--

COPY occupancy."Study_Room_History" (room_num, hall_name, date_time, occupied, flag) FROM stdin;
2020	EnGeo	2024-03-02 21:00:00	t	f
357	King	2024-03-02 21:00:00	t	t
358	King	2024-03-02 21:00:00	f	f
101	Phys/Chem	2024-03-02 21:00:00	f	t
202	Phys/Chem	2024-03-02 21:00:00	t	t
2037	EnGeo	2024-03-02 21:00:00	t	t
2020	EnGeo	2024-03-02 22:00:00	t	f
357	King	2024-03-02 22:00:00	t	t
358	King	2024-03-02 22:00:00	f	f
101	Phys/Chem	2024-03-02 22:00:00	f	t
202	Phys/Chem	2024-03-02 22:00:00	t	t
2037	EnGeo	2024-03-02 22:00:00	t	t
357	King	2024-03-02 23:00:00	t	t
101	Phys/Chem	2024-03-02 23:00:00	t	t
202	Phys/Chem	2024-03-02 23:00:00	f	t
358	King	2024-03-02 23:00:00	t	f
2020	EnGeo	2024-03-02 23:00:00	f	f
2037	EnGeo	2024-03-02 23:00:00	f	t
357	King	2024-03-02 23:10:00	t	t
101	Phys/Chem	2024-03-02 23:10:00	t	t
202	Phys/Chem	2024-03-02 23:10:00	f	t
358	King	2024-03-02 23:10:00	t	f
2020	EnGeo	2024-03-02 23:10:00	f	f
2037	EnGeo	2024-03-02 23:10:00	f	t
357	King	2024-03-02 23:20:00	t	t
101	Phys/Chem	2024-03-02 23:20:00	t	t
202	Phys/Chem	2024-03-02 23:20:00	f	t
358	King	2024-03-02 23:20:00	t	f
2020	EnGeo	2024-03-02 23:20:00	f	f
2037	EnGeo	2024-03-02 23:20:00	f	t
357	King	2024-03-02 23:30:00	t	t
101	Phys/Chem	2024-03-02 23:30:00	t	t
202	Phys/Chem	2024-03-02 23:30:00	f	t
358	King	2024-03-02 23:30:00	t	f
2020	EnGeo	2024-03-02 23:30:00	f	f
2037	EnGeo	2024-03-02 23:30:00	f	t
357	King	2024-03-02 23:40:00	t	t
101	Phys/Chem	2024-03-02 23:40:00	t	t
202	Phys/Chem	2024-03-02 23:40:00	f	t
358	King	2024-03-02 23:40:00	t	f
2020	EnGeo	2024-03-02 23:40:00	f	f
2037	EnGeo	2024-03-02 23:40:00	f	t
357	King	2024-03-02 23:50:00	t	t
101	Phys/Chem	2024-03-02 23:50:00	t	t
202	Phys/Chem	2024-03-02 23:50:00	f	t
358	King	2024-03-02 23:50:00	t	f
2020	EnGeo	2024-03-02 23:50:00	f	f
2037	EnGeo	2024-03-02 23:50:00	f	t
357	King	2024-03-03 00:00:00	t	t
101	Phys/Chem	2024-03-03 00:00:00	t	t
202	Phys/Chem	2024-03-03 00:00:00	f	t
358	King	2024-03-03 00:00:00	t	f
2020	EnGeo	2024-03-03 00:00:00	f	f
2037	EnGeo	2024-03-03 00:00:00	f	t
357	King	2024-03-03 00:10:00	t	t
101	Phys/Chem	2024-03-03 00:10:00	t	t
202	Phys/Chem	2024-03-03 00:10:00	f	t
358	King	2024-03-03 00:10:00	t	f
2020	EnGeo	2024-03-03 00:10:00	f	f
2037	EnGeo	2024-03-03 00:10:00	f	t
357	King	2024-03-03 00:20:00	t	t
101	Phys/Chem	2024-03-03 00:20:00	t	t
202	Phys/Chem	2024-03-03 00:20:00	f	t
358	King	2024-03-03 00:20:00	t	f
2020	EnGeo	2024-03-03 00:20:00	f	f
2037	EnGeo	2024-03-03 00:20:00	f	t
357	King	2024-03-03 00:30:00	t	t
101	Phys/Chem	2024-03-03 00:30:00	t	t
202	Phys/Chem	2024-03-03 00:30:00	f	t
358	King	2024-03-03 00:30:00	t	f
2020	EnGeo	2024-03-03 00:30:00	f	f
2037	EnGeo	2024-03-03 00:30:00	f	t
357	King	2024-03-03 00:40:00	t	t
101	Phys/Chem	2024-03-03 00:40:00	t	t
202	Phys/Chem	2024-03-03 00:40:00	f	t
358	King	2024-03-03 00:40:00	t	f
2020	EnGeo	2024-03-03 00:40:00	f	f
2037	EnGeo	2024-03-03 00:40:00	f	t
357	King	2024-03-03 00:50:00	t	t
101	Phys/Chem	2024-03-03 00:50:00	t	t
202	Phys/Chem	2024-03-03 00:50:00	f	t
358	King	2024-03-03 00:50:00	t	f
2020	EnGeo	2024-03-03 00:50:00	f	f
2037	EnGeo	2024-03-03 00:50:00	f	t
357	King	2024-03-03 01:00:00	t	t
101	Phys/Chem	2024-03-03 01:00:00	t	t
202	Phys/Chem	2024-03-03 01:00:00	f	t
358	King	2024-03-03 01:00:00	t	f
2020	EnGeo	2024-03-03 01:00:00	f	f
2037	EnGeo	2024-03-03 01:00:00	f	t
357	King	2024-03-03 01:10:00	t	t
101	Phys/Chem	2024-03-03 01:10:00	t	t
202	Phys/Chem	2024-03-03 01:10:00	f	t
358	King	2024-03-03 01:10:00	t	f
2020	EnGeo	2024-03-03 01:10:00	f	f
2037	EnGeo	2024-03-03 01:10:00	f	t
357	King	2024-03-03 01:20:00	t	t
101	Phys/Chem	2024-03-03 01:20:00	t	t
202	Phys/Chem	2024-03-03 01:20:00	f	t
358	King	2024-03-03 01:20:00	t	f
2020	EnGeo	2024-03-03 01:20:00	f	f
2037	EnGeo	2024-03-03 01:20:00	f	t
357	King	2024-03-03 01:30:00	t	t
101	Phys/Chem	2024-03-03 01:30:00	t	t
202	Phys/Chem	2024-03-03 01:30:00	f	t
358	King	2024-03-03 01:30:00	t	f
2020	EnGeo	2024-03-03 01:30:00	f	f
2037	EnGeo	2024-03-03 01:30:00	f	t
357	King	2024-03-03 01:40:00	t	t
101	Phys/Chem	2024-03-03 01:40:00	t	t
202	Phys/Chem	2024-03-03 01:40:00	f	t
358	King	2024-03-03 01:40:00	t	f
2020	EnGeo	2024-03-03 01:40:00	f	f
2037	EnGeo	2024-03-03 01:40:00	f	t
357	King	2024-03-03 01:50:00	t	t
101	Phys/Chem	2024-03-03 01:50:00	t	t
202	Phys/Chem	2024-03-03 01:50:00	f	t
358	King	2024-03-03 01:50:00	t	f
2020	EnGeo	2024-03-03 01:50:00	f	f
2037	EnGeo	2024-03-03 01:50:00	f	t
357	King	2024-03-03 02:00:00	t	t
101	Phys/Chem	2024-03-03 02:00:00	t	t
202	Phys/Chem	2024-03-03 02:00:00	f	t
358	King	2024-03-03 02:00:00	t	f
2020	EnGeo	2024-03-03 02:00:00	f	f
2037	EnGeo	2024-03-03 02:00:00	f	t
357	King	2024-03-03 02:10:00	t	t
101	Phys/Chem	2024-03-03 02:10:00	t	t
202	Phys/Chem	2024-03-03 02:10:00	f	t
358	King	2024-03-03 02:10:00	t	f
2020	EnGeo	2024-03-03 02:10:00	f	f
2037	EnGeo	2024-03-03 02:10:00	f	t
357	King	2024-03-03 02:20:00	t	t
101	Phys/Chem	2024-03-03 02:20:00	t	t
202	Phys/Chem	2024-03-03 02:20:00	f	t
358	King	2024-03-03 02:20:00	t	f
2020	EnGeo	2024-03-03 02:20:00	f	f
2037	EnGeo	2024-03-03 02:20:00	f	t
357	King	2024-03-03 02:30:00	t	t
101	Phys/Chem	2024-03-03 02:30:00	t	t
202	Phys/Chem	2024-03-03 02:30:00	f	t
358	King	2024-03-03 02:30:00	t	f
2020	EnGeo	2024-03-03 02:30:00	f	f
2037	EnGeo	2024-03-03 02:30:00	f	t
357	King	2024-03-03 02:40:00	t	t
101	Phys/Chem	2024-03-03 02:40:00	t	t
202	Phys/Chem	2024-03-03 02:40:00	f	t
358	King	2024-03-03 02:40:00	t	f
2020	EnGeo	2024-03-03 02:40:00	f	f
2037	EnGeo	2024-03-03 02:40:00	f	t
357	King	2024-03-03 02:50:00	t	t
101	Phys/Chem	2024-03-03 02:50:00	t	t
202	Phys/Chem	2024-03-03 02:50:00	f	t
358	King	2024-03-03 02:50:00	t	f
2020	EnGeo	2024-03-03 02:50:00	f	f
2037	EnGeo	2024-03-03 02:50:00	f	t
357	King	2024-03-03 03:00:00	t	t
101	Phys/Chem	2024-03-03 03:00:00	t	t
202	Phys/Chem	2024-03-03 03:00:00	f	t
358	King	2024-03-03 03:00:00	t	f
2020	EnGeo	2024-03-03 03:00:00	f	f
2037	EnGeo	2024-03-03 03:00:00	f	t
357	King	2024-03-03 03:10:00	t	t
101	Phys/Chem	2024-03-03 03:10:00	t	t
202	Phys/Chem	2024-03-03 03:10:00	f	t
358	King	2024-03-03 03:10:00	t	f
2020	EnGeo	2024-03-03 03:10:00	f	f
2037	EnGeo	2024-03-03 03:10:00	f	t
357	King	2024-03-03 03:20:00	t	t
101	Phys/Chem	2024-03-03 03:20:00	t	t
202	Phys/Chem	2024-03-03 03:20:00	f	t
358	King	2024-03-03 03:20:00	t	f
2020	EnGeo	2024-03-03 03:20:00	f	f
2037	EnGeo	2024-03-03 03:20:00	f	t
357	King	2024-03-03 03:30:00	t	t
101	Phys/Chem	2024-03-03 03:30:00	t	t
202	Phys/Chem	2024-03-03 03:30:00	f	t
358	King	2024-03-03 03:30:00	t	f
2020	EnGeo	2024-03-03 03:30:00	f	f
2037	EnGeo	2024-03-03 03:30:00	f	t
357	King	2024-03-03 03:40:00	t	t
101	Phys/Chem	2024-03-03 03:40:00	t	t
202	Phys/Chem	2024-03-03 03:40:00	f	t
358	King	2024-03-03 03:40:00	t	f
2020	EnGeo	2024-03-03 03:40:00	f	f
2037	EnGeo	2024-03-03 03:40:00	f	t
357	King	2024-03-03 03:50:00	t	t
101	Phys/Chem	2024-03-03 03:50:00	t	t
202	Phys/Chem	2024-03-03 03:50:00	f	t
358	King	2024-03-03 03:50:00	t	f
2020	EnGeo	2024-03-03 03:50:00	f	f
2037	EnGeo	2024-03-03 03:50:00	f	t
357	King	2024-03-03 04:00:00	t	t
101	Phys/Chem	2024-03-03 04:00:00	t	t
202	Phys/Chem	2024-03-03 04:00:00	f	t
358	King	2024-03-03 04:00:00	t	f
2020	EnGeo	2024-03-03 04:00:00	f	f
2037	EnGeo	2024-03-03 04:00:00	f	t
357	King	2024-03-03 04:10:00	t	t
101	Phys/Chem	2024-03-03 04:10:00	t	t
202	Phys/Chem	2024-03-03 04:10:00	f	t
358	King	2024-03-03 04:10:00	t	f
2020	EnGeo	2024-03-03 04:10:00	f	f
2037	EnGeo	2024-03-03 04:10:00	f	t
357	King	2024-03-03 04:20:00	t	t
101	Phys/Chem	2024-03-03 04:20:00	t	t
202	Phys/Chem	2024-03-03 04:20:00	f	t
358	King	2024-03-03 04:20:00	t	f
2020	EnGeo	2024-03-03 04:20:00	f	f
2037	EnGeo	2024-03-03 04:20:00	f	t
357	King	2024-03-03 04:30:00	t	t
101	Phys/Chem	2024-03-03 04:30:00	t	t
202	Phys/Chem	2024-03-03 04:30:00	f	t
358	King	2024-03-03 04:30:00	t	f
2020	EnGeo	2024-03-03 04:30:00	f	f
2037	EnGeo	2024-03-03 04:30:00	f	t
357	King	2024-03-03 04:40:00	t	t
101	Phys/Chem	2024-03-03 04:40:00	t	t
202	Phys/Chem	2024-03-03 04:40:00	f	t
358	King	2024-03-03 04:40:00	t	f
2020	EnGeo	2024-03-03 04:40:00	f	f
2037	EnGeo	2024-03-03 04:40:00	f	t
357	King	2024-03-03 04:50:00	t	t
101	Phys/Chem	2024-03-03 04:50:00	t	t
202	Phys/Chem	2024-03-03 04:50:00	f	t
358	King	2024-03-03 04:50:00	t	f
2020	EnGeo	2024-03-03 04:50:00	f	f
2037	EnGeo	2024-03-03 04:50:00	f	t
357	King	2024-03-03 05:00:00	t	t
101	Phys/Chem	2024-03-03 05:00:00	t	t
202	Phys/Chem	2024-03-03 05:00:00	f	t
358	King	2024-03-03 05:00:00	t	f
2020	EnGeo	2024-03-03 05:00:00	f	f
2037	EnGeo	2024-03-03 05:00:00	f	t
357	King	2024-03-03 05:10:00	t	t
101	Phys/Chem	2024-03-03 05:10:00	t	t
202	Phys/Chem	2024-03-03 05:10:00	f	t
358	King	2024-03-03 05:10:00	t	f
2020	EnGeo	2024-03-03 05:10:00	f	f
2037	EnGeo	2024-03-03 05:10:00	f	t
357	King	2024-03-03 05:20:00	t	t
101	Phys/Chem	2024-03-03 05:20:00	t	t
202	Phys/Chem	2024-03-03 05:20:00	f	t
358	King	2024-03-03 05:20:00	t	f
2020	EnGeo	2024-03-03 05:20:00	f	f
2037	EnGeo	2024-03-03 05:20:00	f	t
357	King	2024-03-03 05:30:00	t	t
101	Phys/Chem	2024-03-03 05:30:00	t	t
202	Phys/Chem	2024-03-03 05:30:00	f	t
358	King	2024-03-03 05:30:00	t	f
2020	EnGeo	2024-03-03 05:30:00	f	f
2037	EnGeo	2024-03-03 05:30:00	f	t
357	King	2024-03-03 05:40:00	t	t
101	Phys/Chem	2024-03-03 05:40:00	t	t
202	Phys/Chem	2024-03-03 05:40:00	f	t
358	King	2024-03-03 05:40:00	t	f
2020	EnGeo	2024-03-03 05:40:00	f	f
2037	EnGeo	2024-03-03 05:40:00	f	t
357	King	2024-03-03 05:50:00	t	t
101	Phys/Chem	2024-03-03 05:50:00	t	t
202	Phys/Chem	2024-03-03 05:50:00	f	t
358	King	2024-03-03 05:50:00	t	f
2020	EnGeo	2024-03-03 05:50:00	f	f
2037	EnGeo	2024-03-03 05:50:00	f	t
357	King	2024-03-03 06:00:00	t	t
101	Phys/Chem	2024-03-03 06:00:00	t	t
202	Phys/Chem	2024-03-03 06:00:00	f	t
358	King	2024-03-03 06:00:00	t	f
2020	EnGeo	2024-03-03 06:00:00	f	f
2037	EnGeo	2024-03-03 06:00:00	f	t
357	King	2024-03-03 06:10:00	t	t
101	Phys/Chem	2024-03-03 06:10:00	t	t
202	Phys/Chem	2024-03-03 06:10:00	f	t
358	King	2024-03-03 06:10:00	t	f
2020	EnGeo	2024-03-03 06:10:00	f	f
2037	EnGeo	2024-03-03 06:10:00	f	t
357	King	2024-03-03 06:20:00	t	t
101	Phys/Chem	2024-03-03 06:20:00	t	t
202	Phys/Chem	2024-03-03 06:20:00	f	t
358	King	2024-03-03 06:20:00	t	f
2020	EnGeo	2024-03-03 06:20:00	f	f
2037	EnGeo	2024-03-03 06:20:00	f	t
357	King	2024-03-03 06:30:00	t	t
101	Phys/Chem	2024-03-03 06:30:00	t	t
202	Phys/Chem	2024-03-03 06:30:00	f	t
358	King	2024-03-03 06:30:00	t	f
2020	EnGeo	2024-03-03 06:30:00	f	f
2037	EnGeo	2024-03-03 06:30:00	f	t
357	King	2024-03-03 06:40:00	t	t
101	Phys/Chem	2024-03-03 06:40:00	t	t
202	Phys/Chem	2024-03-03 06:40:00	f	t
358	King	2024-03-03 06:40:00	t	f
2020	EnGeo	2024-03-03 06:40:00	f	f
2037	EnGeo	2024-03-03 06:40:00	f	t
357	King	2024-03-03 06:50:00	t	t
101	Phys/Chem	2024-03-03 06:50:00	t	t
202	Phys/Chem	2024-03-03 06:50:00	f	t
358	King	2024-03-03 06:50:00	t	f
2020	EnGeo	2024-03-03 06:50:00	f	f
2037	EnGeo	2024-03-03 06:50:00	f	t
357	King	2024-03-03 07:00:00	t	t
101	Phys/Chem	2024-03-03 07:00:00	t	t
202	Phys/Chem	2024-03-03 07:00:00	f	t
358	King	2024-03-03 07:00:00	t	f
2020	EnGeo	2024-03-03 07:00:00	f	f
2037	EnGeo	2024-03-03 07:00:00	f	t
357	King	2024-03-03 07:10:00	t	t
101	Phys/Chem	2024-03-03 07:10:00	t	t
202	Phys/Chem	2024-03-03 07:10:00	f	t
358	King	2024-03-03 07:10:00	t	f
2020	EnGeo	2024-03-03 07:10:00	f	f
2037	EnGeo	2024-03-03 07:10:00	f	t
357	King	2024-03-03 07:20:00	t	t
101	Phys/Chem	2024-03-03 07:20:00	t	t
202	Phys/Chem	2024-03-03 07:20:00	f	t
358	King	2024-03-03 07:20:00	t	f
2020	EnGeo	2024-03-03 07:20:00	f	f
2037	EnGeo	2024-03-03 07:20:00	f	t
357	King	2024-03-03 07:30:00	t	t
101	Phys/Chem	2024-03-03 07:30:00	t	t
202	Phys/Chem	2024-03-03 07:30:00	f	t
358	King	2024-03-03 07:30:00	t	f
2020	EnGeo	2024-03-03 07:30:00	f	f
2037	EnGeo	2024-03-03 07:30:00	f	t
357	King	2024-03-03 07:40:00	t	t
101	Phys/Chem	2024-03-03 07:40:00	t	t
202	Phys/Chem	2024-03-03 07:40:00	f	t
358	King	2024-03-03 07:40:00	t	f
2020	EnGeo	2024-03-03 07:40:00	f	f
2037	EnGeo	2024-03-03 07:40:00	f	t
357	King	2024-03-03 07:50:00	t	t
101	Phys/Chem	2024-03-03 07:50:00	t	t
202	Phys/Chem	2024-03-03 07:50:00	f	t
358	King	2024-03-03 07:50:00	t	f
2020	EnGeo	2024-03-03 07:50:00	f	f
2037	EnGeo	2024-03-03 07:50:00	f	t
357	King	2024-03-03 08:00:00	t	t
101	Phys/Chem	2024-03-03 08:00:00	t	t
202	Phys/Chem	2024-03-03 08:00:00	f	t
358	King	2024-03-03 08:00:00	t	f
2020	EnGeo	2024-03-03 08:00:00	f	f
2037	EnGeo	2024-03-03 08:00:00	f	t
357	King	2024-03-03 08:10:00	t	t
101	Phys/Chem	2024-03-03 08:10:00	t	t
202	Phys/Chem	2024-03-03 08:10:00	f	t
358	King	2024-03-03 08:10:00	t	f
2020	EnGeo	2024-03-03 08:10:00	f	f
2037	EnGeo	2024-03-03 08:10:00	f	t
357	King	2024-03-03 08:20:00	t	t
101	Phys/Chem	2024-03-03 08:20:00	t	t
202	Phys/Chem	2024-03-03 08:20:00	f	t
358	King	2024-03-03 08:20:00	t	f
2020	EnGeo	2024-03-03 08:20:00	f	f
2037	EnGeo	2024-03-03 08:20:00	f	t
357	King	2024-03-03 08:30:00	t	t
101	Phys/Chem	2024-03-03 08:30:00	t	t
202	Phys/Chem	2024-03-03 08:30:00	f	t
358	King	2024-03-03 08:30:00	t	f
2020	EnGeo	2024-03-03 08:30:00	f	f
2037	EnGeo	2024-03-03 08:30:00	f	t
357	King	2024-03-03 08:40:00	t	t
101	Phys/Chem	2024-03-03 08:40:00	t	t
202	Phys/Chem	2024-03-03 08:40:00	f	t
358	King	2024-03-03 08:40:00	t	f
2020	EnGeo	2024-03-03 08:40:00	f	f
2037	EnGeo	2024-03-03 08:40:00	f	t
357	King	2024-03-03 08:50:00	t	t
101	Phys/Chem	2024-03-03 08:50:00	t	t
202	Phys/Chem	2024-03-03 08:50:00	f	t
358	King	2024-03-03 08:50:00	t	f
2020	EnGeo	2024-03-03 08:50:00	f	f
2037	EnGeo	2024-03-03 08:50:00	f	t
357	King	2024-03-03 09:00:00	t	t
101	Phys/Chem	2024-03-03 09:00:00	t	t
202	Phys/Chem	2024-03-03 09:00:00	f	t
358	King	2024-03-03 09:00:00	t	f
2020	EnGeo	2024-03-03 09:00:00	f	f
2037	EnGeo	2024-03-03 09:00:00	f	t
357	King	2024-03-03 09:10:00	t	t
101	Phys/Chem	2024-03-03 09:10:00	t	t
202	Phys/Chem	2024-03-03 09:10:00	f	t
358	King	2024-03-03 09:10:00	t	f
2020	EnGeo	2024-03-03 09:10:00	f	f
2037	EnGeo	2024-03-03 09:10:00	f	t
357	King	2024-03-03 09:20:00	t	t
101	Phys/Chem	2024-03-03 09:20:00	t	t
202	Phys/Chem	2024-03-03 09:20:00	f	t
358	King	2024-03-03 09:20:00	t	f
2020	EnGeo	2024-03-03 09:20:00	f	f
2037	EnGeo	2024-03-03 09:20:00	f	t
357	King	2024-03-03 09:30:00	t	t
101	Phys/Chem	2024-03-03 09:30:00	t	t
202	Phys/Chem	2024-03-03 09:30:00	f	t
358	King	2024-03-03 09:30:00	t	f
2020	EnGeo	2024-03-03 09:30:00	f	f
2037	EnGeo	2024-03-03 09:30:00	f	t
357	King	2024-03-03 09:40:00	t	t
101	Phys/Chem	2024-03-03 09:40:00	t	t
202	Phys/Chem	2024-03-03 09:40:00	f	t
358	King	2024-03-03 09:40:00	t	f
2020	EnGeo	2024-03-03 09:40:00	f	f
2037	EnGeo	2024-03-03 09:40:00	f	t
357	King	2024-03-03 09:50:00	t	t
101	Phys/Chem	2024-03-03 09:50:00	t	t
202	Phys/Chem	2024-03-03 09:50:00	f	t
358	King	2024-03-03 09:50:00	t	f
2020	EnGeo	2024-03-03 09:50:00	f	f
2037	EnGeo	2024-03-03 09:50:00	f	t
357	King	2024-03-03 10:00:00	t	t
101	Phys/Chem	2024-03-03 10:00:00	t	t
202	Phys/Chem	2024-03-03 10:00:00	f	t
358	King	2024-03-03 10:00:00	t	f
2020	EnGeo	2024-03-03 10:00:00	f	f
2037	EnGeo	2024-03-03 10:00:00	f	t
357	King	2024-03-03 10:10:00	t	t
101	Phys/Chem	2024-03-03 10:10:00	t	t
202	Phys/Chem	2024-03-03 10:10:00	f	t
358	King	2024-03-03 10:10:00	t	f
2020	EnGeo	2024-03-03 10:10:00	f	f
2037	EnGeo	2024-03-03 10:10:00	f	t
357	King	2024-03-03 10:20:00	t	t
101	Phys/Chem	2024-03-03 10:20:00	t	t
202	Phys/Chem	2024-03-03 10:20:00	f	t
358	King	2024-03-03 10:20:00	t	f
2020	EnGeo	2024-03-03 10:20:00	f	f
2037	EnGeo	2024-03-03 10:20:00	f	t
357	King	2024-03-03 10:30:00	t	t
101	Phys/Chem	2024-03-03 10:30:00	t	t
202	Phys/Chem	2024-03-03 10:30:00	f	t
358	King	2024-03-03 10:30:00	t	f
2020	EnGeo	2024-03-03 10:30:00	f	f
2037	EnGeo	2024-03-03 10:30:00	f	t
357	King	2024-03-03 10:40:00	t	t
101	Phys/Chem	2024-03-03 10:40:00	t	t
202	Phys/Chem	2024-03-03 10:40:00	f	t
358	King	2024-03-03 10:40:00	t	f
2020	EnGeo	2024-03-03 10:40:00	f	f
2037	EnGeo	2024-03-03 10:40:00	f	t
357	King	2024-03-03 10:50:00	t	t
101	Phys/Chem	2024-03-03 10:50:00	t	t
202	Phys/Chem	2024-03-03 10:50:00	f	t
358	King	2024-03-03 10:50:00	t	f
2020	EnGeo	2024-03-03 10:50:00	f	f
2037	EnGeo	2024-03-03 10:50:00	f	t
357	King	2024-03-03 11:00:00	t	t
101	Phys/Chem	2024-03-03 11:00:00	t	t
202	Phys/Chem	2024-03-03 11:00:00	f	t
358	King	2024-03-03 11:00:00	t	f
2020	EnGeo	2024-03-03 11:00:00	f	f
2037	EnGeo	2024-03-03 11:00:00	f	t
357	King	2024-03-03 11:10:00	t	t
101	Phys/Chem	2024-03-03 11:10:00	t	t
202	Phys/Chem	2024-03-03 11:10:00	f	t
358	King	2024-03-03 11:10:00	t	f
2020	EnGeo	2024-03-03 11:10:00	f	f
2037	EnGeo	2024-03-03 11:10:00	f	t
357	King	2024-03-03 11:20:00	t	t
101	Phys/Chem	2024-03-03 11:20:00	t	t
202	Phys/Chem	2024-03-03 11:20:00	f	t
358	King	2024-03-03 11:20:00	t	f
2020	EnGeo	2024-03-03 11:20:00	f	f
2037	EnGeo	2024-03-03 11:20:00	f	t
357	King	2024-03-03 11:30:00	t	t
101	Phys/Chem	2024-03-03 11:30:00	t	t
202	Phys/Chem	2024-03-03 11:30:00	f	t
358	King	2024-03-03 11:30:00	t	f
2020	EnGeo	2024-03-03 11:30:00	f	f
2037	EnGeo	2024-03-03 11:30:00	f	t
357	King	2024-03-03 11:40:00	t	t
101	Phys/Chem	2024-03-03 11:40:00	t	t
202	Phys/Chem	2024-03-03 11:40:00	f	t
358	King	2024-03-03 11:40:00	t	f
2020	EnGeo	2024-03-03 11:40:00	f	f
2037	EnGeo	2024-03-03 11:40:00	f	t
357	King	2024-03-03 11:50:00	t	t
101	Phys/Chem	2024-03-03 11:50:00	t	t
202	Phys/Chem	2024-03-03 11:50:00	f	t
358	King	2024-03-03 11:50:00	t	f
2020	EnGeo	2024-03-03 11:50:00	f	f
2037	EnGeo	2024-03-03 11:50:00	f	t
357	King	2024-03-03 12:00:00	t	t
101	Phys/Chem	2024-03-03 12:00:00	t	t
202	Phys/Chem	2024-03-03 12:00:00	f	t
358	King	2024-03-03 12:00:00	t	f
2020	EnGeo	2024-03-03 12:00:00	f	f
2037	EnGeo	2024-03-03 12:00:00	f	t
357	King	2024-03-03 12:10:00	t	t
101	Phys/Chem	2024-03-03 12:10:00	t	t
202	Phys/Chem	2024-03-03 12:10:00	f	t
358	King	2024-03-03 12:10:00	t	f
2020	EnGeo	2024-03-03 12:10:00	f	f
2037	EnGeo	2024-03-03 12:10:00	f	t
357	King	2024-03-03 12:20:00	t	t
101	Phys/Chem	2024-03-03 12:20:00	t	t
202	Phys/Chem	2024-03-03 12:20:00	f	t
358	King	2024-03-03 12:20:00	t	f
2020	EnGeo	2024-03-03 12:20:00	f	f
2037	EnGeo	2024-03-03 12:20:00	f	t
357	King	2024-03-03 12:30:00	t	t
101	Phys/Chem	2024-03-03 12:30:00	t	t
202	Phys/Chem	2024-03-03 12:30:00	f	t
358	King	2024-03-03 12:30:00	t	f
2020	EnGeo	2024-03-03 12:30:00	f	f
2037	EnGeo	2024-03-03 12:30:00	f	t
357	King	2024-03-03 12:40:00	t	t
101	Phys/Chem	2024-03-03 12:40:00	t	t
202	Phys/Chem	2024-03-03 12:40:00	f	t
358	King	2024-03-03 12:40:00	t	f
2020	EnGeo	2024-03-03 12:40:00	f	f
2037	EnGeo	2024-03-03 12:40:00	f	t
357	King	2024-03-03 12:50:00	t	t
101	Phys/Chem	2024-03-03 12:50:00	t	t
202	Phys/Chem	2024-03-03 12:50:00	f	t
358	King	2024-03-03 12:50:00	t	f
2020	EnGeo	2024-03-03 12:50:00	f	f
2037	EnGeo	2024-03-03 12:50:00	f	t
357	King	2024-03-03 13:00:00	t	t
101	Phys/Chem	2024-03-03 13:00:00	t	t
202	Phys/Chem	2024-03-03 13:00:00	f	t
358	King	2024-03-03 13:00:00	t	f
2020	EnGeo	2024-03-03 13:00:00	f	f
2037	EnGeo	2024-03-03 13:00:00	f	t
357	King	2024-03-03 13:10:00	t	t
101	Phys/Chem	2024-03-03 13:10:00	t	t
202	Phys/Chem	2024-03-03 13:10:00	f	t
358	King	2024-03-03 13:10:00	t	f
2020	EnGeo	2024-03-03 13:10:00	f	f
2037	EnGeo	2024-03-03 13:10:00	f	t
357	King	2024-03-03 13:20:00	t	t
101	Phys/Chem	2024-03-03 13:20:00	t	t
202	Phys/Chem	2024-03-03 13:20:00	f	t
358	King	2024-03-03 13:20:00	t	f
2020	EnGeo	2024-03-03 13:20:00	f	f
2037	EnGeo	2024-03-03 13:20:00	f	t
357	King	2024-03-03 13:30:00	t	t
101	Phys/Chem	2024-03-03 13:30:00	t	t
202	Phys/Chem	2024-03-03 13:30:00	f	t
358	King	2024-03-03 13:30:00	t	f
2020	EnGeo	2024-03-03 13:30:00	f	f
2037	EnGeo	2024-03-03 13:30:00	f	t
357	King	2024-03-03 13:40:00	t	t
101	Phys/Chem	2024-03-03 13:40:00	t	t
202	Phys/Chem	2024-03-03 13:40:00	f	t
358	King	2024-03-03 13:40:00	t	f
2020	EnGeo	2024-03-03 13:40:00	f	f
2037	EnGeo	2024-03-03 13:40:00	f	t
357	King	2024-03-03 13:50:00	t	t
101	Phys/Chem	2024-03-03 13:50:00	t	t
202	Phys/Chem	2024-03-03 13:50:00	f	t
358	King	2024-03-03 13:50:00	t	f
2020	EnGeo	2024-03-03 13:50:00	f	f
2037	EnGeo	2024-03-03 13:50:00	f	t
357	King	2024-03-03 14:00:00	t	t
101	Phys/Chem	2024-03-03 14:00:00	t	t
202	Phys/Chem	2024-03-03 14:00:00	f	t
358	King	2024-03-03 14:00:00	t	f
2020	EnGeo	2024-03-03 14:00:00	f	f
2037	EnGeo	2024-03-03 14:00:00	f	t
357	King	2024-03-03 14:10:00	t	t
101	Phys/Chem	2024-03-03 14:10:00	t	t
202	Phys/Chem	2024-03-03 14:10:00	f	t
358	King	2024-03-03 14:10:00	t	f
2020	EnGeo	2024-03-03 14:10:00	f	f
2037	EnGeo	2024-03-03 14:10:00	f	t
357	King	2024-03-03 14:20:00	t	t
101	Phys/Chem	2024-03-03 14:20:00	t	t
202	Phys/Chem	2024-03-03 14:20:00	f	t
358	King	2024-03-03 14:20:00	t	f
2020	EnGeo	2024-03-03 14:20:00	f	f
2037	EnGeo	2024-03-03 14:20:00	f	t
357	King	2024-03-03 14:30:00	t	t
101	Phys/Chem	2024-03-03 14:30:00	t	t
202	Phys/Chem	2024-03-03 14:30:00	f	t
358	King	2024-03-03 14:30:00	t	f
2020	EnGeo	2024-03-03 14:30:00	f	f
2037	EnGeo	2024-03-03 14:30:00	f	t
357	King	2024-03-03 14:40:00	t	t
101	Phys/Chem	2024-03-03 14:40:00	t	t
202	Phys/Chem	2024-03-03 14:40:00	f	t
358	King	2024-03-03 14:40:00	t	f
2020	EnGeo	2024-03-03 14:40:00	f	f
2037	EnGeo	2024-03-03 14:40:00	f	t
357	King	2024-03-03 14:50:00	t	t
101	Phys/Chem	2024-03-03 14:50:00	t	t
202	Phys/Chem	2024-03-03 14:50:00	f	t
358	King	2024-03-03 14:50:00	t	f
2020	EnGeo	2024-03-03 14:50:00	f	f
2037	EnGeo	2024-03-03 14:50:00	f	t
357	King	2024-03-03 15:00:00	t	t
101	Phys/Chem	2024-03-03 15:00:00	t	t
202	Phys/Chem	2024-03-03 15:00:00	f	t
358	King	2024-03-03 15:00:00	t	f
2020	EnGeo	2024-03-03 15:00:00	f	f
2037	EnGeo	2024-03-03 15:00:00	f	t
357	King	2024-03-03 15:10:00	t	t
101	Phys/Chem	2024-03-03 15:10:00	t	t
202	Phys/Chem	2024-03-03 15:10:00	f	t
358	King	2024-03-03 15:10:00	t	f
2020	EnGeo	2024-03-03 15:10:00	f	f
2037	EnGeo	2024-03-03 15:10:00	f	t
357	King	2024-03-03 15:20:00	t	t
101	Phys/Chem	2024-03-03 15:20:00	t	t
202	Phys/Chem	2024-03-03 15:20:00	f	t
358	King	2024-03-03 15:20:00	t	f
2020	EnGeo	2024-03-03 15:20:00	f	f
2037	EnGeo	2024-03-03 15:20:00	f	t
357	King	2024-03-03 15:30:00	t	t
101	Phys/Chem	2024-03-03 15:30:00	t	t
202	Phys/Chem	2024-03-03 15:30:00	f	t
358	King	2024-03-03 15:30:00	t	f
2020	EnGeo	2024-03-03 15:30:00	f	f
2037	EnGeo	2024-03-03 15:30:00	f	t
357	King	2024-03-03 15:40:00	t	t
101	Phys/Chem	2024-03-03 15:40:00	t	t
202	Phys/Chem	2024-03-03 15:40:00	f	t
358	King	2024-03-03 15:40:00	t	f
2020	EnGeo	2024-03-03 15:40:00	f	f
2037	EnGeo	2024-03-03 15:40:00	f	t
357	King	2024-03-03 15:50:00	t	t
101	Phys/Chem	2024-03-03 15:50:00	t	t
202	Phys/Chem	2024-03-03 15:50:00	f	t
358	King	2024-03-03 15:50:00	t	f
2020	EnGeo	2024-03-03 15:50:00	f	f
2037	EnGeo	2024-03-03 15:50:00	f	t
357	King	2024-03-03 16:00:00	t	t
101	Phys/Chem	2024-03-03 16:00:00	t	t
202	Phys/Chem	2024-03-03 16:00:00	f	t
358	King	2024-03-03 16:00:00	t	f
2020	EnGeo	2024-03-03 16:00:00	f	f
2037	EnGeo	2024-03-03 16:00:00	f	t
357	King	2024-03-03 16:10:00	t	t
101	Phys/Chem	2024-03-03 16:10:00	t	t
202	Phys/Chem	2024-03-03 16:10:00	f	t
358	King	2024-03-03 16:10:00	t	f
2020	EnGeo	2024-03-03 16:10:00	f	f
2037	EnGeo	2024-03-03 16:10:00	f	t
357	King	2024-03-03 16:20:00	t	t
101	Phys/Chem	2024-03-03 16:20:00	t	t
202	Phys/Chem	2024-03-03 16:20:00	f	t
358	King	2024-03-03 16:20:00	t	f
2020	EnGeo	2024-03-03 16:20:00	f	f
2037	EnGeo	2024-03-03 16:20:00	f	t
357	King	2024-03-03 16:30:00	t	t
101	Phys/Chem	2024-03-03 16:30:00	t	t
202	Phys/Chem	2024-03-03 16:30:00	f	t
358	King	2024-03-03 16:30:00	t	f
2020	EnGeo	2024-03-03 16:30:00	f	f
2037	EnGeo	2024-03-03 16:30:00	f	t
357	King	2024-03-03 16:40:00	t	t
101	Phys/Chem	2024-03-03 16:40:00	t	t
202	Phys/Chem	2024-03-03 16:40:00	f	t
358	King	2024-03-03 16:40:00	t	f
2020	EnGeo	2024-03-03 16:40:00	f	f
2037	EnGeo	2024-03-03 16:40:00	f	t
357	King	2024-03-03 16:50:00	t	t
101	Phys/Chem	2024-03-03 16:50:00	t	t
202	Phys/Chem	2024-03-03 16:50:00	f	t
358	King	2024-03-03 16:50:00	t	f
2020	EnGeo	2024-03-03 16:50:00	f	f
2037	EnGeo	2024-03-03 16:50:00	f	t
357	King	2024-03-03 17:00:00	t	t
101	Phys/Chem	2024-03-03 17:00:00	t	t
202	Phys/Chem	2024-03-03 17:00:00	f	t
358	King	2024-03-03 17:00:00	t	f
2020	EnGeo	2024-03-03 17:00:00	f	f
2037	EnGeo	2024-03-03 17:00:00	f	t
357	King	2024-03-03 17:10:00	t	t
101	Phys/Chem	2024-03-03 17:10:00	t	t
202	Phys/Chem	2024-03-03 17:10:00	f	t
358	King	2024-03-03 17:10:00	t	f
2020	EnGeo	2024-03-03 17:10:00	f	f
2037	EnGeo	2024-03-03 17:10:00	f	t
357	King	2024-03-03 17:20:00	t	t
101	Phys/Chem	2024-03-03 17:20:00	t	t
202	Phys/Chem	2024-03-03 17:20:00	f	t
358	King	2024-03-03 17:20:00	t	f
2020	EnGeo	2024-03-03 17:20:00	f	f
2037	EnGeo	2024-03-03 17:20:00	f	t
357	King	2024-03-03 17:30:00	t	t
101	Phys/Chem	2024-03-03 17:30:00	t	t
202	Phys/Chem	2024-03-03 17:30:00	f	t
358	King	2024-03-03 17:30:00	t	f
2020	EnGeo	2024-03-03 17:30:00	f	f
2037	EnGeo	2024-03-03 17:30:00	f	t
357	King	2024-03-03 17:40:00	t	t
101	Phys/Chem	2024-03-03 17:40:00	t	t
202	Phys/Chem	2024-03-03 17:40:00	f	t
358	King	2024-03-03 17:40:00	t	f
2020	EnGeo	2024-03-03 17:40:00	f	f
2037	EnGeo	2024-03-03 17:40:00	f	t
357	King	2024-03-03 17:50:00	t	t
101	Phys/Chem	2024-03-03 17:50:00	t	t
202	Phys/Chem	2024-03-03 17:50:00	f	t
358	King	2024-03-03 17:50:00	t	f
2020	EnGeo	2024-03-03 17:50:00	f	f
2037	EnGeo	2024-03-03 17:50:00	f	t
357	King	2024-03-03 18:00:00	t	t
101	Phys/Chem	2024-03-03 18:00:00	t	t
202	Phys/Chem	2024-03-03 18:00:00	f	t
358	King	2024-03-03 18:00:00	t	f
2020	EnGeo	2024-03-03 18:00:00	f	f
2037	EnGeo	2024-03-03 18:00:00	f	t
357	King	2024-03-03 18:10:00	t	t
101	Phys/Chem	2024-03-03 18:10:00	t	t
202	Phys/Chem	2024-03-03 18:10:00	f	t
358	King	2024-03-03 18:10:00	t	f
2020	EnGeo	2024-03-03 18:10:00	f	f
2037	EnGeo	2024-03-03 18:10:00	f	t
357	King	2024-03-03 18:20:00	t	t
101	Phys/Chem	2024-03-03 18:20:00	t	t
202	Phys/Chem	2024-03-03 18:20:00	f	t
358	King	2024-03-03 18:20:00	t	f
2020	EnGeo	2024-03-03 18:20:00	f	f
2037	EnGeo	2024-03-03 18:20:00	f	t
357	King	2024-03-03 18:30:00	t	t
101	Phys/Chem	2024-03-03 18:30:00	t	t
202	Phys/Chem	2024-03-03 18:30:00	f	t
358	King	2024-03-03 18:30:00	t	f
2020	EnGeo	2024-03-03 18:30:00	t	f
2037	EnGeo	2024-03-03 18:30:00	t	t
101	Phys/Chem	2024-03-03 18:40:00	t	t
202	Phys/Chem	2024-03-03 18:40:00	f	t
358	King	2024-03-03 18:40:00	t	f
2037	EnGeo	2024-03-03 18:40:00	f	t
2020	EnGeo	2024-03-03 18:40:00	t	f
357	King	2024-03-03 18:40:00	f	t
101	Phys/Chem	2024-03-03 18:50:00	t	t
202	Phys/Chem	2024-03-03 18:50:00	f	t
2020	EnGeo	2024-03-03 18:50:00	t	f
2037	EnGeo	2024-03-03 18:50:00	t	t
358	King	2024-03-03 18:50:00	f	f
357	King	2024-03-03 18:50:00	f	t
202	Phys/Chem	2024-03-03 19:00:00	f	t
357	King	2024-03-03 19:00:00	f	t
2020	EnGeo	2024-03-03 19:00:00	f	f
2037	EnGeo	2024-03-03 19:00:00	t	t
101	Phys/Chem	2024-03-03 19:00:00	t	t
358	King	2024-03-03 19:00:00	t	f
357	King	2024-03-03 19:10:00	f	t
358	King	2024-03-03 19:10:00	t	f
2020	EnGeo	2024-03-03 19:10:00	f	t
2037	EnGeo	2024-03-03 19:10:00	t	f
101	Phys/Chem	2024-03-03 19:10:00	t	f
202	Phys/Chem	2024-03-03 19:10:00	f	t
357	King	2024-03-03 19:20:00	f	t
358	King	2024-03-03 19:20:00	t	f
2020	EnGeo	2024-03-03 19:20:00	f	t
2037	EnGeo	2024-03-03 19:20:00	t	f
202	Phys/Chem	2024-03-03 19:20:00	f	t
101	Phys/Chem	2024-03-03 19:20:00	t	f
357	King	2024-03-03 19:30:00	f	t
358	King	2024-03-03 19:30:00	t	f
2020	EnGeo	2024-03-03 19:30:00	f	t
2037	EnGeo	2024-03-03 19:30:00	t	f
202	Phys/Chem	2024-03-03 19:30:00	f	t
101	Phys/Chem	2024-03-03 19:30:00	t	f
101	Phys/Chem	2024-03-03 19:40:00	f	t
202	Phys/Chem	2024-03-03 19:40:00	f	f
2020	EnGeo	2024-03-03 19:40:00	t	f
2037	EnGeo	2024-03-03 19:40:00	f	t
357	King	2024-03-03 19:40:00	t	f
358	King	2024-03-03 19:40:00	f	f
101	Phys/Chem	2024-03-03 19:50:00	f	t
202	Phys/Chem	2024-03-03 19:50:00	f	f
2020	EnGeo	2024-03-03 19:50:00	t	f
2037	EnGeo	2024-03-03 19:50:00	f	t
357	King	2024-03-03 19:50:00	t	f
358	King	2024-03-03 19:50:00	f	f
101	Phys/Chem	2024-03-03 20:00:00	f	t
202	Phys/Chem	2024-03-03 20:00:00	f	f
2020	EnGeo	2024-03-03 20:00:00	t	f
2037	EnGeo	2024-03-03 20:00:00	f	t
357	King	2024-03-03 20:00:00	t	f
358	King	2024-03-03 20:00:00	f	f
101	Phys/Chem	2024-03-03 20:10:00	f	t
202	Phys/Chem	2024-03-03 20:10:00	f	f
2020	EnGeo	2024-03-03 20:10:00	t	f
2037	EnGeo	2024-03-03 20:10:00	f	t
357	King	2024-03-03 20:10:00	t	f
358	King	2024-03-03 20:10:00	f	f
101	Phys/Chem	2024-03-03 20:20:00	f	t
202	Phys/Chem	2024-03-03 20:20:00	f	f
2020	EnGeo	2024-03-03 20:20:00	t	f
2037	EnGeo	2024-03-03 20:20:00	f	t
357	King	2024-03-03 20:20:00	t	f
358	King	2024-03-03 20:20:00	f	f
101	Phys/Chem	2024-03-03 20:30:00	f	t
202	Phys/Chem	2024-03-03 20:30:00	f	f
2020	EnGeo	2024-03-03 20:30:00	t	f
2037	EnGeo	2024-03-03 20:30:00	f	t
357	King	2024-03-03 20:30:00	t	f
358	King	2024-03-03 20:30:00	f	f
101	Phys/Chem	2024-03-03 20:40:00	f	t
202	Phys/Chem	2024-03-03 20:40:00	f	f
2020	EnGeo	2024-03-03 20:40:00	t	f
2037	EnGeo	2024-03-03 20:40:00	f	t
357	King	2024-03-03 20:40:00	t	f
358	King	2024-03-03 20:40:00	f	f
101	Phys/Chem	2024-03-03 20:50:00	f	t
202	Phys/Chem	2024-03-03 20:50:00	f	f
2020	EnGeo	2024-03-03 20:50:00	t	f
2037	EnGeo	2024-03-03 20:50:00	f	t
357	King	2024-03-03 20:50:00	t	f
358	King	2024-03-03 20:50:00	f	f
101	Phys/Chem	2024-03-03 21:00:00	f	t
202	Phys/Chem	2024-03-03 21:00:00	f	f
2020	EnGeo	2024-03-03 21:00:00	t	f
2037	EnGeo	2024-03-03 21:00:00	f	t
357	King	2024-03-03 21:00:00	t	f
358	King	2024-03-03 21:00:00	f	f
101	Phys/Chem	2024-03-03 21:10:00	f	t
202	Phys/Chem	2024-03-03 21:10:00	f	f
2020	EnGeo	2024-03-03 21:10:00	t	f
2037	EnGeo	2024-03-03 21:10:00	f	t
357	King	2024-03-03 21:10:00	t	f
358	King	2024-03-03 21:10:00	f	f
101	Phys/Chem	2024-03-03 21:20:00	f	t
202	Phys/Chem	2024-03-03 21:20:00	f	f
2037	EnGeo	2024-03-03 21:20:00	f	t
358	King	2024-03-03 21:20:00	f	f
2020	EnGeo	2024-03-03 21:20:00	t	t
357	King	2024-03-03 21:20:00	t	t
101	Phys/Chem	2024-03-03 21:30:00	f	t
202	Phys/Chem	2024-03-03 21:30:00	f	f
2037	EnGeo	2024-03-03 21:30:00	f	t
358	King	2024-03-03 21:30:00	f	f
2020	EnGeo	2024-03-03 21:30:00	t	t
357	King	2024-03-03 21:30:00	t	t
101	Phys/Chem	2024-03-03 21:40:00	f	t
202	Phys/Chem	2024-03-03 21:40:00	f	f
2037	EnGeo	2024-03-03 21:40:00	f	t
358	King	2024-03-03 21:40:00	f	f
357	King	2024-03-03 21:40:00	t	t
2020	EnGeo	2024-03-03 21:40:00	f	t
101	Phys/Chem	2024-03-03 21:50:00	f	t
202	Phys/Chem	2024-03-03 21:50:00	f	f
2037	EnGeo	2024-03-03 21:50:00	f	t
358	King	2024-03-03 21:50:00	f	f
357	King	2024-03-03 21:50:00	t	t
2020	EnGeo	2024-03-03 21:50:00	f	t
101	Phys/Chem	2024-03-03 22:00:00	f	t
202	Phys/Chem	2024-03-03 22:00:00	f	f
2037	EnGeo	2024-03-03 22:00:00	f	t
358	King	2024-03-03 22:00:00	f	f
357	King	2024-03-03 22:00:00	t	t
2020	EnGeo	2024-03-03 22:00:00	f	t
101	Phys/Chem	2024-03-03 22:10:00	f	t
202	Phys/Chem	2024-03-03 22:10:00	f	f
2037	EnGeo	2024-03-03 22:10:00	f	t
358	King	2024-03-03 22:10:00	f	f
357	King	2024-03-03 22:10:00	t	t
2020	EnGeo	2024-03-03 22:10:00	f	t
101	Phys/Chem	2024-03-03 22:20:00	f	t
202	Phys/Chem	2024-03-03 22:20:00	f	f
2037	EnGeo	2024-03-03 22:20:00	f	t
358	King	2024-03-03 22:20:00	f	f
357	King	2024-03-03 22:20:00	t	t
2020	EnGeo	2024-03-03 22:20:00	f	t
101	Phys/Chem	2024-03-03 22:30:00	f	t
202	Phys/Chem	2024-03-03 22:30:00	f	f
2037	EnGeo	2024-03-03 22:30:00	f	t
358	King	2024-03-03 22:30:00	f	f
357	King	2024-03-03 22:30:00	t	t
2020	EnGeo	2024-03-03 22:30:00	f	t
101	Phys/Chem	2024-03-03 22:40:00	f	t
202	Phys/Chem	2024-03-03 22:40:00	f	f
2037	EnGeo	2024-03-03 22:40:00	f	t
358	King	2024-03-03 22:40:00	f	f
357	King	2024-03-03 22:40:00	t	t
2020	EnGeo	2024-03-03 22:40:00	f	t
101	Phys/Chem	2024-03-03 22:50:00	f	t
202	Phys/Chem	2024-03-03 22:50:00	f	f
2037	EnGeo	2024-03-03 22:50:00	f	t
358	King	2024-03-03 22:50:00	f	f
357	King	2024-03-03 22:50:00	t	t
2020	EnGeo	2024-03-03 22:50:00	f	t
101	Phys/Chem	2024-03-03 23:00:00	f	t
202	Phys/Chem	2024-03-03 23:00:00	f	f
2037	EnGeo	2024-03-03 23:00:00	f	t
358	King	2024-03-03 23:00:00	f	f
357	King	2024-03-03 23:00:00	t	t
2020	EnGeo	2024-03-03 23:00:00	f	t
101	Phys/Chem	2024-03-03 23:10:00	f	t
202	Phys/Chem	2024-03-03 23:10:00	f	f
2037	EnGeo	2024-03-03 23:10:00	f	t
358	King	2024-03-03 23:10:00	f	f
357	King	2024-03-03 23:10:00	t	t
2020	EnGeo	2024-03-03 23:10:00	f	t
101	Phys/Chem	2024-03-03 23:20:00	f	t
202	Phys/Chem	2024-03-03 23:20:00	f	f
2037	EnGeo	2024-03-03 23:20:00	f	t
358	King	2024-03-03 23:20:00	f	f
357	King	2024-03-03 23:20:00	t	t
2020	EnGeo	2024-03-03 23:20:00	f	t
101	Phys/Chem	2024-03-03 23:30:00	f	t
202	Phys/Chem	2024-03-03 23:30:00	f	f
2037	EnGeo	2024-03-03 23:30:00	f	t
358	King	2024-03-03 23:30:00	f	f
357	King	2024-03-03 23:30:00	t	t
2020	EnGeo	2024-03-03 23:30:00	f	t
101	Phys/Chem	2024-03-03 23:40:00	f	t
202	Phys/Chem	2024-03-03 23:40:00	f	f
2037	EnGeo	2024-03-03 23:40:00	f	t
358	King	2024-03-03 23:40:00	f	f
357	King	2024-03-03 23:40:00	t	t
2020	EnGeo	2024-03-03 23:40:00	f	t
101	Phys/Chem	2024-03-03 23:50:00	f	t
202	Phys/Chem	2024-03-03 23:50:00	f	f
2037	EnGeo	2024-03-03 23:50:00	f	t
358	King	2024-03-03 23:50:00	f	f
357	King	2024-03-03 23:50:00	t	t
2020	EnGeo	2024-03-03 23:50:00	f	t
101	Phys/Chem	2024-03-04 00:00:00	f	t
202	Phys/Chem	2024-03-04 00:00:00	f	f
2037	EnGeo	2024-03-04 00:00:00	f	t
358	King	2024-03-04 00:00:00	f	f
357	King	2024-03-04 00:00:00	t	t
2020	EnGeo	2024-03-04 00:00:00	f	t
101	Phys/Chem	2024-03-04 00:10:00	f	t
202	Phys/Chem	2024-03-04 00:10:00	f	f
2037	EnGeo	2024-03-04 00:10:00	f	t
358	King	2024-03-04 00:10:00	f	f
357	King	2024-03-04 00:10:00	t	t
2020	EnGeo	2024-03-04 00:10:00	f	t
101	Phys/Chem	2024-03-04 00:20:00	f	t
202	Phys/Chem	2024-03-04 00:20:00	f	f
2037	EnGeo	2024-03-04 00:20:00	f	t
358	King	2024-03-04 00:20:00	f	f
357	King	2024-03-04 00:20:00	t	t
2020	EnGeo	2024-03-04 00:20:00	f	t
101	Phys/Chem	2024-03-04 00:30:00	f	t
202	Phys/Chem	2024-03-04 00:30:00	f	f
2037	EnGeo	2024-03-04 00:30:00	f	t
358	King	2024-03-04 00:30:00	f	f
357	King	2024-03-04 00:30:00	t	t
2020	EnGeo	2024-03-04 00:30:00	f	t
101	Phys/Chem	2024-03-04 00:40:00	f	t
202	Phys/Chem	2024-03-04 00:40:00	f	f
2037	EnGeo	2024-03-04 00:40:00	f	t
358	King	2024-03-04 00:40:00	f	f
357	King	2024-03-04 00:40:00	t	t
2020	EnGeo	2024-03-04 00:40:00	f	t
101	Phys/Chem	2024-03-04 00:50:00	f	t
202	Phys/Chem	2024-03-04 00:50:00	f	f
2037	EnGeo	2024-03-04 00:50:00	f	t
358	King	2024-03-04 00:50:00	f	f
357	King	2024-03-04 00:50:00	t	t
2020	EnGeo	2024-03-04 00:50:00	f	t
101	Phys/Chem	2024-03-04 01:00:00	f	t
202	Phys/Chem	2024-03-04 01:00:00	f	f
2037	EnGeo	2024-03-04 01:00:00	f	t
358	King	2024-03-04 01:00:00	f	f
357	King	2024-03-04 01:00:00	t	t
2020	EnGeo	2024-03-04 01:00:00	f	t
101	Phys/Chem	2024-03-04 01:10:00	f	t
202	Phys/Chem	2024-03-04 01:10:00	f	f
2037	EnGeo	2024-03-04 01:10:00	f	t
358	King	2024-03-04 01:10:00	f	f
357	King	2024-03-04 01:10:00	t	t
2020	EnGeo	2024-03-04 01:10:00	f	t
101	Phys/Chem	2024-03-04 01:20:00	f	t
202	Phys/Chem	2024-03-04 01:20:00	f	f
2037	EnGeo	2024-03-04 01:20:00	f	t
358	King	2024-03-04 01:20:00	f	f
357	King	2024-03-04 01:20:00	t	t
2020	EnGeo	2024-03-04 01:20:00	f	t
101	Phys/Chem	2024-03-04 01:30:00	f	t
202	Phys/Chem	2024-03-04 01:30:00	f	f
2037	EnGeo	2024-03-04 01:30:00	f	t
358	King	2024-03-04 01:30:00	f	f
357	King	2024-03-04 01:30:00	t	t
2020	EnGeo	2024-03-04 01:30:00	f	t
101	Phys/Chem	2024-03-04 01:40:00	f	t
202	Phys/Chem	2024-03-04 01:40:00	f	f
2037	EnGeo	2024-03-04 01:40:00	f	t
358	King	2024-03-04 01:40:00	f	f
357	King	2024-03-04 01:40:00	t	t
2020	EnGeo	2024-03-04 01:40:00	f	t
101	Phys/Chem	2024-03-04 01:50:00	f	t
202	Phys/Chem	2024-03-04 01:50:00	f	f
2037	EnGeo	2024-03-04 01:50:00	f	t
358	King	2024-03-04 01:50:00	f	f
357	King	2024-03-04 01:50:00	t	t
2020	EnGeo	2024-03-04 01:50:00	f	t
101	Phys/Chem	2024-03-04 13:28:00	f	t
202	Phys/Chem	2024-03-04 13:28:00	f	f
2037	EnGeo	2024-03-04 13:28:00	f	t
358	King	2024-03-04 13:28:00	f	f
357	King	2024-03-04 13:28:00	t	t
2020	EnGeo	2024-03-04 13:28:00	f	t
101	Phys/Chem	2024-03-04 13:30:00	f	t
202	Phys/Chem	2024-03-04 13:30:00	f	f
2037	EnGeo	2024-03-04 13:30:00	f	t
358	King	2024-03-04 13:30:00	f	f
357	King	2024-03-04 13:30:00	t	t
2020	EnGeo	2024-03-04 13:30:00	f	t
101	Phys/Chem	2024-03-04 13:40:00	f	t
202	Phys/Chem	2024-03-04 13:40:00	f	f
2037	EnGeo	2024-03-04 13:40:00	f	t
358	King	2024-03-04 13:40:00	f	f
357	King	2024-03-04 13:40:00	t	t
2020	EnGeo	2024-03-04 13:40:00	f	t
101	Phys/Chem	2024-03-04 13:50:00	f	t
202	Phys/Chem	2024-03-04 13:50:00	f	f
2037	EnGeo	2024-03-04 13:50:00	f	t
358	King	2024-03-04 13:50:00	f	f
357	King	2024-03-04 13:50:00	t	t
2020	EnGeo	2024-03-04 13:50:00	f	t
101	Phys/Chem	2024-03-04 14:00:00	f	t
202	Phys/Chem	2024-03-04 14:00:00	f	f
2037	EnGeo	2024-03-04 14:00:00	f	t
358	King	2024-03-04 14:00:00	f	f
357	King	2024-03-04 14:00:00	t	t
2020	EnGeo	2024-03-04 14:00:00	f	t
101	Phys/Chem	2024-03-04 14:10:00	f	t
202	Phys/Chem	2024-03-04 14:10:00	f	f
2037	EnGeo	2024-03-04 14:10:00	f	t
2020	EnGeo	2024-03-04 14:10:00	f	f
358	King	2024-03-04 14:10:00	f	t
357	King	2024-03-04 14:10:00	t	f
101	Phys/Chem	2024-03-04 14:20:00	f	t
202	Phys/Chem	2024-03-04 14:20:00	f	f
2037	EnGeo	2024-03-04 14:20:00	f	t
2020	EnGeo	2024-03-04 14:20:00	f	f
358	King	2024-03-04 14:20:00	f	t
357	King	2024-03-04 14:20:00	t	f
101	Phys/Chem	2024-03-04 14:30:00	f	t
202	Phys/Chem	2024-03-04 14:30:00	f	f
2037	EnGeo	2024-03-04 14:30:00	f	t
2020	EnGeo	2024-03-04 14:30:00	f	f
358	King	2024-03-04 14:30:00	f	t
357	King	2024-03-04 14:30:00	t	f
101	Phys/Chem	2024-03-04 14:40:00	f	t
202	Phys/Chem	2024-03-04 14:40:00	f	f
2037	EnGeo	2024-03-04 14:40:00	f	t
2020	EnGeo	2024-03-04 14:40:00	f	f
358	King	2024-03-04 14:40:00	f	t
357	King	2024-03-04 14:40:00	t	f
101	Phys/Chem	2024-03-04 14:50:00	f	t
202	Phys/Chem	2024-03-04 14:50:00	f	f
2037	EnGeo	2024-03-04 14:50:00	f	t
2020	EnGeo	2024-03-04 14:50:00	f	f
358	King	2024-03-04 14:50:00	f	t
357	King	2024-03-04 14:50:00	t	f
101	Phys/Chem	2024-03-04 15:00:00	f	t
202	Phys/Chem	2024-03-04 15:00:00	f	f
2037	EnGeo	2024-03-04 15:00:00	f	t
2020	EnGeo	2024-03-04 15:00:00	f	f
358	King	2024-03-04 15:00:00	f	t
357	King	2024-03-04 15:00:00	t	f
101	Phys/Chem	2024-03-04 15:10:00	f	t
202	Phys/Chem	2024-03-04 15:10:00	f	f
2037	EnGeo	2024-03-04 15:10:00	f	t
2020	EnGeo	2024-03-04 15:10:00	f	f
358	King	2024-03-04 15:10:00	f	t
357	King	2024-03-04 15:10:00	t	f
101	Phys/Chem	2024-03-04 15:20:00	f	t
202	Phys/Chem	2024-03-04 15:20:00	f	f
2037	EnGeo	2024-03-04 15:20:00	f	t
2020	EnGeo	2024-03-04 15:20:00	f	f
358	King	2024-03-04 15:20:00	f	t
357	King	2024-03-04 15:20:00	t	f
101	Phys/Chem	2024-03-04 15:30:00	f	t
202	Phys/Chem	2024-03-04 15:30:00	f	f
2037	EnGeo	2024-03-04 15:30:00	f	t
2020	EnGeo	2024-03-04 15:30:00	f	f
358	King	2024-03-04 15:30:00	f	t
357	King	2024-03-04 15:30:00	f	f
101	Phys/Chem	2024-03-04 15:40:00	f	t
202	Phys/Chem	2024-03-04 15:40:00	f	f
2037	EnGeo	2024-03-04 15:40:00	f	t
2020	EnGeo	2024-03-04 15:40:00	f	f
358	King	2024-03-04 15:40:00	f	t
357	King	2024-03-04 15:40:00	f	f
101	Phys/Chem	2024-03-04 15:50:00	f	t
202	Phys/Chem	2024-03-04 15:50:00	f	f
2037	EnGeo	2024-03-04 15:50:00	f	t
2020	EnGeo	2024-03-04 15:50:00	f	f
358	King	2024-03-04 15:50:00	f	t
357	King	2024-03-04 15:50:00	f	f
101	Phys/Chem	2024-03-04 16:00:00	f	t
202	Phys/Chem	2024-03-04 16:00:00	f	f
2037	EnGeo	2024-03-04 16:00:00	f	t
2020	EnGeo	2024-03-04 16:00:00	f	f
358	King	2024-03-04 16:00:00	f	t
357	King	2024-03-04 16:00:00	f	f
101	Phys/Chem	2024-03-04 16:10:00	f	t
202	Phys/Chem	2024-03-04 16:10:00	f	f
2037	EnGeo	2024-03-04 16:10:00	f	t
2020	EnGeo	2024-03-04 16:10:00	f	f
358	King	2024-03-04 16:10:00	f	t
357	King	2024-03-04 16:10:00	f	f
101	Phys/Chem	2024-03-04 16:20:00	f	t
202	Phys/Chem	2024-03-04 16:20:00	f	f
2037	EnGeo	2024-03-04 16:20:00	f	t
2020	EnGeo	2024-03-04 16:20:00	f	f
358	King	2024-03-04 16:20:00	f	t
357	King	2024-03-04 16:20:00	f	f
101	Phys/Chem	2024-03-04 16:30:00	f	t
202	Phys/Chem	2024-03-04 16:30:00	f	f
2037	EnGeo	2024-03-04 16:30:00	f	t
2020	EnGeo	2024-03-04 16:30:00	f	f
358	King	2024-03-04 16:30:00	f	t
357	King	2024-03-04 16:30:00	t	f
101	Phys/Chem	2024-03-04 16:40:00	f	t
202	Phys/Chem	2024-03-04 16:40:00	f	f
2037	EnGeo	2024-03-04 16:40:00	f	t
2020	EnGeo	2024-03-04 16:40:00	f	f
358	King	2024-03-04 16:40:00	f	t
357	King	2024-03-04 16:40:00	t	f
101	Phys/Chem	2024-03-04 16:50:00	f	t
202	Phys/Chem	2024-03-04 16:50:00	f	f
2037	EnGeo	2024-03-04 16:50:00	f	t
2020	EnGeo	2024-03-04 16:50:00	f	f
358	King	2024-03-04 16:50:00	f	t
357	King	2024-03-04 16:50:00	t	f
101	Phys/Chem	2024-03-04 17:00:00	f	t
202	Phys/Chem	2024-03-04 17:00:00	f	f
2037	EnGeo	2024-03-04 17:00:00	f	t
2020	EnGeo	2024-03-04 17:00:00	f	f
358	King	2024-03-04 17:00:00	f	t
357	King	2024-03-04 17:00:00	t	f
101	Phys/Chem	2024-03-04 17:10:00	f	t
202	Phys/Chem	2024-03-04 17:10:00	f	f
2037	EnGeo	2024-03-04 17:10:00	f	t
2020	EnGeo	2024-03-04 17:10:00	f	f
358	King	2024-03-04 17:10:00	f	t
357	King	2024-03-04 17:10:00	t	f
101	Phys/Chem	2024-03-04 17:20:00	f	t
202	Phys/Chem	2024-03-04 17:20:00	f	f
2037	EnGeo	2024-03-04 17:20:00	f	t
2020	EnGeo	2024-03-04 17:20:00	f	f
358	King	2024-03-04 17:20:00	f	t
357	King	2024-03-04 17:20:00	t	f
101	Phys/Chem	2024-03-04 17:30:00	f	t
202	Phys/Chem	2024-03-04 17:30:00	f	f
2037	EnGeo	2024-03-04 17:30:00	f	t
2020	EnGeo	2024-03-04 17:30:00	f	f
358	King	2024-03-04 17:30:00	f	t
357	King	2024-03-04 17:30:00	t	f
101	Phys/Chem	2024-03-04 17:40:00	f	t
202	Phys/Chem	2024-03-04 17:40:00	f	f
2037	EnGeo	2024-03-04 17:40:00	f	t
2020	EnGeo	2024-03-04 17:40:00	f	f
358	King	2024-03-04 17:40:00	f	t
357	King	2024-03-04 17:40:00	t	f
101	Phys/Chem	2024-03-04 17:50:00	f	t
202	Phys/Chem	2024-03-04 17:50:00	f	f
2037	EnGeo	2024-03-04 17:50:00	f	t
2020	EnGeo	2024-03-04 17:50:00	f	f
358	King	2024-03-04 17:50:00	f	t
357	King	2024-03-04 17:50:00	t	f
202	Phys/Chem	2024-03-04 18:00:00	f	f
2037	EnGeo	2024-03-04 18:00:00	f	t
2020	EnGeo	2024-03-04 18:00:00	f	f
358	King	2024-03-04 18:00:00	f	t
357	King	2024-03-04 18:00:00	t	f
101	Phys/Chem	2024-03-04 18:00:00	f	f
202	Phys/Chem	2024-03-04 18:10:00	f	f
2037	EnGeo	2024-03-04 18:10:00	f	t
2020	EnGeo	2024-03-04 18:10:00	f	f
358	King	2024-03-04 18:10:00	f	t
357	King	2024-03-04 18:10:00	t	f
101	Phys/Chem	2024-03-04 18:10:00	f	f
202	Phys/Chem	2024-03-04 18:20:00	f	f
2037	EnGeo	2024-03-04 18:20:00	f	t
2020	EnGeo	2024-03-04 18:20:00	f	f
358	King	2024-03-04 18:20:00	f	t
357	King	2024-03-04 18:20:00	t	f
101	Phys/Chem	2024-03-04 18:20:00	f	f
202	Phys/Chem	2024-03-04 18:30:00	f	f
2037	EnGeo	2024-03-04 18:30:00	f	t
2020	EnGeo	2024-03-04 18:30:00	f	f
358	King	2024-03-04 18:30:00	f	t
357	King	2024-03-04 18:30:00	t	f
101	Phys/Chem	2024-03-04 18:30:00	f	f
202	Phys/Chem	2024-03-04 18:40:00	f	f
2037	EnGeo	2024-03-04 18:40:00	f	t
2020	EnGeo	2024-03-04 18:40:00	f	f
358	King	2024-03-04 18:40:00	f	t
357	King	2024-03-04 18:40:00	t	f
101	Phys/Chem	2024-03-04 18:40:00	f	f
202	Phys/Chem	2024-03-04 18:50:00	f	f
2037	EnGeo	2024-03-04 18:50:00	f	t
2020	EnGeo	2024-03-04 18:50:00	f	f
358	King	2024-03-04 18:50:00	f	t
357	King	2024-03-04 18:50:00	t	f
101	Phys/Chem	2024-03-04 18:50:00	f	f
202	Phys/Chem	2024-03-04 19:00:00	f	f
2037	EnGeo	2024-03-04 19:00:00	f	t
2020	EnGeo	2024-03-04 19:00:00	f	f
358	King	2024-03-04 19:00:00	f	t
357	King	2024-03-04 19:00:00	t	f
101	Phys/Chem	2024-03-04 19:00:00	f	f
202	Phys/Chem	2024-03-04 19:10:00	f	f
2037	EnGeo	2024-03-04 19:10:00	f	t
2020	EnGeo	2024-03-04 19:10:00	f	f
358	King	2024-03-04 19:10:00	f	t
357	King	2024-03-04 19:10:00	t	f
101	Phys/Chem	2024-03-04 19:10:00	f	f
202	Phys/Chem	2024-03-04 19:20:00	f	f
2037	EnGeo	2024-03-04 19:20:00	f	t
2020	EnGeo	2024-03-04 19:20:00	f	f
358	King	2024-03-04 19:20:00	f	t
357	King	2024-03-04 19:20:00	t	f
101	Phys/Chem	2024-03-04 19:20:00	f	f
202	Phys/Chem	2024-03-04 19:30:00	f	f
2037	EnGeo	2024-03-04 19:30:00	f	t
2020	EnGeo	2024-03-04 19:30:00	f	f
358	King	2024-03-04 19:30:00	f	t
357	King	2024-03-04 19:30:00	t	f
101	Phys/Chem	2024-03-04 19:30:00	f	f
202	Phys/Chem	2024-03-04 19:40:00	f	f
2037	EnGeo	2024-03-04 19:40:00	f	t
2020	EnGeo	2024-03-04 19:40:00	f	f
358	King	2024-03-04 19:40:00	f	t
357	King	2024-03-04 19:40:00	t	f
101	Phys/Chem	2024-03-04 19:40:00	f	f
202	Phys/Chem	2024-03-04 19:50:00	f	f
2037	EnGeo	2024-03-04 19:50:00	f	t
2020	EnGeo	2024-03-04 19:50:00	f	f
358	King	2024-03-04 19:50:00	f	t
357	King	2024-03-04 19:50:00	t	f
101	Phys/Chem	2024-03-04 19:50:00	f	f
202	Phys/Chem	2024-03-04 20:00:00	f	f
2037	EnGeo	2024-03-04 20:00:00	f	t
2020	EnGeo	2024-03-04 20:00:00	f	f
358	King	2024-03-04 20:00:00	f	t
357	King	2024-03-04 20:00:00	t	f
101	Phys/Chem	2024-03-04 20:00:00	f	f
202	Phys/Chem	2024-03-04 20:10:00	f	f
2037	EnGeo	2024-03-04 20:10:00	f	t
2020	EnGeo	2024-03-04 20:10:00	f	f
358	King	2024-03-04 20:10:00	f	t
357	King	2024-03-04 20:10:00	t	f
101	Phys/Chem	2024-03-04 20:10:00	f	f
202	Phys/Chem	2024-03-04 20:20:00	f	f
2037	EnGeo	2024-03-04 20:20:00	f	t
2020	EnGeo	2024-03-04 20:20:00	f	f
358	King	2024-03-04 20:20:00	f	t
357	King	2024-03-04 20:20:00	t	f
101	Phys/Chem	2024-03-04 20:20:00	f	f
202	Phys/Chem	2024-03-04 20:30:00	f	f
2037	EnGeo	2024-03-04 20:30:00	f	t
2020	EnGeo	2024-03-04 20:30:00	f	f
358	King	2024-03-04 20:30:00	f	t
357	King	2024-03-04 20:30:00	t	f
101	Phys/Chem	2024-03-04 20:30:00	f	f
202	Phys/Chem	2024-03-04 20:40:00	f	f
2037	EnGeo	2024-03-04 20:40:00	f	t
2020	EnGeo	2024-03-04 20:40:00	f	f
358	King	2024-03-04 20:40:00	f	t
357	King	2024-03-04 20:40:00	t	f
101	Phys/Chem	2024-03-04 20:40:00	f	f
202	Phys/Chem	2024-03-04 20:50:00	f	f
2037	EnGeo	2024-03-04 20:50:00	f	t
2020	EnGeo	2024-03-04 20:50:00	f	f
358	King	2024-03-04 20:50:00	f	t
357	King	2024-03-04 20:50:00	t	f
101	Phys/Chem	2024-03-04 20:50:00	f	f
202	Phys/Chem	2024-03-04 21:00:00	f	f
2037	EnGeo	2024-03-04 21:00:00	f	t
2020	EnGeo	2024-03-04 21:00:00	f	f
358	King	2024-03-04 21:00:00	f	t
357	King	2024-03-04 21:00:00	t	f
101	Phys/Chem	2024-03-04 21:00:00	f	f
202	Phys/Chem	2024-03-04 21:10:00	f	f
2037	EnGeo	2024-03-04 21:10:00	f	t
2020	EnGeo	2024-03-04 21:10:00	f	f
358	King	2024-03-04 21:10:00	f	t
357	King	2024-03-04 21:10:00	t	f
101	Phys/Chem	2024-03-04 21:10:00	f	f
202	Phys/Chem	2024-03-04 21:20:00	f	f
2037	EnGeo	2024-03-04 21:20:00	f	t
2020	EnGeo	2024-03-04 21:20:00	f	f
358	King	2024-03-04 21:20:00	f	t
357	King	2024-03-04 21:20:00	t	f
101	Phys/Chem	2024-03-04 21:20:00	f	f
202	Phys/Chem	2024-03-04 21:30:00	f	f
2037	EnGeo	2024-03-04 21:30:00	f	t
2020	EnGeo	2024-03-04 21:30:00	f	f
358	King	2024-03-04 21:30:00	f	t
357	King	2024-03-04 21:30:00	t	f
101	Phys/Chem	2024-03-04 21:30:00	f	f
202	Phys/Chem	2024-03-04 21:40:00	f	f
2037	EnGeo	2024-03-04 21:40:00	f	t
2020	EnGeo	2024-03-04 21:40:00	f	f
358	King	2024-03-04 21:40:00	f	t
357	King	2024-03-04 21:40:00	t	f
101	Phys/Chem	2024-03-04 21:40:00	f	f
202	Phys/Chem	2024-03-04 21:50:00	f	f
2037	EnGeo	2024-03-04 21:50:00	f	t
2020	EnGeo	2024-03-04 21:50:00	f	f
358	King	2024-03-04 21:50:00	f	t
357	King	2024-03-04 21:50:00	t	f
101	Phys/Chem	2024-03-04 21:50:00	f	f
202	Phys/Chem	2024-03-04 22:00:00	f	f
2037	EnGeo	2024-03-04 22:00:00	f	t
2020	EnGeo	2024-03-04 22:00:00	f	f
358	King	2024-03-04 22:00:00	f	t
357	King	2024-03-04 22:00:00	t	f
101	Phys/Chem	2024-03-04 22:00:00	f	f
202	Phys/Chem	2024-03-04 22:10:00	f	f
2037	EnGeo	2024-03-04 22:10:00	f	t
2020	EnGeo	2024-03-04 22:10:00	f	f
358	King	2024-03-04 22:10:00	f	t
357	King	2024-03-04 22:10:00	t	f
101	Phys/Chem	2024-03-04 22:10:00	f	f
202	Phys/Chem	2024-03-04 22:20:00	f	f
2037	EnGeo	2024-03-04 22:20:00	f	t
2020	EnGeo	2024-03-04 22:20:00	f	f
358	King	2024-03-04 22:20:00	f	t
357	King	2024-03-04 22:20:00	t	f
101	Phys/Chem	2024-03-04 22:20:00	f	f
202	Phys/Chem	2024-03-04 22:30:00	f	f
2037	EnGeo	2024-03-04 22:30:00	f	t
2020	EnGeo	2024-03-04 22:30:00	f	f
358	King	2024-03-04 22:30:00	f	t
357	King	2024-03-04 22:30:00	t	f
101	Phys/Chem	2024-03-04 22:30:00	f	f
202	Phys/Chem	2024-03-04 22:40:00	f	f
2037	EnGeo	2024-03-04 22:40:00	f	t
2020	EnGeo	2024-03-04 22:40:00	f	f
358	King	2024-03-04 22:40:00	f	t
357	King	2024-03-04 22:40:00	t	f
101	Phys/Chem	2024-03-04 22:40:00	f	f
202	Phys/Chem	2024-03-04 22:50:00	f	f
2037	EnGeo	2024-03-04 22:50:00	f	t
2020	EnGeo	2024-03-04 22:50:00	f	f
358	King	2024-03-04 22:50:00	f	t
357	King	2024-03-04 22:50:00	t	f
101	Phys/Chem	2024-03-04 22:50:00	f	f
202	Phys/Chem	2024-03-04 23:00:00	f	f
2037	EnGeo	2024-03-04 23:00:00	f	t
2020	EnGeo	2024-03-04 23:00:00	f	f
358	King	2024-03-04 23:00:00	f	t
357	King	2024-03-04 23:00:00	t	f
101	Phys/Chem	2024-03-04 23:00:00	f	f
202	Phys/Chem	2024-03-04 23:10:00	f	f
2037	EnGeo	2024-03-04 23:10:00	f	t
2020	EnGeo	2024-03-04 23:10:00	f	f
358	King	2024-03-04 23:10:00	f	t
357	King	2024-03-04 23:10:00	t	f
101	Phys/Chem	2024-03-04 23:10:00	f	f
202	Phys/Chem	2024-03-04 23:20:00	f	f
2037	EnGeo	2024-03-04 23:20:00	f	t
2020	EnGeo	2024-03-04 23:20:00	f	f
358	King	2024-03-04 23:20:00	f	t
357	King	2024-03-04 23:20:00	t	f
101	Phys/Chem	2024-03-04 23:20:00	f	f
202	Phys/Chem	2024-03-04 23:30:00	f	f
2037	EnGeo	2024-03-04 23:30:00	f	t
2020	EnGeo	2024-03-04 23:30:00	f	f
358	King	2024-03-04 23:30:00	f	t
357	King	2024-03-04 23:30:00	t	f
101	Phys/Chem	2024-03-04 23:30:00	f	f
202	Phys/Chem	2024-03-04 23:40:00	f	f
2037	EnGeo	2024-03-04 23:40:00	f	t
358	King	2024-03-04 23:40:00	f	t
357	King	2024-03-04 23:40:00	t	f
101	Phys/Chem	2024-03-04 23:40:00	f	f
2020	EnGeo	2024-03-04 23:40:00	f	f
202	Phys/Chem	2024-03-04 23:50:00	f	f
2037	EnGeo	2024-03-04 23:50:00	f	t
358	King	2024-03-04 23:50:00	f	t
357	King	2024-03-04 23:50:00	t	f
101	Phys/Chem	2024-03-04 23:50:00	f	f
2020	EnGeo	2024-03-04 23:50:00	f	f
202	Phys/Chem	2024-03-05 00:00:00	f	f
2037	EnGeo	2024-03-05 00:00:00	f	t
358	King	2024-03-05 00:00:00	f	t
357	King	2024-03-05 00:00:00	t	f
101	Phys/Chem	2024-03-05 00:00:00	f	f
2020	EnGeo	2024-03-05 00:00:00	f	f
202	Phys/Chem	2024-03-05 00:10:00	f	f
2037	EnGeo	2024-03-05 00:10:00	f	t
358	King	2024-03-05 00:10:00	f	t
357	King	2024-03-05 00:10:00	t	f
101	Phys/Chem	2024-03-05 00:10:00	f	f
2020	EnGeo	2024-03-05 00:10:00	f	f
202	Phys/Chem	2024-03-05 00:20:00	f	f
2037	EnGeo	2024-03-05 00:20:00	f	t
358	King	2024-03-05 00:20:00	f	t
357	King	2024-03-05 00:20:00	t	f
101	Phys/Chem	2024-03-05 00:20:00	f	f
2020	EnGeo	2024-03-05 00:20:00	f	f
202	Phys/Chem	2024-03-05 00:30:00	f	f
2037	EnGeo	2024-03-05 00:30:00	f	t
358	King	2024-03-05 00:30:00	f	t
357	King	2024-03-05 00:30:00	t	f
101	Phys/Chem	2024-03-05 00:30:00	f	f
2020	EnGeo	2024-03-05 00:30:00	f	f
202	Phys/Chem	2024-03-05 00:40:00	f	f
2037	EnGeo	2024-03-05 00:40:00	f	t
358	King	2024-03-05 00:40:00	f	t
357	King	2024-03-05 00:40:00	t	f
101	Phys/Chem	2024-03-05 00:40:00	f	f
2020	EnGeo	2024-03-05 00:40:00	f	f
202	Phys/Chem	2024-03-05 00:50:00	f	f
2037	EnGeo	2024-03-05 00:50:00	f	t
358	King	2024-03-05 00:50:00	f	t
357	King	2024-03-05 00:50:00	t	f
101	Phys/Chem	2024-03-05 00:50:00	f	f
2020	EnGeo	2024-03-05 00:50:00	f	f
202	Phys/Chem	2024-03-05 01:00:00	f	f
2037	EnGeo	2024-03-05 01:00:00	f	t
358	King	2024-03-05 01:00:00	f	t
357	King	2024-03-05 01:00:00	t	f
101	Phys/Chem	2024-03-05 01:00:00	f	f
2020	EnGeo	2024-03-05 01:00:00	f	f
202	Phys/Chem	2024-03-05 01:10:00	f	f
2037	EnGeo	2024-03-05 01:10:00	f	t
358	King	2024-03-05 01:10:00	f	t
357	King	2024-03-05 01:10:00	t	f
101	Phys/Chem	2024-03-05 01:10:00	f	f
2020	EnGeo	2024-03-05 01:10:00	f	f
202	Phys/Chem	2024-03-05 01:20:00	f	f
2037	EnGeo	2024-03-05 01:20:00	f	t
358	King	2024-03-05 01:20:00	f	t
357	King	2024-03-05 01:20:00	t	f
101	Phys/Chem	2024-03-05 01:20:00	f	f
2020	EnGeo	2024-03-05 01:20:00	f	f
202	Phys/Chem	2024-03-05 01:30:00	f	f
2037	EnGeo	2024-03-05 01:30:00	f	t
358	King	2024-03-05 01:30:00	f	t
357	King	2024-03-05 01:30:00	t	f
101	Phys/Chem	2024-03-05 01:30:00	f	f
2020	EnGeo	2024-03-05 01:30:00	f	f
202	Phys/Chem	2024-03-05 01:40:00	f	f
2037	EnGeo	2024-03-05 01:40:00	f	t
358	King	2024-03-05 01:40:00	f	t
357	King	2024-03-05 01:40:00	t	f
101	Phys/Chem	2024-03-05 01:40:00	f	f
2020	EnGeo	2024-03-05 01:40:00	f	f
202	Phys/Chem	2024-03-05 01:50:00	f	f
2037	EnGeo	2024-03-05 01:50:00	f	t
358	King	2024-03-05 01:50:00	f	t
357	King	2024-03-05 01:50:00	t	f
101	Phys/Chem	2024-03-05 01:50:00	f	f
2020	EnGeo	2024-03-05 01:50:00	f	f
202	Phys/Chem	2024-03-05 02:00:00	f	f
2037	EnGeo	2024-03-05 02:00:00	f	t
358	King	2024-03-05 02:00:00	f	t
357	King	2024-03-05 02:00:00	t	f
101	Phys/Chem	2024-03-05 02:00:00	f	f
2020	EnGeo	2024-03-05 02:00:00	f	f
202	Phys/Chem	2024-03-05 02:10:00	f	f
2037	EnGeo	2024-03-05 02:10:00	f	t
358	King	2024-03-05 02:10:00	f	t
357	King	2024-03-05 02:10:00	t	f
101	Phys/Chem	2024-03-05 02:10:00	f	f
2020	EnGeo	2024-03-05 02:10:00	f	f
202	Phys/Chem	2024-03-05 02:20:00	f	f
2037	EnGeo	2024-03-05 02:20:00	f	t
358	King	2024-03-05 02:20:00	f	t
357	King	2024-03-05 02:20:00	t	f
101	Phys/Chem	2024-03-05 02:20:00	f	f
2020	EnGeo	2024-03-05 02:20:00	f	f
202	Phys/Chem	2024-03-05 02:30:00	f	f
2037	EnGeo	2024-03-05 02:30:00	f	t
358	King	2024-03-05 02:30:00	f	t
357	King	2024-03-05 02:30:00	t	f
101	Phys/Chem	2024-03-05 02:30:00	f	f
2020	EnGeo	2024-03-05 02:30:00	f	f
202	Phys/Chem	2024-03-05 02:40:00	f	f
2037	EnGeo	2024-03-05 02:40:00	f	t
358	King	2024-03-05 02:40:00	f	t
357	King	2024-03-05 02:40:00	t	f
101	Phys/Chem	2024-03-05 02:40:00	f	f
2020	EnGeo	2024-03-05 02:40:00	f	f
202	Phys/Chem	2024-03-05 02:50:00	f	f
2037	EnGeo	2024-03-05 02:50:00	f	t
358	King	2024-03-05 02:50:00	f	t
357	King	2024-03-05 02:50:00	t	f
101	Phys/Chem	2024-03-05 02:50:00	f	f
2020	EnGeo	2024-03-05 02:50:00	f	f
202	Phys/Chem	2024-03-05 03:00:00	f	f
2037	EnGeo	2024-03-05 03:00:00	f	t
358	King	2024-03-05 03:00:00	f	t
357	King	2024-03-05 03:00:00	t	f
101	Phys/Chem	2024-03-05 03:00:00	f	f
2020	EnGeo	2024-03-05 03:00:00	f	f
202	Phys/Chem	2024-03-05 03:10:00	f	f
2037	EnGeo	2024-03-05 03:10:00	f	t
358	King	2024-03-05 03:10:00	f	t
357	King	2024-03-05 03:10:00	t	f
101	Phys/Chem	2024-03-05 03:10:00	f	f
2020	EnGeo	2024-03-05 03:10:00	f	f
202	Phys/Chem	2024-03-05 03:20:00	f	f
2037	EnGeo	2024-03-05 03:20:00	f	t
358	King	2024-03-05 03:20:00	f	t
357	King	2024-03-05 03:20:00	t	f
101	Phys/Chem	2024-03-05 03:20:00	f	f
2020	EnGeo	2024-03-05 03:20:00	f	f
202	Phys/Chem	2024-03-05 03:30:00	f	f
2037	EnGeo	2024-03-05 03:30:00	f	t
358	King	2024-03-05 03:30:00	f	t
357	King	2024-03-05 03:30:00	t	f
101	Phys/Chem	2024-03-05 03:30:00	f	f
2020	EnGeo	2024-03-05 03:30:00	f	f
202	Phys/Chem	2024-03-05 03:40:00	f	f
2037	EnGeo	2024-03-05 03:40:00	f	t
358	King	2024-03-05 03:40:00	f	t
357	King	2024-03-05 03:40:00	t	f
101	Phys/Chem	2024-03-05 03:40:00	f	f
2020	EnGeo	2024-03-05 03:40:00	f	f
202	Phys/Chem	2024-03-05 03:50:00	f	f
2037	EnGeo	2024-03-05 03:50:00	f	t
358	King	2024-03-05 03:50:00	f	t
357	King	2024-03-05 03:50:00	t	f
101	Phys/Chem	2024-03-05 03:50:00	f	f
2020	EnGeo	2024-03-05 03:50:00	f	f
202	Phys/Chem	2024-03-05 04:00:00	f	f
2037	EnGeo	2024-03-05 04:00:00	f	t
358	King	2024-03-05 04:00:00	f	t
357	King	2024-03-05 04:00:00	t	f
101	Phys/Chem	2024-03-05 04:00:00	f	f
2020	EnGeo	2024-03-05 04:00:00	f	f
202	Phys/Chem	2024-03-05 04:10:00	f	f
2037	EnGeo	2024-03-05 04:10:00	f	t
358	King	2024-03-05 04:10:00	f	t
357	King	2024-03-05 04:10:00	t	f
101	Phys/Chem	2024-03-05 04:10:00	f	f
2020	EnGeo	2024-03-05 04:10:00	f	f
202	Phys/Chem	2024-03-05 04:20:00	f	f
2037	EnGeo	2024-03-05 04:20:00	f	t
358	King	2024-03-05 04:20:00	f	t
357	King	2024-03-05 04:20:00	t	f
101	Phys/Chem	2024-03-05 04:20:00	f	f
2020	EnGeo	2024-03-05 04:20:00	f	f
202	Phys/Chem	2024-03-05 04:30:00	f	f
2037	EnGeo	2024-03-05 04:30:00	f	t
358	King	2024-03-05 04:30:00	f	t
357	King	2024-03-05 04:30:00	t	f
101	Phys/Chem	2024-03-05 04:30:00	f	f
2020	EnGeo	2024-03-05 04:30:00	f	f
202	Phys/Chem	2024-03-05 04:40:00	f	f
2037	EnGeo	2024-03-05 04:40:00	f	t
358	King	2024-03-05 04:40:00	f	t
357	King	2024-03-05 04:40:00	t	f
101	Phys/Chem	2024-03-05 04:40:00	f	f
2020	EnGeo	2024-03-05 04:40:00	f	f
202	Phys/Chem	2024-03-05 04:50:00	f	f
2037	EnGeo	2024-03-05 04:50:00	f	t
358	King	2024-03-05 04:50:00	f	t
357	King	2024-03-05 04:50:00	t	f
101	Phys/Chem	2024-03-05 04:50:00	f	f
2020	EnGeo	2024-03-05 04:50:00	f	f
202	Phys/Chem	2024-03-05 05:00:00	f	f
2037	EnGeo	2024-03-05 05:00:00	f	t
358	King	2024-03-05 05:00:00	f	t
357	King	2024-03-05 05:00:00	t	f
101	Phys/Chem	2024-03-05 05:00:00	f	f
2020	EnGeo	2024-03-05 05:00:00	f	f
202	Phys/Chem	2024-03-05 05:10:00	f	f
2037	EnGeo	2024-03-05 05:10:00	f	t
358	King	2024-03-05 05:10:00	f	t
357	King	2024-03-05 05:10:00	t	f
101	Phys/Chem	2024-03-05 05:10:00	f	f
2020	EnGeo	2024-03-05 05:10:00	f	f
202	Phys/Chem	2024-03-05 05:20:00	f	f
2037	EnGeo	2024-03-05 05:20:00	f	t
358	King	2024-03-05 05:20:00	f	t
357	King	2024-03-05 05:20:00	t	f
101	Phys/Chem	2024-03-05 05:20:00	f	f
2020	EnGeo	2024-03-05 05:20:00	f	f
202	Phys/Chem	2024-03-05 05:30:00	f	f
2037	EnGeo	2024-03-05 05:30:00	f	t
358	King	2024-03-05 05:30:00	f	t
357	King	2024-03-05 05:30:00	t	f
101	Phys/Chem	2024-03-05 05:30:00	f	f
2020	EnGeo	2024-03-05 05:30:00	f	f
202	Phys/Chem	2024-03-05 05:40:00	f	f
2037	EnGeo	2024-03-05 05:40:00	f	t
358	King	2024-03-05 05:40:00	f	t
357	King	2024-03-05 05:40:00	t	f
101	Phys/Chem	2024-03-05 05:40:00	f	f
2020	EnGeo	2024-03-05 05:40:00	f	f
202	Phys/Chem	2024-03-05 05:50:00	f	f
2037	EnGeo	2024-03-05 05:50:00	f	t
358	King	2024-03-05 05:50:00	f	t
357	King	2024-03-05 05:50:00	t	f
101	Phys/Chem	2024-03-05 05:50:00	f	f
2020	EnGeo	2024-03-05 05:50:00	f	f
202	Phys/Chem	2024-03-05 06:00:00	f	f
2037	EnGeo	2024-03-05 06:00:00	f	t
358	King	2024-03-05 06:00:00	f	t
357	King	2024-03-05 06:00:00	t	f
101	Phys/Chem	2024-03-05 06:00:00	f	f
2020	EnGeo	2024-03-05 06:00:00	f	f
202	Phys/Chem	2024-03-05 06:10:00	f	f
2037	EnGeo	2024-03-05 06:10:00	f	t
358	King	2024-03-05 06:10:00	f	t
357	King	2024-03-05 06:10:00	t	f
101	Phys/Chem	2024-03-05 06:10:00	f	f
2020	EnGeo	2024-03-05 06:10:00	f	f
202	Phys/Chem	2024-03-05 06:20:00	f	f
2037	EnGeo	2024-03-05 06:20:00	f	t
358	King	2024-03-05 06:20:00	f	t
357	King	2024-03-05 06:20:00	t	f
101	Phys/Chem	2024-03-05 06:20:00	f	f
2020	EnGeo	2024-03-05 06:20:00	f	f
202	Phys/Chem	2024-03-05 06:30:00	f	f
2037	EnGeo	2024-03-05 06:30:00	f	t
358	King	2024-03-05 06:30:00	f	t
357	King	2024-03-05 06:30:00	t	f
101	Phys/Chem	2024-03-05 06:30:00	f	f
2020	EnGeo	2024-03-05 06:30:00	f	f
202	Phys/Chem	2024-03-05 06:40:00	f	f
2037	EnGeo	2024-03-05 06:40:00	f	t
358	King	2024-03-05 06:40:00	f	t
357	King	2024-03-05 06:40:00	t	f
101	Phys/Chem	2024-03-05 06:40:00	f	f
2020	EnGeo	2024-03-05 06:40:00	f	f
202	Phys/Chem	2024-03-05 06:50:00	f	f
2037	EnGeo	2024-03-05 06:50:00	f	t
358	King	2024-03-05 06:50:00	f	t
357	King	2024-03-05 06:50:00	t	f
101	Phys/Chem	2024-03-05 06:50:00	f	f
2020	EnGeo	2024-03-05 06:50:00	f	f
202	Phys/Chem	2024-03-05 07:00:00	f	f
2037	EnGeo	2024-03-05 07:00:00	f	t
358	King	2024-03-05 07:00:00	f	t
357	King	2024-03-05 07:00:00	t	f
101	Phys/Chem	2024-03-05 07:00:00	f	f
2020	EnGeo	2024-03-05 07:00:00	f	f
202	Phys/Chem	2024-03-05 07:10:00	f	f
2037	EnGeo	2024-03-05 07:10:00	f	t
358	King	2024-03-05 07:10:00	f	t
357	King	2024-03-05 07:10:00	t	f
101	Phys/Chem	2024-03-05 07:10:00	f	f
2020	EnGeo	2024-03-05 07:10:00	f	f
202	Phys/Chem	2024-03-05 07:20:00	f	f
2037	EnGeo	2024-03-05 07:20:00	f	t
358	King	2024-03-05 07:20:00	f	t
357	King	2024-03-05 07:20:00	t	f
101	Phys/Chem	2024-03-05 07:20:00	f	f
2020	EnGeo	2024-03-05 07:20:00	f	f
202	Phys/Chem	2024-03-05 07:30:00	f	f
2037	EnGeo	2024-03-05 07:30:00	f	t
358	King	2024-03-05 07:30:00	f	t
357	King	2024-03-05 07:30:00	t	f
101	Phys/Chem	2024-03-05 07:30:00	f	f
2020	EnGeo	2024-03-05 07:30:00	f	f
202	Phys/Chem	2024-03-05 07:40:00	f	f
2037	EnGeo	2024-03-05 07:40:00	f	t
358	King	2024-03-05 07:40:00	f	t
357	King	2024-03-05 07:40:00	t	f
101	Phys/Chem	2024-03-05 07:40:00	f	f
2020	EnGeo	2024-03-05 07:40:00	f	f
202	Phys/Chem	2024-03-05 07:50:00	f	f
2037	EnGeo	2024-03-05 07:50:00	f	t
358	King	2024-03-05 07:50:00	f	t
357	King	2024-03-05 07:50:00	t	f
101	Phys/Chem	2024-03-05 07:50:00	f	f
2020	EnGeo	2024-03-05 07:50:00	f	f
202	Phys/Chem	2024-03-05 08:00:00	f	f
2037	EnGeo	2024-03-05 08:00:00	f	t
358	King	2024-03-05 08:00:00	f	t
357	King	2024-03-05 08:00:00	t	f
101	Phys/Chem	2024-03-05 08:00:00	f	f
2020	EnGeo	2024-03-05 08:00:00	f	f
202	Phys/Chem	2024-03-05 08:10:00	f	f
2037	EnGeo	2024-03-05 08:10:00	f	t
358	King	2024-03-05 08:10:00	f	t
357	King	2024-03-05 08:10:00	t	f
101	Phys/Chem	2024-03-05 08:10:00	f	f
2020	EnGeo	2024-03-05 08:10:00	f	f
202	Phys/Chem	2024-03-05 08:20:00	f	f
2037	EnGeo	2024-03-05 08:20:00	f	t
358	King	2024-03-05 08:20:00	f	t
357	King	2024-03-05 08:20:00	t	f
101	Phys/Chem	2024-03-05 08:20:00	f	f
2020	EnGeo	2024-03-05 08:20:00	f	f
202	Phys/Chem	2024-03-05 08:30:00	f	f
2037	EnGeo	2024-03-05 08:30:00	f	t
358	King	2024-03-05 08:30:00	f	t
357	King	2024-03-05 08:30:00	t	f
101	Phys/Chem	2024-03-05 08:30:00	f	f
2020	EnGeo	2024-03-05 08:30:00	f	f
202	Phys/Chem	2024-03-05 08:40:00	f	f
2037	EnGeo	2024-03-05 08:40:00	f	t
358	King	2024-03-05 08:40:00	f	t
357	King	2024-03-05 08:40:00	t	f
101	Phys/Chem	2024-03-05 08:40:00	f	f
2020	EnGeo	2024-03-05 08:40:00	f	f
202	Phys/Chem	2024-03-05 08:50:00	f	f
2037	EnGeo	2024-03-05 08:50:00	f	t
358	King	2024-03-05 08:50:00	f	t
357	King	2024-03-05 08:50:00	t	f
101	Phys/Chem	2024-03-05 08:50:00	f	f
2020	EnGeo	2024-03-05 08:50:00	f	f
202	Phys/Chem	2024-03-05 09:00:00	f	f
2037	EnGeo	2024-03-05 09:00:00	f	t
358	King	2024-03-05 09:00:00	f	t
357	King	2024-03-05 09:00:00	t	f
101	Phys/Chem	2024-03-05 09:00:00	f	f
2020	EnGeo	2024-03-05 09:00:00	f	f
202	Phys/Chem	2024-03-05 09:10:00	f	f
358	King	2024-03-05 09:10:00	f	t
357	King	2024-03-05 09:10:00	t	f
101	Phys/Chem	2024-03-05 09:10:00	f	f
2020	EnGeo	2024-03-05 09:10:00	f	f
2037	EnGeo	2024-03-05 09:10:00	t	t
202	Phys/Chem	2024-03-05 09:20:00	f	f
358	King	2024-03-05 09:20:00	f	t
357	King	2024-03-05 09:20:00	t	f
101	Phys/Chem	2024-03-05 09:20:00	f	f
2020	EnGeo	2024-03-05 09:20:00	f	f
2037	EnGeo	2024-03-05 09:20:00	t	t
202	Phys/Chem	2024-03-05 09:30:00	f	f
358	King	2024-03-05 09:30:00	f	t
357	King	2024-03-05 09:30:00	t	f
101	Phys/Chem	2024-03-05 09:30:00	f	f
2020	EnGeo	2024-03-05 09:30:00	f	f
2037	EnGeo	2024-03-05 09:30:00	t	t
202	Phys/Chem	2024-03-05 09:40:00	f	f
358	King	2024-03-05 09:40:00	f	t
357	King	2024-03-05 09:40:00	t	f
101	Phys/Chem	2024-03-05 09:40:00	f	f
2020	EnGeo	2024-03-05 09:40:00	f	f
2037	EnGeo	2024-03-05 09:40:00	t	t
202	Phys/Chem	2024-03-05 09:50:00	f	f
358	King	2024-03-05 09:50:00	f	t
357	King	2024-03-05 09:50:00	t	f
101	Phys/Chem	2024-03-05 09:50:00	f	f
2020	EnGeo	2024-03-05 09:50:00	f	f
2037	EnGeo	2024-03-05 09:50:00	t	t
202	Phys/Chem	2024-03-05 10:00:00	f	f
358	King	2024-03-05 10:00:00	f	t
357	King	2024-03-05 10:00:00	t	f
101	Phys/Chem	2024-03-05 10:00:00	f	f
2020	EnGeo	2024-03-05 10:00:00	f	f
2037	EnGeo	2024-03-05 10:00:00	t	t
202	Phys/Chem	2024-03-05 10:10:00	f	f
358	King	2024-03-05 10:10:00	f	t
357	King	2024-03-05 10:10:00	t	f
101	Phys/Chem	2024-03-05 10:10:00	f	f
2020	EnGeo	2024-03-05 10:10:00	f	f
2037	EnGeo	2024-03-05 10:10:00	t	t
202	Phys/Chem	2024-03-05 10:20:00	f	f
358	King	2024-03-05 10:20:00	f	t
357	King	2024-03-05 10:20:00	t	f
101	Phys/Chem	2024-03-05 10:20:00	f	f
2020	EnGeo	2024-03-05 10:20:00	f	f
2037	EnGeo	2024-03-05 10:20:00	t	t
202	Phys/Chem	2024-03-05 10:30:00	f	f
358	King	2024-03-05 10:30:00	f	t
357	King	2024-03-05 10:30:00	t	f
101	Phys/Chem	2024-03-05 10:30:00	f	f
2020	EnGeo	2024-03-05 10:30:00	f	f
2037	EnGeo	2024-03-05 10:30:00	t	t
202	Phys/Chem	2024-03-05 10:40:00	f	f
358	King	2024-03-05 10:40:00	f	t
357	King	2024-03-05 10:40:00	t	f
101	Phys/Chem	2024-03-05 10:40:00	f	f
2020	EnGeo	2024-03-05 10:40:00	f	f
2037	EnGeo	2024-03-05 10:40:00	t	t
202	Phys/Chem	2024-03-05 10:50:00	f	f
358	King	2024-03-05 10:50:00	f	t
357	King	2024-03-05 10:50:00	t	f
101	Phys/Chem	2024-03-05 10:50:00	f	f
2020	EnGeo	2024-03-05 10:50:00	f	f
2037	EnGeo	2024-03-05 10:50:00	t	t
202	Phys/Chem	2024-03-05 11:00:00	f	f
358	King	2024-03-05 11:00:00	f	t
357	King	2024-03-05 11:00:00	t	f
101	Phys/Chem	2024-03-05 11:00:00	f	f
2020	EnGeo	2024-03-05 11:00:00	f	f
2037	EnGeo	2024-03-05 11:00:00	t	t
202	Phys/Chem	2024-03-05 11:10:00	f	f
358	King	2024-03-05 11:10:00	f	t
357	King	2024-03-05 11:10:00	t	f
101	Phys/Chem	2024-03-05 11:10:00	f	f
2037	EnGeo	2024-03-05 11:10:00	t	t
2020	EnGeo	2024-03-05 11:10:00	f	t
202	Phys/Chem	2024-03-05 11:30:00	f	f
358	King	2024-03-05 11:30:00	f	t
357	King	2024-03-05 11:30:00	t	f
101	Phys/Chem	2024-03-05 11:30:00	f	f
2037	EnGeo	2024-03-05 11:30:00	t	t
2020	EnGeo	2024-03-05 11:30:00	f	t
202	Phys/Chem	2024-03-05 11:40:00	f	f
358	King	2024-03-05 11:40:00	f	t
357	King	2024-03-05 11:40:00	t	f
101	Phys/Chem	2024-03-05 11:40:00	f	f
2037	EnGeo	2024-03-05 11:40:00	t	t
2020	EnGeo	2024-03-05 11:40:00	f	t
202	Phys/Chem	2024-03-05 11:50:00	f	f
358	King	2024-03-05 11:50:00	f	t
357	King	2024-03-05 11:50:00	t	f
101	Phys/Chem	2024-03-05 11:50:00	f	f
2037	EnGeo	2024-03-05 11:50:00	t	t
2020	EnGeo	2024-03-05 11:50:00	f	t
202	Phys/Chem	2024-03-05 12:00:00	f	f
358	King	2024-03-05 12:00:00	f	t
357	King	2024-03-05 12:00:00	t	f
101	Phys/Chem	2024-03-05 12:00:00	f	f
2037	EnGeo	2024-03-05 12:00:00	t	t
2020	EnGeo	2024-03-05 12:00:00	f	t
202	Phys/Chem	2024-03-05 12:10:00	f	f
358	King	2024-03-05 12:10:00	f	t
357	King	2024-03-05 12:10:00	t	f
101	Phys/Chem	2024-03-05 12:10:00	f	f
2037	EnGeo	2024-03-05 12:10:00	t	t
2020	EnGeo	2024-03-05 12:10:00	f	t
202	Phys/Chem	2024-03-05 12:20:00	f	f
358	King	2024-03-05 12:20:00	f	t
357	King	2024-03-05 12:20:00	t	f
101	Phys/Chem	2024-03-05 12:20:00	f	f
2037	EnGeo	2024-03-05 12:20:00	t	t
2020	EnGeo	2024-03-05 12:20:00	f	t
202	Phys/Chem	2024-03-05 12:30:00	f	f
358	King	2024-03-05 12:30:00	f	t
101	Phys/Chem	2024-03-05 12:30:00	f	f
2037	EnGeo	2024-03-05 12:30:00	t	t
2020	EnGeo	2024-03-05 12:30:00	f	t
357	King	2024-03-05 12:30:00	t	f
202	Phys/Chem	2024-03-05 12:40:00	f	f
358	King	2024-03-05 12:40:00	f	t
101	Phys/Chem	2024-03-05 12:40:00	f	f
2037	EnGeo	2024-03-05 12:40:00	t	t
2020	EnGeo	2024-03-05 12:40:00	f	t
357	King	2024-03-05 12:40:00	t	f
202	Phys/Chem	2024-03-05 12:50:00	f	f
358	King	2024-03-05 12:50:00	f	t
101	Phys/Chem	2024-03-05 12:50:00	f	f
2037	EnGeo	2024-03-05 12:50:00	t	t
2020	EnGeo	2024-03-05 12:50:00	f	t
357	King	2024-03-05 12:50:00	t	f
202	Phys/Chem	2024-03-05 13:00:00	f	f
358	King	2024-03-05 13:00:00	f	t
101	Phys/Chem	2024-03-05 13:00:00	f	f
2020	EnGeo	2024-03-05 13:00:00	t	f
2037	EnGeo	2024-03-05 13:00:00	f	f
357	King	2024-03-05 13:00:00	t	f
202	Phys/Chem	2024-03-05 13:10:00	f	f
358	King	2024-03-05 13:10:00	f	t
101	Phys/Chem	2024-03-05 13:10:00	f	f
2020	EnGeo	2024-03-05 13:10:00	t	f
2037	EnGeo	2024-03-05 13:10:00	f	f
357	King	2024-03-05 13:10:00	f	f
202	Phys/Chem	2024-03-05 13:20:00	f	f
358	King	2024-03-05 13:20:00	f	t
101	Phys/Chem	2024-03-05 13:20:00	f	f
2020	EnGeo	2024-03-05 13:20:00	t	f
2037	EnGeo	2024-03-05 13:20:00	f	f
357	King	2024-03-05 13:20:00	f	f
202	Phys/Chem	2024-03-05 13:30:00	f	f
358	King	2024-03-05 13:30:00	f	t
101	Phys/Chem	2024-03-05 13:30:00	f	f
2020	EnGeo	2024-03-05 13:30:00	t	f
2037	EnGeo	2024-03-05 13:30:00	f	f
357	King	2024-03-05 13:30:00	f	f
202	Phys/Chem	2024-03-05 13:40:00	f	f
358	King	2024-03-05 13:40:00	f	t
101	Phys/Chem	2024-03-05 13:40:00	f	f
2020	EnGeo	2024-03-05 13:40:00	t	f
2037	EnGeo	2024-03-05 13:40:00	f	f
357	King	2024-03-05 13:40:00	f	f
202	Phys/Chem	2024-03-05 13:50:00	f	f
358	King	2024-03-05 13:50:00	f	t
101	Phys/Chem	2024-03-05 13:50:00	f	f
2020	EnGeo	2024-03-05 13:50:00	t	f
2037	EnGeo	2024-03-05 13:50:00	f	f
357	King	2024-03-05 13:50:00	f	f
202	Phys/Chem	2024-03-05 14:00:00	f	f
358	King	2024-03-05 14:00:00	f	t
101	Phys/Chem	2024-03-05 14:00:00	f	f
2020	EnGeo	2024-03-05 14:00:00	t	f
2037	EnGeo	2024-03-05 14:00:00	f	f
357	King	2024-03-05 14:00:00	f	f
202	Phys/Chem	2024-03-05 14:10:00	f	f
358	King	2024-03-05 14:10:00	f	t
101	Phys/Chem	2024-03-05 14:10:00	f	f
2020	EnGeo	2024-03-05 14:10:00	t	f
2037	EnGeo	2024-03-05 14:10:00	f	f
357	King	2024-03-05 14:10:00	f	f
202	Phys/Chem	2024-03-05 14:20:00	f	f
358	King	2024-03-05 14:20:00	f	t
101	Phys/Chem	2024-03-05 14:20:00	f	f
2020	EnGeo	2024-03-05 14:20:00	t	f
2037	EnGeo	2024-03-05 14:20:00	f	f
357	King	2024-03-05 14:20:00	f	f
202	Phys/Chem	2024-03-05 14:30:00	f	f
358	King	2024-03-05 14:30:00	f	t
101	Phys/Chem	2024-03-05 14:30:00	f	f
2020	EnGeo	2024-03-05 14:30:00	t	f
2037	EnGeo	2024-03-05 14:30:00	f	f
357	King	2024-03-05 14:30:00	f	f
202	Phys/Chem	2024-03-05 14:40:00	f	f
358	King	2024-03-05 14:40:00	f	t
101	Phys/Chem	2024-03-05 14:40:00	f	f
2020	EnGeo	2024-03-05 14:40:00	t	f
2037	EnGeo	2024-03-05 14:40:00	f	f
357	King	2024-03-05 14:40:00	f	f
202	Phys/Chem	2024-03-05 14:50:00	f	f
358	King	2024-03-05 14:50:00	f	t
101	Phys/Chem	2024-03-05 14:50:00	f	f
2020	EnGeo	2024-03-05 14:50:00	t	f
2037	EnGeo	2024-03-05 14:50:00	f	f
357	King	2024-03-05 14:50:00	f	f
202	Phys/Chem	2024-03-05 15:00:00	f	f
358	King	2024-03-05 15:00:00	f	t
101	Phys/Chem	2024-03-05 15:00:00	f	f
2020	EnGeo	2024-03-05 15:00:00	t	f
2037	EnGeo	2024-03-05 15:00:00	f	f
357	King	2024-03-05 15:00:00	f	f
202	Phys/Chem	2024-03-05 15:10:00	f	f
358	King	2024-03-05 15:10:00	f	t
101	Phys/Chem	2024-03-05 15:10:00	f	f
2020	EnGeo	2024-03-05 15:10:00	t	f
2037	EnGeo	2024-03-05 15:10:00	f	f
357	King	2024-03-05 15:10:00	f	f
202	Phys/Chem	2024-03-05 15:20:00	f	f
358	King	2024-03-05 15:20:00	f	t
101	Phys/Chem	2024-03-05 15:20:00	f	f
2020	EnGeo	2024-03-05 15:20:00	t	f
2037	EnGeo	2024-03-05 15:20:00	f	f
357	King	2024-03-05 15:20:00	f	f
202	Phys/Chem	2024-03-05 15:30:00	f	f
358	King	2024-03-05 15:30:00	f	t
101	Phys/Chem	2024-03-05 15:30:00	f	f
2020	EnGeo	2024-03-05 15:30:00	t	f
2037	EnGeo	2024-03-05 15:30:00	f	f
357	King	2024-03-05 15:30:00	f	f
202	Phys/Chem	2024-03-05 15:40:00	f	f
358	King	2024-03-05 15:40:00	f	t
101	Phys/Chem	2024-03-05 15:40:00	f	f
2020	EnGeo	2024-03-05 15:40:00	t	f
2037	EnGeo	2024-03-05 15:40:00	f	f
357	King	2024-03-05 15:40:00	f	f
202	Phys/Chem	2024-03-05 15:50:00	f	f
358	King	2024-03-05 15:50:00	f	t
101	Phys/Chem	2024-03-05 15:50:00	f	f
2020	EnGeo	2024-03-05 15:50:00	t	f
2037	EnGeo	2024-03-05 15:50:00	f	f
357	King	2024-03-05 15:50:00	f	f
202	Phys/Chem	2024-03-05 16:00:00	f	f
358	King	2024-03-05 16:00:00	f	t
101	Phys/Chem	2024-03-05 16:00:00	f	f
2020	EnGeo	2024-03-05 16:00:00	t	f
2037	EnGeo	2024-03-05 16:00:00	f	f
357	King	2024-03-05 16:00:00	f	f
202	Phys/Chem	2024-03-05 16:10:00	f	f
358	King	2024-03-05 16:10:00	f	t
101	Phys/Chem	2024-03-05 16:10:00	f	f
2020	EnGeo	2024-03-05 16:10:00	t	f
2037	EnGeo	2024-03-05 16:10:00	f	f
357	King	2024-03-05 16:10:00	f	f
202	Phys/Chem	2024-03-05 16:20:00	f	f
358	King	2024-03-05 16:20:00	f	t
101	Phys/Chem	2024-03-05 16:20:00	f	f
2020	EnGeo	2024-03-05 16:20:00	t	f
2037	EnGeo	2024-03-05 16:20:00	f	f
357	King	2024-03-05 16:20:00	f	f
202	Phys/Chem	2024-03-05 16:30:00	f	f
358	King	2024-03-05 16:30:00	f	t
101	Phys/Chem	2024-03-05 16:30:00	f	f
2020	EnGeo	2024-03-05 16:30:00	t	f
2037	EnGeo	2024-03-05 16:30:00	f	f
357	King	2024-03-05 16:30:00	f	f
202	Phys/Chem	2024-03-05 16:40:00	f	f
358	King	2024-03-05 16:40:00	f	t
101	Phys/Chem	2024-03-05 16:40:00	f	f
2020	EnGeo	2024-03-05 16:40:00	t	f
2037	EnGeo	2024-03-05 16:40:00	f	f
357	King	2024-03-05 16:40:00	f	f
202	Phys/Chem	2024-03-05 16:50:00	f	f
358	King	2024-03-05 16:50:00	f	t
101	Phys/Chem	2024-03-05 16:50:00	f	f
2020	EnGeo	2024-03-05 16:50:00	t	f
2037	EnGeo	2024-03-05 16:50:00	f	f
357	King	2024-03-05 16:50:00	f	f
202	Phys/Chem	2024-03-05 17:00:00	f	f
358	King	2024-03-05 17:00:00	f	t
101	Phys/Chem	2024-03-05 17:00:00	f	f
2020	EnGeo	2024-03-05 17:00:00	t	f
2037	EnGeo	2024-03-05 17:00:00	f	f
357	King	2024-03-05 17:00:00	f	f
202	Phys/Chem	2024-03-05 17:10:00	f	f
358	King	2024-03-05 17:10:00	f	t
101	Phys/Chem	2024-03-05 17:10:00	f	f
2020	EnGeo	2024-03-05 17:10:00	t	f
2037	EnGeo	2024-03-05 17:10:00	f	f
357	King	2024-03-05 17:10:00	f	f
202	Phys/Chem	2024-03-05 17:20:00	f	f
358	King	2024-03-05 17:20:00	f	t
101	Phys/Chem	2024-03-05 17:20:00	f	f
2020	EnGeo	2024-03-05 17:20:00	t	f
2037	EnGeo	2024-03-05 17:20:00	f	f
357	King	2024-03-05 17:20:00	f	f
202	Phys/Chem	2024-03-05 17:30:00	f	f
358	King	2024-03-05 17:30:00	f	t
101	Phys/Chem	2024-03-05 17:30:00	f	f
2020	EnGeo	2024-03-05 17:30:00	t	f
2037	EnGeo	2024-03-05 17:30:00	f	f
357	King	2024-03-05 17:30:00	f	f
202	Phys/Chem	2024-03-05 17:40:00	f	f
358	King	2024-03-05 17:40:00	f	t
101	Phys/Chem	2024-03-05 17:40:00	f	f
2020	EnGeo	2024-03-05 17:40:00	t	f
2037	EnGeo	2024-03-05 17:40:00	f	f
357	King	2024-03-05 17:40:00	f	f
202	Phys/Chem	2024-03-05 17:50:00	f	f
358	King	2024-03-05 17:50:00	f	t
101	Phys/Chem	2024-03-05 17:50:00	f	f
2020	EnGeo	2024-03-05 17:50:00	t	f
2037	EnGeo	2024-03-05 17:50:00	f	f
357	King	2024-03-05 17:50:00	f	f
202	Phys/Chem	2024-03-05 18:00:00	f	f
358	King	2024-03-05 18:00:00	f	t
101	Phys/Chem	2024-03-05 18:00:00	f	f
2020	EnGeo	2024-03-05 18:00:00	t	f
2037	EnGeo	2024-03-05 18:00:00	f	f
357	King	2024-03-05 18:00:00	f	f
202	Phys/Chem	2024-03-05 18:10:00	f	f
358	King	2024-03-05 18:10:00	f	t
101	Phys/Chem	2024-03-05 18:10:00	f	f
2020	EnGeo	2024-03-05 18:10:00	t	f
2037	EnGeo	2024-03-05 18:10:00	f	f
357	King	2024-03-05 18:10:00	f	f
202	Phys/Chem	2024-03-05 18:20:00	f	f
358	King	2024-03-05 18:20:00	f	t
101	Phys/Chem	2024-03-05 18:20:00	f	f
2020	EnGeo	2024-03-05 18:20:00	t	f
2037	EnGeo	2024-03-05 18:20:00	f	f
357	King	2024-03-05 18:20:00	f	f
202	Phys/Chem	2024-03-05 18:30:00	f	f
358	King	2024-03-05 18:30:00	f	t
101	Phys/Chem	2024-03-05 18:30:00	f	f
2020	EnGeo	2024-03-05 18:30:00	t	f
2037	EnGeo	2024-03-05 18:30:00	f	f
357	King	2024-03-05 18:30:00	f	f
202	Phys/Chem	2024-03-05 18:40:00	f	f
358	King	2024-03-05 18:40:00	f	t
101	Phys/Chem	2024-03-05 18:40:00	f	f
2020	EnGeo	2024-03-05 18:40:00	t	f
2037	EnGeo	2024-03-05 18:40:00	f	f
357	King	2024-03-05 18:40:00	f	f
202	Phys/Chem	2024-03-05 18:50:00	f	f
358	King	2024-03-05 18:50:00	f	t
101	Phys/Chem	2024-03-05 18:50:00	f	f
2020	EnGeo	2024-03-05 18:50:00	t	f
2037	EnGeo	2024-03-05 18:50:00	f	f
357	King	2024-03-05 18:50:00	f	f
202	Phys/Chem	2024-03-05 19:00:00	f	f
358	King	2024-03-05 19:00:00	f	t
101	Phys/Chem	2024-03-05 19:00:00	f	f
2020	EnGeo	2024-03-05 19:00:00	t	f
2037	EnGeo	2024-03-05 19:00:00	f	f
357	King	2024-03-05 19:00:00	f	f
202	Phys/Chem	2024-03-05 19:10:00	f	f
358	King	2024-03-05 19:10:00	f	t
101	Phys/Chem	2024-03-05 19:10:00	f	f
2020	EnGeo	2024-03-05 19:10:00	t	f
2037	EnGeo	2024-03-05 19:10:00	f	f
357	King	2024-03-05 19:10:00	f	f
202	Phys/Chem	2024-03-05 19:20:00	f	f
358	King	2024-03-05 19:20:00	f	t
101	Phys/Chem	2024-03-05 19:20:00	f	f
2020	EnGeo	2024-03-05 19:20:00	t	f
2037	EnGeo	2024-03-05 19:20:00	f	f
357	King	2024-03-05 19:20:00	f	f
202	Phys/Chem	2024-03-05 19:30:00	f	f
358	King	2024-03-05 19:30:00	f	t
101	Phys/Chem	2024-03-05 19:30:00	f	f
2020	EnGeo	2024-03-05 19:30:00	t	f
2037	EnGeo	2024-03-05 19:30:00	f	f
357	King	2024-03-05 19:30:00	f	f
202	Phys/Chem	2024-03-05 19:40:00	f	f
358	King	2024-03-05 19:40:00	f	t
101	Phys/Chem	2024-03-05 19:40:00	f	f
2020	EnGeo	2024-03-05 19:40:00	t	f
2037	EnGeo	2024-03-05 19:40:00	f	f
357	King	2024-03-05 19:40:00	f	f
202	Phys/Chem	2024-03-05 19:50:00	f	f
358	King	2024-03-05 19:50:00	f	t
101	Phys/Chem	2024-03-05 19:50:00	f	f
2020	EnGeo	2024-03-05 19:50:00	t	f
2037	EnGeo	2024-03-05 19:50:00	f	f
357	King	2024-03-05 19:50:00	f	f
202	Phys/Chem	2024-03-05 20:00:00	f	f
358	King	2024-03-05 20:00:00	f	t
101	Phys/Chem	2024-03-05 20:00:00	f	f
2020	EnGeo	2024-03-05 20:00:00	t	f
2037	EnGeo	2024-03-05 20:00:00	f	f
357	King	2024-03-05 20:00:00	f	f
202	Phys/Chem	2024-03-05 20:10:00	f	f
358	King	2024-03-05 20:10:00	f	t
101	Phys/Chem	2024-03-05 20:10:00	f	f
2020	EnGeo	2024-03-05 20:10:00	t	f
2037	EnGeo	2024-03-05 20:10:00	f	f
357	King	2024-03-05 20:10:00	f	f
202	Phys/Chem	2024-03-05 20:20:00	f	f
358	King	2024-03-05 20:20:00	f	t
101	Phys/Chem	2024-03-05 20:20:00	f	f
2020	EnGeo	2024-03-05 20:20:00	t	f
2037	EnGeo	2024-03-05 20:20:00	f	f
357	King	2024-03-05 20:20:00	f	f
202	Phys/Chem	2024-03-05 20:30:00	f	f
358	King	2024-03-05 20:30:00	f	t
101	Phys/Chem	2024-03-05 20:30:00	f	f
2020	EnGeo	2024-03-05 20:30:00	t	f
2037	EnGeo	2024-03-05 20:30:00	f	f
357	King	2024-03-05 20:30:00	f	f
202	Phys/Chem	2024-03-05 20:40:00	f	f
358	King	2024-03-05 20:40:00	f	t
101	Phys/Chem	2024-03-05 20:40:00	f	f
2020	EnGeo	2024-03-05 20:40:00	t	f
2037	EnGeo	2024-03-05 20:40:00	f	f
357	King	2024-03-05 20:40:00	f	f
202	Phys/Chem	2024-03-05 20:50:00	f	f
358	King	2024-03-05 20:50:00	f	t
101	Phys/Chem	2024-03-05 20:50:00	f	f
2020	EnGeo	2024-03-05 20:50:00	t	f
2037	EnGeo	2024-03-05 20:50:00	f	f
357	King	2024-03-05 20:50:00	f	f
202	Phys/Chem	2024-03-05 21:00:00	f	f
358	King	2024-03-05 21:00:00	f	t
101	Phys/Chem	2024-03-05 21:00:00	f	f
2020	EnGeo	2024-03-05 21:00:00	t	f
2037	EnGeo	2024-03-05 21:00:00	f	f
357	King	2024-03-05 21:00:00	f	f
202	Phys/Chem	2024-03-05 21:10:00	f	f
358	King	2024-03-05 21:10:00	f	t
101	Phys/Chem	2024-03-05 21:10:00	f	f
2020	EnGeo	2024-03-05 21:10:00	t	f
2037	EnGeo	2024-03-05 21:10:00	f	f
357	King	2024-03-05 21:10:00	f	f
202	Phys/Chem	2024-03-05 21:20:00	f	f
358	King	2024-03-05 21:20:00	f	t
101	Phys/Chem	2024-03-05 21:20:00	f	f
2020	EnGeo	2024-03-05 21:20:00	t	f
2037	EnGeo	2024-03-05 21:20:00	f	f
357	King	2024-03-05 21:20:00	f	f
202	Phys/Chem	2024-03-05 21:30:00	f	f
358	King	2024-03-05 21:30:00	f	t
101	Phys/Chem	2024-03-05 21:30:00	f	f
2020	EnGeo	2024-03-05 21:30:00	t	f
2037	EnGeo	2024-03-05 21:30:00	f	f
357	King	2024-03-05 21:30:00	f	f
202	Phys/Chem	2024-03-05 21:40:00	f	f
358	King	2024-03-05 21:40:00	f	t
101	Phys/Chem	2024-03-05 21:40:00	f	f
2020	EnGeo	2024-03-05 21:40:00	t	f
2037	EnGeo	2024-03-05 21:40:00	f	f
357	King	2024-03-05 21:40:00	f	f
202	Phys/Chem	2024-03-05 21:50:00	f	f
358	King	2024-03-05 21:50:00	f	t
101	Phys/Chem	2024-03-05 21:50:00	f	f
2020	EnGeo	2024-03-05 21:50:00	t	f
2037	EnGeo	2024-03-05 21:50:00	f	f
357	King	2024-03-05 21:50:00	f	f
202	Phys/Chem	2024-03-05 22:00:00	f	f
358	King	2024-03-05 22:00:00	f	t
101	Phys/Chem	2024-03-05 22:00:00	f	f
2020	EnGeo	2024-03-05 22:00:00	t	f
2037	EnGeo	2024-03-05 22:00:00	f	f
357	King	2024-03-05 22:00:00	f	f
202	Phys/Chem	2024-03-05 22:10:00	f	f
358	King	2024-03-05 22:10:00	f	t
101	Phys/Chem	2024-03-05 22:10:00	f	f
2020	EnGeo	2024-03-05 22:10:00	t	f
2037	EnGeo	2024-03-05 22:10:00	f	f
357	King	2024-03-05 22:10:00	f	f
202	Phys/Chem	2024-03-05 22:20:00	f	f
358	King	2024-03-05 22:20:00	f	t
101	Phys/Chem	2024-03-05 22:20:00	f	f
2020	EnGeo	2024-03-05 22:20:00	t	f
2037	EnGeo	2024-03-05 22:20:00	f	f
357	King	2024-03-05 22:20:00	f	f
202	Phys/Chem	2024-03-05 22:30:00	f	f
358	King	2024-03-05 22:30:00	f	t
101	Phys/Chem	2024-03-05 22:30:00	f	f
2020	EnGeo	2024-03-05 22:30:00	t	f
2037	EnGeo	2024-03-05 22:30:00	f	f
357	King	2024-03-05 22:30:00	f	f
202	Phys/Chem	2024-03-05 22:40:00	f	f
358	King	2024-03-05 22:40:00	f	t
101	Phys/Chem	2024-03-05 22:40:00	f	f
2020	EnGeo	2024-03-05 22:40:00	t	f
2037	EnGeo	2024-03-05 22:40:00	f	f
357	King	2024-03-05 22:40:00	f	f
202	Phys/Chem	2024-03-05 22:50:00	f	f
358	King	2024-03-05 22:50:00	f	t
101	Phys/Chem	2024-03-05 22:50:00	f	f
2020	EnGeo	2024-03-05 22:50:00	t	f
2037	EnGeo	2024-03-05 22:50:00	f	f
357	King	2024-03-05 22:50:00	f	f
202	Phys/Chem	2024-03-05 23:00:00	f	f
358	King	2024-03-05 23:00:00	f	t
101	Phys/Chem	2024-03-05 23:00:00	f	f
2020	EnGeo	2024-03-05 23:00:00	t	f
2037	EnGeo	2024-03-05 23:00:00	f	f
357	King	2024-03-05 23:00:00	f	f
202	Phys/Chem	2024-03-05 23:10:00	f	f
358	King	2024-03-05 23:10:00	f	t
101	Phys/Chem	2024-03-05 23:10:00	f	f
2020	EnGeo	2024-03-05 23:10:00	t	f
2037	EnGeo	2024-03-05 23:10:00	f	f
357	King	2024-03-05 23:10:00	f	f
202	Phys/Chem	2024-03-05 23:20:00	f	f
358	King	2024-03-05 23:20:00	f	t
101	Phys/Chem	2024-03-05 23:20:00	f	f
2020	EnGeo	2024-03-05 23:20:00	t	f
2037	EnGeo	2024-03-05 23:20:00	f	f
357	King	2024-03-05 23:20:00	f	f
202	Phys/Chem	2024-03-05 23:30:00	f	f
358	King	2024-03-05 23:30:00	f	t
101	Phys/Chem	2024-03-05 23:30:00	f	f
2020	EnGeo	2024-03-05 23:30:00	t	f
2037	EnGeo	2024-03-05 23:30:00	f	f
357	King	2024-03-05 23:30:00	f	f
202	Phys/Chem	2024-03-05 23:40:00	f	f
358	King	2024-03-05 23:40:00	f	t
101	Phys/Chem	2024-03-05 23:40:00	f	f
2020	EnGeo	2024-03-05 23:40:00	t	f
2037	EnGeo	2024-03-05 23:40:00	f	f
357	King	2024-03-05 23:40:00	f	f
202	Phys/Chem	2024-03-05 23:50:00	f	f
358	King	2024-03-05 23:50:00	f	t
101	Phys/Chem	2024-03-05 23:50:00	f	f
2020	EnGeo	2024-03-05 23:50:00	t	f
2037	EnGeo	2024-03-05 23:50:00	f	f
357	King	2024-03-05 23:50:00	f	f
202	Phys/Chem	2024-03-06 00:00:00	f	f
358	King	2024-03-06 00:00:00	f	t
101	Phys/Chem	2024-03-06 00:00:00	f	f
2020	EnGeo	2024-03-06 00:00:00	t	f
2037	EnGeo	2024-03-06 00:00:00	f	f
357	King	2024-03-06 00:00:00	f	f
202	Phys/Chem	2024-03-06 00:10:00	f	f
358	King	2024-03-06 00:10:00	f	t
101	Phys/Chem	2024-03-06 00:10:00	f	f
2020	EnGeo	2024-03-06 00:10:00	t	f
2037	EnGeo	2024-03-06 00:10:00	f	f
357	King	2024-03-06 00:10:00	f	f
202	Phys/Chem	2024-03-06 00:20:00	f	f
358	King	2024-03-06 00:20:00	f	t
101	Phys/Chem	2024-03-06 00:20:00	f	f
2020	EnGeo	2024-03-06 00:20:00	t	f
2037	EnGeo	2024-03-06 00:20:00	f	f
357	King	2024-03-06 00:20:00	f	f
202	Phys/Chem	2024-03-06 00:30:00	f	f
358	King	2024-03-06 00:30:00	f	t
101	Phys/Chem	2024-03-06 00:30:00	f	f
2020	EnGeo	2024-03-06 00:30:00	t	f
2037	EnGeo	2024-03-06 00:30:00	f	f
357	King	2024-03-06 00:30:00	f	f
202	Phys/Chem	2024-03-06 00:40:00	f	f
358	King	2024-03-06 00:40:00	f	t
101	Phys/Chem	2024-03-06 00:40:00	f	f
2020	EnGeo	2024-03-06 00:40:00	t	f
2037	EnGeo	2024-03-06 00:40:00	f	f
357	King	2024-03-06 00:40:00	f	f
202	Phys/Chem	2024-03-06 00:50:00	f	f
358	King	2024-03-06 00:50:00	f	t
101	Phys/Chem	2024-03-06 00:50:00	f	f
2020	EnGeo	2024-03-06 00:50:00	t	f
2037	EnGeo	2024-03-06 00:50:00	f	f
357	King	2024-03-06 00:50:00	f	f
202	Phys/Chem	2024-03-06 01:00:00	f	f
358	King	2024-03-06 01:00:00	f	t
101	Phys/Chem	2024-03-06 01:00:00	f	f
2020	EnGeo	2024-03-06 01:00:00	t	f
2037	EnGeo	2024-03-06 01:00:00	f	f
357	King	2024-03-06 01:00:00	f	f
202	Phys/Chem	2024-03-06 01:10:00	f	f
358	King	2024-03-06 01:10:00	f	t
101	Phys/Chem	2024-03-06 01:10:00	f	f
2020	EnGeo	2024-03-06 01:10:00	t	f
2037	EnGeo	2024-03-06 01:10:00	f	f
357	King	2024-03-06 01:10:00	f	f
202	Phys/Chem	2024-03-06 01:20:00	f	f
358	King	2024-03-06 01:20:00	f	t
101	Phys/Chem	2024-03-06 01:20:00	f	f
2020	EnGeo	2024-03-06 01:20:00	t	f
2037	EnGeo	2024-03-06 01:20:00	f	f
357	King	2024-03-06 01:20:00	f	f
202	Phys/Chem	2024-03-06 01:30:00	f	f
358	King	2024-03-06 01:30:00	f	t
101	Phys/Chem	2024-03-06 01:30:00	f	f
2020	EnGeo	2024-03-06 01:30:00	t	f
2037	EnGeo	2024-03-06 01:30:00	f	f
357	King	2024-03-06 01:30:00	f	f
202	Phys/Chem	2024-03-06 01:40:00	f	f
358	King	2024-03-06 01:40:00	f	t
101	Phys/Chem	2024-03-06 01:40:00	f	f
2020	EnGeo	2024-03-06 01:40:00	t	f
2037	EnGeo	2024-03-06 01:40:00	f	f
357	King	2024-03-06 01:40:00	f	f
202	Phys/Chem	2024-03-06 01:50:00	f	f
358	King	2024-03-06 01:50:00	f	t
101	Phys/Chem	2024-03-06 01:50:00	f	f
2020	EnGeo	2024-03-06 01:50:00	t	f
2037	EnGeo	2024-03-06 01:50:00	f	f
357	King	2024-03-06 01:50:00	f	f
202	Phys/Chem	2024-03-06 02:00:00	f	f
358	King	2024-03-06 02:00:00	f	t
101	Phys/Chem	2024-03-06 02:00:00	f	f
2020	EnGeo	2024-03-06 02:00:00	t	f
2037	EnGeo	2024-03-06 02:00:00	f	f
357	King	2024-03-06 02:00:00	f	f
202	Phys/Chem	2024-03-06 02:10:00	f	f
358	King	2024-03-06 02:10:00	f	t
101	Phys/Chem	2024-03-06 02:10:00	f	f
2020	EnGeo	2024-03-06 02:10:00	t	f
2037	EnGeo	2024-03-06 02:10:00	f	f
357	King	2024-03-06 02:10:00	f	f
202	Phys/Chem	2024-03-06 02:20:00	f	f
358	King	2024-03-06 02:20:00	f	t
101	Phys/Chem	2024-03-06 02:20:00	f	f
2020	EnGeo	2024-03-06 02:20:00	t	f
2037	EnGeo	2024-03-06 02:20:00	f	f
357	King	2024-03-06 02:20:00	f	f
202	Phys/Chem	2024-03-06 02:30:00	f	f
358	King	2024-03-06 02:30:00	f	t
101	Phys/Chem	2024-03-06 02:30:00	f	f
2020	EnGeo	2024-03-06 02:30:00	t	f
2037	EnGeo	2024-03-06 02:30:00	f	f
357	King	2024-03-06 02:30:00	f	f
202	Phys/Chem	2024-03-06 02:40:00	f	f
358	King	2024-03-06 02:40:00	f	t
101	Phys/Chem	2024-03-06 02:40:00	f	f
2020	EnGeo	2024-03-06 02:40:00	t	f
2037	EnGeo	2024-03-06 02:40:00	f	f
357	King	2024-03-06 02:40:00	f	f
202	Phys/Chem	2024-03-06 02:50:00	f	f
358	King	2024-03-06 02:50:00	f	t
101	Phys/Chem	2024-03-06 02:50:00	f	f
2020	EnGeo	2024-03-06 02:50:00	t	f
2037	EnGeo	2024-03-06 02:50:00	f	f
357	King	2024-03-06 02:50:00	f	f
202	Phys/Chem	2024-03-06 03:00:00	f	f
358	King	2024-03-06 03:00:00	f	t
101	Phys/Chem	2024-03-06 03:00:00	f	f
2020	EnGeo	2024-03-06 03:00:00	t	f
2037	EnGeo	2024-03-06 03:00:00	f	f
357	King	2024-03-06 03:00:00	f	f
202	Phys/Chem	2024-03-06 03:10:00	f	f
358	King	2024-03-06 03:10:00	f	t
101	Phys/Chem	2024-03-06 03:10:00	f	f
2020	EnGeo	2024-03-06 03:10:00	t	f
2037	EnGeo	2024-03-06 03:10:00	f	f
357	King	2024-03-06 03:10:00	f	f
202	Phys/Chem	2024-03-06 03:20:00	f	f
358	King	2024-03-06 03:20:00	f	t
101	Phys/Chem	2024-03-06 03:20:00	f	f
2020	EnGeo	2024-03-06 03:20:00	t	f
2037	EnGeo	2024-03-06 03:20:00	f	f
357	King	2024-03-06 03:20:00	f	f
202	Phys/Chem	2024-03-06 03:30:00	f	f
358	King	2024-03-06 03:30:00	f	t
101	Phys/Chem	2024-03-06 03:30:00	f	f
2020	EnGeo	2024-03-06 03:30:00	t	f
2037	EnGeo	2024-03-06 03:30:00	f	f
357	King	2024-03-06 03:30:00	f	f
202	Phys/Chem	2024-03-06 03:40:00	f	f
358	King	2024-03-06 03:40:00	f	t
101	Phys/Chem	2024-03-06 03:40:00	f	f
2020	EnGeo	2024-03-06 03:40:00	t	f
2037	EnGeo	2024-03-06 03:40:00	f	f
357	King	2024-03-06 03:40:00	f	f
202	Phys/Chem	2024-03-06 03:50:00	f	f
358	King	2024-03-06 03:50:00	f	t
101	Phys/Chem	2024-03-06 03:50:00	f	f
2020	EnGeo	2024-03-06 03:50:00	t	f
2037	EnGeo	2024-03-06 03:50:00	f	f
357	King	2024-03-06 03:50:00	f	f
202	Phys/Chem	2024-03-06 04:00:00	f	f
358	King	2024-03-06 04:00:00	f	t
101	Phys/Chem	2024-03-06 04:00:00	f	f
2020	EnGeo	2024-03-06 04:00:00	t	f
2037	EnGeo	2024-03-06 04:00:00	f	f
357	King	2024-03-06 04:00:00	f	f
202	Phys/Chem	2024-03-06 04:10:00	f	f
358	King	2024-03-06 04:10:00	f	t
101	Phys/Chem	2024-03-06 04:10:00	f	f
2020	EnGeo	2024-03-06 04:10:00	t	f
2037	EnGeo	2024-03-06 04:10:00	f	f
357	King	2024-03-06 04:10:00	f	f
202	Phys/Chem	2024-03-06 04:20:00	f	f
358	King	2024-03-06 04:20:00	f	t
101	Phys/Chem	2024-03-06 04:20:00	f	f
2020	EnGeo	2024-03-06 04:20:00	t	f
2037	EnGeo	2024-03-06 04:20:00	f	f
357	King	2024-03-06 04:20:00	f	f
202	Phys/Chem	2024-03-06 04:30:00	f	f
358	King	2024-03-06 04:30:00	f	t
101	Phys/Chem	2024-03-06 04:30:00	f	f
2020	EnGeo	2024-03-06 04:30:00	t	f
2037	EnGeo	2024-03-06 04:30:00	f	f
357	King	2024-03-06 04:30:00	f	f
202	Phys/Chem	2024-03-06 04:40:00	f	f
358	King	2024-03-06 04:40:00	f	t
101	Phys/Chem	2024-03-06 04:40:00	f	f
2020	EnGeo	2024-03-06 04:40:00	t	f
2037	EnGeo	2024-03-06 04:40:00	f	f
357	King	2024-03-06 04:40:00	f	f
202	Phys/Chem	2024-03-06 04:50:00	f	f
358	King	2024-03-06 04:50:00	f	t
101	Phys/Chem	2024-03-06 04:50:00	f	f
2020	EnGeo	2024-03-06 04:50:00	t	f
2037	EnGeo	2024-03-06 04:50:00	f	f
357	King	2024-03-06 04:50:00	f	f
202	Phys/Chem	2024-03-06 05:00:00	f	f
358	King	2024-03-06 05:00:00	f	t
101	Phys/Chem	2024-03-06 05:00:00	f	f
2020	EnGeo	2024-03-06 05:00:00	t	f
2037	EnGeo	2024-03-06 05:00:00	f	f
357	King	2024-03-06 05:00:00	f	f
202	Phys/Chem	2024-03-06 05:10:00	f	f
358	King	2024-03-06 05:10:00	f	t
101	Phys/Chem	2024-03-06 05:10:00	f	f
2020	EnGeo	2024-03-06 05:10:00	t	f
2037	EnGeo	2024-03-06 05:10:00	f	f
357	King	2024-03-06 05:10:00	f	f
202	Phys/Chem	2024-03-06 05:20:00	f	f
358	King	2024-03-06 05:20:00	f	t
101	Phys/Chem	2024-03-06 05:20:00	f	f
2020	EnGeo	2024-03-06 05:20:00	t	f
2037	EnGeo	2024-03-06 05:20:00	f	f
357	King	2024-03-06 05:20:00	f	f
202	Phys/Chem	2024-03-06 05:30:00	f	f
358	King	2024-03-06 05:30:00	f	t
101	Phys/Chem	2024-03-06 05:30:00	f	f
2020	EnGeo	2024-03-06 05:30:00	t	f
2037	EnGeo	2024-03-06 05:30:00	f	f
357	King	2024-03-06 05:30:00	f	f
202	Phys/Chem	2024-03-06 05:40:00	f	f
358	King	2024-03-06 05:40:00	f	t
101	Phys/Chem	2024-03-06 05:40:00	f	f
2020	EnGeo	2024-03-06 05:40:00	t	f
2037	EnGeo	2024-03-06 05:40:00	f	f
357	King	2024-03-06 05:40:00	f	f
202	Phys/Chem	2024-03-06 05:50:00	f	f
358	King	2024-03-06 05:50:00	f	t
101	Phys/Chem	2024-03-06 05:50:00	f	f
2020	EnGeo	2024-03-06 05:50:00	t	f
2037	EnGeo	2024-03-06 05:50:00	f	f
357	King	2024-03-06 05:50:00	f	f
202	Phys/Chem	2024-03-06 06:00:00	f	f
358	King	2024-03-06 06:00:00	f	t
101	Phys/Chem	2024-03-06 06:00:00	f	f
2020	EnGeo	2024-03-06 06:00:00	t	f
2037	EnGeo	2024-03-06 06:00:00	f	f
357	King	2024-03-06 06:00:00	f	f
202	Phys/Chem	2024-03-06 06:10:00	f	f
358	King	2024-03-06 06:10:00	f	t
101	Phys/Chem	2024-03-06 06:10:00	f	f
2020	EnGeo	2024-03-06 06:10:00	t	f
2037	EnGeo	2024-03-06 06:10:00	f	f
357	King	2024-03-06 06:10:00	f	f
202	Phys/Chem	2024-03-06 06:20:00	f	f
358	King	2024-03-06 06:20:00	f	t
101	Phys/Chem	2024-03-06 06:20:00	f	f
2020	EnGeo	2024-03-06 06:20:00	t	f
2037	EnGeo	2024-03-06 06:20:00	f	f
357	King	2024-03-06 06:20:00	f	f
202	Phys/Chem	2024-03-06 06:30:00	f	f
358	King	2024-03-06 06:30:00	f	t
101	Phys/Chem	2024-03-06 06:30:00	f	f
2020	EnGeo	2024-03-06 06:30:00	t	f
2037	EnGeo	2024-03-06 06:30:00	f	f
357	King	2024-03-06 06:30:00	f	f
202	Phys/Chem	2024-03-06 06:40:00	f	f
358	King	2024-03-06 06:40:00	f	t
101	Phys/Chem	2024-03-06 06:40:00	f	f
2020	EnGeo	2024-03-06 06:40:00	t	f
2037	EnGeo	2024-03-06 06:40:00	f	f
357	King	2024-03-06 06:40:00	f	f
202	Phys/Chem	2024-03-06 06:50:00	f	f
358	King	2024-03-06 06:50:00	f	t
101	Phys/Chem	2024-03-06 06:50:00	f	f
2020	EnGeo	2024-03-06 06:50:00	t	f
2037	EnGeo	2024-03-06 06:50:00	f	f
357	King	2024-03-06 06:50:00	f	f
\.


--
-- Name: Employee_Check_Study_Room Employee_Check_Study_Room_pkey; Type: CONSTRAINT; Schema: occupancy; Owner: centralteam
--

ALTER TABLE ONLY occupancy."Employee_Check_Study_Room"
    ADD CONSTRAINT "Employee_Check_Study_Room_pkey" PRIMARY KEY (employee_username, room_num, room_hall);


--
-- Name: Employee Employee_pkey; Type: CONSTRAINT; Schema: occupancy; Owner: centralteam
--

ALTER TABLE ONLY occupancy."Employee"
    ADD CONSTRAINT "Employee_pkey" PRIMARY KEY (username);


--
-- Name: Hall Hall_pkey; Type: CONSTRAINT; Schema: occupancy; Owner: centralteam
--

ALTER TABLE ONLY occupancy."Hall"
    ADD CONSTRAINT "Hall_pkey" PRIMARY KEY (hall_name);


--
-- Name: Student Student_pkey; Type: CONSTRAINT; Schema: occupancy; Owner: centralteam
--

ALTER TABLE ONLY occupancy."Student"
    ADD CONSTRAINT "Student_pkey" PRIMARY KEY (username);


--
-- Name: Study_Room_History Study_Room_History_pkey; Type: CONSTRAINT; Schema: occupancy; Owner: centralteam
--

ALTER TABLE ONLY occupancy."Study_Room_History"
    ADD CONSTRAINT "Study_Room_History_pkey" PRIMARY KEY (room_num, hall_name, date_time);


--
-- Name: Study_Room Study_Room_pkey; Type: CONSTRAINT; Schema: occupancy; Owner: centralteam
--

ALTER TABLE ONLY occupancy."Study_Room"
    ADD CONSTRAINT "Study_Room_pkey" PRIMARY KEY (room_num, hall_name);


--
-- Name: Schedule_Room pk_schedule_id; Type: CONSTRAINT; Schema: occupancy; Owner: centralteam
--

ALTER TABLE ONLY occupancy."Schedule_Room"
    ADD CONSTRAINT pk_schedule_id PRIMARY KEY (schedule_id);


--
-- Name: Employee_Check_Study_Room fk_employee; Type: FK CONSTRAINT; Schema: occupancy; Owner: centralteam
--

ALTER TABLE ONLY occupancy."Employee_Check_Study_Room"
    ADD CONSTRAINT fk_employee FOREIGN KEY (employee_username) REFERENCES occupancy."Employee"(username) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Study_Room fk_hall; Type: FK CONSTRAINT; Schema: occupancy; Owner: centralteam
--

ALTER TABLE ONLY occupancy."Study_Room"
    ADD CONSTRAINT fk_hall FOREIGN KEY (hall_name) REFERENCES occupancy."Hall"(hall_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Schedule_Room fk_room_id; Type: FK CONSTRAINT; Schema: occupancy; Owner: centralteam
--

ALTER TABLE ONLY occupancy."Schedule_Room"
    ADD CONSTRAINT fk_room_id FOREIGN KEY (room_num, room_hall) REFERENCES occupancy."Study_Room"(room_num, hall_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Employee_Check_Study_Room fk_study_room; Type: FK CONSTRAINT; Schema: occupancy; Owner: centralteam
--

ALTER TABLE ONLY occupancy."Employee_Check_Study_Room"
    ADD CONSTRAINT fk_study_room FOREIGN KEY (room_num, room_hall) REFERENCES occupancy."Study_Room"(room_num, hall_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Study_Room_History fk_study_room; Type: FK CONSTRAINT; Schema: occupancy; Owner: centralteam
--

ALTER TABLE ONLY occupancy."Study_Room_History"
    ADD CONSTRAINT fk_study_room FOREIGN KEY (room_num, hall_name) REFERENCES occupancy."Study_Room"(room_num, hall_name) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Schedule_Room fk_username; Type: FK CONSTRAINT; Schema: occupancy; Owner: centralteam
--

ALTER TABLE ONLY occupancy."Schedule_Room"
    ADD CONSTRAINT fk_username FOREIGN KEY (username) REFERENCES occupancy."Student"(username) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

