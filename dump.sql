--
-- PostgreSQL database dump
--

-- Dumped from database version 12.11 (Ubuntu 12.11-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.11 (Ubuntu 12.11-0ubuntu0.20.04.1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: sections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sections (
    id integer NOT NULL,
    "userId" integer NOT NULL,
    token text NOT NULL
);


ALTER TABLE public.sections OWNER TO postgres;

--
-- Name: sections_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sections_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sections_id_seq OWNER TO postgres;

--
-- Name: sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sections_id_seq OWNED BY public.sections.id;


--
-- Name: urlOriginal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."urlOriginal" (
    id integer NOT NULL,
    url text NOT NULL,
    "userId" integer NOT NULL
);


ALTER TABLE public."urlOriginal" OWNER TO postgres;

--
-- Name: urlOriginal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."urlOriginal_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."urlOriginal_id_seq" OWNER TO postgres;

--
-- Name: urlOriginal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."urlOriginal_id_seq" OWNED BY public."urlOriginal".id;


--
-- Name: urlShort; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."urlShort" (
    id integer NOT NULL,
    "urlShort" text NOT NULL,
    "urlOriginalId" integer NOT NULL,
    "visitCount" integer NOT NULL
);


ALTER TABLE public."urlShort" OWNER TO postgres;

--
-- Name: urlShort_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."urlShort_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."urlShort_id_seq" OWNER TO postgres;

--
-- Name: urlShort_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."urlShort_id_seq" OWNED BY public."urlShort".id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: sections id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections ALTER COLUMN id SET DEFAULT nextval('public.sections_id_seq'::regclass);


--
-- Name: urlOriginal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."urlOriginal" ALTER COLUMN id SET DEFAULT nextval('public."urlOriginal_id_seq"'::regclass);


--
-- Name: urlShort id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."urlShort" ALTER COLUMN id SET DEFAULT nextval('public."urlShort_id_seq"'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: sections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sections (id, "userId", token) FROM stdin;
1	1	3b9e738c-344a-46a5-b311-6cdf4c623178
\.


--
-- Data for Name: urlOriginal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."urlOriginal" (id, url, "userId") FROM stdin;
6	facebook.com	1
12	google.com	1
13	trello.com	1
\.


--
-- Data for Name: urlShort; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."urlShort" (id, "urlShort", "urlOriginalId", "visitCount") FROM stdin;
6	qhDcyDKgF4	6	0
7	S5pimcHr-o	12	0
8	-XNpPtaCEw	13	0
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password) FROM stdin;
1	joão	joao2@gmail.com	$2b$10$GMu3JJ7pEWpACHOQveQ1ReeACDY1kOKb6MNlhVBPgZa4/MlR1os/e
\.


--
-- Name: sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sections_id_seq', 1, true);


--
-- Name: urlOriginal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."urlOriginal_id_seq"', 13, true);


--
-- Name: urlShort_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."urlShort_id_seq"', 8, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: sections sections_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pk PRIMARY KEY (id);


--
-- Name: sections sections_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_token_key UNIQUE (token);


--
-- Name: urlOriginal urlOriginal_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."urlOriginal"
    ADD CONSTRAINT "urlOriginal_pk" PRIMARY KEY (id);


--
-- Name: urlShort urlShort_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."urlShort"
    ADD CONSTRAINT "urlShort_pk" PRIMARY KEY (id);


--
-- Name: urlShort urlShort_urlShort_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."urlShort"
    ADD CONSTRAINT "urlShort_urlShort_key" UNIQUE ("urlShort");


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- Name: sections sections_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_fk0 FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: urlOriginal urlOriginal_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."urlOriginal"
    ADD CONSTRAINT "urlOriginal_fk0" FOREIGN KEY ("userId") REFERENCES public.users(id);


--
-- Name: urlShort urlShort_fk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."urlShort"
    ADD CONSTRAINT "urlShort_fk0" FOREIGN KEY ("urlOriginalId") REFERENCES public."urlOriginal"(id);


--
-- PostgreSQL database dump complete
--

