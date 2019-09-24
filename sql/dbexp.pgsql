--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1 (Debian 11.1-2)
-- Dumped by pg_dump version 11.1 (Debian 11.1-2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status (
    id integer NOT NULL,
    name character varying NOT NULL,
    team_n integer,
    status character varying
);


ALTER TABLE public.status OWNER TO postgres;

--
-- Name: names_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.names_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.names_id_seq OWNER TO postgres;

--
-- Name: names_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.names_id_seq OWNED BY public.status.id;


--
-- Name: statusp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.statusp (
    id integer NOT NULL,
    name character varying NOT NULL,
    status character varying NOT NULL,
    duration integer NOT NULL,
    team_id integer
);


ALTER TABLE public.statusp OWNER TO postgres;

--
-- Name: statusp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.statusp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.statusp_id_seq OWNER TO postgres;

--
-- Name: statusp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.statusp_id_seq OWNED BY public.statusp.id;


--
-- Name: team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team (
    id integer NOT NULL,
    team character varying NOT NULL
);


ALTER TABLE public.team OWNER TO postgres;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_id_seq OWNER TO postgres;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teams_id_seq OWNED BY public.team.id;


--
-- Name: status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status ALTER COLUMN id SET DEFAULT nextval('public.names_id_seq'::regclass);


--
-- Name: statusp id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statusp ALTER COLUMN id SET DEFAULT nextval('public.statusp_id_seq'::regclass);


--
-- Name: team id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team ALTER COLUMN id SET DEFAULT nextval('public.teams_id_seq'::regclass);


--
-- Data for Name: status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.status (id, name, team_n, status) FROM stdin;
1	Adam	1	Online
2	Jakub	1	Offline
3	Pawel.B	2	Offline
4	Pawel.K	1	Online
5	Mark	3	Offline
6	Justyna	2	Online
7	Adrian	3	Offline
8	Lukas	3	Offline
\.


--
-- Data for Name: statusp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.statusp (id, name, status, duration, team_id) FROM stdin;
1	Adam	Offline	240	1
2	Jakub	Online	160	1
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team (id, team) FROM stdin;
1	WAF
2	AF
3	DDOS
\.


--
-- Name: names_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.names_id_seq', 23, true);


--
-- Name: statusp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.statusp_id_seq', 2, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teams_id_seq', 3, true);


--
-- Name: status names_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT names_pkey PRIMARY KEY (id);


--
-- Name: statusp statusp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.statusp
    ADD CONSTRAINT statusp_pkey PRIMARY KEY (id);


--
-- Name: team teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: status names_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT names_team_id_fkey FOREIGN KEY (team_n) REFERENCES public.team(id);


--
-- PostgreSQL database dump complete
--

