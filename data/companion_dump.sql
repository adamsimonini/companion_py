--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

-- Started on 2022-01-05 19:11:06 UTC

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
-- TOC entry 205 (class 1259 OID 16677)
-- Name: city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.city (
    id integer NOT NULL,
    city_name text NOT NULL,
    fk_country_id integer NOT NULL
);


ALTER TABLE public.city OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16675)
-- Name: city_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_id_seq OWNER TO postgres;

--
-- TOC entry 3089 (class 0 OID 0)
-- Dependencies: 204
-- Name: city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.city_id_seq OWNED BY public.city.id;


--
-- TOC entry 209 (class 1259 OID 16706)
-- Name: companion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.companion (
    id integer NOT NULL,
    name text NOT NULL,
    sex text NOT NULL,
    hourly_rate smallint DEFAULT 30,
    is_active boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fk_user_account_id integer NOT NULL,
    fk_sexual_orientation_id smallint NOT NULL,
    fk_city_id integer NOT NULL
);


ALTER TABLE public.companion OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16704)
-- Name: companion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.companion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.companion_id_seq OWNER TO postgres;

--
-- TOC entry 3090 (class 0 OID 0)
-- Dependencies: 208
-- Name: companion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.companion_id_seq OWNED BY public.companion.id;


--
-- TOC entry 203 (class 1259 OID 16664)
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    id integer NOT NULL,
    country_name text NOT NULL
);


ALTER TABLE public.country OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16662)
-- Name: country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.country_id_seq OWNER TO postgres;

--
-- TOC entry 3091 (class 0 OID 0)
-- Dependencies: 202
-- Name: country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.country_id_seq OWNED BY public.country.id;


--
-- TOC entry 213 (class 1259 OID 16766)
-- Name: meeting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.meeting (
    meeting_id integer NOT NULL,
    datetime timestamp without time zone NOT NULL,
    fk_patron_id integer NOT NULL,
    fk_companion_id integer NOT NULL,
    fk_city_id integer NOT NULL
);


ALTER TABLE public.meeting OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16764)
-- Name: meeting_meeting_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.meeting_meeting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meeting_meeting_id_seq OWNER TO postgres;

--
-- TOC entry 3092 (class 0 OID 0)
-- Dependencies: 212
-- Name: meeting_meeting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.meeting_meeting_id_seq OWNED BY public.meeting.meeting_id;


--
-- TOC entry 211 (class 1259 OID 16737)
-- Name: patron; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patron (
    id integer NOT NULL,
    name text NOT NULL,
    sex text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    fk_user_account_id integer NOT NULL,
    fk_sexual_orientation_id smallint NOT NULL,
    fk_city_id integer NOT NULL
);


ALTER TABLE public.patron OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16735)
-- Name: patron_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patron_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patron_id_seq OWNER TO postgres;

--
-- TOC entry 3093 (class 0 OID 0)
-- Dependencies: 210
-- Name: patron_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patron_id_seq OWNED BY public.patron.id;


--
-- TOC entry 207 (class 1259 OID 16695)
-- Name: sexual_orientation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sexual_orientation (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.sexual_orientation OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16693)
-- Name: sexual_orientation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sexual_orientation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sexual_orientation_id_seq OWNER TO postgres;

--
-- TOC entry 3094 (class 0 OID 0)
-- Dependencies: 206
-- Name: sexual_orientation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sexual_orientation_id_seq OWNED BY public.sexual_orientation.id;


--
-- TOC entry 201 (class 1259 OID 16648)
-- Name: user_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_account (
    id integer NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    phone_number text NOT NULL,
    birthday text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_account OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16646)
-- Name: user_account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_account_id_seq OWNER TO postgres;

--
-- TOC entry 3095 (class 0 OID 0)
-- Dependencies: 200
-- Name: user_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_account_id_seq OWNED BY public.user_account.id;


--
-- TOC entry 2895 (class 2604 OID 16680)
-- Name: city id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city ALTER COLUMN id SET DEFAULT nextval('public.city_id_seq'::regclass);


--
-- TOC entry 2897 (class 2604 OID 16709)
-- Name: companion id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companion ALTER COLUMN id SET DEFAULT nextval('public.companion_id_seq'::regclass);


--
-- TOC entry 2894 (class 2604 OID 16667)
-- Name: country id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country ALTER COLUMN id SET DEFAULT nextval('public.country_id_seq'::regclass);


--
-- TOC entry 2903 (class 2604 OID 16769)
-- Name: meeting meeting_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meeting ALTER COLUMN meeting_id SET DEFAULT nextval('public.meeting_meeting_id_seq'::regclass);


--
-- TOC entry 2901 (class 2604 OID 16740)
-- Name: patron id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patron ALTER COLUMN id SET DEFAULT nextval('public.patron_id_seq'::regclass);


--
-- TOC entry 2896 (class 2604 OID 16698)
-- Name: sexual_orientation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sexual_orientation ALTER COLUMN id SET DEFAULT nextval('public.sexual_orientation_id_seq'::regclass);


--
-- TOC entry 2892 (class 2604 OID 16651)
-- Name: user_account id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_account ALTER COLUMN id SET DEFAULT nextval('public.user_account_id_seq'::regclass);


--
-- TOC entry 3075 (class 0 OID 16677)
-- Dependencies: 205
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.city (id, city_name, fk_country_id) FROM stdin;
1	Toronto	1
2	Los Angeles	2
3	Mexico City	3
4	Rome	4
5	Tokyo	5
\.


--
-- TOC entry 3079 (class 0 OID 16706)
-- Dependencies: 209
-- Data for Name: companion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.companion (id, name, sex, hourly_rate, is_active, created_at, fk_user_account_id, fk_sexual_orientation_id, fk_city_id) FROM stdin;
1	Julia	female	30	f	2022-01-05 19:07:44.031+00	1	1	1
2	Alexis	female	35	t	2022-01-05 19:07:44.031+00	3	2	3
\.


--
-- TOC entry 3073 (class 0 OID 16664)
-- Dependencies: 203
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country (id, country_name) FROM stdin;
1	Canada
2	USA
3	Mexico
4	Italy
5	Japan
\.


--
-- TOC entry 3083 (class 0 OID 16766)
-- Dependencies: 213
-- Data for Name: meeting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.meeting (meeting_id, datetime, fk_patron_id, fk_companion_id, fk_city_id) FROM stdin;
\.


--
-- TOC entry 3081 (class 0 OID 16737)
-- Dependencies: 211
-- Data for Name: patron; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patron (id, name, sex, created_at, fk_user_account_id, fk_sexual_orientation_id, fk_city_id) FROM stdin;
1	Alex	male	2022-01-05 19:07:44.031+00	1	2	1
2	Lisa	female	2022-01-05 19:07:44.031+00	2	4	3
\.


--
-- TOC entry 3077 (class 0 OID 16695)
-- Dependencies: 207
-- Data for Name: sexual_orientation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sexual_orientation (id, name) FROM stdin;
1	Straight
2	Gay
3	Bisexual
4	Queer
5	Asexual
\.


--
-- TOC entry 3071 (class 0 OID 16648)
-- Dependencies: 201
-- Data for Name: user_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_account (id, email, password, phone_number, birthday, created_at) FROM stdin;
1	efg@g.com	abcdefg	4445556666	1980-01-01	2022-01-05 19:07:44.031+00
2	hij@g.com	abcdefg	2223334455	1977-01-01	2022-01-05 19:07:44.031+00
3	lmn@g.com	abcdefg	9998887766	1998-01-01	2022-01-05 19:07:44.031+00
4	opq@g.com	abcdefg	5556667788	1988-01-01	2022-01-05 19:07:44.031+00
\.


--
-- TOC entry 3096 (class 0 OID 0)
-- Dependencies: 204
-- Name: city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.city_id_seq', 5, true);


--
-- TOC entry 3097 (class 0 OID 0)
-- Dependencies: 208
-- Name: companion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.companion_id_seq', 2, true);


--
-- TOC entry 3098 (class 0 OID 0)
-- Dependencies: 202
-- Name: country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.country_id_seq', 5, true);


--
-- TOC entry 3099 (class 0 OID 0)
-- Dependencies: 212
-- Name: meeting_meeting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.meeting_meeting_id_seq', 1, false);


--
-- TOC entry 3100 (class 0 OID 0)
-- Dependencies: 210
-- Name: patron_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patron_id_seq', 2, true);


--
-- TOC entry 3101 (class 0 OID 0)
-- Dependencies: 206
-- Name: sexual_orientation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sexual_orientation_id_seq', 5, true);


--
-- TOC entry 3102 (class 0 OID 0)
-- Dependencies: 200
-- Name: user_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_account_id_seq', 4, true);


--
-- TOC entry 2915 (class 2606 OID 16687)
-- Name: city city_city_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_city_name_key UNIQUE (city_name);


--
-- TOC entry 2917 (class 2606 OID 16685)
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- TOC entry 2921 (class 2606 OID 16719)
-- Name: companion companion_fk_user_account_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companion
    ADD CONSTRAINT companion_fk_user_account_id_key UNIQUE (fk_user_account_id);


--
-- TOC entry 2923 (class 2606 OID 16717)
-- Name: companion companion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companion
    ADD CONSTRAINT companion_pkey PRIMARY KEY (id);


--
-- TOC entry 2911 (class 2606 OID 16674)
-- Name: country country_country_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_country_name_key UNIQUE (country_name);


--
-- TOC entry 2913 (class 2606 OID 16672)
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- TOC entry 2929 (class 2606 OID 16771)
-- Name: meeting meeting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meeting
    ADD CONSTRAINT meeting_pkey PRIMARY KEY (meeting_id);


--
-- TOC entry 2925 (class 2606 OID 16748)
-- Name: patron patron_fk_user_account_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patron
    ADD CONSTRAINT patron_fk_user_account_id_key UNIQUE (fk_user_account_id);


--
-- TOC entry 2927 (class 2606 OID 16746)
-- Name: patron patron_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patron
    ADD CONSTRAINT patron_pkey PRIMARY KEY (id);


--
-- TOC entry 2919 (class 2606 OID 16703)
-- Name: sexual_orientation sexual_orientation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sexual_orientation
    ADD CONSTRAINT sexual_orientation_pkey PRIMARY KEY (id);


--
-- TOC entry 2905 (class 2606 OID 16659)
-- Name: user_account user_account_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_email_key UNIQUE (email);


--
-- TOC entry 2907 (class 2606 OID 16661)
-- Name: user_account user_account_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_phone_number_key UNIQUE (phone_number);


--
-- TOC entry 2909 (class 2606 OID 16657)
-- Name: user_account user_account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (id);


--
-- TOC entry 2930 (class 2606 OID 16688)
-- Name: city city_fk_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_fk_country_id_fkey FOREIGN KEY (fk_country_id) REFERENCES public.country(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2933 (class 2606 OID 16730)
-- Name: companion companion_fk_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companion
    ADD CONSTRAINT companion_fk_city_id_fkey FOREIGN KEY (fk_city_id) REFERENCES public.city(id) ON DELETE CASCADE;


--
-- TOC entry 2932 (class 2606 OID 16725)
-- Name: companion companion_fk_sexual_orientation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companion
    ADD CONSTRAINT companion_fk_sexual_orientation_id_fkey FOREIGN KEY (fk_sexual_orientation_id) REFERENCES public.sexual_orientation(id) ON DELETE CASCADE;


--
-- TOC entry 2931 (class 2606 OID 16720)
-- Name: companion companion_fk_user_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.companion
    ADD CONSTRAINT companion_fk_user_account_id_fkey FOREIGN KEY (fk_user_account_id) REFERENCES public.user_account(id) ON DELETE CASCADE;


--
-- TOC entry 2937 (class 2606 OID 16772)
-- Name: meeting meeting_fk_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meeting
    ADD CONSTRAINT meeting_fk_city_id_fkey FOREIGN KEY (fk_city_id) REFERENCES public.city(id) ON DELETE CASCADE;


--
-- TOC entry 2939 (class 2606 OID 16782)
-- Name: meeting meeting_fk_companion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meeting
    ADD CONSTRAINT meeting_fk_companion_id_fkey FOREIGN KEY (fk_companion_id) REFERENCES public.companion(id) ON DELETE CASCADE;


--
-- TOC entry 2938 (class 2606 OID 16777)
-- Name: meeting meeting_fk_patron_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.meeting
    ADD CONSTRAINT meeting_fk_patron_id_fkey FOREIGN KEY (fk_patron_id) REFERENCES public.patron(id) ON DELETE CASCADE;


--
-- TOC entry 2936 (class 2606 OID 16759)
-- Name: patron patron_fk_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patron
    ADD CONSTRAINT patron_fk_city_id_fkey FOREIGN KEY (fk_city_id) REFERENCES public.city(id) ON DELETE CASCADE;


--
-- TOC entry 2935 (class 2606 OID 16754)
-- Name: patron patron_fk_sexual_orientation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patron
    ADD CONSTRAINT patron_fk_sexual_orientation_id_fkey FOREIGN KEY (fk_sexual_orientation_id) REFERENCES public.sexual_orientation(id) ON DELETE CASCADE;


--
-- TOC entry 2934 (class 2606 OID 16749)
-- Name: patron patron_fk_user_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patron
    ADD CONSTRAINT patron_fk_user_account_id_fkey FOREIGN KEY (fk_user_account_id) REFERENCES public.user_account(id) ON DELETE CASCADE;


-- Completed on 2022-01-05 19:11:07 UTC

--
-- PostgreSQL database dump complete
--

