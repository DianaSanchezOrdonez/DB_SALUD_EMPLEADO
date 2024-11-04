--
-- PostgreSQL database dump
--

-- Dumped from database version 15.7 (Postgres.app)
-- Dumped by pg_dump version 15.7 (Postgres.app)

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
-- Name: contrato; Type: TABLE; Schema: public; Owner: dianasanchezordonez
--

CREATE TABLE public.contrato (
    empleado_id character varying(20) NOT NULL,
    empresa_id character varying(20),
    periodo character varying(7) NOT NULL,
    puesto_trabajo character varying(50) NOT NULL,
    modalidad_trabajo character varying(10) NOT NULL,
    CONSTRAINT chk_modalidad_trabajo CHECK (((modalidad_trabajo)::text = ANY ((ARRAY['Remoto'::character varying, 'Hibrido'::character varying, 'Presencial'::character varying])::text[]))),
    CONSTRAINT chk_periodo CHECK (((periodo)::text ~ '^\d{4}-(0[1-2])$'::text))
);


ALTER TABLE public.contrato OWNER TO dianasanchezordonez;

--
-- Name: edesempenio; Type: TABLE; Schema: public; Owner: dianasanchezordonez
--

CREATE TABLE public.edesempenio (
    codigo integer NOT NULL,
    productividad_impacto integer NOT NULL,
    satisfaccion_trabajo integer NOT NULL,
    empleado_id character varying(20) NOT NULL,
    periodo character varying(7) NOT NULL,
    CONSTRAINT chk_productividad_impacto CHECK (((productividad_impacto >= '-1'::integer) AND (productividad_impacto <= 1))),
    CONSTRAINT chk_satisfaccion_trabajo CHECK (((satisfaccion_trabajo >= 1) AND (satisfaccion_trabajo <= 5)))
);


ALTER TABLE public.edesempenio OWNER TO dianasanchezordonez;

--
-- Name: edesempenio_codigo_seq; Type: SEQUENCE; Schema: public; Owner: dianasanchezordonez
--

CREATE SEQUENCE public.edesempenio_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.edesempenio_codigo_seq OWNER TO dianasanchezordonez;

--
-- Name: edesempenio_codigo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dianasanchezordonez
--

ALTER SEQUENCE public.edesempenio_codigo_seq OWNED BY public.edesempenio.codigo;


--
-- Name: empleado; Type: TABLE; Schema: public; Owner: dianasanchezordonez
--

CREATE TABLE public.empleado (
    empleado_id character varying(20) NOT NULL,
    nombres character varying(100) NOT NULL,
    apellidos character varying(100) NOT NULL,
    fecha_nacimiento date NOT NULL,
    genero character varying(20) NOT NULL,
    anios_experiencia integer NOT NULL,
    rating_equilibrio_vida_laboral integer NOT NULL,
    num_reuniones_virtuales integer NOT NULL,
    horas_trabajadas_por_semana double precision NOT NULL,
    CONSTRAINT chk_empleado_id CHECK (((empleado_id)::text ~~ 'EMP%'::text)),
    CONSTRAINT chk_experiencia CHECK ((anios_experiencia >= 0)),
    CONSTRAINT chk_genero CHECK (((genero)::text = ANY ((ARRAY['masculino'::character varying, 'femenino'::character varying, 'no mencionar'::character varying])::text[]))),
    CONSTRAINT chk_horas_trabajadas_por_semana CHECK (((horas_trabajadas_por_semana >= (20)::double precision) AND (horas_trabajadas_por_semana <= (60)::double precision))),
    CONSTRAINT chk_mayor_de_edad CHECK ((date_part('year'::text, age((fecha_nacimiento)::timestamp with time zone)) >= (18)::double precision)),
    CONSTRAINT chk_rating_vida_laboral CHECK (((rating_equilibrio_vida_laboral >= 1) AND (rating_equilibrio_vida_laboral <= 5))),
    CONSTRAINT chk_reuniones_virtuales CHECK ((num_reuniones_virtuales >= 0))
);


ALTER TABLE public.empleado OWNER TO dianasanchezordonez;

--
-- Name: empresa; Type: TABLE; Schema: public; Owner: dianasanchezordonez
--

CREATE TABLE public.empresa (
    empresa_id character varying(20) NOT NULL,
    nombre character varying(100) NOT NULL,
    industria character varying(50) NOT NULL
);


ALTER TABLE public.empresa OWNER TO dianasanchezordonez;

--
-- Name: saludmental; Type: TABLE; Schema: public; Owner: dianasanchezordonez
--

CREATE TABLE public.saludmental (
    codigo integer NOT NULL,
    rating_aislamiento_social integer NOT NULL,
    freq_actividad_fisica integer NOT NULL,
    calidad_suenio integer NOT NULL,
    nivel_estres integer NOT NULL,
    diagnostico character varying(30) NOT NULL,
    empleado_id character varying(20) NOT NULL,
    periodo character varying(7) NOT NULL,
    CONSTRAINT chk_calidad_suenio CHECK (((calidad_suenio >= 1) AND (calidad_suenio <= 5))),
    CONSTRAINT chk_freq_actividad_fisica CHECK (((freq_actividad_fisica >= 1) AND (freq_actividad_fisica <= 5))),
    CONSTRAINT chk_nivel_estres CHECK (((nivel_estres >= 1) AND (nivel_estres <= 5))),
    CONSTRAINT chk_rating_aislamiento_social CHECK (((rating_aislamiento_social >= 1) AND (rating_aislamiento_social <= 5)))
);


ALTER TABLE public.saludmental OWNER TO dianasanchezordonez;

--
-- Name: saludmental_codigo_seq; Type: SEQUENCE; Schema: public; Owner: dianasanchezordonez
--

CREATE SEQUENCE public.saludmental_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.saludmental_codigo_seq OWNER TO dianasanchezordonez;

--
-- Name: saludmental_codigo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dianasanchezordonez
--

ALTER SEQUENCE public.saludmental_codigo_seq OWNED BY public.saludmental.codigo;


--
-- Name: edesempenio codigo; Type: DEFAULT; Schema: public; Owner: dianasanchezordonez
--

ALTER TABLE ONLY public.edesempenio ALTER COLUMN codigo SET DEFAULT nextval('public.edesempenio_codigo_seq'::regclass);


--
-- Name: saludmental codigo; Type: DEFAULT; Schema: public; Owner: dianasanchezordonez
--

ALTER TABLE ONLY public.saludmental ALTER COLUMN codigo SET DEFAULT nextval('public.saludmental_codigo_seq'::regclass);


--
-- Data for Name: contrato; Type: TABLE DATA; Schema: public; Owner: dianasanchezordonez
--

COPY public.contrato (empleado_id, empresa_id, periodo, puesto_trabajo, modalidad_trabajo) FROM stdin;
EMP0000001	EMPRESA0000052	2012-01	Frontend Developer	Remoto
EMP0000002	EMPRESA0000079	2009-01	Backend Developer	Hibrido
EMP0000003	EMPRESA0000063	2009-01	Full Stack Developer	Presencial
EMP0000004	EMPRESA0000112	2012-01	Data Scientist	Hibrido
EMP0000005	EMPRESA0000016	2004-01	DevOps Engineer	Remoto
EMP0000006	EMPRESA0000120	2000-02	Cloud Architect	Hibrido
EMP0000007	EMPRESA0000126	2004-01	Systems Administrator	Remoto
EMP0000008	EMPRESA0000120	2000-02	Machine Learning Engineer	Presencial
EMP0000009	EMPRESA0000077	2016-01	Database Administrator	Remoto
EMP0000010	EMPRESA0000089	2016-01	IT Support Specialist	Presencial
EMP0000011	EMPRESA0000026	2023-01	Security Analyst	Hibrido
EMP0000012	EMPRESA0000101	2016-02	Network Engineer	Presencial
EMP0000013	EMPRESA0000138	2004-02	AI Researcher	Remoto
EMP0000014	EMPRESA0000023	2002-01	Mobile App Developer	Remoto
EMP0000015	EMPRESA0000126	2014-01	Product Manager	Presencial
EMP0000016	EMPRESA0000120	2004-02	UI/UX Designer	Hibrido
EMP0000017	EMPRESA0000094	2020-01	Blockchain Developer	Presencial
EMP0000018	EMPRESA0000005	2022-02	Cybersecurity Specialist	Hibrido
EMP0000019	EMPRESA0000003	2016-01	Solutions Architect	Remoto
EMP0000020	EMPRESA0000114	2019-01	Data Analyst	Hibrido
EMP0000021	EMPRESA0000149	2016-02	Game Developer	Remoto
EMP0000022	EMPRESA0000053	2002-02	Business Intelligence Analyst	Hibrido
EMP0000023	EMPRESA0000041	2024-01	Site Reliability Engineer	Presencial
EMP0000024	EMPRESA0000141	2022-02	Quality Assurance Engineer	Remoto
EMP0000025	EMPRESA0000112	2011-02	Technical Support Engineer	Remoto
EMP0000026	EMPRESA0000149	2003-01	Technical Writer	Remoto
EMP0000027	EMPRESA0000059	2023-02	Embedded Systems Engineer	Presencial
EMP0000028	EMPRESA0000095	2006-01	Computer Vision Engineer	Remoto
EMP0000029	EMPRESA0000040	2024-02	Web Developer	Presencial
EMP0000030	EMPRESA0000046	2009-01	API Developer	Remoto
EMP0000031	EMPRESA0000149	2014-01	Robotics Engineer	Remoto
EMP0000032	EMPRESA0000060	2006-01	Software Architect	Presencial
EMP0000033	EMPRESA0000147	2022-02	Big Data Engineer	Presencial
EMP0000034	EMPRESA0000053	2018-01	Network Security Engineer	Hibrido
EMP0000035	EMPRESA0000051	2006-02	Cloud Engineer	Presencial
EMP0000036	EMPRESA0000041	2004-01	Artificial Intelligence Engineer	Remoto
EMP0000037	EMPRESA0000120	2020-02	Augmented Reality Developer	Presencial
EMP0000038	EMPRESA0000133	2019-02	Virtual Reality Developer	Remoto
EMP0000039	EMPRESA0000128	2004-02	IT Project Manager	Presencial
EMP0000040	EMPRESA0000146	2010-01	Automation Engineer	Presencial
EMP0000041	EMPRESA0000001	2019-01	Penetration Tester	Remoto
EMP0000042	EMPRESA0000084	2007-01	CRM Developer	Hibrido
EMP0000043	EMPRESA0000039	2004-02	Data Engineer	Presencial
EMP0000044	EMPRESA0000026	2000-01	Help Desk Technician	Presencial
EMP0000045	EMPRESA0000150	2024-01	Solutions Engineer	Hibrido
EMP0000046	EMPRESA0000124	2006-02	IT Consultant	Remoto
EMP0000047	EMPRESA0000111	2017-01	IoT Developer	Hibrido
EMP0000048	EMPRESA0000121	2019-01	Software Tester	Presencial
EMP0000049	EMPRESA0000122	2012-01	Security Engineer	Hibrido
EMP0000050	EMPRESA0000066	2024-01	Database Engineer	Hibrido
EMP0000051	EMPRESA0000116	2017-02	IT Operations Manager	Hibrido
EMP0000052	EMPRESA0000127	2017-01	Cybersecurity Consultant	Remoto
EMP0000053	EMPRESA0000030	2022-01	Digital Transformation Manager	Remoto
EMP0000054	EMPRESA0000118	2009-01	Cloud Solutions Specialist	Hibrido
EMP0000055	EMPRESA0000131	2023-01	Systems Engineer	Remoto
EMP0000056	EMPRESA0000069	2001-02	Mobile Architect	Remoto
EMP0000057	EMPRESA0000132	2006-02	Data Warehouse Engineer	Presencial
EMP0000058	EMPRESA0000005	2005-01	Application Developer	Remoto
EMP0000059	EMPRESA0000126	2000-01	Cloud Consultant	Hibrido
EMP0000060	EMPRESA0000127	2000-01	Blockchain Analyst	Presencial
EMP0000061	EMPRESA0000143	2023-02	User Researcher	Hibrido
EMP0000062	EMPRESA0000082	2014-02	Machine Learning Developer	Presencial
EMP0000063	EMPRESA0000006	2008-01	Algorithm Developer	Remoto
EMP0000064	EMPRESA0000093	2005-01	Data Operations Analyst	Presencial
EMP0000065	EMPRESA0000142	2003-02	Tech Support Specialist	Remoto
EMP0000066	EMPRESA0000035	2015-02	Cloud Infrastructure Engineer	Hibrido
EMP0000067	EMPRESA0000099	2015-02	DevSecOps Engineer	Remoto
EMP0000068	EMPRESA0000134	2016-01	Information Systems Manager	Remoto
EMP0000069	EMPRESA0000053	2024-02	Scrum Master	Remoto
EMP0000070	EMPRESA0000008	2005-01	Firmware Engineer	Presencial
EMP0000071	EMPRESA0000101	2006-01	Network Architect	Remoto
EMP0000072	EMPRESA0000072	2011-01	Virtualization Engineer	Hibrido
EMP0000073	EMPRESA0000032	2001-01	IT Analyst	Hibrido
EMP0000074	EMPRESA0000132	2003-02	Chief Technology Officer (CTO)	Hibrido
EMP0000075	EMPRESA0000110	2016-02	Chief Information Officer (CIO)	Remoto
EMP0000076	EMPRESA0000143	2021-01	Release Manager	Hibrido
EMP0000077	EMPRESA0000130	2002-02	ERP Developer	Presencial
EMP0000078	EMPRESA0000032	2013-02	SAP Consultant	Presencial
EMP0000079	EMPRESA0000058	2007-02	Front-End Architect	Hibrido
EMP0000080	EMPRESA0000124	2000-01	Digital Marketing Technologist	Remoto
EMP0000081	EMPRESA0000144	2008-01	Technical Recruiter	Remoto
EMP0000082	EMPRESA0000067	2010-02	Solutions Developer	Remoto
EMP0000083	EMPRESA0000035	2012-02	Data Governance Analyst	Presencial
EMP0000084	EMPRESA0000017	2016-02	Mobile Security Analyst	Hibrido
EMP0000085	EMPRESA0000060	2007-02	Cloud Security Engineer	Hibrido
EMP0000086	EMPRESA0000011	2016-02	AI Trainer	Remoto
EMP0000087	EMPRESA0000136	2023-01	Tech Evangelist	Remoto
EMP0000088	EMPRESA0000106	2013-02	IT Risk Analyst	Remoto
EMP0000089	EMPRESA0000008	2001-02	IT Auditor	Presencial
EMP0000090	EMPRESA0000075	2023-01	Mobile Product Manager	Remoto
EMP0000091	EMPRESA0000005	2003-01	Infrastructure Engineer	Hibrido
EMP0000092	EMPRESA0000123	2004-01	Incident Response Analyst	Hibrido
EMP0000093	EMPRESA0000018	2020-01	Server Administrator	Hibrido
EMP0000094	EMPRESA0000139	2011-02	IT Trainer	Presencial
EMP0000095	EMPRESA0000054	2010-01	Data Visualization Engineer	Presencial
EMP0000096	EMPRESA0000144	2008-01	E-commerce Developer	Remoto
EMP0000097	EMPRESA0000066	2013-02	Digital Forensics Analyst	Hibrido
EMP0000098	EMPRESA0000029	2011-01	Innovation Manager	Hibrido
EMP0000099	EMPRESA0000011	2014-01	Software Engineer	Hibrido
EMP0000100	EMPRESA0000079	2024-01	Frontend Developer	Hibrido
\.


--
-- Data for Name: edesempenio; Type: TABLE DATA; Schema: public; Owner: dianasanchezordonez
--

COPY public.edesempenio (codigo, productividad_impacto, satisfaccion_trabajo, empleado_id, periodo) FROM stdin;
1	1	1	EMP0000001	2012-01
2	1	3	EMP0000002	2009-01
3	0	3	EMP0000003	2009-01
4	0	1	EMP0000004	2012-01
5	0	2	EMP0000005	2004-01
6	-1	1	EMP0000006	2000-02
7	-1	5	EMP0000007	2004-01
8	0	5	EMP0000008	2000-02
9	0	3	EMP0000009	2016-01
10	1	2	EMP0000010	2016-01
11	1	5	EMP0000011	2023-01
12	0	1	EMP0000012	2016-02
13	0	5	EMP0000013	2004-02
14	1	3	EMP0000014	2002-01
15	0	4	EMP0000015	2014-01
16	0	4	EMP0000016	2004-02
17	-1	4	EMP0000017	2020-01
18	1	1	EMP0000018	2022-02
19	-1	1	EMP0000019	2016-01
20	-1	1	EMP0000020	2019-01
21	0	5	EMP0000021	2016-02
22	0	2	EMP0000022	2002-02
23	1	5	EMP0000023	2024-01
24	-1	3	EMP0000024	2022-02
25	1	5	EMP0000025	2011-02
26	0	5	EMP0000026	2003-01
27	0	4	EMP0000027	2023-02
28	0	2	EMP0000028	2006-01
29	1	5	EMP0000029	2024-02
30	0	3	EMP0000030	2009-01
31	0	2	EMP0000031	2014-01
32	0	1	EMP0000032	2006-01
33	1	4	EMP0000033	2022-02
34	0	5	EMP0000034	2018-01
35	0	5	EMP0000035	2006-02
36	0	4	EMP0000036	2004-01
37	0	3	EMP0000037	2020-02
38	0	3	EMP0000038	2019-02
39	-1	5	EMP0000039	2004-02
40	0	4	EMP0000040	2010-01
41	0	2	EMP0000041	2019-01
42	1	1	EMP0000042	2007-01
43	-1	1	EMP0000043	2004-02
44	1	2	EMP0000044	2000-01
45	0	1	EMP0000045	2024-01
46	-1	1	EMP0000046	2006-02
47	-1	2	EMP0000047	2017-01
48	1	4	EMP0000048	2019-01
49	1	1	EMP0000049	2012-01
50	1	5	EMP0000050	2024-01
51	0	1	EMP0000051	2017-02
52	-1	3	EMP0000052	2017-01
53	-1	5	EMP0000053	2022-01
54	-1	2	EMP0000054	2009-01
55	0	5	EMP0000055	2023-01
56	-1	3	EMP0000056	2001-02
57	0	5	EMP0000057	2006-02
58	0	5	EMP0000058	2005-01
59	1	3	EMP0000059	2000-01
60	-1	1	EMP0000060	2000-01
61	0	5	EMP0000061	2023-02
62	-1	1	EMP0000062	2014-02
63	0	1	EMP0000063	2008-01
64	-1	2	EMP0000064	2005-01
65	-1	4	EMP0000065	2003-02
66	1	3	EMP0000066	2015-02
67	0	3	EMP0000067	2015-02
68	-1	4	EMP0000068	2016-01
69	0	1	EMP0000069	2024-02
70	-1	1	EMP0000070	2005-01
71	0	1	EMP0000071	2006-01
72	1	2	EMP0000072	2011-01
73	-1	1	EMP0000073	2001-01
74	0	3	EMP0000074	2003-02
75	-1	4	EMP0000075	2016-02
76	1	5	EMP0000076	2021-01
77	0	4	EMP0000077	2002-02
78	0	2	EMP0000078	2013-02
79	1	3	EMP0000079	2007-02
80	0	2	EMP0000080	2000-01
81	-1	3	EMP0000081	2008-01
82	0	2	EMP0000082	2010-02
83	-1	4	EMP0000083	2012-02
84	0	1	EMP0000084	2016-02
85	1	4	EMP0000085	2007-02
86	0	4	EMP0000086	2016-02
87	1	3	EMP0000087	2023-01
88	0	3	EMP0000088	2013-02
89	0	5	EMP0000089	2001-02
90	1	4	EMP0000090	2023-01
91	-1	5	EMP0000091	2003-01
92	1	4	EMP0000092	2004-01
93	-1	3	EMP0000093	2020-01
94	-1	1	EMP0000094	2011-02
95	-1	1	EMP0000095	2010-01
96	-1	5	EMP0000096	2008-01
97	-1	1	EMP0000097	2013-02
98	-1	2	EMP0000098	2011-01
99	-1	5	EMP0000099	2014-01
100	0	4	EMP0000100	2024-01
\.


--
-- Data for Name: empleado; Type: TABLE DATA; Schema: public; Owner: dianasanchezordonez
--

COPY public.empleado (empleado_id, nombres, apellidos, fecha_nacimiento, genero, anios_experiencia, rating_equilibrio_vida_laboral, num_reuniones_virtuales, horas_trabajadas_por_semana) FROM stdin;
EMP0000001	Alejandro	Serrano	1988-12-05	masculino	10	1	2	46
EMP0000002	Luis	Navarro	1980-06-17	masculino	27	4	0	46
EMP0000003	Carlos	Cruz	1977-11-04	masculino	11	3	1	20
EMP0000004	Miguel	Cabellos	1977-10-07	masculino	15	1	5	30
EMP0000005	José	Rojas	1984-07-30	masculino	5	1	11	39
EMP0000006	Manuel	Cordero	1980-03-22	masculino	21	2	6	59
EMP0000007	Juan	Castro	1972-10-23	masculino	25	2	13	39
EMP0000008	Francisco	Cano	1983-04-03	masculino	34	5	8	47
EMP0000009	Pedro	Hidalgo	1978-07-18	masculino	12	5	14	51
EMP0000010	Ricardo	Lopez	1984-04-26	masculino	1	4	15	23
EMP0000011	Sergio	Perez	1987-06-08	masculino	33	1	11	34
EMP0000012	Diego	Mora	1970-08-07	masculino	4	1	11	24
EMP0000013	Fernando	Alvarado	1997-12-18	masculino	11	2	5	60
EMP0000014	Javier	Ocampo	1977-05-07	masculino	32	4	4	52
EMP0000015	Andrés	Galindo	1997-01-29	masculino	10	4	7	24
EMP0000016	Rafael	Trujillo	1980-11-17	masculino	12	3	12	23
EMP0000017	Antonio	Cabrera	1992-09-13	masculino	28	3	8	49
EMP0000018	Adrián	Soto	1997-02-17	masculino	15	5	11	51
EMP0000019	Mario	Cisneros	1974-07-07	masculino	6	1	2	30
EMP0000020	Daniel	León	1987-11-15	masculino	9	4	12	46
EMP0000021	Pablo	Vallejo	1983-01-10	masculino	33	1	10	50
EMP0000022	Jorge	Roldán	1988-07-16	masculino	19	3	2	37
EMP0000023	Hugo	Duarte	1994-09-22	masculino	19	2	15	20
EMP0000024	David	Salas	1976-03-17	masculino	27	3	5	60
EMP0000025	Enrique	Mendoza	1980-10-15	masculino	10	5	0	52
EMP0000026	Ruben	Esquivel	1970-05-22	masculino	2	4	13	51
EMP0000027	Raúl	Yupton	1975-08-05	masculino	16	3	11	48
EMP0000028	Gabriel	Ceballos	1972-07-22	masculino	32	1	6	34
EMP0000029	Alberto	Mejía	1990-10-11	masculino	4	1	4	23
EMP0000030	Emilio	Almeida	1974-10-06	masculino	6	4	0	52
EMP0000031	Victor	Cumpa	1996-02-16	masculino	11	3	7	56
EMP0000032	Gustavo	Lara	1995-02-18	masculino	15	3	7	27
EMP0000033	Jaime	Osorio	1979-12-11	masculino	4	3	14	48
EMP0000034	Cristian	Gonzales	1981-10-25	masculino	7	1	11	27
EMP0000035	Rodrigo	Zavaleta	1983-11-05	masculino	19	4	13	53
EMP0000036	Oscar	Tovar	1988-01-12	masculino	26	1	0	36
EMP0000037	Felipe	Palacios	1970-03-14	masculino	22	3	9	41
EMP0000038	Nicolás	Villalobos	1997-06-11	masculino	34	5	3	52
EMP0000039	Armando	García	1998-05-30	masculino	29	3	6	57
EMP0000040	Simón	Pérez	1971-09-26	masculino	15	1	10	53
EMP0000041	Iván	Chávez	1985-03-19	masculino	32	2	3	57
EMP0000042	Agustín	Córdoba	1982-04-10	masculino	30	1	10	55
EMP0000043	Sebastián	Bermúdez	1980-11-07	masculino	31	1	12	30
EMP0000044	Tomás	Sánchez	1993-07-03	masculino	28	5	5	28
EMP0000045	Esteban	Campos	1986-12-12	masculino	25	1	1	23
EMP0000046	Ramiro	Polo	1977-04-20	masculino	11	4	1	53
EMP0000047	Álvaro	Barrenechea	1993-05-26	masculino	33	5	7	26
EMP0000048	Mauricio	Rojas	1991-10-24	masculino	1	2	10	35
EMP0000049	César	Valencia	1988-01-10	masculino	29	4	8	41
EMP0000050	Eduardo	Robles	1979-10-24	masculino	16	3	13	57
EMP0000051	Isabella	García	1992-08-12	femenino	7	1	4	29
EMP0000052	Olivia	Martínez	1977-07-29	femenino	10	3	13	47
EMP0000053	Sophia	López	1978-12-28	femenino	29	1	12	33
EMP0000054	Emma	Hernández	1973-09-22	femenino	24	2	5	23
EMP0000055	Ava	González	1994-05-24	femenino	2	3	0	58
EMP0000056	Mia	Rodríguez	1985-02-04	femenino	26	1	15	42
EMP0000057	Amelia	Pérez	1996-12-02	femenino	17	5	0	35
EMP0000058	Charlotte	Sánchez	1992-03-02	femenino	29	2	5	25
EMP0000059	Luna	Ramírez	1971-02-27	femenino	28	4	4	54
EMP0000060	Harper	Torres	1992-05-18	femenino	10	2	9	20
EMP0000061	Evelyn	Flores	1997-09-30	femenino	25	5	7	55
EMP0000062	Abigail	Rivera	1988-06-28	femenino	3	5	4	47
EMP0000063	Ella	Gómez	1970-02-24	femenino	22	3	6	53
EMP0000064	Scarlett	Díaz	1980-02-17	femenino	34	2	10	49
EMP0000065	Emily	Cruz	1994-01-11	femenino	30	3	14	31
EMP0000066	Sofia	Morales	1992-07-16	femenino	34	2	14	51
EMP0000067	Aria	Ortiz	1998-03-26	femenino	22	4	6	26
EMP0000068	Chloe	Gutiérrez	1980-07-06	femenino	34	2	9	22
EMP0000069	Layla	Chávez	1988-09-23	femenino	30	2	8	33
EMP0000070	Aurora	Ramos	1975-04-24	femenino	13	3	13	40
EMP0000071	Avery	Vargas	1991-07-27	femenino	12	2	7	46
EMP0000072	Grace	Castro	1973-11-21	femenino	6	1	12	36
EMP0000073	Lily	Romero	1996-09-13	femenino	7	4	4	56
EMP0000074	Zoey	Medina	1991-11-27	femenino	4	5	11	39
EMP0000075	Hannah	Guerrero	1994-10-11	femenino	33	2	9	55
EMP0000076	Hazel	Mendoza	1996-11-05	femenino	5	1	12	35
EMP0000077	Ellie	Iglesias	1972-08-19	femenino	1	1	12	44
EMP0000078	Nora	Soto	1982-01-05	femenino	9	2	6	39
EMP0000079	Stella	Peña	1974-02-09	femenino	7	4	5	55
EMP0000080	Riley	Silva	1997-03-26	femenino	22	1	8	36
EMP0000081	Victoria	Vega	1994-07-03	femenino	11	4	10	57
EMP0000082	Penelope	Navarro	1975-12-01	femenino	19	5	13	54
EMP0000083	Lillian	Reyes	1988-01-03	femenino	1	4	12	32
EMP0000084	Addison	Jiménez	1998-12-04	femenino	2	5	7	25
EMP0000085	Natalie	Mora	1986-11-28	femenino	27	4	5	47
EMP0000086	Leah	Núñez	1978-07-08	femenino	29	4	2	49
EMP0000087	Audrey	Suárez	1978-04-12	femenino	14	4	3	27
EMP0000088	Maya	Herrera	1991-06-17	femenino	10	2	13	56
EMP0000089	Savannah	Montoya	1986-05-14	femenino	22	4	5	35
EMP0000090	Bella	Paredes	1994-10-15	femenino	3	4	9	25
EMP0000091	Claire	Escobar	1983-07-10	femenino	16	1	11	47
EMP0000092	Lucy	Cardenas	1996-11-06	femenino	20	4	13	24
EMP0000093	Paisley	Salinas	1989-01-28	femenino	24	2	9	35
EMP0000094	Sarah	Figueroa	1985-10-14	femenino	21	5	9	26
EMP0000095	Elena	Valencia	1980-03-21	femenino	25	1	5	36
EMP0000096	Caroline	Palacios	1997-09-23	femenino	7	5	6	58
EMP0000097	Kennedy	Campos	1990-07-27	femenino	12	3	0	45
EMP0000098	Anna	Vázquez	1989-08-14	femenino	6	2	12	25
EMP0000099	Genesis	Maldonado	1990-11-07	femenino	7	4	12	22
EMP0000100	Naomi	Cabrera	1995-05-11	femenino	22	5	13	26
\.


--
-- Data for Name: empresa; Type: TABLE DATA; Schema: public; Owner: dianasanchezordonez
--

COPY public.empresa (empresa_id, nombre, industria) FROM stdin;
EMPRESA0000001	AMD	Internet Services
EMPRESA0000002	Adobe	Consumer Electronics
EMPRESA0000003	AirTable	Software Development
EMPRESA0000004	Airbnb	E-commerce
EMPRESA0000005	Airtable	Information Technology Services
EMPRESA0000006	Algolia	Social Media
EMPRESA0000007	Alibaba	Semiconductors
EMPRESA0000008	Amazon	Database Management
EMPRESA0000009	AppDynamics	Graphics Processing
EMPRESA0000010	AppLovin	Cloud Computing
EMPRESA0000011	Apple	Streaming Services
EMPRESA0000012	Asana	Cybersecurity
EMPRESA0000013	Atlassian	Mobile Applications
EMPRESA0000014	Basecamp	Software as a Service
EMPRESA0000015	BetterCloud	Collaboration Tools
EMPRESA0000016	BigCommerce	Content Management
EMPRESA0000017	BigQuery	Digital Marketing
EMPRESA0000018	Bill.com	E-learning
EMPRESA0000019	BlaBlaCar	Online Payment Solutions
EMPRESA0000020	Box	Data Analytics
EMPRESA0000021	Buffer	AI and Machine Learning
EMPRESA0000022	Cado Security	Virtual Reality
EMPRESA0000023	Calendly	Augmented Reality
EMPRESA0000024	Chargebee	Blockchain Technology
EMPRESA0000025	Cisco	Remote Work Tools
EMPRESA0000026	CleverTap	Gaming
EMPRESA0000027	ClickUp	Artificial Intelligence
EMPRESA0000028	Cloudflare	Internet of Things
EMPRESA0000029	CoConstruct	Wearable Technology
EMPRESA0000030	CoSchedule	Telecommunications
EMPRESA0000031	Cobalt	E-sports
EMPRESA0000032	Contentful	Digital Payments
EMPRESA0000033	Cortex	Health Tech
EMPRESA0000034	Cricut	Biotechnology
EMPRESA0000035	Criteo	EdTech
EMPRESA0000036	Cytobank	Logistics Technology
EMPRESA0000037	DataRobot	Agritech
EMPRESA0000038	Databricks	Fintech
EMPRESA0000039	Datadog	Legal Tech
EMPRESA0000040	Dell	PropTech
EMPRESA0000041	Dev.to	MarTech
EMPRESA0000042	Discord	Travel Tech
EMPRESA0000043	Domo	Food Tech
EMPRESA0000044	DoorDash	Green Tech
EMPRESA0000045	Dropbox	Retail Tech
EMPRESA0000046	Elastic	Social Impact Tech
EMPRESA0000047	Eventbrite	Fashion Tech
EMPRESA0000048	Expensify	HR Tech
EMPRESA0000049	Fieldwire	Creative Tech
EMPRESA0000050	Figma	Music Tech
EMPRESA0000051	Fiverr	Media Tech
EMPRESA0000052	Forte	Sports Tech
EMPRESA0000053	FreshBooks	Insurance Tech
EMPRESA0000054	Freshdesk	Real Estate Tech
EMPRESA0000055	Freshsales	Energy Tech
EMPRESA0000056	Freshworks	Transportation Tech
EMPRESA0000057	Fynd	Robotics
EMPRESA0000058	GitHub	Drones
EMPRESA0000059	GitLab	5G Technology
EMPRESA0000060	Google	Quantum Computing
EMPRESA0000061	Google Workspace	Smart Cities
EMPRESA0000062	Greenhouse	SaaS
EMPRESA0000063	Grubhub	PaaS
EMPRESA0000064	HP	IaaS
EMPRESA0000065	HackerRank	Analytics
EMPRESA0000066	Hootsuite	Voice Technology
EMPRESA0000067	Huawei	Computer Vision
EMPRESA0000068	HubSpot	Natural Language Processing
EMPRESA0000069	HubSpot CRM	Cloud Storage
EMPRESA0000070	IBM	API Management
EMPRESA0000071	InVision	Supply Chain Tech
EMPRESA0000072	Insightly	Project Management Tools
EMPRESA0000073	Instacart	Collaboration Software
EMPRESA0000074	Integromat	Customer Relationship Management
EMPRESA0000075	Intel	Human Resource Management
EMPRESA0000076	Intercom	Content Delivery Networks
EMPRESA0000077	Intuit	Digital Signage
EMPRESA0000078	Jira	Podcasting
EMPRESA0000079	Kaltura	Live Streaming
EMPRESA0000080	Kashoo	Subscription Services
EMPRESA0000081	Keap	Mobile Gaming
EMPRESA0000082	Looker	E-learning Platforms
EMPRESA0000083	Lucid	Online Courses
EMPRESA0000084	Lucidchart	Digital Content Creation
EMPRESA0000085	Lyft	E-commerce Platforms
EMPRESA0000086	Mailchimp	B2B Marketplaces
EMPRESA0000087	Mailgun	B2C Marketplaces
EMPRESA0000088	Meta	Travel Booking
EMPRESA0000089	Microsoft	Real-time Analytics
EMPRESA0000090	Microsoft Dynamics	Business Intelligence
EMPRESA0000091	Microsoft Teams	Software Development Kits
EMPRESA0000092	Miro	Testing Tools
EMPRESA0000093	Mixpanel	DevOps Tools
EMPRESA0000094	Monday.com	Integration Platforms
EMPRESA0000095	NVIDIA	Security Solutions
EMPRESA0000096	NetSuite	Digital Identity
EMPRESA0000097	Netflix	Collaboration Hardware
EMPRESA0000098	New Relic	Smart Home
EMPRESA0000099	Notion	Smart Appliances
EMPRESA0000100	Nutshell	Tech Consulting
EMPRESA0000101	Okta	Technology Investment
EMPRESA0000102	Optimizely	Venture Capital
EMPRESA0000103	Oracle	Startup Accelerators
EMPRESA0000104	Oracle Cloud	Incubators
EMPRESA0000105	Palantir	Hackathons
EMPRESA0000106	PandaDoc	Internet Services
EMPRESA0000107	Parabola	Consumer Electronics
EMPRESA0000108	PatSnap	Software Development
EMPRESA0000109	PayPal	E-commerce
EMPRESA0000110	Pendo	Information Technology Services
EMPRESA0000111	Periscope Data	Social Media
EMPRESA0000112	Pinterest	Semiconductors
EMPRESA0000113	Pipedrive	Database Management
EMPRESA0000114	Plangrid	Graphics Processing
EMPRESA0000115	Pluralsight	Cloud Computing
EMPRESA0000116	Postman	Streaming Services
EMPRESA0000117	Procore	Cybersecurity
EMPRESA0000118	Qualys	Mobile Applications
EMPRESA0000119	QuickBooks	Software as a Service
EMPRESA0000120	Quora	Collaboration Tools
EMPRESA0000121	Rally	Content Management
EMPRESA0000122	Red Hat	Digital Marketing
EMPRESA0000123	Redfin	E-learning
EMPRESA0000124	RingCentral	Online Payment Solutions
EMPRESA0000125	Riot Games	Data Analytics
EMPRESA0000126	Rocket League	AI and Machine Learning
EMPRESA0000127	Roku	Virtual Reality
EMPRESA0000128	SAP	Augmented Reality
EMPRESA0000129	Salesflare	Blockchain Technology
EMPRESA0000130	Salesforce	Remote Work Tools
EMPRESA0000131	Samsara	Gaming
EMPRESA0000132	Segment	Artificial Intelligence
EMPRESA0000133	SendGrid	Internet of Things
EMPRESA0000134	Sentry	Wearable Technology
EMPRESA0000135	ServiceNow	Telecommunications
EMPRESA0000136	Shopify	E-sports
EMPRESA0000137	Slack	Digital Payments
EMPRESA0000138	Smartsheet	Health Tech
EMPRESA0000139	Snap	Biotechnology
EMPRESA0000140	Spotify	EdTech
EMPRESA0000141	Square	Logistics Technology
EMPRESA0000142	Squarespace	Agritech
EMPRESA0000143	Stripe	Fintech
EMPRESA0000144	SugarCRM	Legal Tech
EMPRESA0000145	Sumo Logic	PropTech
EMPRESA0000146	Tableau	MarTech
EMPRESA0000147	Tesla	Travel Tech
EMPRESA0000148	TikTok	Food Tech
EMPRESA0000149	Todoist	Green Tech
EMPRESA0000150	Toggl	Retail Tech
\.


--
-- Data for Name: saludmental; Type: TABLE DATA; Schema: public; Owner: dianasanchezordonez
--

COPY public.saludmental (codigo, rating_aislamiento_social, freq_actividad_fisica, calidad_suenio, nivel_estres, diagnostico, empleado_id, periodo) FROM stdin;
1	4	3	4	3	Burnout	EMP0000001	2012-01
2	1	5	1	5	Depresion	EMP0000002	2009-01
3	1	4	4	4	Burnout	EMP0000003	2009-01
4	3	3	3	2	Depresion	EMP0000004	2012-01
5	2	1	3	4	Ansiedad	EMP0000005	2004-01
6	2	3	1	4	Depresion	EMP0000006	2000-02
7	1	5	3	1	Depresion	EMP0000007	2004-01
8	4	3	5	2	Ansiedad	EMP0000008	2000-02
9	5	2	2	4	Ansiedad	EMP0000009	2016-01
10	3	3	2	1	Saludable	EMP0000010	2016-01
11	4	4	5	4	Depresion	EMP0000011	2023-01
12	2	4	2	2	Ansiedad	EMP0000012	2016-02
13	4	1	5	3	Burnout	EMP0000013	2004-02
14	2	4	4	4	Burnout	EMP0000014	2002-01
15	2	3	1	4	Ansiedad	EMP0000015	2014-01
16	2	5	3	3	Depresion	EMP0000016	2004-02
17	3	2	5	2	Saludable	EMP0000017	2020-01
18	3	4	2	1	Saludable	EMP0000018	2022-02
19	5	4	3	4	Depresion	EMP0000019	2016-01
20	1	3	2	2	Saludable	EMP0000020	2019-01
21	1	3	3	5	Ansiedad	EMP0000021	2016-02
22	2	5	2	4	Saludable	EMP0000022	2002-02
23	2	5	1	5	Burnout	EMP0000023	2024-01
24	4	4	5	5	Depresion	EMP0000024	2022-02
25	4	3	1	4	Depresion	EMP0000025	2011-02
26	5	3	2	1	Ansiedad	EMP0000026	2003-01
27	1	5	5	4	Burnout	EMP0000027	2023-02
28	1	1	3	4	Burnout	EMP0000028	2006-01
29	4	4	3	1	Ansiedad	EMP0000029	2024-02
30	5	3	5	4	Ansiedad	EMP0000030	2009-01
31	1	4	4	2	Depresion	EMP0000031	2014-01
32	3	4	1	1	Burnout	EMP0000032	2006-01
33	1	3	4	3	Saludable	EMP0000033	2022-02
34	1	4	4	2	Saludable	EMP0000034	2018-01
35	1	4	1	5	Ansiedad	EMP0000035	2006-02
36	1	2	2	2	Saludable	EMP0000036	2004-01
37	4	2	4	5	Burnout	EMP0000037	2020-02
38	1	4	2	4	Ansiedad	EMP0000038	2019-02
39	4	2	1	1	Depresion	EMP0000039	2004-02
40	1	3	5	5	Depresion	EMP0000040	2010-01
41	4	3	1	1	Depresion	EMP0000041	2019-01
42	2	4	5	4	Ansiedad	EMP0000042	2007-01
43	1	3	3	3	Ansiedad	EMP0000043	2004-02
44	3	4	2	1	Ansiedad	EMP0000044	2000-01
45	5	1	1	4	Depresion	EMP0000045	2024-01
46	3	5	5	2	Depresion	EMP0000046	2006-02
47	3	4	1	3	Burnout	EMP0000047	2017-01
48	5	2	3	4	Depresion	EMP0000048	2019-01
49	2	2	4	2	Burnout	EMP0000049	2012-01
50	5	5	2	4	Depresion	EMP0000050	2024-01
51	4	4	2	5	Burnout	EMP0000051	2017-02
52	1	5	3	1	Ansiedad	EMP0000052	2017-01
53	2	5	3	2	Burnout	EMP0000053	2022-01
54	2	2	3	1	Burnout	EMP0000054	2009-01
55	1	5	3	5	Saludable	EMP0000055	2023-01
56	4	2	4	5	Ansiedad	EMP0000056	2001-02
57	4	1	1	4	Burnout	EMP0000057	2006-02
58	3	1	2	1	Saludable	EMP0000058	2005-01
59	1	5	5	3	Burnout	EMP0000059	2000-01
60	1	2	5	5	Burnout	EMP0000060	2000-01
61	1	1	1	4	Burnout	EMP0000061	2023-02
62	2	4	2	2	Ansiedad	EMP0000062	2014-02
63	2	2	3	5	Ansiedad	EMP0000063	2008-01
64	3	5	4	4	Ansiedad	EMP0000064	2005-01
65	4	1	1	5	Saludable	EMP0000065	2003-02
66	2	3	5	2	Saludable	EMP0000066	2015-02
67	4	1	2	4	Ansiedad	EMP0000067	2015-02
68	5	1	5	4	Burnout	EMP0000068	2016-01
69	2	2	4	2	Ansiedad	EMP0000069	2024-02
70	5	1	1	5	Saludable	EMP0000070	2005-01
71	3	5	2	2	Saludable	EMP0000071	2006-01
72	2	5	1	3	Ansiedad	EMP0000072	2011-01
73	1	3	3	2	Ansiedad	EMP0000073	2001-01
74	5	4	5	1	Ansiedad	EMP0000074	2003-02
75	5	5	2	3	Burnout	EMP0000075	2016-02
76	2	1	4	3	Saludable	EMP0000076	2021-01
77	4	2	4	4	Saludable	EMP0000077	2002-02
78	3	2	2	4	Depresion	EMP0000078	2013-02
79	5	1	1	4	Burnout	EMP0000079	2007-02
80	2	2	4	3	Burnout	EMP0000080	2000-01
81	5	3	3	5	Saludable	EMP0000081	2008-01
82	1	3	4	5	Burnout	EMP0000082	2010-02
83	4	5	5	3	Saludable	EMP0000083	2012-02
84	2	2	1	1	Depresion	EMP0000084	2016-02
85	5	4	3	4	Saludable	EMP0000085	2007-02
86	5	1	5	1	Ansiedad	EMP0000086	2016-02
87	1	4	2	3	Ansiedad	EMP0000087	2023-01
88	5	2	5	1	Burnout	EMP0000088	2013-02
89	2	2	5	1	Saludable	EMP0000089	2001-02
90	4	5	4	5	Saludable	EMP0000090	2023-01
91	5	5	2	2	Burnout	EMP0000091	2003-01
92	1	3	4	2	Saludable	EMP0000092	2004-01
93	5	3	4	1	Depresion	EMP0000093	2020-01
94	5	4	4	2	Burnout	EMP0000094	2011-02
95	3	3	4	2	Depresion	EMP0000095	2010-01
96	1	3	1	3	Depresion	EMP0000096	2008-01
97	4	1	2	4	Ansiedad	EMP0000097	2013-02
98	5	3	1	4	Ansiedad	EMP0000098	2011-01
99	5	3	5	2	Saludable	EMP0000099	2014-01
100	3	3	1	3	Burnout	EMP0000100	2024-01
\.


--
-- Name: edesempenio_codigo_seq; Type: SEQUENCE SET; Schema: public; Owner: dianasanchezordonez
--

SELECT pg_catalog.setval('public.edesempenio_codigo_seq', 100, true);


--
-- Name: saludmental_codigo_seq; Type: SEQUENCE SET; Schema: public; Owner: dianasanchezordonez
--

SELECT pg_catalog.setval('public.saludmental_codigo_seq', 100, true);


--
-- Name: contrato contrato_pkey; Type: CONSTRAINT; Schema: public; Owner: dianasanchezordonez
--

ALTER TABLE ONLY public.contrato
    ADD CONSTRAINT contrato_pkey PRIMARY KEY (empleado_id, periodo);


--
-- Name: edesempenio edesempenio_pkey; Type: CONSTRAINT; Schema: public; Owner: dianasanchezordonez
--

ALTER TABLE ONLY public.edesempenio
    ADD CONSTRAINT edesempenio_pkey PRIMARY KEY (codigo);


--
-- Name: empleado empleado_pkey; Type: CONSTRAINT; Schema: public; Owner: dianasanchezordonez
--

ALTER TABLE ONLY public.empleado
    ADD CONSTRAINT empleado_pkey PRIMARY KEY (empleado_id);


--
-- Name: empresa empresa_pkey; Type: CONSTRAINT; Schema: public; Owner: dianasanchezordonez
--

ALTER TABLE ONLY public.empresa
    ADD CONSTRAINT empresa_pkey PRIMARY KEY (empresa_id);


--
-- Name: saludmental saludmental_pkey; Type: CONSTRAINT; Schema: public; Owner: dianasanchezordonez
--

ALTER TABLE ONLY public.saludmental
    ADD CONSTRAINT saludmental_pkey PRIMARY KEY (codigo);


--
-- Name: contrato contrato_empleado_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dianasanchezordonez
--

ALTER TABLE ONLY public.contrato
    ADD CONSTRAINT contrato_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: contrato contrato_empresa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dianasanchezordonez
--

ALTER TABLE ONLY public.contrato
    ADD CONSTRAINT contrato_empresa_id_fkey FOREIGN KEY (empresa_id) REFERENCES public.empresa(empresa_id);


--
-- Name: edesempenio edesempenio_empleado_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dianasanchezordonez
--

ALTER TABLE ONLY public.edesempenio
    ADD CONSTRAINT edesempenio_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: edesempenio edesempenio_empleado_id_periodo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dianasanchezordonez
--

ALTER TABLE ONLY public.edesempenio
    ADD CONSTRAINT edesempenio_empleado_id_periodo_fkey FOREIGN KEY (empleado_id, periodo) REFERENCES public.contrato(empleado_id, periodo);


--
-- Name: saludmental saludmental_empleado_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dianasanchezordonez
--

ALTER TABLE ONLY public.saludmental
    ADD CONSTRAINT saludmental_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES public.empleado(empleado_id);


--
-- Name: saludmental saludmental_empleado_id_periodo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dianasanchezordonez
--

ALTER TABLE ONLY public.saludmental
    ADD CONSTRAINT saludmental_empleado_id_periodo_fkey FOREIGN KEY (empleado_id, periodo) REFERENCES public.contrato(empleado_id, periodo);


--
-- PostgreSQL database dump complete
--

