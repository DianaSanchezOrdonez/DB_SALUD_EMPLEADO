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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


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
    CONSTRAINT chk_modalidad_trabajo CHECK (((modalidad_trabajo)::text = ANY (ARRAY[('Remoto'::character varying)::text, ('Hibrido'::character varying)::text, ('Presencial'::character varying)::text]))),
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
    CONSTRAINT chk_genero CHECK (((genero)::text = ANY (ARRAY[('masculino'::character varying)::text, ('femenino'::character varying)::text, ('no mencionar'::character varying)::text]))),
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
EMP0000101	EMPRESA0000126	2006-02	Frontend Developer	Remoto
EMP0000102	EMPRESA0000064	2023-02	Backend Developer	Remoto
EMP0000103	EMPRESA0000029	2020-02	Full Stack Developer	Hibrido
EMP0000104	EMPRESA0000118	2011-01	Data Scientist	Remoto
EMP0000105	EMPRESA0000097	2005-02	DevOps Engineer	Remoto
EMP0000106	EMPRESA0000122	2017-01	Cloud Architect	Presencial
EMP0000107	EMPRESA0000106	2012-02	Systems Administrator	Hibrido
EMP0000108	EMPRESA0000136	2022-02	Machine Learning Engineer	Hibrido
EMP0000109	EMPRESA0000024	2002-02	Database Administrator	Hibrido
EMP0000110	EMPRESA0000125	2013-01	IT Support Specialist	Presencial
EMP0000111	EMPRESA0000096	2000-01	Security Analyst	Remoto
EMP0000112	EMPRESA0000033	2024-02	Network Engineer	Remoto
EMP0000113	EMPRESA0000129	2009-01	AI Researcher	Remoto
EMP0000114	EMPRESA0000011	2000-01	Mobile App Developer	Hibrido
EMP0000115	EMPRESA0000068	2009-01	Product Manager	Hibrido
EMP0000116	EMPRESA0000019	2019-02	UI/UX Designer	Remoto
EMP0000117	EMPRESA0000137	2005-02	Blockchain Developer	Hibrido
EMP0000118	EMPRESA0000073	2000-02	Cybersecurity Specialist	Hibrido
EMP0000119	EMPRESA0000150	2024-01	Solutions Architect	Presencial
EMP0000120	EMPRESA0000012	2022-01	Data Analyst	Remoto
EMP0000121	EMPRESA0000031	2014-01	Game Developer	Presencial
EMP0000122	EMPRESA0000062	2010-02	Business Intelligence Analyst	Remoto
EMP0000123	EMPRESA0000057	2007-02	Site Reliability Engineer	Hibrido
EMP0000124	EMPRESA0000073	2017-01	Quality Assurance Engineer	Hibrido
EMP0000125	EMPRESA0000020	2019-01	Technical Support Engineer	Remoto
EMP0000126	EMPRESA0000036	2021-02	Technical Writer	Hibrido
EMP0000127	EMPRESA0000112	2021-01	Embedded Systems Engineer	Remoto
EMP0000128	EMPRESA0000068	2017-01	Computer Vision Engineer	Remoto
EMP0000129	EMPRESA0000046	2010-01	Web Developer	Remoto
EMP0000130	EMPRESA0000031	2000-02	API Developer	Remoto
EMP0000131	EMPRESA0000009	2013-01	Robotics Engineer	Remoto
EMP0000132	EMPRESA0000023	2007-01	Software Architect	Remoto
EMP0000133	EMPRESA0000029	2016-02	Big Data Engineer	Presencial
EMP0000134	EMPRESA0000060	2015-01	Network Security Engineer	Remoto
EMP0000135	EMPRESA0000093	2010-02	Cloud Engineer	Hibrido
EMP0000136	EMPRESA0000121	2017-01	Artificial Intelligence Engineer	Hibrido
EMP0000137	EMPRESA0000128	2014-01	Augmented Reality Developer	Hibrido
EMP0000138	EMPRESA0000091	2022-01	Virtual Reality Developer	Remoto
EMP0000139	EMPRESA0000111	2000-02	IT Project Manager	Remoto
EMP0000140	EMPRESA0000103	2007-02	Automation Engineer	Remoto
EMP0000141	EMPRESA0000125	2013-01	Penetration Tester	Presencial
EMP0000142	EMPRESA0000088	2011-02	CRM Developer	Presencial
EMP0000143	EMPRESA0000115	2011-02	Data Engineer	Hibrido
EMP0000144	EMPRESA0000073	2012-02	Help Desk Technician	Remoto
EMP0000145	EMPRESA0000037	2006-02	Solutions Engineer	Hibrido
EMP0000146	EMPRESA0000036	2001-02	IT Consultant	Hibrido
EMP0000147	EMPRESA0000002	2006-01	IoT Developer	Remoto
EMP0000148	EMPRESA0000148	2020-02	Software Tester	Hibrido
EMP0000149	EMPRESA0000039	2022-01	Security Engineer	Hibrido
EMP0000150	EMPRESA0000033	2015-01	Database Engineer	Remoto
EMP0000151	EMPRESA0000048	2015-01	IT Operations Manager	Hibrido
EMP0000152	EMPRESA0000072	2023-01	Cybersecurity Consultant	Remoto
EMP0000153	EMPRESA0000109	2010-01	Digital Transformation Manager	Remoto
EMP0000154	EMPRESA0000040	2024-02	Cloud Solutions Specialist	Hibrido
EMP0000155	EMPRESA0000114	2016-02	Systems Engineer	Remoto
EMP0000156	EMPRESA0000105	2007-01	Mobile Architect	Presencial
EMP0000157	EMPRESA0000136	2016-01	Data Warehouse Engineer	Hibrido
EMP0000158	EMPRESA0000123	2015-01	Application Developer	Remoto
EMP0000159	EMPRESA0000148	2000-02	Cloud Consultant	Remoto
EMP0000160	EMPRESA0000135	2016-01	Blockchain Analyst	Remoto
EMP0000161	EMPRESA0000075	2024-01	User Researcher	Presencial
EMP0000162	EMPRESA0000087	2015-02	Machine Learning Developer	Presencial
EMP0000163	EMPRESA0000095	2007-02	Algorithm Developer	Presencial
EMP0000164	EMPRESA0000093	2005-01	Data Operations Analyst	Presencial
EMP0000165	EMPRESA0000139	2014-01	Tech Support Specialist	Remoto
EMP0000166	EMPRESA0000013	2017-02	Cloud Infrastructure Engineer	Presencial
EMP0000167	EMPRESA0000110	2005-01	DevSecOps Engineer	Presencial
EMP0000168	EMPRESA0000108	2018-02	Information Systems Manager	Hibrido
EMP0000169	EMPRESA0000003	2002-01	Scrum Master	Remoto
EMP0000170	EMPRESA0000062	2022-01	Firmware Engineer	Hibrido
EMP0000171	EMPRESA0000148	2022-02	Network Architect	Hibrido
EMP0000172	EMPRESA0000050	2011-02	Virtualization Engineer	Hibrido
EMP0000173	EMPRESA0000054	2004-01	IT Analyst	Hibrido
EMP0000174	EMPRESA0000025	2021-02	Chief Technology Officer (CTO)	Presencial
EMP0000175	EMPRESA0000141	2005-02	Chief Information Officer (CIO)	Presencial
EMP0000176	EMPRESA0000094	2001-02	Release Manager	Presencial
EMP0000177	EMPRESA0000101	2021-02	ERP Developer	Hibrido
EMP0000178	EMPRESA0000069	2020-02	SAP Consultant	Remoto
EMP0000179	EMPRESA0000064	2021-02	Front-End Architect	Remoto
EMP0000180	EMPRESA0000136	2009-02	Digital Marketing Technologist	Presencial
EMP0000181	EMPRESA0000112	2007-01	Technical Recruiter	Hibrido
EMP0000182	EMPRESA0000015	2021-01	Solutions Developer	Hibrido
EMP0000183	EMPRESA0000086	2012-02	Data Governance Analyst	Remoto
EMP0000184	EMPRESA0000050	2017-01	Mobile Security Analyst	Presencial
EMP0000185	EMPRESA0000052	2019-01	Cloud Security Engineer	Hibrido
EMP0000186	EMPRESA0000108	2005-02	AI Trainer	Hibrido
EMP0000187	EMPRESA0000105	2002-01	Tech Evangelist	Hibrido
EMP0000188	EMPRESA0000114	2012-02	IT Risk Analyst	Remoto
EMP0000189	EMPRESA0000096	2005-02	IT Auditor	Hibrido
EMP0000190	EMPRESA0000058	2018-02	Mobile Product Manager	Hibrido
EMP0000191	EMPRESA0000108	2006-02	Infrastructure Engineer	Hibrido
EMP0000192	EMPRESA0000090	2002-02	Incident Response Analyst	Remoto
EMP0000193	EMPRESA0000029	2012-02	Server Administrator	Hibrido
EMP0000194	EMPRESA0000072	2003-01	IT Trainer	Presencial
EMP0000195	EMPRESA0000022	2013-02	Data Visualization Engineer	Presencial
EMP0000196	EMPRESA0000006	2016-02	E-commerce Developer	Presencial
EMP0000197	EMPRESA0000107	2016-01	Digital Forensics Analyst	Hibrido
EMP0000198	EMPRESA0000086	2014-02	Innovation Manager	Presencial
EMP0000199	EMPRESA0000085	2002-02	Software Engineer	Remoto
EMP0000200	EMPRESA0000075	2007-02	Frontend Developer	Remoto
EMP0000201	EMPRESA0000093	2022-01	Frontend Developer	Presencial
EMP0000202	EMPRESA0000015	2021-02	Backend Developer	Remoto
EMP0000203	EMPRESA0000121	2021-02	Full Stack Developer	Hibrido
EMP0000204	EMPRESA0000044	2024-02	Data Scientist	Hibrido
EMP0000205	EMPRESA0000008	2011-02	DevOps Engineer	Hibrido
EMP0000206	EMPRESA0000133	2016-01	Cloud Architect	Hibrido
EMP0000207	EMPRESA0000031	2009-02	Systems Administrator	Presencial
EMP0000208	EMPRESA0000056	2024-01	Machine Learning Engineer	Presencial
EMP0000209	EMPRESA0000145	2022-02	Database Administrator	Remoto
EMP0000210	EMPRESA0000060	2006-02	IT Support Specialist	Hibrido
EMP0000211	EMPRESA0000018	2006-01	Security Analyst	Hibrido
EMP0000212	EMPRESA0000062	2010-01	Network Engineer	Remoto
EMP0000213	EMPRESA0000130	2007-02	AI Researcher	Hibrido
EMP0000214	EMPRESA0000134	2001-01	Mobile App Developer	Hibrido
EMP0000215	EMPRESA0000144	2012-01	Product Manager	Hibrido
EMP0000216	EMPRESA0000064	2020-02	UI/UX Designer	Hibrido
EMP0000217	EMPRESA0000116	2024-02	Blockchain Developer	Hibrido
EMP0000218	EMPRESA0000064	2017-02	Cybersecurity Specialist	Remoto
EMP0000219	EMPRESA0000046	2012-01	Solutions Architect	Presencial
EMP0000220	EMPRESA0000098	2020-02	Data Analyst	Remoto
EMP0000221	EMPRESA0000065	2013-01	Game Developer	Hibrido
EMP0000222	EMPRESA0000148	2019-02	Business Intelligence Analyst	Presencial
EMP0000223	EMPRESA0000136	2015-02	Site Reliability Engineer	Hibrido
EMP0000224	EMPRESA0000117	2004-02	Quality Assurance Engineer	Hibrido
EMP0000225	EMPRESA0000135	2001-02	Technical Support Engineer	Remoto
EMP0000226	EMPRESA0000109	2017-02	Technical Writer	Presencial
EMP0000227	EMPRESA0000002	2010-02	Embedded Systems Engineer	Hibrido
EMP0000228	EMPRESA0000124	2020-01	Computer Vision Engineer	Remoto
EMP0000229	EMPRESA0000010	2001-01	Web Developer	Hibrido
EMP0000230	EMPRESA0000004	2013-01	API Developer	Remoto
EMP0000231	EMPRESA0000017	2015-01	Robotics Engineer	Remoto
EMP0000232	EMPRESA0000112	2003-02	Software Architect	Presencial
EMP0000233	EMPRESA0000076	2003-01	Big Data Engineer	Remoto
EMP0000234	EMPRESA0000031	2021-01	Network Security Engineer	Presencial
EMP0000235	EMPRESA0000094	2005-01	Cloud Engineer	Remoto
EMP0000236	EMPRESA0000077	2001-01	Artificial Intelligence Engineer	Hibrido
EMP0000237	EMPRESA0000074	2000-01	Augmented Reality Developer	Hibrido
EMP0000238	EMPRESA0000042	2023-01	Virtual Reality Developer	Presencial
EMP0000239	EMPRESA0000144	2009-01	IT Project Manager	Remoto
EMP0000240	EMPRESA0000081	2023-01	Automation Engineer	Remoto
EMP0000241	EMPRESA0000054	2022-02	Penetration Tester	Remoto
EMP0000242	EMPRESA0000050	2023-01	CRM Developer	Presencial
EMP0000243	EMPRESA0000124	2014-01	Data Engineer	Hibrido
EMP0000244	EMPRESA0000011	2016-02	Help Desk Technician	Presencial
EMP0000245	EMPRESA0000104	2015-02	Solutions Engineer	Hibrido
EMP0000246	EMPRESA0000014	2015-02	IT Consultant	Remoto
EMP0000247	EMPRESA0000088	2009-02	IoT Developer	Hibrido
EMP0000248	EMPRESA0000129	2020-02	Software Tester	Remoto
EMP0000249	EMPRESA0000117	2001-02	Security Engineer	Presencial
EMP0000250	EMPRESA0000083	2007-01	Database Engineer	Hibrido
EMP0000251	EMPRESA0000098	2007-02	IT Operations Manager	Hibrido
EMP0000252	EMPRESA0000066	2004-01	Cybersecurity Consultant	Remoto
EMP0000253	EMPRESA0000140	2022-01	Digital Transformation Manager	Presencial
EMP0000254	EMPRESA0000023	2014-01	Cloud Solutions Specialist	Remoto
EMP0000255	EMPRESA0000017	2021-02	Systems Engineer	Hibrido
EMP0000256	EMPRESA0000084	2013-02	Mobile Architect	Presencial
EMP0000257	EMPRESA0000086	2022-01	Data Warehouse Engineer	Presencial
EMP0000258	EMPRESA0000002	2020-01	Application Developer	Remoto
EMP0000259	EMPRESA0000005	2021-01	Cloud Consultant	Remoto
EMP0000260	EMPRESA0000125	2021-02	Blockchain Analyst	Presencial
EMP0000261	EMPRESA0000030	2010-01	User Researcher	Remoto
EMP0000262	EMPRESA0000104	2014-01	Machine Learning Developer	Presencial
EMP0000263	EMPRESA0000002	2019-02	Algorithm Developer	Hibrido
EMP0000264	EMPRESA0000134	2007-02	Data Operations Analyst	Presencial
EMP0000265	EMPRESA0000081	2019-01	Tech Support Specialist	Hibrido
EMP0000266	EMPRESA0000139	2016-02	Cloud Infrastructure Engineer	Remoto
EMP0000267	EMPRESA0000043	2008-02	DevSecOps Engineer	Remoto
EMP0000268	EMPRESA0000060	2019-02	Information Systems Manager	Presencial
EMP0000269	EMPRESA0000002	2021-01	Scrum Master	Remoto
EMP0000270	EMPRESA0000016	2016-01	Firmware Engineer	Remoto
EMP0000271	EMPRESA0000007	2022-01	Network Architect	Remoto
EMP0000272	EMPRESA0000023	2015-01	Virtualization Engineer	Hibrido
EMP0000273	EMPRESA0000128	2019-02	IT Analyst	Presencial
EMP0000274	EMPRESA0000082	2021-02	Chief Technology Officer (CTO)	Remoto
EMP0000275	EMPRESA0000085	2015-02	Chief Information Officer (CIO)	Remoto
EMP0000276	EMPRESA0000013	2011-02	Release Manager	Remoto
EMP0000277	EMPRESA0000126	2000-02	ERP Developer	Remoto
EMP0000278	EMPRESA0000141	2023-02	SAP Consultant	Remoto
EMP0000279	EMPRESA0000038	2021-01	Front-End Architect	Presencial
EMP0000280	EMPRESA0000053	2019-02	Digital Marketing Technologist	Hibrido
EMP0000281	EMPRESA0000063	2019-01	Technical Recruiter	Remoto
EMP0000282	EMPRESA0000142	2013-01	Solutions Developer	Remoto
EMP0000283	EMPRESA0000024	2010-01	Data Governance Analyst	Remoto
EMP0000284	EMPRESA0000094	2020-01	Mobile Security Analyst	Remoto
EMP0000285	EMPRESA0000146	2018-02	Cloud Security Engineer	Hibrido
EMP0000286	EMPRESA0000082	2019-02	AI Trainer	Remoto
EMP0000287	EMPRESA0000020	2002-02	Tech Evangelist	Remoto
EMP0000288	EMPRESA0000148	2002-02	IT Risk Analyst	Remoto
EMP0000289	EMPRESA0000030	2013-02	IT Auditor	Remoto
EMP0000290	EMPRESA0000101	2015-02	Mobile Product Manager	Presencial
EMP0000291	EMPRESA0000065	2010-01	Infrastructure Engineer	Remoto
EMP0000292	EMPRESA0000008	2004-01	Incident Response Analyst	Remoto
EMP0000293	EMPRESA0000123	2016-01	Server Administrator	Hibrido
EMP0000294	EMPRESA0000045	2011-02	IT Trainer	Remoto
EMP0000295	EMPRESA0000017	2016-02	Data Visualization Engineer	Hibrido
EMP0000296	EMPRESA0000030	2006-01	E-commerce Developer	Remoto
EMP0000297	EMPRESA0000015	2010-01	Digital Forensics Analyst	Remoto
EMP0000298	EMPRESA0000048	2004-01	Innovation Manager	Presencial
EMP0000299	EMPRESA0000088	2008-01	Software Engineer	Presencial
EMP0000300	EMPRESA0000139	2009-01	Frontend Developer	Hibrido
EMP0000301	EMPRESA0000100	2021-02	Backend Developer	Hibrido
EMP0000302	EMPRESA0000066	2007-02	Full Stack Developer	Hibrido
EMP0000303	EMPRESA0000136	2013-01	Data Scientist	Hibrido
EMP0000304	EMPRESA0000025	2009-01	DevOps Engineer	Remoto
EMP0000305	EMPRESA0000021	2003-01	Cloud Architect	Remoto
EMP0000306	EMPRESA0000098	2019-01	Systems Administrator	Remoto
EMP0000307	EMPRESA0000110	2006-01	Machine Learning Engineer	Remoto
EMP0000308	EMPRESA0000013	2016-01	Database Administrator	Hibrido
EMP0000309	EMPRESA0000028	2006-01	IT Support Specialist	Presencial
EMP0000310	EMPRESA0000013	2024-01	Security Analyst	Remoto
EMP0000311	EMPRESA0000059	2022-02	Network Engineer	Hibrido
EMP0000312	EMPRESA0000118	2018-01	AI Researcher	Presencial
EMP0000313	EMPRESA0000117	2023-02	Mobile App Developer	Hibrido
EMP0000314	EMPRESA0000126	2009-01	Product Manager	Hibrido
EMP0000315	EMPRESA0000052	2006-01	UI/UX Designer	Hibrido
EMP0000316	EMPRESA0000122	2007-02	Blockchain Developer	Remoto
EMP0000317	EMPRESA0000094	2009-02	Cybersecurity Specialist	Remoto
EMP0000318	EMPRESA0000038	2001-01	Solutions Architect	Remoto
EMP0000319	EMPRESA0000086	2019-01	Data Analyst	Hibrido
EMP0000320	EMPRESA0000096	2003-02	Game Developer	Remoto
EMP0000321	EMPRESA0000093	2021-01	Business Intelligence Analyst	Remoto
EMP0000322	EMPRESA0000014	2021-01	Site Reliability Engineer	Remoto
EMP0000323	EMPRESA0000104	2021-01	Quality Assurance Engineer	Presencial
EMP0000324	EMPRESA0000112	2002-01	Technical Support Engineer	Presencial
EMP0000325	EMPRESA0000085	2010-02	Technical Writer	Remoto
EMP0000326	EMPRESA0000125	2015-01	Embedded Systems Engineer	Remoto
EMP0000327	EMPRESA0000074	2009-01	Computer Vision Engineer	Remoto
EMP0000328	EMPRESA0000143	2009-01	Web Developer	Presencial
EMP0000329	EMPRESA0000122	2010-02	API Developer	Remoto
EMP0000330	EMPRESA0000007	2003-02	Robotics Engineer	Hibrido
EMP0000331	EMPRESA0000115	2001-01	Software Architect	Remoto
EMP0000332	EMPRESA0000138	2010-02	Big Data Engineer	Remoto
EMP0000333	EMPRESA0000005	2013-02	Network Security Engineer	Hibrido
EMP0000334	EMPRESA0000105	2024-01	Cloud Engineer	Hibrido
EMP0000335	EMPRESA0000121	2002-01	Artificial Intelligence Engineer	Remoto
EMP0000336	EMPRESA0000022	2016-01	Augmented Reality Developer	Remoto
EMP0000337	EMPRESA0000033	2002-01	Virtual Reality Developer	Remoto
EMP0000338	EMPRESA0000022	2012-01	IT Project Manager	Presencial
EMP0000339	EMPRESA0000139	2023-01	Automation Engineer	Hibrido
EMP0000340	EMPRESA0000099	2002-01	Penetration Tester	Remoto
EMP0000341	EMPRESA0000045	2012-02	CRM Developer	Presencial
EMP0000342	EMPRESA0000138	2009-02	Data Engineer	Presencial
EMP0000343	EMPRESA0000057	2008-02	Help Desk Technician	Hibrido
EMP0000344	EMPRESA0000030	2005-02	Solutions Engineer	Remoto
EMP0000345	EMPRESA0000012	2018-02	IT Consultant	Remoto
EMP0000346	EMPRESA0000044	2010-02	IoT Developer	Hibrido
EMP0000347	EMPRESA0000133	2007-02	Software Tester	Remoto
EMP0000348	EMPRESA0000149	2018-01	Security Engineer	Remoto
EMP0000349	EMPRESA0000096	2020-02	Database Engineer	Hibrido
EMP0000350	EMPRESA0000102	2017-02	IT Operations Manager	Remoto
EMP0000351	EMPRESA0000131	2021-01	Cybersecurity Consultant	Hibrido
EMP0000352	EMPRESA0000119	2002-01	Digital Transformation Manager	Remoto
EMP0000353	EMPRESA0000092	2004-01	Cloud Solutions Specialist	Hibrido
EMP0000354	EMPRESA0000070	2024-02	Systems Engineer	Presencial
EMP0000355	EMPRESA0000121	2024-02	Mobile Architect	Remoto
EMP0000356	EMPRESA0000080	2017-02	Data Warehouse Engineer	Hibrido
EMP0000357	EMPRESA0000022	2006-01	Application Developer	Hibrido
EMP0000358	EMPRESA0000147	2005-02	Cloud Consultant	Remoto
EMP0000359	EMPRESA0000043	2012-02	Blockchain Analyst	Remoto
EMP0000360	EMPRESA0000074	2010-01	User Researcher	Hibrido
EMP0000361	EMPRESA0000024	2010-02	Machine Learning Developer	Remoto
EMP0000362	EMPRESA0000096	2022-01	Algorithm Developer	Hibrido
EMP0000363	EMPRESA0000124	2023-02	Data Operations Analyst	Remoto
EMP0000364	EMPRESA0000034	2016-02	Tech Support Specialist	Remoto
EMP0000365	EMPRESA0000048	2000-02	Cloud Infrastructure Engineer	Presencial
EMP0000366	EMPRESA0000042	2011-02	DevSecOps Engineer	Hibrido
EMP0000367	EMPRESA0000061	2015-02	Information Systems Manager	Remoto
EMP0000368	EMPRESA0000073	2008-01	Scrum Master	Remoto
EMP0000369	EMPRESA0000069	2013-01	Firmware Engineer	Presencial
EMP0000370	EMPRESA0000115	2017-01	Network Architect	Hibrido
EMP0000371	EMPRESA0000125	2023-02	Virtualization Engineer	Hibrido
EMP0000372	EMPRESA0000133	2024-01	IT Analyst	Remoto
EMP0000373	EMPRESA0000108	2024-02	Chief Technology Officer (CTO)	Hibrido
EMP0000374	EMPRESA0000069	2014-01	Chief Information Officer (CIO)	Hibrido
EMP0000375	EMPRESA0000037	2000-01	Release Manager	Hibrido
EMP0000376	EMPRESA0000148	2006-02	ERP Developer	Presencial
EMP0000377	EMPRESA0000124	2012-01	SAP Consultant	Hibrido
EMP0000378	EMPRESA0000010	2015-01	Front-End Architect	Remoto
EMP0000379	EMPRESA0000018	2005-02	Digital Marketing Technologist	Remoto
EMP0000380	EMPRESA0000083	2007-01	Technical Recruiter	Remoto
EMP0000381	EMPRESA0000145	2020-02	Solutions Developer	Hibrido
EMP0000382	EMPRESA0000063	2019-02	Data Governance Analyst	Hibrido
EMP0000383	EMPRESA0000053	2024-02	Mobile Security Analyst	Remoto
EMP0000384	EMPRESA0000111	2006-02	Cloud Security Engineer	Remoto
EMP0000385	EMPRESA0000007	2017-01	AI Trainer	Remoto
EMP0000386	EMPRESA0000107	2016-01	Tech Evangelist	Presencial
EMP0000387	EMPRESA0000093	2006-02	IT Risk Analyst	Hibrido
EMP0000388	EMPRESA0000037	2011-01	IT Auditor	Remoto
EMP0000389	EMPRESA0000065	2022-02	Mobile Product Manager	Hibrido
EMP0000390	EMPRESA0000028	2014-01	Infrastructure Engineer	Hibrido
EMP0000391	EMPRESA0000021	2010-01	Incident Response Analyst	Presencial
EMP0000392	EMPRESA0000117	2022-02	Server Administrator	Presencial
EMP0000393	EMPRESA0000100	2020-02	IT Trainer	Remoto
EMP0000394	EMPRESA0000006	2008-01	Data Visualization Engineer	Hibrido
EMP0000395	EMPRESA0000106	2002-02	E-commerce Developer	Hibrido
EMP0000396	EMPRESA0000146	2009-01	Digital Forensics Analyst	Presencial
EMP0000397	EMPRESA0000079	2018-02	Innovation Manager	Hibrido
EMP0000398	EMPRESA0000067	2008-02	Software Engineer	Hibrido
EMP0000399	EMPRESA0000017	2000-01	Frontend Developer	Hibrido
EMP0000400	EMPRESA0000067	2019-02	Backend Developer	Presencial
EMP0000401	EMPRESA0000059	2010-02	Full Stack Developer	Presencial
EMP0000402	EMPRESA0000040	2001-02	Data Scientist	Hibrido
EMP0000403	EMPRESA0000036	2020-01	DevOps Engineer	Hibrido
EMP0000404	EMPRESA0000146	2004-01	Cloud Architect	Presencial
EMP0000405	EMPRESA0000086	2005-01	Systems Administrator	Hibrido
EMP0000406	EMPRESA0000005	2011-01	Machine Learning Engineer	Remoto
EMP0000407	EMPRESA0000092	2024-01	Database Administrator	Remoto
EMP0000408	EMPRESA0000096	2016-01	IT Support Specialist	Remoto
EMP0000409	EMPRESA0000050	2011-02	Security Analyst	Presencial
EMP0000410	EMPRESA0000046	2023-02	Network Engineer	Presencial
EMP0000411	EMPRESA0000129	2009-02	AI Researcher	Presencial
EMP0000412	EMPRESA0000073	2013-01	Mobile App Developer	Hibrido
EMP0000413	EMPRESA0000078	2022-01	Product Manager	Hibrido
EMP0000414	EMPRESA0000147	2012-01	UI/UX Designer	Presencial
EMP0000415	EMPRESA0000062	2015-01	Blockchain Developer	Remoto
EMP0000416	EMPRESA0000047	2016-02	Cybersecurity Specialist	Hibrido
EMP0000417	EMPRESA0000145	2020-01	Solutions Architect	Presencial
EMP0000418	EMPRESA0000038	2019-01	Data Analyst	Remoto
EMP0000419	EMPRESA0000004	2023-01	Game Developer	Presencial
EMP0000420	EMPRESA0000037	2009-02	Business Intelligence Analyst	Presencial
EMP0000421	EMPRESA0000050	2000-01	Site Reliability Engineer	Presencial
EMP0000422	EMPRESA0000141	2016-01	Quality Assurance Engineer	Hibrido
EMP0000423	EMPRESA0000004	2013-02	Technical Support Engineer	Remoto
EMP0000424	EMPRESA0000050	2007-02	Technical Writer	Remoto
EMP0000425	EMPRESA0000146	2001-02	Embedded Systems Engineer	Remoto
EMP0000426	EMPRESA0000054	2023-02	Computer Vision Engineer	Presencial
EMP0000427	EMPRESA0000086	2022-02	Web Developer	Hibrido
EMP0000428	EMPRESA0000044	2018-01	API Developer	Hibrido
EMP0000429	EMPRESA0000115	2016-01	Robotics Engineer	Remoto
EMP0000430	EMPRESA0000133	2015-02	Software Architect	Remoto
EMP0000431	EMPRESA0000069	2013-02	Big Data Engineer	Remoto
EMP0000432	EMPRESA0000136	2020-01	Network Security Engineer	Presencial
EMP0000433	EMPRESA0000080	2018-02	Cloud Engineer	Hibrido
EMP0000434	EMPRESA0000026	2019-01	Artificial Intelligence Engineer	Hibrido
EMP0000435	EMPRESA0000017	2001-02	Augmented Reality Developer	Presencial
EMP0000436	EMPRESA0000090	2024-01	Virtual Reality Developer	Hibrido
EMP0000437	EMPRESA0000028	2011-01	IT Project Manager	Remoto
EMP0000438	EMPRESA0000145	2014-01	Automation Engineer	Remoto
EMP0000439	EMPRESA0000129	2009-02	Penetration Tester	Remoto
EMP0000440	EMPRESA0000138	2002-02	CRM Developer	Remoto
EMP0000441	EMPRESA0000094	2003-01	Data Engineer	Remoto
EMP0000442	EMPRESA0000051	2000-01	Help Desk Technician	Hibrido
EMP0000443	EMPRESA0000008	2020-02	Solutions Engineer	Hibrido
EMP0000444	EMPRESA0000005	2017-02	IT Consultant	Presencial
EMP0000445	EMPRESA0000078	2020-02	IoT Developer	Remoto
EMP0000446	EMPRESA0000131	2011-02	Software Tester	Hibrido
EMP0000447	EMPRESA0000057	2006-01	Security Engineer	Hibrido
EMP0000448	EMPRESA0000008	2007-02	Database Engineer	Presencial
EMP0000449	EMPRESA0000149	2022-01	IT Operations Manager	Remoto
EMP0000450	EMPRESA0000038	2022-02	Cybersecurity Consultant	Presencial
EMP0000451	EMPRESA0000100	2008-02	Digital Transformation Manager	Presencial
EMP0000452	EMPRESA0000109	2022-02	Cloud Solutions Specialist	Presencial
EMP0000453	EMPRESA0000054	2011-02	Systems Engineer	Hibrido
EMP0000454	EMPRESA0000109	2016-02	Mobile Architect	Hibrido
EMP0000455	EMPRESA0000077	2006-01	Data Warehouse Engineer	Remoto
EMP0000456	EMPRESA0000133	2000-01	Application Developer	Remoto
EMP0000457	EMPRESA0000037	2005-01	Cloud Consultant	Hibrido
EMP0000458	EMPRESA0000104	2004-01	Blockchain Analyst	Hibrido
EMP0000459	EMPRESA0000118	2022-02	User Researcher	Hibrido
EMP0000460	EMPRESA0000042	2000-02	Machine Learning Developer	Hibrido
EMP0000461	EMPRESA0000097	2021-02	Algorithm Developer	Hibrido
EMP0000462	EMPRESA0000097	2001-02	Data Operations Analyst	Hibrido
EMP0000463	EMPRESA0000057	2014-02	Tech Support Specialist	Remoto
EMP0000464	EMPRESA0000069	2012-02	Cloud Infrastructure Engineer	Remoto
EMP0000465	EMPRESA0000106	2023-02	DevSecOps Engineer	Remoto
EMP0000466	EMPRESA0000115	2012-02	Information Systems Manager	Remoto
EMP0000467	EMPRESA0000131	2007-01	Scrum Master	Remoto
EMP0000468	EMPRESA0000024	2021-01	Firmware Engineer	Remoto
EMP0000469	EMPRESA0000006	2009-02	Network Architect	Presencial
EMP0000470	EMPRESA0000046	2001-01	Virtualization Engineer	Hibrido
EMP0000471	EMPRESA0000025	2024-01	IT Analyst	Remoto
EMP0000472	EMPRESA0000012	2022-02	Chief Technology Officer (CTO)	Remoto
EMP0000473	EMPRESA0000012	2014-01	Chief Information Officer (CIO)	Presencial
EMP0000474	EMPRESA0000075	2020-02	Release Manager	Presencial
EMP0000475	EMPRESA0000131	2010-02	ERP Developer	Remoto
EMP0000476	EMPRESA0000072	2016-01	SAP Consultant	Remoto
EMP0000477	EMPRESA0000132	2016-02	Front-End Architect	Remoto
EMP0000478	EMPRESA0000106	2015-01	Digital Marketing Technologist	Remoto
EMP0000479	EMPRESA0000080	2007-02	Technical Recruiter	Remoto
EMP0000480	EMPRESA0000101	2016-02	Solutions Developer	Remoto
EMP0000481	EMPRESA0000115	2013-02	Data Governance Analyst	Presencial
EMP0000482	EMPRESA0000088	2004-01	Mobile Security Analyst	Remoto
EMP0000483	EMPRESA0000010	2019-01	Cloud Security Engineer	Remoto
EMP0000484	EMPRESA0000008	2014-01	AI Trainer	Remoto
EMP0000485	EMPRESA0000128	2006-01	Tech Evangelist	Hibrido
EMP0000486	EMPRESA0000015	2010-02	IT Risk Analyst	Hibrido
EMP0000487	EMPRESA0000007	2005-02	IT Auditor	Remoto
EMP0000488	EMPRESA0000087	2008-02	Mobile Product Manager	Remoto
EMP0000489	EMPRESA0000082	2004-01	Infrastructure Engineer	Remoto
EMP0000490	EMPRESA0000059	2014-02	Incident Response Analyst	Hibrido
EMP0000491	EMPRESA0000078	2004-02	Server Administrator	Presencial
EMP0000492	EMPRESA0000118	2019-02	IT Trainer	Presencial
EMP0000493	EMPRESA0000104	2004-02	Data Visualization Engineer	Presencial
EMP0000494	EMPRESA0000004	2001-02	E-commerce Developer	Remoto
EMP0000495	EMPRESA0000140	2016-02	Digital Forensics Analyst	Presencial
EMP0000496	EMPRESA0000097	2009-02	Innovation Manager	Remoto
EMP0000497	EMPRESA0000149	2018-02	Software Engineer	Hibrido
EMP0000498	EMPRESA0000100	2024-01	Frontend Developer	Hibrido
EMP0000499	EMPRESA0000041	2017-02	Backend Developer	Presencial
EMP0000500	EMPRESA0000051	2024-02	Full Stack Developer	Remoto
EMP0000501	EMPRESA0000129	2006-02	Data Scientist	Remoto
EMP0000502	EMPRESA0000047	2016-01	DevOps Engineer	Hibrido
EMP0000503	EMPRESA0000142	2022-02	Cloud Architect	Hibrido
EMP0000504	EMPRESA0000084	2007-01	Systems Administrator	Hibrido
EMP0000505	EMPRESA0000046	2001-02	Machine Learning Engineer	Presencial
EMP0000506	EMPRESA0000032	2001-01	Database Administrator	Remoto
EMP0000507	EMPRESA0000057	2022-02	IT Support Specialist	Remoto
EMP0000508	EMPRESA0000061	2006-02	Security Analyst	Remoto
EMP0000509	EMPRESA0000101	2013-02	Network Engineer	Hibrido
EMP0000510	EMPRESA0000105	2021-02	AI Researcher	Presencial
EMP0000511	EMPRESA0000115	2010-02	Mobile App Developer	Remoto
EMP0000512	EMPRESA0000128	2019-02	Product Manager	Remoto
EMP0000513	EMPRESA0000112	2020-02	UI/UX Designer	Remoto
EMP0000514	EMPRESA0000130	2010-01	Blockchain Developer	Hibrido
EMP0000515	EMPRESA0000105	2001-02	Cybersecurity Specialist	Hibrido
EMP0000516	EMPRESA0000069	2022-01	Solutions Architect	Hibrido
EMP0000517	EMPRESA0000001	2020-01	Data Analyst	Remoto
EMP0000518	EMPRESA0000073	2016-02	Game Developer	Remoto
EMP0000519	EMPRESA0000085	2004-01	Business Intelligence Analyst	Remoto
EMP0000520	EMPRESA0000105	2022-02	Site Reliability Engineer	Remoto
EMP0000521	EMPRESA0000094	2018-02	Quality Assurance Engineer	Remoto
EMP0000522	EMPRESA0000131	2022-02	Technical Support Engineer	Hibrido
EMP0000523	EMPRESA0000018	2009-01	Technical Writer	Hibrido
EMP0000524	EMPRESA0000102	2011-01	Embedded Systems Engineer	Presencial
EMP0000525	EMPRESA0000062	2014-02	Computer Vision Engineer	Hibrido
EMP0000526	EMPRESA0000005	2000-02	Web Developer	Remoto
EMP0000527	EMPRESA0000043	2006-02	API Developer	Hibrido
EMP0000528	EMPRESA0000136	2022-01	Robotics Engineer	Hibrido
EMP0000529	EMPRESA0000004	2005-01	Software Architect	Remoto
EMP0000530	EMPRESA0000090	2018-02	Big Data Engineer	Hibrido
EMP0000531	EMPRESA0000030	2003-02	Network Security Engineer	Remoto
EMP0000532	EMPRESA0000062	2020-01	Cloud Engineer	Remoto
EMP0000533	EMPRESA0000056	2011-01	Artificial Intelligence Engineer	Presencial
EMP0000534	EMPRESA0000126	2014-01	Augmented Reality Developer	Remoto
EMP0000535	EMPRESA0000089	2023-01	Virtual Reality Developer	Remoto
EMP0000536	EMPRESA0000107	2002-02	IT Project Manager	Hibrido
EMP0000537	EMPRESA0000113	2021-02	Automation Engineer	Hibrido
EMP0000538	EMPRESA0000002	2003-01	Penetration Tester	Presencial
EMP0000539	EMPRESA0000079	2002-02	CRM Developer	Presencial
EMP0000540	EMPRESA0000046	2024-01	Data Engineer	Remoto
EMP0000541	EMPRESA0000129	2000-02	Help Desk Technician	Hibrido
EMP0000542	EMPRESA0000133	2012-02	Solutions Engineer	Presencial
EMP0000543	EMPRESA0000091	2019-01	IT Consultant	Hibrido
EMP0000544	EMPRESA0000006	2006-01	IoT Developer	Hibrido
EMP0000545	EMPRESA0000042	2011-01	Software Tester	Remoto
EMP0000546	EMPRESA0000026	2016-01	Security Engineer	Hibrido
EMP0000547	EMPRESA0000132	2008-01	Database Engineer	Remoto
EMP0000548	EMPRESA0000038	2020-02	IT Operations Manager	Presencial
EMP0000549	EMPRESA0000046	2002-02	Cybersecurity Consultant	Remoto
EMP0000550	EMPRESA0000136	2021-02	Digital Transformation Manager	Hibrido
EMP0000551	EMPRESA0000118	2002-02	Cloud Solutions Specialist	Remoto
EMP0000552	EMPRESA0000042	2005-01	Systems Engineer	Remoto
EMP0000553	EMPRESA0000062	2022-02	Mobile Architect	Presencial
EMP0000554	EMPRESA0000005	2002-01	Data Warehouse Engineer	Remoto
EMP0000555	EMPRESA0000082	2017-02	Application Developer	Remoto
EMP0000556	EMPRESA0000072	2009-02	Cloud Consultant	Remoto
EMP0000557	EMPRESA0000056	2014-01	Blockchain Analyst	Remoto
EMP0000558	EMPRESA0000055	2004-01	User Researcher	Hibrido
EMP0000559	EMPRESA0000031	2017-01	Machine Learning Developer	Remoto
EMP0000560	EMPRESA0000125	2015-02	Algorithm Developer	Remoto
EMP0000561	EMPRESA0000080	2003-01	Data Operations Analyst	Hibrido
EMP0000562	EMPRESA0000140	2022-02	Tech Support Specialist	Hibrido
EMP0000563	EMPRESA0000079	2015-01	Cloud Infrastructure Engineer	Remoto
EMP0000564	EMPRESA0000015	2017-01	DevSecOps Engineer	Remoto
EMP0000565	EMPRESA0000134	2022-01	Information Systems Manager	Remoto
EMP0000566	EMPRESA0000021	2021-02	Scrum Master	Presencial
EMP0000567	EMPRESA0000056	2009-01	Firmware Engineer	Remoto
EMP0000568	EMPRESA0000104	2020-01	Network Architect	Hibrido
EMP0000569	EMPRESA0000052	2016-01	Virtualization Engineer	Remoto
EMP0000570	EMPRESA0000047	2007-01	IT Analyst	Presencial
EMP0000571	EMPRESA0000071	2018-01	Chief Technology Officer (CTO)	Remoto
EMP0000572	EMPRESA0000020	2019-02	Chief Information Officer (CIO)	Presencial
EMP0000573	EMPRESA0000104	2019-02	Release Manager	Hibrido
EMP0000574	EMPRESA0000016	2006-01	ERP Developer	Remoto
EMP0000575	EMPRESA0000104	2024-02	SAP Consultant	Remoto
EMP0000576	EMPRESA0000084	2008-02	Front-End Architect	Hibrido
EMP0000577	EMPRESA0000058	2024-01	Digital Marketing Technologist	Remoto
EMP0000578	EMPRESA0000040	2012-02	Technical Recruiter	Hibrido
EMP0000579	EMPRESA0000039	2006-01	Solutions Developer	Remoto
EMP0000580	EMPRESA0000034	2008-02	Data Governance Analyst	Hibrido
EMP0000581	EMPRESA0000020	2012-01	Mobile Security Analyst	Presencial
EMP0000582	EMPRESA0000061	2010-01	Cloud Security Engineer	Presencial
EMP0000583	EMPRESA0000137	2018-02	AI Trainer	Hibrido
EMP0000584	EMPRESA0000077	2024-02	Tech Evangelist	Remoto
EMP0000585	EMPRESA0000145	2019-01	IT Risk Analyst	Hibrido
EMP0000586	EMPRESA0000017	2020-02	IT Auditor	Hibrido
EMP0000587	EMPRESA0000128	2000-01	Mobile Product Manager	Remoto
EMP0000588	EMPRESA0000052	2002-01	Infrastructure Engineer	Hibrido
EMP0000589	EMPRESA0000058	2008-01	Incident Response Analyst	Presencial
EMP0000590	EMPRESA0000023	2019-01	Server Administrator	Remoto
EMP0000591	EMPRESA0000054	2022-02	IT Trainer	Remoto
EMP0000592	EMPRESA0000035	2009-01	Data Visualization Engineer	Hibrido
EMP0000593	EMPRESA0000086	2002-01	E-commerce Developer	Remoto
EMP0000594	EMPRESA0000132	2000-02	Digital Forensics Analyst	Remoto
EMP0000595	EMPRESA0000115	2003-02	Innovation Manager	Hibrido
EMP0000596	EMPRESA0000098	2009-02	Software Engineer	Presencial
EMP0000597	EMPRESA0000084	2006-01	Frontend Developer	Remoto
EMP0000598	EMPRESA0000089	2007-01	Backend Developer	Hibrido
EMP0000599	EMPRESA0000049	2014-01	Full Stack Developer	Remoto
EMP0000600	EMPRESA0000134	2019-01	Data Scientist	Remoto
EMP0000601	EMPRESA0000027	2024-02	DevOps Engineer	Hibrido
EMP0000602	EMPRESA0000141	2023-02	Cloud Architect	Remoto
EMP0000603	EMPRESA0000057	2018-02	Systems Administrator	Presencial
EMP0000604	EMPRESA0000115	2009-01	Machine Learning Engineer	Remoto
EMP0000605	EMPRESA0000012	2000-01	Database Administrator	Remoto
EMP0000606	EMPRESA0000010	2021-01	IT Support Specialist	Hibrido
EMP0000607	EMPRESA0000009	2024-02	Security Analyst	Presencial
EMP0000608	EMPRESA0000072	2002-01	Network Engineer	Hibrido
EMP0000609	EMPRESA0000080	2010-01	AI Researcher	Hibrido
EMP0000610	EMPRESA0000089	2014-02	Mobile App Developer	Remoto
EMP0000611	EMPRESA0000026	2005-01	Product Manager	Remoto
EMP0000612	EMPRESA0000011	2020-02	UI/UX Designer	Remoto
EMP0000613	EMPRESA0000112	2018-01	Blockchain Developer	Remoto
EMP0000614	EMPRESA0000003	2008-02	Cybersecurity Specialist	Presencial
EMP0000615	EMPRESA0000019	2017-02	Solutions Architect	Remoto
EMP0000616	EMPRESA0000145	2017-02	Data Analyst	Remoto
EMP0000617	EMPRESA0000101	2000-01	Game Developer	Hibrido
EMP0000618	EMPRESA0000071	2008-01	Business Intelligence Analyst	Hibrido
EMP0000619	EMPRESA0000053	2009-01	Site Reliability Engineer	Hibrido
EMP0000620	EMPRESA0000113	2007-02	Quality Assurance Engineer	Hibrido
EMP0000621	EMPRESA0000081	2022-01	Technical Support Engineer	Hibrido
EMP0000622	EMPRESA0000082	2010-02	Technical Writer	Presencial
EMP0000623	EMPRESA0000137	2003-02	Embedded Systems Engineer	Hibrido
EMP0000624	EMPRESA0000118	2000-01	Computer Vision Engineer	Remoto
EMP0000625	EMPRESA0000063	2012-02	Web Developer	Hibrido
EMP0000626	EMPRESA0000042	2016-01	API Developer	Hibrido
EMP0000627	EMPRESA0000025	2008-01	Robotics Engineer	Hibrido
EMP0000628	EMPRESA0000124	2013-01	Software Architect	Presencial
EMP0000629	EMPRESA0000067	2015-02	Big Data Engineer	Remoto
EMP0000630	EMPRESA0000049	2022-01	Network Security Engineer	Remoto
EMP0000631	EMPRESA0000034	2014-01	Cloud Engineer	Hibrido
EMP0000632	EMPRESA0000049	2014-01	Artificial Intelligence Engineer	Hibrido
EMP0000633	EMPRESA0000054	2011-01	Augmented Reality Developer	Remoto
EMP0000634	EMPRESA0000072	2009-02	Virtual Reality Developer	Presencial
EMP0000635	EMPRESA0000084	2012-01	IT Project Manager	Presencial
EMP0000636	EMPRESA0000092	2003-01	Automation Engineer	Remoto
EMP0000637	EMPRESA0000113	2007-02	Penetration Tester	Remoto
EMP0000638	EMPRESA0000046	2023-02	CRM Developer	Hibrido
EMP0000639	EMPRESA0000093	2020-01	Data Engineer	Remoto
EMP0000640	EMPRESA0000148	2024-01	Help Desk Technician	Presencial
EMP0000641	EMPRESA0000089	2001-02	Solutions Engineer	Remoto
EMP0000642	EMPRESA0000101	2004-01	IT Consultant	Remoto
EMP0000643	EMPRESA0000144	2005-02	IoT Developer	Remoto
EMP0000644	EMPRESA0000149	2003-02	Software Tester	Remoto
EMP0000645	EMPRESA0000101	2009-01	Security Engineer	Remoto
EMP0000646	EMPRESA0000104	2021-01	Database Engineer	Presencial
EMP0000647	EMPRESA0000102	2006-01	IT Operations Manager	Presencial
EMP0000648	EMPRESA0000141	2005-02	Cybersecurity Consultant	Remoto
EMP0000649	EMPRESA0000070	2024-01	Digital Transformation Manager	Remoto
EMP0000650	EMPRESA0000048	2017-02	Cloud Solutions Specialist	Presencial
EMP0000651	EMPRESA0000121	2008-01	Systems Engineer	Hibrido
EMP0000652	EMPRESA0000146	2002-02	Mobile Architect	Remoto
EMP0000653	EMPRESA0000041	2004-01	Data Warehouse Engineer	Hibrido
EMP0000654	EMPRESA0000019	2023-01	Application Developer	Hibrido
EMP0000655	EMPRESA0000108	2007-01	Cloud Consultant	Hibrido
EMP0000656	EMPRESA0000019	2013-01	Blockchain Analyst	Presencial
EMP0000657	EMPRESA0000084	2004-01	User Researcher	Hibrido
EMP0000658	EMPRESA0000046	2024-01	Machine Learning Developer	Remoto
EMP0000659	EMPRESA0000147	2017-02	Algorithm Developer	Presencial
EMP0000660	EMPRESA0000024	2013-02	Data Operations Analyst	Presencial
EMP0000661	EMPRESA0000001	2012-02	Tech Support Specialist	Presencial
EMP0000662	EMPRESA0000045	2010-02	Cloud Infrastructure Engineer	Hibrido
EMP0000663	EMPRESA0000069	2021-02	DevSecOps Engineer	Hibrido
EMP0000664	EMPRESA0000013	2024-01	Information Systems Manager	Remoto
EMP0000665	EMPRESA0000047	2008-01	Scrum Master	Hibrido
EMP0000666	EMPRESA0000006	2000-02	Firmware Engineer	Remoto
EMP0000667	EMPRESA0000041	2003-02	Network Architect	Hibrido
EMP0000668	EMPRESA0000072	2003-02	Virtualization Engineer	Hibrido
EMP0000669	EMPRESA0000122	2014-02	IT Analyst	Hibrido
EMP0000670	EMPRESA0000074	2004-01	Chief Technology Officer (CTO)	Remoto
EMP0000671	EMPRESA0000085	2017-02	Chief Information Officer (CIO)	Presencial
EMP0000672	EMPRESA0000102	2024-02	Release Manager	Remoto
EMP0000673	EMPRESA0000124	2008-02	ERP Developer	Hibrido
EMP0000674	EMPRESA0000055	2003-02	SAP Consultant	Remoto
EMP0000675	EMPRESA0000078	2020-01	Front-End Architect	Remoto
EMP0000676	EMPRESA0000129	2007-01	Digital Marketing Technologist	Hibrido
EMP0000677	EMPRESA0000058	2006-01	Technical Recruiter	Presencial
EMP0000678	EMPRESA0000090	2017-01	Solutions Developer	Remoto
EMP0000679	EMPRESA0000006	2024-02	Data Governance Analyst	Presencial
EMP0000680	EMPRESA0000020	2015-02	Mobile Security Analyst	Presencial
EMP0000681	EMPRESA0000015	2009-02	Cloud Security Engineer	Presencial
EMP0000682	EMPRESA0000082	2012-01	AI Trainer	Presencial
EMP0000683	EMPRESA0000137	2003-02	Tech Evangelist	Hibrido
EMP0000684	EMPRESA0000145	2021-02	IT Risk Analyst	Remoto
EMP0000685	EMPRESA0000043	2002-02	IT Auditor	Hibrido
EMP0000686	EMPRESA0000141	2017-02	Mobile Product Manager	Presencial
EMP0000687	EMPRESA0000025	2011-01	Infrastructure Engineer	Hibrido
EMP0000688	EMPRESA0000072	2008-01	Incident Response Analyst	Remoto
EMP0000689	EMPRESA0000114	2011-01	Server Administrator	Remoto
EMP0000690	EMPRESA0000097	2002-01	IT Trainer	Presencial
EMP0000691	EMPRESA0000098	2013-01	Data Visualization Engineer	Hibrido
EMP0000692	EMPRESA0000113	2015-01	E-commerce Developer	Hibrido
EMP0000693	EMPRESA0000037	2011-02	Digital Forensics Analyst	Hibrido
EMP0000694	EMPRESA0000014	2013-01	Innovation Manager	Remoto
EMP0000695	EMPRESA0000144	2000-01	Software Engineer	Remoto
EMP0000696	EMPRESA0000083	2002-02	Frontend Developer	Remoto
EMP0000697	EMPRESA0000059	2018-01	Backend Developer	Presencial
EMP0000698	EMPRESA0000056	2014-02	Full Stack Developer	Presencial
EMP0000699	EMPRESA0000010	2013-01	Data Scientist	Presencial
EMP0000700	EMPRESA0000144	2014-02	DevOps Engineer	Presencial
EMP0000701	EMPRESA0000062	2005-01	Cloud Architect	Hibrido
EMP0000702	EMPRESA0000008	2017-02	Systems Administrator	Remoto
EMP0000703	EMPRESA0000006	2024-02	Machine Learning Engineer	Presencial
EMP0000704	EMPRESA0000036	2005-01	Database Administrator	Presencial
EMP0000705	EMPRESA0000026	2001-02	IT Support Specialist	Remoto
EMP0000706	EMPRESA0000104	2024-02	Security Analyst	Remoto
EMP0000707	EMPRESA0000081	2012-01	Network Engineer	Remoto
EMP0000708	EMPRESA0000011	2017-02	AI Researcher	Presencial
EMP0000709	EMPRESA0000108	2011-02	Mobile App Developer	Remoto
EMP0000710	EMPRESA0000131	2005-02	Product Manager	Remoto
EMP0000711	EMPRESA0000110	2024-02	UI/UX Designer	Presencial
EMP0000712	EMPRESA0000007	2007-02	Blockchain Developer	Hibrido
EMP0000713	EMPRESA0000038	2005-02	Cybersecurity Specialist	Hibrido
EMP0000714	EMPRESA0000100	2013-02	Solutions Architect	Hibrido
EMP0000715	EMPRESA0000091	2006-02	Data Analyst	Remoto
EMP0000716	EMPRESA0000009	2006-01	Game Developer	Remoto
EMP0000717	EMPRESA0000087	2007-02	Business Intelligence Analyst	Remoto
EMP0000718	EMPRESA0000063	2008-02	Site Reliability Engineer	Hibrido
EMP0000719	EMPRESA0000039	2019-02	Quality Assurance Engineer	Remoto
EMP0000720	EMPRESA0000025	2008-02	Technical Support Engineer	Remoto
EMP0000721	EMPRESA0000017	2001-01	Technical Writer	Hibrido
EMP0000722	EMPRESA0000016	2013-01	Embedded Systems Engineer	Remoto
EMP0000723	EMPRESA0000061	2007-01	Computer Vision Engineer	Presencial
EMP0000724	EMPRESA0000032	2022-02	Web Developer	Hibrido
EMP0000725	EMPRESA0000052	2008-02	API Developer	Remoto
EMP0000726	EMPRESA0000081	2017-01	Robotics Engineer	Remoto
EMP0000727	EMPRESA0000052	2001-01	Software Architect	Remoto
EMP0000728	EMPRESA0000117	2020-01	Big Data Engineer	Remoto
EMP0000729	EMPRESA0000065	2019-01	Network Security Engineer	Remoto
EMP0000730	EMPRESA0000127	2004-02	Cloud Engineer	Hibrido
EMP0000731	EMPRESA0000076	2005-02	Artificial Intelligence Engineer	Remoto
EMP0000732	EMPRESA0000073	2011-02	Augmented Reality Developer	Presencial
EMP0000733	EMPRESA0000074	2008-01	Virtual Reality Developer	Presencial
EMP0000734	EMPRESA0000124	2023-02	IT Project Manager	Presencial
EMP0000735	EMPRESA0000008	2007-02	Automation Engineer	Remoto
EMP0000736	EMPRESA0000110	2009-01	Penetration Tester	Remoto
EMP0000737	EMPRESA0000114	2016-01	CRM Developer	Presencial
EMP0000738	EMPRESA0000054	2007-02	Data Engineer	Hibrido
EMP0000739	EMPRESA0000009	2012-02	Help Desk Technician	Presencial
EMP0000740	EMPRESA0000061	2013-02	Solutions Engineer	Hibrido
EMP0000741	EMPRESA0000058	2000-01	IT Consultant	Remoto
EMP0000742	EMPRESA0000117	2022-02	IoT Developer	Hibrido
EMP0000743	EMPRESA0000082	2009-02	Software Tester	Presencial
EMP0000744	EMPRESA0000072	2010-01	Security Engineer	Presencial
EMP0000745	EMPRESA0000109	2002-01	Database Engineer	Hibrido
EMP0000746	EMPRESA0000132	2011-01	IT Operations Manager	Remoto
EMP0000747	EMPRESA0000123	2013-02	Cybersecurity Consultant	Presencial
EMP0000748	EMPRESA0000083	2016-01	Digital Transformation Manager	Hibrido
EMP0000749	EMPRESA0000091	2009-01	Cloud Solutions Specialist	Remoto
EMP0000750	EMPRESA0000060	2003-02	Systems Engineer	Hibrido
EMP0000751	EMPRESA0000123	2006-02	Mobile Architect	Presencial
EMP0000752	EMPRESA0000032	2012-01	Data Warehouse Engineer	Hibrido
EMP0000753	EMPRESA0000125	2014-01	Application Developer	Remoto
EMP0000754	EMPRESA0000150	2020-02	Cloud Consultant	Hibrido
EMP0000755	EMPRESA0000023	2003-02	Blockchain Analyst	Remoto
EMP0000756	EMPRESA0000097	2001-02	User Researcher	Remoto
EMP0000757	EMPRESA0000082	2020-01	Machine Learning Developer	Hibrido
EMP0000758	EMPRESA0000068	2020-02	Algorithm Developer	Remoto
EMP0000759	EMPRESA0000075	2014-01	Data Operations Analyst	Hibrido
EMP0000760	EMPRESA0000058	2009-02	Tech Support Specialist	Remoto
EMP0000761	EMPRESA0000034	2001-01	Cloud Infrastructure Engineer	Remoto
EMP0000762	EMPRESA0000017	2010-01	DevSecOps Engineer	Presencial
EMP0000763	EMPRESA0000004	2022-01	Information Systems Manager	Presencial
EMP0000764	EMPRESA0000044	2003-01	Scrum Master	Remoto
EMP0000765	EMPRESA0000031	2024-02	Firmware Engineer	Presencial
EMP0000766	EMPRESA0000093	2009-01	Network Architect	Hibrido
EMP0000767	EMPRESA0000037	2023-01	Virtualization Engineer	Remoto
EMP0000768	EMPRESA0000043	2012-02	IT Analyst	Remoto
EMP0000769	EMPRESA0000129	2017-02	Chief Technology Officer (CTO)	Remoto
EMP0000770	EMPRESA0000050	2017-02	Chief Information Officer (CIO)	Presencial
EMP0000771	EMPRESA0000073	2018-01	Release Manager	Remoto
EMP0000772	EMPRESA0000008	2000-01	ERP Developer	Remoto
EMP0000773	EMPRESA0000070	2002-01	SAP Consultant	Remoto
EMP0000774	EMPRESA0000072	2005-01	Front-End Architect	Remoto
EMP0000775	EMPRESA0000050	2017-02	Digital Marketing Technologist	Hibrido
EMP0000776	EMPRESA0000113	2004-01	Technical Recruiter	Hibrido
EMP0000777	EMPRESA0000119	2002-01	Solutions Developer	Remoto
EMP0000778	EMPRESA0000088	2003-01	Data Governance Analyst	Remoto
EMP0000779	EMPRESA0000079	2020-01	Mobile Security Analyst	Hibrido
EMP0000780	EMPRESA0000004	2021-02	Cloud Security Engineer	Presencial
EMP0000781	EMPRESA0000098	2017-02	AI Trainer	Remoto
EMP0000782	EMPRESA0000048	2021-02	Tech Evangelist	Presencial
EMP0000783	EMPRESA0000078	2020-01	IT Risk Analyst	Hibrido
EMP0000784	EMPRESA0000077	2003-01	IT Auditor	Presencial
EMP0000785	EMPRESA0000138	2005-01	Mobile Product Manager	Presencial
EMP0000786	EMPRESA0000021	2021-02	Infrastructure Engineer	Remoto
EMP0000787	EMPRESA0000036	2007-01	Incident Response Analyst	Remoto
EMP0000788	EMPRESA0000130	2005-02	Server Administrator	Remoto
EMP0000789	EMPRESA0000147	2003-02	IT Trainer	Remoto
EMP0000790	EMPRESA0000098	2020-02	Data Visualization Engineer	Remoto
EMP0000791	EMPRESA0000084	2021-01	E-commerce Developer	Remoto
EMP0000792	EMPRESA0000025	2016-01	Digital Forensics Analyst	Hibrido
EMP0000793	EMPRESA0000106	2018-02	Innovation Manager	Remoto
EMP0000794	EMPRESA0000045	2006-02	Software Engineer	Remoto
EMP0000795	EMPRESA0000075	2001-02	Frontend Developer	Hibrido
EMP0000796	EMPRESA0000027	2000-01	Backend Developer	Remoto
EMP0000797	EMPRESA0000084	2008-02	Full Stack Developer	Remoto
EMP0000798	EMPRESA0000080	2020-01	Data Scientist	Remoto
EMP0000799	EMPRESA0000026	2007-02	DevOps Engineer	Remoto
EMP0000800	EMPRESA0000121	2010-02	Cloud Architect	Remoto
EMP0000801	EMPRESA0000093	2023-01	Systems Administrator	Remoto
EMP0000802	EMPRESA0000129	2009-02	Machine Learning Engineer	Remoto
EMP0000803	EMPRESA0000137	2004-02	Database Administrator	Presencial
EMP0000804	EMPRESA0000104	2012-01	IT Support Specialist	Remoto
EMP0000805	EMPRESA0000045	2020-02	Security Analyst	Hibrido
EMP0000806	EMPRESA0000086	2024-01	Network Engineer	Remoto
EMP0000807	EMPRESA0000023	2011-02	AI Researcher	Hibrido
EMP0000808	EMPRESA0000070	2020-02	Mobile App Developer	Remoto
EMP0000809	EMPRESA0000059	2000-01	Product Manager	Hibrido
EMP0000810	EMPRESA0000086	2010-01	UI/UX Designer	Presencial
EMP0000811	EMPRESA0000063	2011-01	Blockchain Developer	Remoto
EMP0000812	EMPRESA0000089	2024-01	Cybersecurity Specialist	Remoto
EMP0000813	EMPRESA0000024	2003-01	Solutions Architect	Remoto
EMP0000814	EMPRESA0000149	2016-01	Data Analyst	Remoto
EMP0000815	EMPRESA0000090	2010-01	Game Developer	Remoto
EMP0000816	EMPRESA0000003	2015-01	Business Intelligence Analyst	Remoto
EMP0000817	EMPRESA0000046	2013-02	Site Reliability Engineer	Hibrido
EMP0000818	EMPRESA0000096	2015-02	Quality Assurance Engineer	Remoto
EMP0000819	EMPRESA0000107	2022-02	Technical Support Engineer	Hibrido
EMP0000820	EMPRESA0000036	2024-02	Technical Writer	Presencial
EMP0000821	EMPRESA0000109	2012-01	Embedded Systems Engineer	Remoto
EMP0000822	EMPRESA0000118	2011-02	Computer Vision Engineer	Hibrido
EMP0000823	EMPRESA0000063	2005-02	Web Developer	Hibrido
EMP0000824	EMPRESA0000143	2009-01	API Developer	Remoto
EMP0000825	EMPRESA0000096	2006-01	Robotics Engineer	Presencial
EMP0000826	EMPRESA0000099	2005-01	Software Architect	Hibrido
EMP0000827	EMPRESA0000084	2006-01	Big Data Engineer	Hibrido
EMP0000828	EMPRESA0000132	2014-02	Network Security Engineer	Hibrido
EMP0000829	EMPRESA0000019	2014-01	Cloud Engineer	Hibrido
EMP0000830	EMPRESA0000107	2018-01	Artificial Intelligence Engineer	Presencial
EMP0000831	EMPRESA0000099	2013-02	Augmented Reality Developer	Presencial
EMP0000832	EMPRESA0000075	2018-02	Virtual Reality Developer	Hibrido
EMP0000833	EMPRESA0000114	2007-02	IT Project Manager	Hibrido
EMP0000834	EMPRESA0000034	2021-02	Automation Engineer	Hibrido
EMP0000835	EMPRESA0000148	2016-02	Penetration Tester	Hibrido
EMP0000836	EMPRESA0000009	2008-01	CRM Developer	Remoto
EMP0000837	EMPRESA0000017	2022-02	Data Engineer	Remoto
EMP0000838	EMPRESA0000098	2021-02	Help Desk Technician	Remoto
EMP0000839	EMPRESA0000046	2023-02	Solutions Engineer	Presencial
EMP0000840	EMPRESA0000004	2018-01	IT Consultant	Remoto
EMP0000841	EMPRESA0000037	2006-01	IoT Developer	Hibrido
EMP0000842	EMPRESA0000128	2019-02	Software Tester	Remoto
EMP0000843	EMPRESA0000071	2016-02	Security Engineer	Remoto
EMP0000844	EMPRESA0000007	2023-02	Database Engineer	Hibrido
EMP0000845	EMPRESA0000085	2001-02	IT Operations Manager	Hibrido
EMP0000846	EMPRESA0000051	2000-02	Cybersecurity Consultant	Hibrido
EMP0000847	EMPRESA0000069	2017-02	Digital Transformation Manager	Remoto
EMP0000848	EMPRESA0000065	2006-01	Cloud Solutions Specialist	Remoto
EMP0000849	EMPRESA0000125	2002-01	Systems Engineer	Remoto
EMP0000850	EMPRESA0000079	2011-01	Mobile Architect	Presencial
EMP0000851	EMPRESA0000026	2006-02	Data Warehouse Engineer	Remoto
EMP0000852	EMPRESA0000061	2012-01	Application Developer	Remoto
EMP0000853	EMPRESA0000039	2021-01	Cloud Consultant	Remoto
EMP0000854	EMPRESA0000003	2009-02	Blockchain Analyst	Hibrido
EMP0000855	EMPRESA0000125	2020-02	User Researcher	Remoto
EMP0000856	EMPRESA0000019	2005-02	Machine Learning Developer	Presencial
EMP0000857	EMPRESA0000147	2017-01	Algorithm Developer	Hibrido
EMP0000858	EMPRESA0000077	2017-02	Data Operations Analyst	Presencial
EMP0000859	EMPRESA0000122	2008-01	Tech Support Specialist	Hibrido
EMP0000860	EMPRESA0000129	2008-01	Cloud Infrastructure Engineer	Hibrido
EMP0000861	EMPRESA0000031	2011-01	DevSecOps Engineer	Presencial
EMP0000862	EMPRESA0000027	2006-02	Information Systems Manager	Hibrido
EMP0000863	EMPRESA0000113	2014-02	Scrum Master	Presencial
EMP0000864	EMPRESA0000101	2010-02	Firmware Engineer	Presencial
EMP0000865	EMPRESA0000065	2018-02	Network Architect	Remoto
EMP0000866	EMPRESA0000102	2001-02	Virtualization Engineer	Remoto
EMP0000867	EMPRESA0000103	2024-01	IT Analyst	Remoto
EMP0000868	EMPRESA0000064	2006-01	Chief Technology Officer (CTO)	Remoto
EMP0000869	EMPRESA0000087	2002-01	Chief Information Officer (CIO)	Remoto
EMP0000870	EMPRESA0000039	2009-01	Release Manager	Remoto
EMP0000871	EMPRESA0000046	2009-01	ERP Developer	Remoto
EMP0000872	EMPRESA0000012	2001-02	SAP Consultant	Remoto
EMP0000873	EMPRESA0000043	2008-01	Front-End Architect	Hibrido
EMP0000874	EMPRESA0000116	2001-01	Digital Marketing Technologist	Remoto
EMP0000875	EMPRESA0000001	2019-01	Technical Recruiter	Remoto
EMP0000876	EMPRESA0000039	2011-01	Solutions Developer	Hibrido
EMP0000877	EMPRESA0000081	2015-02	Data Governance Analyst	Hibrido
EMP0000878	EMPRESA0000135	2023-02	Mobile Security Analyst	Hibrido
EMP0000879	EMPRESA0000042	2001-01	Cloud Security Engineer	Hibrido
EMP0000880	EMPRESA0000049	2010-02	AI Trainer	Remoto
EMP0000881	EMPRESA0000041	2007-01	Tech Evangelist	Presencial
EMP0000882	EMPRESA0000047	2015-02	IT Risk Analyst	Remoto
EMP0000883	EMPRESA0000038	2005-02	IT Auditor	Hibrido
EMP0000884	EMPRESA0000116	2006-01	Mobile Product Manager	Remoto
EMP0000885	EMPRESA0000030	2010-02	Infrastructure Engineer	Remoto
EMP0000886	EMPRESA0000003	2002-01	Incident Response Analyst	Hibrido
EMP0000887	EMPRESA0000062	2004-01	Server Administrator	Hibrido
EMP0000888	EMPRESA0000004	2001-02	IT Trainer	Hibrido
EMP0000889	EMPRESA0000001	2008-01	Data Visualization Engineer	Presencial
EMP0000890	EMPRESA0000039	2002-02	E-commerce Developer	Remoto
EMP0000891	EMPRESA0000005	2010-01	Digital Forensics Analyst	Remoto
EMP0000892	EMPRESA0000093	2006-02	Innovation Manager	Hibrido
EMP0000893	EMPRESA0000128	2018-01	Software Engineer	Remoto
EMP0000894	EMPRESA0000108	2006-02	Frontend Developer	Hibrido
EMP0000895	EMPRESA0000080	2002-01	Backend Developer	Remoto
EMP0000896	EMPRESA0000054	2018-01	Full Stack Developer	Remoto
EMP0000897	EMPRESA0000123	2000-02	Data Scientist	Presencial
EMP0000898	EMPRESA0000067	2016-02	DevOps Engineer	Hibrido
EMP0000899	EMPRESA0000078	2017-02	Cloud Architect	Remoto
EMP0000900	EMPRESA0000104	2007-01	Systems Administrator	Hibrido
EMP0000901	EMPRESA0000150	2024-02	Machine Learning Engineer	Presencial
EMP0000902	EMPRESA0000092	2022-02	Database Administrator	Hibrido
EMP0000903	EMPRESA0000066	2024-02	IT Support Specialist	Remoto
EMP0000904	EMPRESA0000070	2016-01	Security Analyst	Presencial
EMP0000905	EMPRESA0000011	2018-02	Network Engineer	Hibrido
EMP0000906	EMPRESA0000077	2014-02	AI Researcher	Remoto
EMP0000907	EMPRESA0000086	2017-01	Mobile App Developer	Remoto
EMP0000908	EMPRESA0000094	2012-02	Product Manager	Presencial
EMP0000909	EMPRESA0000067	2013-01	UI/UX Designer	Presencial
EMP0000910	EMPRESA0000112	2019-01	Blockchain Developer	Hibrido
EMP0000911	EMPRESA0000069	2007-01	Cybersecurity Specialist	Presencial
EMP0000912	EMPRESA0000048	2000-01	Solutions Architect	Presencial
EMP0000913	EMPRESA0000026	2018-02	Data Analyst	Hibrido
EMP0000914	EMPRESA0000147	2018-01	Game Developer	Hibrido
EMP0000915	EMPRESA0000040	2002-02	Business Intelligence Analyst	Presencial
EMP0000916	EMPRESA0000032	2015-02	Site Reliability Engineer	Hibrido
EMP0000917	EMPRESA0000110	2016-01	Quality Assurance Engineer	Hibrido
EMP0000918	EMPRESA0000077	2023-01	Technical Support Engineer	Remoto
EMP0000919	EMPRESA0000096	2006-02	Technical Writer	Hibrido
EMP0000920	EMPRESA0000069	2022-01	Embedded Systems Engineer	Presencial
EMP0000921	EMPRESA0000096	2014-01	Computer Vision Engineer	Hibrido
EMP0000922	EMPRESA0000008	2002-01	Web Developer	Remoto
EMP0000923	EMPRESA0000043	2010-02	API Developer	Presencial
EMP0000924	EMPRESA0000029	2016-02	Robotics Engineer	Presencial
EMP0000925	EMPRESA0000015	2005-01	Software Architect	Remoto
EMP0000926	EMPRESA0000003	2022-02	Big Data Engineer	Remoto
EMP0000927	EMPRESA0000150	2019-02	Network Security Engineer	Remoto
EMP0000928	EMPRESA0000012	2018-01	Cloud Engineer	Hibrido
EMP0000929	EMPRESA0000118	2017-02	Artificial Intelligence Engineer	Presencial
EMP0000930	EMPRESA0000020	2013-01	Augmented Reality Developer	Remoto
EMP0000931	EMPRESA0000033	2009-01	Virtual Reality Developer	Hibrido
EMP0000932	EMPRESA0000118	2009-01	IT Project Manager	Hibrido
EMP0000933	EMPRESA0000049	2009-01	Automation Engineer	Remoto
EMP0000934	EMPRESA0000064	2016-02	Penetration Tester	Remoto
EMP0000935	EMPRESA0000033	2001-02	CRM Developer	Presencial
EMP0000936	EMPRESA0000125	2012-01	Data Engineer	Presencial
EMP0000937	EMPRESA0000060	2012-01	Help Desk Technician	Remoto
EMP0000938	EMPRESA0000062	2019-02	Solutions Engineer	Hibrido
EMP0000939	EMPRESA0000145	2020-01	IT Consultant	Hibrido
EMP0000940	EMPRESA0000045	2003-01	IoT Developer	Remoto
EMP0000941	EMPRESA0000068	2003-02	Software Tester	Remoto
EMP0000942	EMPRESA0000028	2019-01	Security Engineer	Remoto
EMP0000943	EMPRESA0000120	2015-01	Database Engineer	Hibrido
EMP0000944	EMPRESA0000010	2002-01	IT Operations Manager	Presencial
EMP0000945	EMPRESA0000124	2004-01	Cybersecurity Consultant	Presencial
EMP0000946	EMPRESA0000148	2008-02	Digital Transformation Manager	Remoto
EMP0000947	EMPRESA0000039	2006-01	Cloud Solutions Specialist	Remoto
EMP0000948	EMPRESA0000143	2018-02	Systems Engineer	Remoto
EMP0000949	EMPRESA0000033	2024-02	Mobile Architect	Presencial
EMP0000950	EMPRESA0000097	2003-01	Data Warehouse Engineer	Presencial
EMP0000951	EMPRESA0000019	2020-02	Application Developer	Remoto
EMP0000952	EMPRESA0000045	2007-01	Cloud Consultant	Remoto
EMP0000953	EMPRESA0000059	2014-02	Blockchain Analyst	Hibrido
EMP0000954	EMPRESA0000142	2020-01	User Researcher	Remoto
EMP0000955	EMPRESA0000138	2006-01	Machine Learning Developer	Presencial
EMP0000956	EMPRESA0000123	2023-02	Algorithm Developer	Remoto
EMP0000957	EMPRESA0000029	2023-02	Data Operations Analyst	Remoto
EMP0000958	EMPRESA0000079	2001-02	Tech Support Specialist	Remoto
EMP0000959	EMPRESA0000108	2003-01	Cloud Infrastructure Engineer	Remoto
EMP0000960	EMPRESA0000040	2022-01	DevSecOps Engineer	Remoto
EMP0000961	EMPRESA0000004	2001-02	Information Systems Manager	Hibrido
EMP0000962	EMPRESA0000061	2020-02	Scrum Master	Remoto
EMP0000963	EMPRESA0000036	2014-02	Firmware Engineer	Presencial
EMP0000964	EMPRESA0000109	2016-01	Network Architect	Hibrido
EMP0000965	EMPRESA0000118	2021-02	Virtualization Engineer	Hibrido
EMP0000966	EMPRESA0000033	2022-01	IT Analyst	Remoto
EMP0000967	EMPRESA0000125	2004-01	Chief Technology Officer (CTO)	Hibrido
EMP0000968	EMPRESA0000098	2023-02	Chief Information Officer (CIO)	Presencial
EMP0000969	EMPRESA0000043	2007-02	Release Manager	Remoto
EMP0000970	EMPRESA0000023	2020-02	ERP Developer	Remoto
EMP0000971	EMPRESA0000107	2021-02	SAP Consultant	Presencial
EMP0000972	EMPRESA0000086	2011-02	Front-End Architect	Hibrido
EMP0000973	EMPRESA0000086	2020-01	Digital Marketing Technologist	Presencial
EMP0000974	EMPRESA0000105	2011-02	Technical Recruiter	Remoto
EMP0000975	EMPRESA0000040	2013-02	Solutions Developer	Remoto
EMP0000976	EMPRESA0000043	2009-01	Data Governance Analyst	Hibrido
EMP0000977	EMPRESA0000131	2000-01	Mobile Security Analyst	Remoto
EMP0000978	EMPRESA0000128	2009-02	Cloud Security Engineer	Remoto
EMP0000979	EMPRESA0000136	2017-02	AI Trainer	Presencial
EMP0000980	EMPRESA0000017	2013-01	Tech Evangelist	Remoto
EMP0000981	EMPRESA0000087	2012-01	IT Risk Analyst	Hibrido
EMP0000982	EMPRESA0000047	2021-01	IT Auditor	Hibrido
EMP0000983	EMPRESA0000094	2003-02	Mobile Product Manager	Hibrido
EMP0000984	EMPRESA0000136	2008-02	Infrastructure Engineer	Remoto
EMP0000985	EMPRESA0000014	2017-01	Incident Response Analyst	Presencial
EMP0000986	EMPRESA0000124	2020-02	Server Administrator	Remoto
EMP0000987	EMPRESA0000013	2017-01	IT Trainer	Presencial
EMP0000988	EMPRESA0000127	2003-02	Data Visualization Engineer	Hibrido
EMP0000989	EMPRESA0000090	2017-02	E-commerce Developer	Remoto
EMP0000990	EMPRESA0000049	2013-02	Digital Forensics Analyst	Remoto
EMP0000991	EMPRESA0000113	2017-01	Innovation Manager	Remoto
EMP0000992	EMPRESA0000146	2010-01	Software Engineer	Hibrido
EMP0000993	EMPRESA0000017	2019-02	Frontend Developer	Remoto
EMP0000994	EMPRESA0000008	2001-01	Backend Developer	Remoto
EMP0000995	EMPRESA0000147	2017-02	Full Stack Developer	Presencial
EMP0000996	EMPRESA0000006	2000-01	Data Scientist	Hibrido
EMP0000997	EMPRESA0000087	2003-01	DevOps Engineer	Hibrido
EMP0000998	EMPRESA0000047	2004-01	Cloud Architect	Remoto
EMP0000999	EMPRESA0000147	2014-01	Systems Administrator	Presencial
EMP0001000	EMPRESA0000086	2005-02	Machine Learning Engineer	Presencial
\.


--
-- Data for Name: edesempenio; Type: TABLE DATA; Schema: public; Owner: dianasanchezordonez
--

COPY public.edesempenio (codigo, productividad_impacto, satisfaccion_trabajo, empleado_id, periodo) FROM stdin;
1	0	2	EMP0000001	2012-01
2	0	2	EMP0000002	2009-01
3	1	5	EMP0000003	2009-01
4	0	5	EMP0000004	2012-01
5	0	5	EMP0000005	2004-01
6	1	3	EMP0000006	2000-02
7	1	3	EMP0000007	2004-01
8	1	3	EMP0000008	2000-02
9	0	2	EMP0000009	2016-01
10	0	5	EMP0000010	2016-01
11	-1	5	EMP0000011	2023-01
12	0	5	EMP0000012	2016-02
13	0	3	EMP0000013	2004-02
14	-1	5	EMP0000014	2002-01
15	0	1	EMP0000015	2014-01
16	0	2	EMP0000016	2004-02
17	-1	5	EMP0000017	2020-01
18	0	5	EMP0000018	2022-02
19	0	2	EMP0000019	2016-01
20	-1	1	EMP0000020	2019-01
21	0	1	EMP0000021	2016-02
22	-1	4	EMP0000022	2002-02
23	0	3	EMP0000023	2024-01
24	1	3	EMP0000024	2022-02
25	0	4	EMP0000025	2011-02
26	0	1	EMP0000026	2003-01
27	1	3	EMP0000027	2023-02
28	1	2	EMP0000028	2006-01
29	0	3	EMP0000029	2024-02
30	1	1	EMP0000030	2009-01
31	1	2	EMP0000031	2014-01
32	1	2	EMP0000032	2006-01
33	0	2	EMP0000033	2022-02
34	0	5	EMP0000034	2018-01
35	1	5	EMP0000035	2006-02
36	0	3	EMP0000036	2004-01
37	-1	2	EMP0000037	2020-02
38	1	1	EMP0000038	2019-02
39	0	5	EMP0000039	2004-02
40	0	5	EMP0000040	2010-01
41	0	3	EMP0000041	2019-01
42	1	1	EMP0000042	2007-01
43	1	2	EMP0000043	2004-02
44	-1	5	EMP0000044	2000-01
45	0	4	EMP0000045	2024-01
46	0	3	EMP0000046	2006-02
47	-1	3	EMP0000047	2017-01
48	-1	4	EMP0000048	2019-01
49	1	5	EMP0000049	2012-01
50	0	1	EMP0000050	2024-01
51	1	5	EMP0000051	2017-02
52	-1	1	EMP0000052	2017-01
53	-1	4	EMP0000053	2022-01
54	0	5	EMP0000054	2009-01
55	-1	2	EMP0000055	2023-01
56	0	4	EMP0000056	2001-02
57	0	4	EMP0000057	2006-02
58	-1	3	EMP0000058	2005-01
59	-1	4	EMP0000059	2000-01
60	0	3	EMP0000060	2000-01
61	0	5	EMP0000061	2023-02
62	-1	2	EMP0000062	2014-02
63	0	3	EMP0000063	2008-01
64	0	3	EMP0000064	2005-01
65	0	3	EMP0000065	2003-02
66	1	2	EMP0000066	2015-02
67	-1	2	EMP0000067	2015-02
68	0	5	EMP0000068	2016-01
69	0	2	EMP0000069	2024-02
70	0	1	EMP0000070	2005-01
71	0	3	EMP0000071	2006-01
72	0	2	EMP0000072	2011-01
73	-1	5	EMP0000073	2001-01
74	0	3	EMP0000074	2003-02
75	-1	2	EMP0000075	2016-02
76	0	4	EMP0000076	2021-01
77	1	1	EMP0000077	2002-02
78	1	1	EMP0000078	2013-02
79	0	3	EMP0000079	2007-02
80	1	5	EMP0000080	2000-01
81	0	1	EMP0000081	2008-01
82	-1	3	EMP0000082	2010-02
83	0	5	EMP0000083	2012-02
84	0	4	EMP0000084	2016-02
85	-1	4	EMP0000085	2007-02
86	-1	1	EMP0000086	2016-02
87	0	5	EMP0000087	2023-01
88	1	1	EMP0000088	2013-02
89	-1	4	EMP0000089	2001-02
90	0	1	EMP0000090	2023-01
91	-1	5	EMP0000091	2003-01
92	0	5	EMP0000092	2004-01
93	0	3	EMP0000093	2020-01
94	1	5	EMP0000094	2011-02
95	1	5	EMP0000095	2010-01
96	0	3	EMP0000096	2008-01
97	0	4	EMP0000097	2013-02
98	0	1	EMP0000098	2011-01
99	0	4	EMP0000099	2014-01
100	0	2	EMP0000100	2024-01
101	1	1	EMP0000101	2006-02
102	0	1	EMP0000102	2023-02
103	-1	3	EMP0000103	2020-02
104	0	1	EMP0000104	2011-01
105	1	1	EMP0000105	2005-02
106	1	1	EMP0000106	2017-01
107	0	2	EMP0000107	2012-02
108	-1	4	EMP0000108	2022-02
109	0	3	EMP0000109	2002-02
110	-1	1	EMP0000110	2013-01
111	0	3	EMP0000111	2000-01
112	0	1	EMP0000112	2024-02
113	0	2	EMP0000113	2009-01
114	-1	1	EMP0000114	2000-01
115	-1	5	EMP0000115	2009-01
116	-1	5	EMP0000116	2019-02
117	-1	5	EMP0000117	2005-02
118	-1	4	EMP0000118	2000-02
119	-1	3	EMP0000119	2024-01
120	-1	1	EMP0000120	2022-01
121	0	3	EMP0000121	2014-01
122	-1	2	EMP0000122	2010-02
123	0	3	EMP0000123	2007-02
124	0	2	EMP0000124	2017-01
125	0	4	EMP0000125	2019-01
126	-1	1	EMP0000126	2021-02
127	-1	3	EMP0000127	2021-01
128	0	1	EMP0000128	2017-01
129	0	1	EMP0000129	2010-01
130	0	4	EMP0000130	2000-02
131	0	4	EMP0000131	2013-01
132	-1	1	EMP0000132	2007-01
133	0	4	EMP0000133	2016-02
134	-1	1	EMP0000134	2015-01
135	1	3	EMP0000135	2010-02
136	-1	1	EMP0000136	2017-01
137	0	3	EMP0000137	2014-01
138	-1	5	EMP0000138	2022-01
139	1	4	EMP0000139	2000-02
140	1	1	EMP0000140	2007-02
141	0	4	EMP0000141	2013-01
142	1	3	EMP0000142	2011-02
143	0	5	EMP0000143	2011-02
144	-1	2	EMP0000144	2012-02
145	1	1	EMP0000145	2006-02
146	-1	3	EMP0000146	2001-02
147	-1	1	EMP0000147	2006-01
148	-1	5	EMP0000148	2020-02
149	-1	5	EMP0000149	2022-01
150	0	5	EMP0000150	2015-01
151	1	4	EMP0000151	2015-01
152	1	4	EMP0000152	2023-01
153	0	3	EMP0000153	2010-01
154	1	2	EMP0000154	2024-02
155	-1	4	EMP0000155	2016-02
156	1	4	EMP0000156	2007-01
157	0	5	EMP0000157	2016-01
158	-1	1	EMP0000158	2015-01
159	0	1	EMP0000159	2000-02
160	-1	4	EMP0000160	2016-01
161	0	5	EMP0000161	2024-01
162	-1	3	EMP0000162	2015-02
163	-1	4	EMP0000163	2007-02
164	0	5	EMP0000164	2005-01
165	0	2	EMP0000165	2014-01
166	-1	1	EMP0000166	2017-02
167	-1	5	EMP0000167	2005-01
168	1	1	EMP0000168	2018-02
169	-1	2	EMP0000169	2002-01
170	-1	2	EMP0000170	2022-01
171	0	5	EMP0000171	2022-02
172	0	3	EMP0000172	2011-02
173	-1	2	EMP0000173	2004-01
174	1	3	EMP0000174	2021-02
175	0	1	EMP0000175	2005-02
176	-1	2	EMP0000176	2001-02
177	1	5	EMP0000177	2021-02
178	-1	2	EMP0000178	2020-02
179	0	1	EMP0000179	2021-02
180	0	1	EMP0000180	2009-02
181	0	3	EMP0000181	2007-01
182	0	5	EMP0000182	2021-01
183	-1	4	EMP0000183	2012-02
184	0	3	EMP0000184	2017-01
185	1	4	EMP0000185	2019-01
186	0	2	EMP0000186	2005-02
187	1	4	EMP0000187	2002-01
188	0	2	EMP0000188	2012-02
189	-1	2	EMP0000189	2005-02
190	-1	4	EMP0000190	2018-02
191	-1	5	EMP0000191	2006-02
192	-1	3	EMP0000192	2002-02
193	-1	3	EMP0000193	2012-02
194	0	5	EMP0000194	2003-01
195	0	5	EMP0000195	2013-02
196	0	3	EMP0000196	2016-02
197	1	3	EMP0000197	2016-01
198	0	4	EMP0000198	2014-02
199	0	2	EMP0000199	2002-02
200	0	3	EMP0000200	2007-02
201	0	2	EMP0000201	2022-01
202	0	1	EMP0000202	2021-02
203	-1	4	EMP0000203	2021-02
204	0	5	EMP0000204	2024-02
205	1	4	EMP0000205	2011-02
206	-1	4	EMP0000206	2016-01
207	0	3	EMP0000207	2009-02
208	1	3	EMP0000208	2024-01
209	1	3	EMP0000209	2022-02
210	-1	4	EMP0000210	2006-02
211	0	4	EMP0000211	2006-01
212	0	2	EMP0000212	2010-01
213	-1	2	EMP0000213	2007-02
214	-1	5	EMP0000214	2001-01
215	0	1	EMP0000215	2012-01
216	0	1	EMP0000216	2020-02
217	-1	5	EMP0000217	2024-02
218	-1	5	EMP0000218	2017-02
219	0	1	EMP0000219	2012-01
220	0	2	EMP0000220	2020-02
221	0	3	EMP0000221	2013-01
222	1	5	EMP0000222	2019-02
223	-1	5	EMP0000223	2015-02
224	1	4	EMP0000224	2004-02
225	0	3	EMP0000225	2001-02
226	0	1	EMP0000226	2017-02
227	-1	3	EMP0000227	2010-02
228	0	5	EMP0000228	2020-01
229	0	1	EMP0000229	2001-01
230	-1	4	EMP0000230	2013-01
231	0	1	EMP0000231	2015-01
232	1	3	EMP0000232	2003-02
233	-1	3	EMP0000233	2003-01
234	0	2	EMP0000234	2021-01
235	-1	4	EMP0000235	2005-01
236	0	1	EMP0000236	2001-01
237	-1	2	EMP0000237	2000-01
238	1	4	EMP0000238	2023-01
239	0	4	EMP0000239	2009-01
240	1	3	EMP0000240	2023-01
241	0	2	EMP0000241	2022-02
242	-1	2	EMP0000242	2023-01
243	0	5	EMP0000243	2014-01
244	0	1	EMP0000244	2016-02
245	0	2	EMP0000245	2015-02
246	0	3	EMP0000246	2015-02
247	-1	1	EMP0000247	2009-02
248	1	4	EMP0000248	2020-02
249	-1	3	EMP0000249	2001-02
250	0	2	EMP0000250	2007-01
251	-1	1	EMP0000251	2007-02
252	0	4	EMP0000252	2004-01
253	1	5	EMP0000253	2022-01
254	1	1	EMP0000254	2014-01
255	-1	4	EMP0000255	2021-02
256	-1	5	EMP0000256	2013-02
257	-1	5	EMP0000257	2022-01
258	1	4	EMP0000258	2020-01
259	1	3	EMP0000259	2021-01
260	-1	4	EMP0000260	2021-02
261	0	2	EMP0000261	2010-01
262	-1	4	EMP0000262	2014-01
263	-1	4	EMP0000263	2019-02
264	0	5	EMP0000264	2007-02
265	0	1	EMP0000265	2019-01
266	1	4	EMP0000266	2016-02
267	0	1	EMP0000267	2008-02
268	-1	2	EMP0000268	2019-02
269	-1	4	EMP0000269	2021-01
270	1	5	EMP0000270	2016-01
271	0	5	EMP0000271	2022-01
272	0	4	EMP0000272	2015-01
273	0	3	EMP0000273	2019-02
274	1	5	EMP0000274	2021-02
275	1	2	EMP0000275	2015-02
276	0	1	EMP0000276	2011-02
277	0	5	EMP0000277	2000-02
278	1	3	EMP0000278	2023-02
279	0	3	EMP0000279	2021-01
280	1	1	EMP0000280	2019-02
281	0	5	EMP0000281	2019-01
282	1	1	EMP0000282	2013-01
283	0	3	EMP0000283	2010-01
284	1	5	EMP0000284	2020-01
285	1	5	EMP0000285	2018-02
286	0	3	EMP0000286	2019-02
287	-1	3	EMP0000287	2002-02
288	-1	1	EMP0000288	2002-02
289	1	4	EMP0000289	2013-02
290	0	4	EMP0000290	2015-02
291	0	2	EMP0000291	2010-01
292	1	3	EMP0000292	2004-01
293	0	1	EMP0000293	2016-01
294	1	2	EMP0000294	2011-02
295	0	3	EMP0000295	2016-02
296	0	5	EMP0000296	2006-01
297	-1	3	EMP0000297	2010-01
298	-1	5	EMP0000298	2004-01
299	0	5	EMP0000299	2008-01
300	0	2	EMP0000300	2009-01
301	1	2	EMP0000301	2021-02
302	-1	5	EMP0000302	2007-02
303	0	1	EMP0000303	2013-01
304	1	4	EMP0000304	2009-01
305	0	4	EMP0000305	2003-01
306	-1	4	EMP0000306	2019-01
307	0	1	EMP0000307	2006-01
308	0	2	EMP0000308	2016-01
309	-1	2	EMP0000309	2006-01
310	-1	2	EMP0000310	2024-01
311	-1	1	EMP0000311	2022-02
312	-1	2	EMP0000312	2018-01
313	-1	3	EMP0000313	2023-02
314	1	4	EMP0000314	2009-01
315	1	1	EMP0000315	2006-01
316	0	1	EMP0000316	2007-02
317	-1	2	EMP0000317	2009-02
318	-1	5	EMP0000318	2001-01
319	0	1	EMP0000319	2019-01
320	0	3	EMP0000320	2003-02
321	0	1	EMP0000321	2021-01
322	0	4	EMP0000322	2021-01
323	1	1	EMP0000323	2021-01
324	-1	2	EMP0000324	2002-01
325	1	1	EMP0000325	2010-02
326	1	4	EMP0000326	2015-01
327	-1	3	EMP0000327	2009-01
328	0	5	EMP0000328	2009-01
329	0	1	EMP0000329	2010-02
330	-1	1	EMP0000330	2003-02
331	0	4	EMP0000331	2001-01
332	1	5	EMP0000332	2010-02
333	1	5	EMP0000333	2013-02
334	1	1	EMP0000334	2024-01
335	0	2	EMP0000335	2002-01
336	0	2	EMP0000336	2016-01
337	0	5	EMP0000337	2002-01
338	0	1	EMP0000338	2012-01
339	1	2	EMP0000339	2023-01
340	0	4	EMP0000340	2002-01
341	-1	2	EMP0000341	2012-02
342	-1	1	EMP0000342	2009-02
343	-1	4	EMP0000343	2008-02
344	-1	4	EMP0000344	2005-02
345	-1	1	EMP0000345	2018-02
346	1	4	EMP0000346	2010-02
347	-1	5	EMP0000347	2007-02
348	0	1	EMP0000348	2018-01
349	-1	1	EMP0000349	2020-02
350	-1	1	EMP0000350	2017-02
351	0	4	EMP0000351	2021-01
352	-1	5	EMP0000352	2002-01
353	-1	3	EMP0000353	2004-01
354	-1	2	EMP0000354	2024-02
355	1	2	EMP0000355	2024-02
356	0	3	EMP0000356	2017-02
357	0	1	EMP0000357	2006-01
358	0	5	EMP0000358	2005-02
359	0	1	EMP0000359	2012-02
360	1	2	EMP0000360	2010-01
361	-1	5	EMP0000361	2010-02
362	0	5	EMP0000362	2022-01
363	1	4	EMP0000363	2023-02
364	1	5	EMP0000364	2016-02
365	0	5	EMP0000365	2000-02
366	1	3	EMP0000366	2011-02
367	-1	2	EMP0000367	2015-02
368	0	1	EMP0000368	2008-01
369	-1	5	EMP0000369	2013-01
370	-1	4	EMP0000370	2017-01
371	-1	3	EMP0000371	2023-02
372	0	4	EMP0000372	2024-01
373	0	5	EMP0000373	2024-02
374	0	5	EMP0000374	2014-01
375	0	1	EMP0000375	2000-01
376	-1	2	EMP0000376	2006-02
377	-1	2	EMP0000377	2012-01
378	0	4	EMP0000378	2015-01
379	0	3	EMP0000379	2005-02
380	-1	4	EMP0000380	2007-01
381	-1	1	EMP0000381	2020-02
382	0	2	EMP0000382	2019-02
383	1	4	EMP0000383	2024-02
384	1	5	EMP0000384	2006-02
385	0	1	EMP0000385	2017-01
386	0	3	EMP0000386	2016-01
387	-1	1	EMP0000387	2006-02
388	0	2	EMP0000388	2011-01
389	-1	2	EMP0000389	2022-02
390	0	4	EMP0000390	2014-01
391	-1	3	EMP0000391	2010-01
392	1	3	EMP0000392	2022-02
393	-1	5	EMP0000393	2020-02
394	1	5	EMP0000394	2008-01
395	1	3	EMP0000395	2002-02
396	1	2	EMP0000396	2009-01
397	0	2	EMP0000397	2018-02
398	-1	3	EMP0000398	2008-02
399	0	4	EMP0000399	2000-01
400	0	4	EMP0000400	2019-02
401	-1	1	EMP0000401	2010-02
402	-1	2	EMP0000402	2001-02
403	0	5	EMP0000403	2020-01
404	-1	3	EMP0000404	2004-01
405	-1	5	EMP0000405	2005-01
406	-1	2	EMP0000406	2011-01
407	0	2	EMP0000407	2024-01
408	0	4	EMP0000408	2016-01
409	0	1	EMP0000409	2011-02
410	0	1	EMP0000410	2023-02
411	0	3	EMP0000411	2009-02
412	0	2	EMP0000412	2013-01
413	-1	1	EMP0000413	2022-01
414	0	5	EMP0000414	2012-01
415	0	2	EMP0000415	2015-01
416	-1	5	EMP0000416	2016-02
417	0	5	EMP0000417	2020-01
418	1	2	EMP0000418	2019-01
419	0	1	EMP0000419	2023-01
420	0	1	EMP0000420	2009-02
421	1	1	EMP0000421	2000-01
422	0	1	EMP0000422	2016-01
423	-1	5	EMP0000423	2013-02
424	1	1	EMP0000424	2007-02
425	1	5	EMP0000425	2001-02
426	0	2	EMP0000426	2023-02
427	0	2	EMP0000427	2022-02
428	-1	4	EMP0000428	2018-01
429	-1	1	EMP0000429	2016-01
430	-1	3	EMP0000430	2015-02
431	0	5	EMP0000431	2013-02
432	1	2	EMP0000432	2020-01
433	-1	5	EMP0000433	2018-02
434	-1	5	EMP0000434	2019-01
435	0	3	EMP0000435	2001-02
436	0	4	EMP0000436	2024-01
437	-1	4	EMP0000437	2011-01
438	-1	4	EMP0000438	2014-01
439	-1	1	EMP0000439	2009-02
440	1	5	EMP0000440	2002-02
441	-1	2	EMP0000441	2003-01
442	-1	5	EMP0000442	2000-01
443	0	3	EMP0000443	2020-02
444	0	3	EMP0000444	2017-02
445	0	2	EMP0000445	2020-02
446	-1	1	EMP0000446	2011-02
447	-1	1	EMP0000447	2006-01
448	1	3	EMP0000448	2007-02
449	0	5	EMP0000449	2022-01
450	-1	4	EMP0000450	2022-02
451	0	1	EMP0000451	2008-02
452	-1	1	EMP0000452	2022-02
453	1	4	EMP0000453	2011-02
454	1	5	EMP0000454	2016-02
455	-1	4	EMP0000455	2006-01
456	1	4	EMP0000456	2000-01
457	1	4	EMP0000457	2005-01
458	0	5	EMP0000458	2004-01
459	0	1	EMP0000459	2022-02
460	-1	5	EMP0000460	2000-02
461	0	2	EMP0000461	2021-02
462	-1	3	EMP0000462	2001-02
463	-1	1	EMP0000463	2014-02
464	0	5	EMP0000464	2012-02
465	0	1	EMP0000465	2023-02
466	-1	4	EMP0000466	2012-02
467	0	3	EMP0000467	2007-01
468	0	5	EMP0000468	2021-01
469	0	3	EMP0000469	2009-02
470	1	4	EMP0000470	2001-01
471	0	3	EMP0000471	2024-01
472	0	2	EMP0000472	2022-02
473	0	5	EMP0000473	2014-01
474	0	4	EMP0000474	2020-02
475	0	1	EMP0000475	2010-02
476	-1	3	EMP0000476	2016-01
477	0	4	EMP0000477	2016-02
478	0	1	EMP0000478	2015-01
479	-1	2	EMP0000479	2007-02
480	1	1	EMP0000480	2016-02
481	-1	3	EMP0000481	2013-02
482	1	2	EMP0000482	2004-01
483	-1	1	EMP0000483	2019-01
484	0	2	EMP0000484	2014-01
485	0	3	EMP0000485	2006-01
486	0	4	EMP0000486	2010-02
487	0	5	EMP0000487	2005-02
488	-1	5	EMP0000488	2008-02
489	1	4	EMP0000489	2004-01
490	1	3	EMP0000490	2014-02
491	-1	3	EMP0000491	2004-02
492	1	2	EMP0000492	2019-02
493	0	2	EMP0000493	2004-02
494	0	3	EMP0000494	2001-02
495	0	3	EMP0000495	2016-02
496	-1	3	EMP0000496	2009-02
497	1	3	EMP0000497	2018-02
498	0	2	EMP0000498	2024-01
499	1	1	EMP0000499	2017-02
500	-1	2	EMP0000500	2024-02
501	1	1	EMP0000501	2006-02
502	-1	5	EMP0000502	2016-01
503	-1	2	EMP0000503	2022-02
504	1	1	EMP0000504	2007-01
505	0	4	EMP0000505	2001-02
506	-1	4	EMP0000506	2001-01
507	-1	2	EMP0000507	2022-02
508	1	2	EMP0000508	2006-02
509	-1	1	EMP0000509	2013-02
510	0	2	EMP0000510	2021-02
511	0	4	EMP0000511	2010-02
512	-1	3	EMP0000512	2019-02
513	1	3	EMP0000513	2020-02
514	0	4	EMP0000514	2010-01
515	1	5	EMP0000515	2001-02
516	0	3	EMP0000516	2022-01
517	0	1	EMP0000517	2020-01
518	0	5	EMP0000518	2016-02
519	0	2	EMP0000519	2004-01
520	0	4	EMP0000520	2022-02
521	1	3	EMP0000521	2018-02
522	-1	2	EMP0000522	2022-02
523	-1	3	EMP0000523	2009-01
524	1	1	EMP0000524	2011-01
525	1	2	EMP0000525	2014-02
526	-1	5	EMP0000526	2000-02
527	-1	5	EMP0000527	2006-02
528	0	5	EMP0000528	2022-01
529	0	2	EMP0000529	2005-01
530	1	3	EMP0000530	2018-02
531	0	3	EMP0000531	2003-02
532	-1	2	EMP0000532	2020-01
533	1	5	EMP0000533	2011-01
534	-1	4	EMP0000534	2014-01
535	-1	1	EMP0000535	2023-01
536	-1	2	EMP0000536	2002-02
537	0	3	EMP0000537	2021-02
538	-1	2	EMP0000538	2003-01
539	0	3	EMP0000539	2002-02
540	-1	5	EMP0000540	2024-01
541	0	4	EMP0000541	2000-02
542	1	2	EMP0000542	2012-02
543	-1	5	EMP0000543	2019-01
544	-1	5	EMP0000544	2006-01
545	1	3	EMP0000545	2011-01
546	-1	3	EMP0000546	2016-01
547	0	3	EMP0000547	2008-01
548	-1	5	EMP0000548	2020-02
549	1	3	EMP0000549	2002-02
550	1	1	EMP0000550	2021-02
551	-1	4	EMP0000551	2002-02
552	-1	1	EMP0000552	2005-01
553	0	5	EMP0000553	2022-02
554	-1	4	EMP0000554	2002-01
555	-1	4	EMP0000555	2017-02
556	0	4	EMP0000556	2009-02
557	-1	3	EMP0000557	2014-01
558	-1	3	EMP0000558	2004-01
559	-1	2	EMP0000559	2017-01
560	1	1	EMP0000560	2015-02
561	0	5	EMP0000561	2003-01
562	0	4	EMP0000562	2022-02
563	-1	5	EMP0000563	2015-01
564	0	3	EMP0000564	2017-01
565	-1	3	EMP0000565	2022-01
566	-1	5	EMP0000566	2021-02
567	-1	3	EMP0000567	2009-01
568	0	3	EMP0000568	2020-01
569	0	2	EMP0000569	2016-01
570	0	1	EMP0000570	2007-01
571	0	2	EMP0000571	2018-01
572	-1	1	EMP0000572	2019-02
573	1	3	EMP0000573	2019-02
574	1	4	EMP0000574	2006-01
575	-1	3	EMP0000575	2024-02
576	-1	2	EMP0000576	2008-02
577	0	1	EMP0000577	2024-01
578	-1	3	EMP0000578	2012-02
579	0	2	EMP0000579	2006-01
580	-1	5	EMP0000580	2008-02
581	1	5	EMP0000581	2012-01
582	0	4	EMP0000582	2010-01
583	0	1	EMP0000583	2018-02
584	-1	1	EMP0000584	2024-02
585	1	4	EMP0000585	2019-01
586	-1	1	EMP0000586	2020-02
587	-1	2	EMP0000587	2000-01
588	0	2	EMP0000588	2002-01
589	0	3	EMP0000589	2008-01
590	-1	1	EMP0000590	2019-01
591	-1	4	EMP0000591	2022-02
592	0	4	EMP0000592	2009-01
593	1	1	EMP0000593	2002-01
594	1	1	EMP0000594	2000-02
595	-1	1	EMP0000595	2003-02
596	-1	2	EMP0000596	2009-02
597	1	3	EMP0000597	2006-01
598	0	1	EMP0000598	2007-01
599	1	5	EMP0000599	2014-01
600	-1	3	EMP0000600	2019-01
601	0	3	EMP0000601	2024-02
602	-1	3	EMP0000602	2023-02
603	0	5	EMP0000603	2018-02
604	1	1	EMP0000604	2009-01
605	-1	4	EMP0000605	2000-01
606	-1	3	EMP0000606	2021-01
607	0	2	EMP0000607	2024-02
608	1	4	EMP0000608	2002-01
609	0	2	EMP0000609	2010-01
610	0	2	EMP0000610	2014-02
611	-1	4	EMP0000611	2005-01
612	0	2	EMP0000612	2020-02
613	1	5	EMP0000613	2018-01
614	-1	2	EMP0000614	2008-02
615	-1	2	EMP0000615	2017-02
616	0	1	EMP0000616	2017-02
617	-1	2	EMP0000617	2000-01
618	1	5	EMP0000618	2008-01
619	0	4	EMP0000619	2009-01
620	1	3	EMP0000620	2007-02
621	-1	3	EMP0000621	2022-01
622	0	4	EMP0000622	2010-02
623	1	2	EMP0000623	2003-02
624	0	2	EMP0000624	2000-01
625	0	5	EMP0000625	2012-02
626	0	1	EMP0000626	2016-01
627	0	4	EMP0000627	2008-01
628	1	1	EMP0000628	2013-01
629	0	2	EMP0000629	2015-02
630	-1	1	EMP0000630	2022-01
631	1	2	EMP0000631	2014-01
632	0	3	EMP0000632	2014-01
633	0	1	EMP0000633	2011-01
634	0	5	EMP0000634	2009-02
635	0	3	EMP0000635	2012-01
636	-1	4	EMP0000636	2003-01
637	1	1	EMP0000637	2007-02
638	0	3	EMP0000638	2023-02
639	0	2	EMP0000639	2020-01
640	-1	4	EMP0000640	2024-01
641	-1	1	EMP0000641	2001-02
642	0	3	EMP0000642	2004-01
643	0	3	EMP0000643	2005-02
644	-1	3	EMP0000644	2003-02
645	0	3	EMP0000645	2009-01
646	-1	4	EMP0000646	2021-01
647	0	3	EMP0000647	2006-01
648	-1	3	EMP0000648	2005-02
649	1	5	EMP0000649	2024-01
650	0	2	EMP0000650	2017-02
651	0	4	EMP0000651	2008-01
652	-1	5	EMP0000652	2002-02
653	-1	3	EMP0000653	2004-01
654	0	3	EMP0000654	2023-01
655	-1	2	EMP0000655	2007-01
656	1	5	EMP0000656	2013-01
657	0	4	EMP0000657	2004-01
658	0	1	EMP0000658	2024-01
659	0	4	EMP0000659	2017-02
660	-1	3	EMP0000660	2013-02
661	0	3	EMP0000661	2012-02
662	-1	2	EMP0000662	2010-02
663	-1	2	EMP0000663	2021-02
664	-1	3	EMP0000664	2024-01
665	0	2	EMP0000665	2008-01
666	0	2	EMP0000666	2000-02
667	0	3	EMP0000667	2003-02
668	-1	3	EMP0000668	2003-02
669	1	2	EMP0000669	2014-02
670	1	2	EMP0000670	2004-01
671	-1	4	EMP0000671	2017-02
672	-1	2	EMP0000672	2024-02
673	-1	5	EMP0000673	2008-02
674	-1	2	EMP0000674	2003-02
675	0	2	EMP0000675	2020-01
676	1	4	EMP0000676	2007-01
677	-1	1	EMP0000677	2006-01
678	0	5	EMP0000678	2017-01
679	1	4	EMP0000679	2024-02
680	-1	2	EMP0000680	2015-02
681	0	5	EMP0000681	2009-02
682	-1	5	EMP0000682	2012-01
683	0	2	EMP0000683	2003-02
684	-1	4	EMP0000684	2021-02
685	1	4	EMP0000685	2002-02
686	0	5	EMP0000686	2017-02
687	-1	5	EMP0000687	2011-01
688	-1	5	EMP0000688	2008-01
689	-1	5	EMP0000689	2011-01
690	0	3	EMP0000690	2002-01
691	0	1	EMP0000691	2013-01
692	1	1	EMP0000692	2015-01
693	0	2	EMP0000693	2011-02
694	0	5	EMP0000694	2013-01
695	-1	1	EMP0000695	2000-01
696	-1	2	EMP0000696	2002-02
697	-1	3	EMP0000697	2018-01
698	0	4	EMP0000698	2014-02
699	-1	5	EMP0000699	2013-01
700	0	5	EMP0000700	2014-02
701	1	5	EMP0000701	2005-01
702	-1	5	EMP0000702	2017-02
703	-1	3	EMP0000703	2024-02
704	-1	4	EMP0000704	2005-01
705	-1	3	EMP0000705	2001-02
706	-1	2	EMP0000706	2024-02
707	-1	1	EMP0000707	2012-01
708	0	1	EMP0000708	2017-02
709	-1	5	EMP0000709	2011-02
710	-1	3	EMP0000710	2005-02
711	-1	3	EMP0000711	2024-02
712	1	1	EMP0000712	2007-02
713	0	4	EMP0000713	2005-02
714	-1	5	EMP0000714	2013-02
715	1	3	EMP0000715	2006-02
716	-1	3	EMP0000716	2006-01
717	0	1	EMP0000717	2007-02
718	0	2	EMP0000718	2008-02
719	-1	1	EMP0000719	2019-02
720	0	4	EMP0000720	2008-02
721	-1	4	EMP0000721	2001-01
722	-1	2	EMP0000722	2013-01
723	1	3	EMP0000723	2007-01
724	0	2	EMP0000724	2022-02
725	-1	5	EMP0000725	2008-02
726	-1	4	EMP0000726	2017-01
727	0	1	EMP0000727	2001-01
728	-1	2	EMP0000728	2020-01
729	1	1	EMP0000729	2019-01
730	1	2	EMP0000730	2004-02
731	1	3	EMP0000731	2005-02
732	0	3	EMP0000732	2011-02
733	1	2	EMP0000733	2008-01
734	0	3	EMP0000734	2023-02
735	0	1	EMP0000735	2007-02
736	1	4	EMP0000736	2009-01
737	1	1	EMP0000737	2016-01
738	0	4	EMP0000738	2007-02
739	0	1	EMP0000739	2012-02
740	-1	1	EMP0000740	2013-02
741	1	5	EMP0000741	2000-01
742	-1	1	EMP0000742	2022-02
743	0	1	EMP0000743	2009-02
744	0	2	EMP0000744	2010-01
745	1	5	EMP0000745	2002-01
746	0	2	EMP0000746	2011-01
747	-1	1	EMP0000747	2013-02
748	-1	5	EMP0000748	2016-01
749	-1	4	EMP0000749	2009-01
750	0	1	EMP0000750	2003-02
751	-1	1	EMP0000751	2006-02
752	0	1	EMP0000752	2012-01
753	1	4	EMP0000753	2014-01
754	1	5	EMP0000754	2020-02
755	0	3	EMP0000755	2003-02
756	0	1	EMP0000756	2001-02
757	1	3	EMP0000757	2020-01
758	0	2	EMP0000758	2020-02
759	0	3	EMP0000759	2014-01
760	1	5	EMP0000760	2009-02
761	0	1	EMP0000761	2001-01
762	1	1	EMP0000762	2010-01
763	0	3	EMP0000763	2022-01
764	-1	5	EMP0000764	2003-01
765	0	3	EMP0000765	2024-02
766	0	3	EMP0000766	2009-01
767	-1	1	EMP0000767	2023-01
768	0	3	EMP0000768	2012-02
769	0	2	EMP0000769	2017-02
770	0	3	EMP0000770	2017-02
771	-1	2	EMP0000771	2018-01
772	1	4	EMP0000772	2000-01
773	-1	1	EMP0000773	2002-01
774	-1	5	EMP0000774	2005-01
775	0	2	EMP0000775	2017-02
776	-1	1	EMP0000776	2004-01
777	-1	2	EMP0000777	2002-01
778	1	4	EMP0000778	2003-01
779	0	3	EMP0000779	2020-01
780	-1	1	EMP0000780	2021-02
781	-1	2	EMP0000781	2017-02
782	-1	2	EMP0000782	2021-02
783	-1	2	EMP0000783	2020-01
784	0	4	EMP0000784	2003-01
785	-1	3	EMP0000785	2005-01
786	1	5	EMP0000786	2021-02
787	0	5	EMP0000787	2007-01
788	0	5	EMP0000788	2005-02
789	-1	1	EMP0000789	2003-02
790	0	4	EMP0000790	2020-02
791	0	3	EMP0000791	2021-01
792	0	3	EMP0000792	2016-01
793	0	1	EMP0000793	2018-02
794	0	5	EMP0000794	2006-02
795	1	2	EMP0000795	2001-02
796	0	2	EMP0000796	2000-01
797	1	3	EMP0000797	2008-02
798	-1	2	EMP0000798	2020-01
799	1	1	EMP0000799	2007-02
800	0	3	EMP0000800	2010-02
801	-1	5	EMP0000801	2023-01
802	1	4	EMP0000802	2009-02
803	-1	4	EMP0000803	2004-02
804	1	1	EMP0000804	2012-01
805	1	5	EMP0000805	2020-02
806	-1	1	EMP0000806	2024-01
807	0	5	EMP0000807	2011-02
808	-1	4	EMP0000808	2020-02
809	-1	2	EMP0000809	2000-01
810	1	2	EMP0000810	2010-01
811	1	2	EMP0000811	2011-01
812	1	3	EMP0000812	2024-01
813	0	1	EMP0000813	2003-01
814	-1	1	EMP0000814	2016-01
815	0	2	EMP0000815	2010-01
816	-1	4	EMP0000816	2015-01
817	-1	4	EMP0000817	2013-02
818	0	1	EMP0000818	2015-02
819	0	3	EMP0000819	2022-02
820	1	5	EMP0000820	2024-02
821	-1	3	EMP0000821	2012-01
822	0	5	EMP0000822	2011-02
823	-1	4	EMP0000823	2005-02
824	0	5	EMP0000824	2009-01
825	1	2	EMP0000825	2006-01
826	0	4	EMP0000826	2005-01
827	0	5	EMP0000827	2006-01
828	0	3	EMP0000828	2014-02
829	0	4	EMP0000829	2014-01
830	0	5	EMP0000830	2018-01
831	0	2	EMP0000831	2013-02
832	0	1	EMP0000832	2018-02
833	-1	1	EMP0000833	2007-02
834	0	2	EMP0000834	2021-02
835	0	4	EMP0000835	2016-02
836	1	4	EMP0000836	2008-01
837	-1	5	EMP0000837	2022-02
838	0	4	EMP0000838	2021-02
839	0	1	EMP0000839	2023-02
840	0	5	EMP0000840	2018-01
841	1	1	EMP0000841	2006-01
842	-1	3	EMP0000842	2019-02
843	-1	1	EMP0000843	2016-02
844	-1	3	EMP0000844	2023-02
845	-1	4	EMP0000845	2001-02
846	-1	5	EMP0000846	2000-02
847	-1	5	EMP0000847	2017-02
848	-1	5	EMP0000848	2006-01
849	1	4	EMP0000849	2002-01
850	-1	3	EMP0000850	2011-01
851	0	2	EMP0000851	2006-02
852	0	4	EMP0000852	2012-01
853	0	3	EMP0000853	2021-01
854	0	4	EMP0000854	2009-02
855	1	4	EMP0000855	2020-02
856	1	3	EMP0000856	2005-02
857	-1	4	EMP0000857	2017-01
858	0	5	EMP0000858	2017-02
859	-1	1	EMP0000859	2008-01
860	0	5	EMP0000860	2008-01
861	-1	2	EMP0000861	2011-01
862	1	1	EMP0000862	2006-02
863	0	3	EMP0000863	2014-02
864	0	1	EMP0000864	2010-02
865	0	2	EMP0000865	2018-02
866	1	3	EMP0000866	2001-02
867	-1	3	EMP0000867	2024-01
868	0	5	EMP0000868	2006-01
869	1	1	EMP0000869	2002-01
870	0	2	EMP0000870	2009-01
871	0	1	EMP0000871	2009-01
872	1	1	EMP0000872	2001-02
873	0	4	EMP0000873	2008-01
874	0	3	EMP0000874	2001-01
875	0	2	EMP0000875	2019-01
876	0	2	EMP0000876	2011-01
877	-1	4	EMP0000877	2015-02
878	0	5	EMP0000878	2023-02
879	0	3	EMP0000879	2001-01
880	0	1	EMP0000880	2010-02
881	1	3	EMP0000881	2007-01
882	0	5	EMP0000882	2015-02
883	1	1	EMP0000883	2005-02
884	-1	3	EMP0000884	2006-01
885	-1	2	EMP0000885	2010-02
886	-1	5	EMP0000886	2002-01
887	-1	3	EMP0000887	2004-01
888	0	2	EMP0000888	2001-02
889	0	5	EMP0000889	2008-01
890	0	1	EMP0000890	2002-02
891	1	5	EMP0000891	2010-01
892	1	2	EMP0000892	2006-02
893	0	1	EMP0000893	2018-01
894	1	1	EMP0000894	2006-02
895	1	4	EMP0000895	2002-01
896	1	4	EMP0000896	2018-01
897	-1	4	EMP0000897	2000-02
898	1	1	EMP0000898	2016-02
899	-1	3	EMP0000899	2017-02
900	1	4	EMP0000900	2007-01
901	1	5	EMP0000901	2024-02
902	0	3	EMP0000902	2022-02
903	0	1	EMP0000903	2024-02
904	-1	1	EMP0000904	2016-01
905	0	2	EMP0000905	2018-02
906	0	2	EMP0000906	2014-02
907	-1	1	EMP0000907	2017-01
908	1	3	EMP0000908	2012-02
909	-1	3	EMP0000909	2013-01
910	0	5	EMP0000910	2019-01
911	1	4	EMP0000911	2007-01
912	-1	5	EMP0000912	2000-01
913	0	4	EMP0000913	2018-02
914	0	4	EMP0000914	2018-01
915	0	2	EMP0000915	2002-02
916	-1	4	EMP0000916	2015-02
917	0	2	EMP0000917	2016-01
918	0	1	EMP0000918	2023-01
919	0	2	EMP0000919	2006-02
920	1	5	EMP0000920	2022-01
921	0	5	EMP0000921	2014-01
922	0	5	EMP0000922	2002-01
923	0	3	EMP0000923	2010-02
924	-1	1	EMP0000924	2016-02
925	0	5	EMP0000925	2005-01
926	0	1	EMP0000926	2022-02
927	1	3	EMP0000927	2019-02
928	0	2	EMP0000928	2018-01
929	0	5	EMP0000929	2017-02
930	0	3	EMP0000930	2013-01
931	1	5	EMP0000931	2009-01
932	1	4	EMP0000932	2009-01
933	-1	5	EMP0000933	2009-01
934	-1	3	EMP0000934	2016-02
935	0	1	EMP0000935	2001-02
936	-1	1	EMP0000936	2012-01
937	0	3	EMP0000937	2012-01
938	-1	3	EMP0000938	2019-02
939	-1	4	EMP0000939	2020-01
940	0	4	EMP0000940	2003-01
941	1	4	EMP0000941	2003-02
942	1	1	EMP0000942	2019-01
943	1	5	EMP0000943	2015-01
944	0	5	EMP0000944	2002-01
945	0	5	EMP0000945	2004-01
946	0	4	EMP0000946	2008-02
947	0	1	EMP0000947	2006-01
948	0	1	EMP0000948	2018-02
949	0	4	EMP0000949	2024-02
950	-1	2	EMP0000950	2003-01
951	0	1	EMP0000951	2020-02
952	-1	3	EMP0000952	2007-01
953	0	3	EMP0000953	2014-02
954	-1	1	EMP0000954	2020-01
955	-1	1	EMP0000955	2006-01
956	0	2	EMP0000956	2023-02
957	0	5	EMP0000957	2023-02
958	0	3	EMP0000958	2001-02
959	-1	3	EMP0000959	2003-01
960	1	2	EMP0000960	2022-01
961	0	2	EMP0000961	2001-02
962	1	1	EMP0000962	2020-02
963	0	3	EMP0000963	2014-02
964	0	3	EMP0000964	2016-01
965	0	5	EMP0000965	2021-02
966	1	5	EMP0000966	2022-01
967	-1	2	EMP0000967	2004-01
968	0	4	EMP0000968	2023-02
969	1	4	EMP0000969	2007-02
970	-1	1	EMP0000970	2020-02
971	1	3	EMP0000971	2021-02
972	0	3	EMP0000972	2011-02
973	-1	4	EMP0000973	2020-01
974	0	5	EMP0000974	2011-02
975	0	2	EMP0000975	2013-02
976	-1	4	EMP0000976	2009-01
977	1	5	EMP0000977	2000-01
978	-1	5	EMP0000978	2009-02
979	0	3	EMP0000979	2017-02
980	0	5	EMP0000980	2013-01
981	1	2	EMP0000981	2012-01
982	-1	5	EMP0000982	2021-01
983	0	4	EMP0000983	2003-02
984	0	5	EMP0000984	2008-02
985	-1	3	EMP0000985	2017-01
986	0	2	EMP0000986	2020-02
987	-1	1	EMP0000987	2017-01
988	0	4	EMP0000988	2003-02
989	0	3	EMP0000989	2017-02
990	1	4	EMP0000990	2013-02
991	0	2	EMP0000991	2017-01
992	0	3	EMP0000992	2010-01
993	-1	3	EMP0000993	2019-02
994	-1	1	EMP0000994	2001-01
995	-1	5	EMP0000995	2017-02
996	-1	3	EMP0000996	2000-01
997	0	4	EMP0000997	2003-01
998	0	3	EMP0000998	2004-01
999	1	5	EMP0000999	2014-01
1000	0	4	EMP0001000	2005-02
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
EMP0000101	Emma	Smith	1984-08-07	femenino	9	2	15	33
EMP0000102	Olivia	Johnson	1985-12-12	femenino	5	4	9	57
EMP0000103	Ava	Williams	1973-08-02	femenino	2	3	4	35
EMP0000104	Isabella	Brown	1990-01-15	femenino	31	4	6	27
EMP0000105	Sophia	Jones	1973-08-21	femenino	23	4	0	44
EMP0000106	Mia	Garcia	1980-12-21	femenino	14	3	4	50
EMP0000107	Charlotte	Miller	1994-06-22	femenino	29	1	13	41
EMP0000108	Amelia	Davis	1973-07-02	femenino	28	4	0	27
EMP0000109	Harper	Rodriguez	1988-11-17	femenino	26	5	6	49
EMP0000110	Evelyn	Martinez	1997-08-26	femenino	23	2	9	59
EMP0000111	Abigail	Hernandez	1982-02-28	femenino	24	1	3	39
EMP0000112	Ella	Lopez	1987-04-26	femenino	30	4	4	44
EMP0000113	Scarlett	Gonzalez	1996-10-04	femenino	10	2	3	59
EMP0000114	Grace	Wilson	1971-10-19	femenino	21	2	10	33
EMP0000115	Chloe	Anderson	1977-05-30	femenino	28	3	15	41
EMP0000116	Camila	Thomas	1971-04-21	femenino	30	5	6	26
EMP0000117	Aria	Taylor	1975-01-31	femenino	32	2	3	36
EMP0000118	Mila	Moore	1982-06-03	femenino	12	2	6	21
EMP0000119	Layla	Jackson	1979-08-05	femenino	31	2	1	54
EMP0000120	Riley	Martin	1995-05-22	femenino	28	3	1	23
EMP0000121	Zoey	Lee	1977-07-31	femenino	26	5	6	60
EMP0000122	Nora	Perez	1981-01-03	femenino	28	3	6	39
EMP0000123	Lily	Thompson	1997-04-20	femenino	6	1	1	26
EMP0000124	Aaliyah	White	1979-11-25	femenino	19	4	9	27
EMP0000125	Ellie	Harris	1975-09-16	femenino	15	4	14	53
EMP0000126	Luna	Sanchez	1974-04-16	femenino	29	5	13	30
EMP0000127	Hannah	Clark	1985-06-18	femenino	28	2	6	27
EMP0000128	Addison	Ramirez	1979-02-28	femenino	2	5	9	56
EMP0000129	Stella	Lewis	1997-06-14	femenino	23	3	10	47
EMP0000130	Natalie	Robinson	1993-09-11	femenino	13	1	2	31
EMP0000131	Lucy	Walker	1998-11-02	femenino	9	4	3	32
EMP0000132	Audrey	Young	1983-06-07	femenino	7	3	3	41
EMP0000133	Bella	Allen	1986-04-09	femenino	17	4	0	39
EMP0000134	Skylar	King	1989-02-14	femenino	2	5	13	31
EMP0000135	Samantha	Wright	1986-12-28	femenino	27	3	4	53
EMP0000136	Katherine	Scott	1978-11-08	femenino	3	2	4	42
EMP0000137	Maya	Torres	1974-08-16	femenino	31	1	14	46
EMP0000138	Sadie	Nguyen	1975-10-24	femenino	20	3	2	49
EMP0000139	Genesis	Hill	1993-12-23	femenino	14	5	3	29
EMP0000140	Arianna	Flores	1978-05-28	femenino	6	4	3	23
EMP0000141	Caroline	Green	1990-03-31	femenino	6	5	6	37
EMP0000142	Allison	Adams	1991-05-13	femenino	7	2	1	41
EMP0000143	Anna	Nelson	1990-05-20	femenino	21	5	2	56
EMP0000144	Ruby	Baker	1978-08-26	femenino	30	5	10	58
EMP0000145	Emilia	Hall	1972-10-09	femenino	14	2	14	57
EMP0000146	Eliana	Rivera	1989-08-10	femenino	8	3	9	56
EMP0000147	Piper	Campbell	1992-03-27	femenino	2	3	8	44
EMP0000148	Quinn	Mitchell	1977-04-19	femenino	17	4	9	59
EMP0000149	Clara	Carter	1994-11-27	femenino	14	3	5	25
EMP0000150	Lillian	Roberts	1985-07-12	femenino	18	4	12	21
EMP0000151	Sophie	Gomez	1992-07-27	femenino	17	5	5	36
EMP0000152	Mackenzie	Phillips	1984-08-02	femenino	2	1	0	27
EMP0000153	Valentina	Evans	1970-04-27	femenino	29	5	2	40
EMP0000154	Vivian	Turner	1975-01-29	femenino	6	2	9	51
EMP0000155	Aubrey	Diaz	1983-01-04	femenino	5	2	9	42
EMP0000156	Gianna	Parker	1976-09-17	femenino	17	4	15	24
EMP0000157	Kinsley	Cruz	1997-01-24	femenino	8	1	8	30
EMP0000158	Madelyn	Edwards	1986-06-03	femenino	29	3	13	23
EMP0000159	Serenity	Collins	1991-07-16	femenino	18	2	9	29
EMP0000160	Autumn	Reyes	1985-12-21	femenino	14	1	10	57
EMP0000161	Adeline	Stewart	1992-03-02	femenino	12	4	5	32
EMP0000162	Lydia	Morris	1996-08-26	femenino	4	2	6	45
EMP0000163	Jasmine	Ortiz	1995-11-16	femenino	11	1	9	41
EMP0000164	Nina	Cook	1988-12-12	femenino	5	4	4	55
EMP0000165	Cora	Rogers	1976-06-09	femenino	30	1	5	26
EMP0000166	Brooke	Morgan	1998-01-16	femenino	10	3	10	45
EMP0000167	Maria	Cooper	1970-04-18	femenino	14	3	10	32
EMP0000168	Alyssa	Peterson	1997-03-03	femenino	30	2	5	51
EMP0000169	Rebecca	Bailey	1995-08-13	femenino	18	5	13	49
EMP0000170	Angelina	Murphy	1996-02-04	femenino	31	3	14	28
EMP0000171	Mariana	Rivera	1972-12-18	femenino	15	5	11	60
EMP0000172	Taylor	Kim	1988-04-12	femenino	18	5	6	60
EMP0000173	Sadie	Spencer	1993-11-30	femenino	24	4	12	26
EMP0000174	Sabrina	James	1985-07-30	femenino	2	3	15	20
EMP0000175	Megan	Watson	1997-04-30	femenino	34	5	14	38
EMP0000176	Tessa	Brooks	1995-01-13	femenino	33	4	0	51
EMP0000177	Katherine	Kelly	1976-12-06	femenino	29	4	7	60
EMP0000178	Maddison	Sanders	1992-03-22	femenino	7	3	11	27
EMP0000179	Greta	Price	1998-03-21	femenino	23	1	7	57
EMP0000180	Elena	Bennett	1978-03-20	femenino	10	4	4	60
EMP0000181	Kayla	Wood	1973-10-16	femenino	32	4	8	47
EMP0000182	Daisy	Barnes	1975-07-22	femenino	12	4	3	21
EMP0000183	Isla	Ross	1992-09-06	femenino	29	4	7	33
EMP0000184	Lila	Henderson	1990-10-07	femenino	24	3	5	52
EMP0000185	Nadia	Coleman	1991-11-23	femenino	9	3	13	57
EMP0000186	Harley	Jenkins	1989-04-22	femenino	2	1	2	21
EMP0000187	Gemma	Perry	1986-04-26	femenino	2	5	8	54
EMP0000188	Brooke	Powell	1975-06-03	femenino	26	1	10	48
EMP0000189	Ruth	Long	1980-06-19	femenino	2	5	5	27
EMP0000190	Chloe	Patterson	1977-01-02	femenino	13	1	11	43
EMP0000191	Zara	Hughes	1975-09-24	femenino	22	1	14	30
EMP0000192	Ayla	Flores	1984-12-30	femenino	19	4	10	55
EMP0000193	Hope	Washington	1971-02-10	femenino	6	1	11	38
EMP0000194	Molly	Butler	1980-06-30	femenino	20	1	13	23
EMP0000195	Luisa	Simmons	1979-08-02	femenino	3	3	11	30
EMP0000196	Martha	Foster	1992-12-23	femenino	26	3	12	59
EMP0000197	María	Gonzales	1997-04-10	femenino	5	4	6	54
EMP0000198	Kimberly	Bryant	1986-07-07	femenino	14	3	4	54
EMP0000199	Diana	Alexander	1986-10-19	femenino	15	2	15	23
EMP0000200	Angélica	Russell	1990-06-06	femenino	21	2	14	38
EMP0000201	Jocelyn	Griffin	1992-03-24	femenino	27	3	1	24
EMP0000202	Giovanna	Diaz	1987-08-27	femenino	25	4	14	35
EMP0000203	Nevaeh	Hayes	1977-10-07	femenino	33	3	1	54
EMP0000204	Julianna	Harrison	1996-07-04	femenino	19	1	8	20
EMP0000205	Julie	Mason	1993-01-26	femenino	30	1	4	48
EMP0000206	Kelsey	Alexander	1996-05-01	femenino	2	4	6	60
EMP0000207	Genesis	Stone	1972-08-13	femenino	30	3	1	27
EMP0000208	Angeline	Nichols	1971-04-22	femenino	18	4	6	48
EMP0000209	Gia	Graves	1981-10-15	femenino	32	3	14	26
EMP0000210	Angelina	Hawkins	1991-05-14	femenino	16	5	12	20
EMP0000211	Hannah	Wagner	1988-12-30	femenino	32	1	4	27
EMP0000212	Jayla	Holt	1970-03-16	femenino	11	2	7	38
EMP0000213	Maleah	Gordon	1970-03-13	femenino	21	1	0	27
EMP0000214	Essence	Burke	1974-10-25	femenino	30	5	10	52
EMP0000215	Virginia	Caldwell	1978-03-01	femenino	33	3	7	57
EMP0000216	Sophie	Stevens	1986-02-11	femenino	28	1	10	59
EMP0000217	Lauren	Sullivan	1990-08-22	femenino	17	1	7	58
EMP0000218	Cheyanne	Wells	1970-01-25	femenino	6	1	6	51
EMP0000219	Baylee	Cole	1972-04-07	femenino	31	1	11	25
EMP0000220	Justine	Harmon	1975-08-06	femenino	4	5	5	57
EMP0000221	Lucille	Ferguson	1971-03-25	femenino	1	4	10	50
EMP0000222	Sandra	Hodge	1993-02-15	femenino	7	5	3	29
EMP0000223	Joselyn	McDonald	1982-11-10	femenino	6	3	2	21
EMP0000224	Payton	Henderson	1975-11-21	femenino	15	3	4	48
EMP0000225	Anabella	Nichols	1996-12-02	femenino	30	4	7	46
EMP0000226	Carla	Cameron	1979-08-22	femenino	6	1	0	28
EMP0000227	Karley	Ramos	1970-04-16	femenino	19	2	4	27
EMP0000228	Ruth	Palmer	1982-03-11	femenino	3	4	12	54
EMP0000229	Ann	Mendez	1992-05-19	femenino	13	2	11	32
EMP0000230	Bridget	Murray	1991-12-08	femenino	22	2	11	24
EMP0000231	Kiersten	Carlson	1998-08-04	femenino	15	5	0	33
EMP0000232	Yasmin	Hodge	1979-08-09	femenino	14	3	6	54
EMP0000233	Daniella	Chavez	1975-06-30	femenino	34	1	13	55
EMP0000234	Julia	Norton	1992-04-27	femenino	12	5	9	44
EMP0000235	Kenzie	Harrison	1987-11-04	femenino	2	3	14	26
EMP0000236	Karma	Riley	1985-10-24	femenino	28	2	12	34
EMP0000237	Sydnee	Carlson	1981-04-28	femenino	32	4	15	25
EMP0000238	Veronica	Meyer	1992-11-07	femenino	35	4	10	48
EMP0000239	Amani	Duncan	1991-04-03	femenino	23	2	12	38
EMP0000240	Holly	Reed	1996-04-29	femenino	13	2	3	57
EMP0000241	Esmeralda	Floyd	1985-01-23	femenino	21	4	0	45
EMP0000242	Evie	Dixon	1996-02-08	femenino	32	5	14	45
EMP0000243	Allyson	Hodge	1986-03-26	femenino	26	1	14	35
EMP0000244	Cherish	Higgins	1983-09-29	femenino	15	4	14	20
EMP0000245	Miley	Vincent	1978-03-21	femenino	32	2	15	51
EMP0000246	Lizbeth	Stokes	1987-12-30	femenino	27	1	15	54
EMP0000247	Kennedy	Lloyd	1996-08-09	femenino	7	2	1	35
EMP0000248	Gwendolyn	Harmon	1972-10-21	femenino	6	2	11	23
EMP0000249	Jenna	Chavez	1985-09-07	femenino	27	1	15	27
EMP0000250	Moriah	Gordon	1979-12-14	femenino	14	2	15	49
EMP0000251	Giada	Floyd	1990-08-12	femenino	30	3	8	32
EMP0000252	Aliza	McGee	1992-04-20	femenino	2	2	7	57
EMP0000253	Malia	Black	1970-01-05	femenino	5	2	4	20
EMP0000254	Keira	Rios	1997-11-19	femenino	33	4	10	56
EMP0000255	Haylie	Cameron	1986-05-07	femenino	16	4	7	28
EMP0000256	Asia	Morrison	1994-06-26	femenino	28	5	6	39
EMP0000257	Kate	Pena	1973-12-12	femenino	32	3	8	43
EMP0000258	Haley	McCarthy	1995-06-21	femenino	21	5	14	42
EMP0000259	Rachel	Sandoval	1973-08-23	femenino	28	4	8	26
EMP0000260	Kyra	Garrett	1972-03-25	femenino	26	3	0	54
EMP0000261	Kelsie	Bowen	1977-04-25	femenino	2	5	10	23
EMP0000262	Alyvia	Daniel	1971-10-23	femenino	35	1	3	40
EMP0000263	Skye	Carr	1980-11-23	femenino	30	1	8	34
EMP0000264	Valeria	Farrell	1977-11-23	femenino	12	5	10	55
EMP0000265	Alexia	Harrison	1997-09-30	femenino	14	5	6	22
EMP0000266	Kallie	Meyer	1980-05-04	femenino	31	3	8	37
EMP0000267	Sanaa	Rangel	1970-01-22	femenino	11	1	9	20
EMP0000268	Kaylah	Garrison	1970-06-16	femenino	33	4	14	46
EMP0000269	Charlotte	Bates	1977-09-23	femenino	19	3	9	59
EMP0000270	Alia	Schmidt	1992-02-18	femenino	29	5	12	20
EMP0000271	Kamryn	Bradley	1977-05-04	femenino	10	1	12	24
EMP0000272	Lillie	Sampson	1971-02-22	femenino	19	2	2	51
EMP0000273	Amy	Murray	1970-02-11	femenino	28	5	3	48
EMP0000274	Tiffany	Cross	1977-05-07	femenino	20	4	1	33
EMP0000275	Joslyn	Mullen	1979-02-10	femenino	4	2	12	54
EMP0000276	Amara	Hartman	1997-06-14	femenino	19	3	1	50
EMP0000277	Ainsley	Chambers	1981-05-13	femenino	32	5	8	37
EMP0000278	Sonia	Nash	1971-05-30	femenino	26	5	11	32
EMP0000279	Sydney	Whitaker	1988-01-18	femenino	35	3	5	23
EMP0000280	Jaylah	Raymond	1972-11-28	femenino	24	3	6	43
EMP0000281	Kianna	Sampson	1976-05-20	femenino	31	5	13	36
EMP0000282	Kathryn	Underwood	1994-05-26	femenino	34	1	11	56
EMP0000283	Frances	Cannon	1983-08-22	femenino	26	5	4	24
EMP0000284	Areli	Serrano	1973-06-06	femenino	6	4	15	53
EMP0000285	Paige	Hester	1970-07-31	femenino	9	5	2	42
EMP0000286	Cindy	Monroe	1996-12-26	femenino	11	1	7	54
EMP0000287	Frida	Golden	1980-08-27	femenino	11	2	3	53
EMP0000288	Karsyn	Mathews	1980-05-23	femenino	23	4	7	26
EMP0000289	Harmony	Brock	1992-06-15	femenino	30	2	12	32
EMP0000290	Isis	Caldwell	1974-07-14	femenino	27	3	6	36
EMP0000291	Angela	Cameron	1973-12-30	femenino	15	4	4	48
EMP0000292	Sophia	Little	1975-07-27	femenino	30	1	0	57
EMP0000293	Olivia	Kelley	1981-07-18	femenino	8	1	15	58
EMP0000294	Ava	Wilkins	1979-01-01	femenino	2	1	11	56
EMP0000295	Isabella	Hodge	1982-02-18	femenino	3	2	12	32
EMP0000296	Mia	Wong	1972-04-05	femenino	33	5	3	34
EMP0000297	Charlotte	Gentry	1998-08-03	femenino	2	2	3	56
EMP0000298	Amelia	Hahn	1974-12-27	femenino	18	1	3	39
EMP0000299	Harper	Lindsay	1988-10-22	femenino	22	5	9	44
EMP0000300	Evelyn	Wilkins	1992-10-14	femenino	2	2	4	60
EMP0000301	Liam	Smith	1979-10-08	masculino	9	2	5	60
EMP0000302	Noah	Johnson	1981-10-09	masculino	31	5	8	50
EMP0000303	Oliver	Williams	1984-08-20	masculino	18	1	12	47
EMP0000304	Elijah	Brown	1998-06-28	masculino	25	2	14	29
EMP0000305	James	Jones	1986-12-22	masculino	16	3	0	20
EMP0000306	William	Garcia	1992-04-01	masculino	16	3	6	38
EMP0000307	Benjamin	Miller	1992-10-20	masculino	17	5	9	30
EMP0000308	Lucas	Davis	1971-03-02	masculino	3	5	12	54
EMP0000309	Henry	Rodriguez	1979-07-09	masculino	17	1	5	28
EMP0000310	Theodore	Martinez	1978-07-15	masculino	11	3	9	47
EMP0000311	Jackson	Hernandez	1990-12-15	masculino	2	3	9	42
EMP0000312	Levi	Lopez	1986-10-07	masculino	25	4	7	46
EMP0000313	Mateo	Gonzalez	1977-06-11	masculino	29	3	2	38
EMP0000314	Daniel	Wilson	1976-01-31	masculino	31	1	11	39
EMP0000315	Michael	Anderson	1971-05-25	masculino	8	2	2	52
EMP0000316	Alexander	Thomas	1974-04-26	masculino	28	2	7	40
EMP0000317	Sebastian	Taylor	1987-12-23	masculino	34	2	0	29
EMP0000318	Aiden	Moore	1994-11-22	masculino	20	1	13	34
EMP0000319	Owen	Jackson	1978-06-26	masculino	11	2	2	48
EMP0000320	Samuel	Martin	1986-08-25	masculino	29	1	5	53
EMP0000321	David	Lee	1973-11-14	masculino	6	2	3	57
EMP0000322	Joseph	Perez	1987-08-01	masculino	9	2	4	43
EMP0000323	Carter	Thompson	1979-04-11	masculino	9	1	5	29
EMP0000324	Wyatt	White	1972-11-30	masculino	17	1	2	46
EMP0000325	John	Harris	1996-11-29	masculino	34	2	1	41
EMP0000326	Jack	Sanchez	1993-05-02	masculino	15	5	9	44
EMP0000327	Luke	Clark	1977-10-14	masculino	7	2	12	31
EMP0000328	Asher	Ramirez	1970-04-26	masculino	20	4	11	37
EMP0000329	Grayson	Lewis	1986-06-24	masculino	19	3	3	40
EMP0000330	Leo	Robinson	1984-11-08	masculino	22	5	9	53
EMP0000331	Jayden	Walker	1990-08-11	masculino	3	1	15	52
EMP0000332	Gabriel	Young	1988-11-15	masculino	21	5	0	45
EMP0000333	Isaac	Allen	1985-01-08	masculino	27	3	9	41
EMP0000334	Lincoln	King	1993-08-01	masculino	31	1	15	34
EMP0000335	Anthony	Wright	1997-07-14	masculino	19	3	9	35
EMP0000336	Dylan	Scott	1993-09-30	masculino	30	4	2	20
EMP0000337	Zachary	Torres	1991-11-17	masculino	4	2	1	46
EMP0000338	Christian	Nguyen	1984-06-19	masculino	6	1	4	36
EMP0000339	Maverick	Hill	1981-05-12	masculino	4	1	13	31
EMP0000340	Josiah	Flores	1978-06-24	masculino	6	3	11	44
EMP0000341	Eli	Green	1991-04-05	masculino	15	3	12	34
EMP0000342	Adam	Adams	1985-04-24	masculino	8	3	9	33
EMP0000343	Charles	Nelson	1981-06-26	masculino	12	3	9	41
EMP0000344	Colton	Baker	1987-10-20	masculino	31	3	6	56
EMP0000345	Aaron	Hall	1994-01-03	masculino	4	4	11	24
EMP0000346	Elias	Rivera	1980-06-19	masculino	24	3	8	58
EMP0000347	Hunter	Campbell	1988-08-05	masculino	6	4	11	26
EMP0000348	Nathan	Mitchell	1970-07-26	masculino	25	2	15	27
EMP0000349	Thomas	Carter	1970-03-26	masculino	12	2	13	38
EMP0000350	Christopher	Roberts	1997-12-12	masculino	14	5	13	50
EMP0000351	Jaxon	Gomez	1981-05-30	masculino	20	1	6	23
EMP0000352	Dominic	Phillips	1974-08-03	masculino	4	4	9	28
EMP0000353	Luca	Evans	1991-07-11	masculino	9	2	9	29
EMP0000354	Austin	Turner	1997-03-15	masculino	31	5	3	31
EMP0000355	Ryder	Diaz	1972-04-08	masculino	2	5	3	27
EMP0000356	Ezekiel	Parker	1980-10-10	masculino	35	3	1	53
EMP0000357	Kaden	Cruz	1972-08-28	masculino	9	5	4	27
EMP0000358	Jason	Edwards	1992-11-21	masculino	9	1	13	60
EMP0000359	Bentley	Collins	1980-11-18	masculino	2	4	6	30
EMP0000360	Harrison	Reyes	1990-04-11	masculino	2	2	7	53
EMP0000361	Evan	Stewart	1970-06-01	masculino	25	2	11	52
EMP0000362	Quinn	Morris	1985-09-12	masculino	25	2	3	53
EMP0000363	Jameson	Ortiz	1978-08-30	masculino	26	2	12	25
EMP0000364	River	Cook	1998-07-14	masculino	13	1	14	31
EMP0000365	Xavier	Rogers	1987-06-21	masculino	13	5	4	55
EMP0000366	Nolan	Morgan	1996-08-09	masculino	4	4	2	39
EMP0000367	Graham	Cooper	1975-11-27	masculino	25	1	15	34
EMP0000368	Diego	Peterson	1990-06-26	masculino	18	4	13	31
EMP0000369	Santiago	Bailey	1981-08-30	masculino	25	5	8	51
EMP0000370	Jude	Murphy	1981-09-09	masculino	9	1	7	28
EMP0000371	Matteo	Rivera	1977-08-28	masculino	20	2	13	39
EMP0000372	Khalil	Kim	1987-06-01	masculino	24	1	1	30
EMP0000373	Dante	Spencer	1979-02-14	masculino	3	4	9	50
EMP0000374	Finn	James	1986-05-28	masculino	17	4	14	53
EMP0000375	Beckett	Watson	1977-01-14	masculino	14	5	10	26
EMP0000376	Milo	Brooks	1977-12-17	masculino	9	5	12	59
EMP0000377	Emmett	Kelly	1971-02-21	masculino	33	4	12	38
EMP0000378	Reid	Sanders	1998-07-07	masculino	10	5	3	47
EMP0000379	Axel	Price	1998-09-03	masculino	9	1	12	56
EMP0000380	Dawson	Bennett	1978-07-20	masculino	14	3	12	57
EMP0000381	Riley	Wood	1983-12-01	masculino	6	5	0	57
EMP0000382	Kairo	Barnes	1973-05-12	masculino	34	5	9	27
EMP0000383	Gideon	Ross	1983-03-11	masculino	25	3	15	25
EMP0000384	Giovanni	Henderson	1977-05-17	masculino	30	3	4	35
EMP0000385	Lorenzo	Coleman	1995-03-19	masculino	2	2	11	45
EMP0000386	Tobias	Jenkins	1994-02-01	masculino	5	3	7	32
EMP0000387	Maxwell	Perry	1987-04-06	masculino	33	1	15	60
EMP0000388	Wesley	Powell	1997-12-03	masculino	21	3	4	22
EMP0000389	Ronan	Long	1990-07-13	masculino	8	4	7	25
EMP0000390	Malachi	Patterson	1996-03-13	masculino	6	4	14	41
EMP0000391	Soren	Hughes	1970-11-11	masculino	24	3	11	33
EMP0000392	Anderson	Flores	1980-06-02	masculino	12	2	7	23
EMP0000393	Cyrus	Washington	1994-02-12	masculino	3	2	2	51
EMP0000394	Jasper	Butler	1981-05-22	masculino	23	2	14	36
EMP0000395	Orion	Simmons	1977-02-09	masculino	21	3	3	46
EMP0000396	Zane	Foster	1971-01-08	masculino	31	5	3	55
EMP0000397	Darius	Gonzales	1989-08-01	masculino	27	4	12	56
EMP0000398	Elliott	Bryant	1974-10-08	masculino	14	4	15	40
EMP0000399	Sullivan	Alexander	1987-08-01	masculino	8	5	9	38
EMP0000400	Dustin	Russell	1970-12-30	masculino	26	4	6	31
EMP0000401	Jackson	Griffin	1991-09-30	masculino	4	4	4	49
EMP0000402	Tyler	Diaz	1982-12-01	masculino	6	5	5	37
EMP0000403	Henry	Hayes	1975-12-20	masculino	33	3	12	28
EMP0000404	Bradley	Harrison	1971-11-29	masculino	4	1	10	27
EMP0000405	Marcus	Mason	1998-05-19	masculino	7	4	2	56
EMP0000406	Tristan	Alexander	1994-08-12	masculino	31	4	12	29
EMP0000407	Vincent	Stone	1983-07-30	masculino	30	5	7	34
EMP0000408	Landon	Nichols	1974-05-22	masculino	18	5	0	56
EMP0000409	Gage	Graves	1989-01-11	masculino	24	4	10	56
EMP0000410	Bryson	Hawkins	1970-07-05	masculino	9	1	5	29
EMP0000411	Dorian	Wagner	1996-10-18	masculino	21	2	5	33
EMP0000412	Caden	Holt	1984-07-13	masculino	16	4	3	58
EMP0000413	Nicolas	Gordon	1994-02-11	masculino	29	4	7	58
EMP0000414	Silas	Burke	1978-10-19	masculino	19	5	6	29
EMP0000415	Graham	Caldwell	1970-08-04	masculino	18	2	13	56
EMP0000416	Davis	Stevens	1984-10-31	masculino	30	4	10	35
EMP0000417	Rafael	Sullivan	1973-09-09	masculino	11	2	5	44
EMP0000418	Quinton	Wells	1998-03-10	masculino	27	4	4	58
EMP0000419	Malcolm	Cole	1976-10-16	masculino	23	1	0	41
EMP0000420	Ezra	Harmon	1972-08-08	masculino	35	2	9	44
EMP0000421	Kieran	Ferguson	1998-01-23	masculino	30	2	4	21
EMP0000422	Rory	Hodge	1980-01-28	masculino	25	4	6	24
EMP0000423	Avery	McDonald	1973-10-10	masculino	5	3	2	42
EMP0000424	Jax	Henderson	1998-01-13	masculino	31	2	13	20
EMP0000425	Beckham	Nichols	1983-04-01	masculino	27	2	7	22
EMP0000426	Hayden	Cameron	1976-07-16	masculino	28	2	2	20
EMP0000427	Liam	Ramos	1990-03-03	masculino	28	4	4	33
EMP0000428	Emilio	Palmer	1973-07-17	masculino	8	3	9	32
EMP0000429	Zander	Mendez	1993-02-03	masculino	19	1	8	59
EMP0000430	Chance	Murray	1986-12-29	masculino	23	3	7	52
EMP0000431	Elias	Carlson	1986-10-16	masculino	12	3	3	33
EMP0000432	Damon	Hodge	1981-12-24	masculino	26	1	10	24
EMP0000433	Cody	Chavez	1981-10-22	masculino	34	3	10	29
EMP0000434	Desmond	Norton	1976-03-29	masculino	12	3	2	25
EMP0000435	Alonzo	Harrison	1992-07-12	masculino	7	2	10	20
EMP0000436	Gunner	Riley	1990-05-22	masculino	25	4	0	25
EMP0000437	Kellen	Carlson	1976-09-19	masculino	21	5	13	47
EMP0000438	Zachariah	Meyer	1987-08-27	masculino	7	1	11	39
EMP0000439	Beckett	Duncan	1982-03-01	masculino	31	4	15	25
EMP0000440	Cruz	Reed	1975-10-16	masculino	34	4	8	23
EMP0000441	Tanner	Floyd	1997-03-16	masculino	17	1	0	29
EMP0000442	Colt	Dixon	1974-05-15	masculino	33	1	7	37
EMP0000443	Kendrick	Hodge	1991-12-13	masculino	22	1	14	25
EMP0000444	Kendall	Higgins	1972-05-24	masculino	12	1	5	42
EMP0000445	Paxton	Vincent	1982-07-16	masculino	27	3	11	30
EMP0000446	Brayden	Stokes	1984-02-08	masculino	6	4	11	53
EMP0000447	Tatum	Lloyd	1985-11-22	masculino	10	3	5	27
EMP0000448	Jasper	Harmon	1991-09-22	masculino	4	2	0	32
EMP0000449	Sampson	Chavez	1983-02-20	masculino	25	2	4	60
EMP0000450	Calvin	Gordon	1979-08-27	masculino	34	2	1	27
EMP0000451	Lyle	Floyd	1994-07-05	masculino	23	2	7	47
EMP0000452	Devon	McGee	1973-06-19	masculino	25	4	11	46
EMP0000453	Santiago	Black	1989-07-19	masculino	10	2	4	58
EMP0000454	Axl	Rios	1977-08-13	masculino	28	2	9	36
EMP0000455	Ean	Cameron	1995-06-15	masculino	6	4	4	38
EMP0000456	Ronin	Morrison	1991-03-24	masculino	30	2	2	47
EMP0000457	Malik	Pena	1971-05-05	masculino	24	5	5	51
EMP0000458	Koa	McCarthy	1977-06-05	masculino	10	5	11	28
EMP0000459	Bridger	Sandoval	1991-02-04	masculino	8	5	10	46
EMP0000460	Beckham	Garrett	1987-03-25	masculino	7	4	3	53
EMP0000461	Milo	Bowen	1970-05-20	masculino	3	5	12	23
EMP0000462	Trent	Daniel	1971-06-18	masculino	16	4	1	45
EMP0000463	Rocco	Carr	1993-04-19	masculino	29	1	1	55
EMP0000464	Jett	Farrell	1975-09-08	masculino	7	5	10	31
EMP0000465	Reece	Harrison	1983-02-21	masculino	30	2	12	30
EMP0000466	Trey	Meyer	1995-10-03	masculino	32	4	14	22
EMP0000467	Amir	Rangel	1974-03-24	masculino	6	1	0	50
EMP0000468	Maximus	Garrison	1985-02-18	masculino	4	1	2	37
EMP0000469	Asa	Bates	1974-01-08	masculino	16	4	1	36
EMP0000470	Atlas	Schmidt	1988-07-12	masculino	27	4	12	40
EMP0000471	Warren	Bradley	1977-07-12	masculino	19	1	10	38
EMP0000472	Ridge	Sampson	1985-05-19	masculino	2	5	14	52
EMP0000473	Thaddeus	Murray	1996-03-11	masculino	24	3	3	36
EMP0000474	Deacon	Cross	1996-10-11	masculino	5	1	12	28
EMP0000475	Emery	Mullen	1978-10-22	masculino	29	4	14	55
EMP0000476	Kian	Hartman	1970-11-23	masculino	18	2	12	27
EMP0000477	Waylon	Chambers	1975-11-20	masculino	3	4	9	44
EMP0000478	Kendrick	Nash	1998-10-29	masculino	12	4	5	28
EMP0000479	Knox	Whitaker	1996-04-29	masculino	30	4	7	24
EMP0000480	Reagan	Raymond	1985-07-04	masculino	26	2	0	43
EMP0000481	Brooks	Sampson	1985-01-13	masculino	33	3	10	34
EMP0000482	Brendan	Underwood	1997-05-13	masculino	20	4	8	24
EMP0000483	Raiden	Cannon	1982-04-04	masculino	14	1	1	21
EMP0000484	Anderson	Serrano	1996-10-16	masculino	10	1	14	22
EMP0000485	Benson	Hester	1986-12-30	masculino	20	2	9	52
EMP0000486	Jovany	Monroe	1994-09-23	masculino	31	2	3	55
EMP0000487	Brock	Golden	1972-05-18	masculino	27	2	7	23
EMP0000488	Ridge	Mathews	1988-11-24	masculino	20	4	9	59
EMP0000489	Cade	Brock	1970-09-29	masculino	11	2	7	35
EMP0000490	Dallas	Caldwell	1976-06-10	masculino	34	4	9	20
EMP0000491	Rowan	Cameron	1988-03-05	masculino	4	4	5	39
EMP0000492	Kendall	Little	1982-05-02	masculino	10	3	2	52
EMP0000493	Yahir	Kelley	1988-06-25	masculino	24	5	4	22
EMP0000494	Orlando	Wilkins	1980-01-13	masculino	22	5	13	48
EMP0000495	Sullivan	Hodge	1998-12-18	masculino	31	3	12	53
EMP0000496	Alden	Wong	1973-07-14	masculino	21	4	5	27
EMP0000497	Ellis	Gentry	1978-03-17	masculino	30	4	6	48
EMP0000498	Glen	Hahn	1973-01-20	masculino	8	4	14	38
EMP0000499	Lyle	Lindsay	1992-01-03	masculino	9	5	4	41
EMP0000500	Wesley	Wilkins	1978-12-24	masculino	34	1	11	25
EMP0000501	Sofía	González	1974-03-15	femenino	35	3	6	54
EMP0000502	Valentina	Rodríguez	1984-02-23	femenino	19	2	14	31
EMP0000503	Isabella	Pérez	1981-10-05	femenino	13	5	0	29
EMP0000504	Camila	López	1970-08-16	femenino	21	5	13	36
EMP0000505	Mariana	Sánchez	1973-04-25	femenino	20	4	14	20
EMP0000506	Lucía	García	1991-12-04	femenino	12	4	0	47
EMP0000507	Ximena	Martínez	1975-03-18	femenino	5	4	1	31
EMP0000508	Daniela	Hernández	1988-01-01	femenino	10	4	7	25
EMP0000509	Gabriela	Jiménez	1972-03-20	femenino	29	2	12	38
EMP0000510	Victoria	Díaz	1998-06-19	femenino	30	3	11	47
EMP0000511	Renata	Morales	1985-11-23	femenino	14	5	10	31
EMP0000512	María José	Torres	1978-12-28	femenino	22	5	0	40
EMP0000513	Julia	Ramírez	1992-09-20	femenino	33	5	4	39
EMP0000514	Ana	Rojas	1985-01-21	femenino	20	2	12	32
EMP0000515	Luciana	Reyes	1995-11-15	femenino	25	4	2	28
EMP0000516	Aitana	Cruz	1976-06-28	femenino	17	5	5	56
EMP0000517	Nadia	Gutiérrez	1975-04-29	femenino	3	1	10	57
EMP0000518	Salma	Ortega	1972-09-24	femenino	29	1	0	25
EMP0000519	Mía	Mendoza	1994-10-15	femenino	1	2	9	20
EMP0000520	Alba	Ponce	1997-09-10	femenino	30	1	10	53
EMP0000521	Florencia	Castillo	1989-03-18	femenino	25	4	7	55
EMP0000522	Clara	Salazar	1971-06-16	femenino	30	2	5	20
EMP0000523	Paola	Vázquez	1983-05-27	femenino	9	5	0	25
EMP0000524	Jimena	Fernández	1975-08-22	femenino	26	2	7	59
EMP0000525	Elena	Córdova	1988-01-22	femenino	14	1	4	38
EMP0000526	Carla	Paredes	1976-02-13	femenino	31	4	11	29
EMP0000527	Estefanía	Bermúdez	1979-01-06	femenino	28	4	14	51
EMP0000528	Danna	Aguilar	1973-12-15	femenino	28	1	14	57
EMP0000529	Bianca	Navarro	1994-05-15	femenino	33	4	11	47
EMP0000530	Carmen	Cano	1970-11-03	femenino	4	3	15	47
EMP0000531	Marisol	Castro	1998-11-03	femenino	18	2	14	53
EMP0000532	Fátima	Salinas	1979-07-27	femenino	24	3	8	40
EMP0000533	Angélica	Delgado	1990-01-06	femenino	20	4	4	52
EMP0000534	Tamara	Carrillo	1971-02-22	femenino	22	3	15	24
EMP0000535	Margarita	Aguirre	1995-12-09	femenino	19	5	14	50
EMP0000536	Noelia	Serrano	1974-01-12	femenino	8	5	1	47
EMP0000537	Valeria	Cordero	1975-05-19	femenino	4	5	1	31
EMP0000538	Carolina	Lara	1982-04-15	femenino	16	2	9	28
EMP0000539	Aurora	Ríos	1981-12-04	femenino	5	2	15	47
EMP0000540	María Fernanda	Fuentes	1972-10-13	femenino	12	2	10	54
EMP0000541	Estela	Palacios	1976-07-17	femenino	2	1	14	46
EMP0000542	María del Mar	Pizarro	1988-10-13	femenino	24	5	8	20
EMP0000543	Sabrina	Ocampo	1979-04-29	femenino	23	2	11	35
EMP0000544	Verónica	Montoya	1976-03-30	femenino	15	3	1	60
EMP0000545	Luna	Núñez	1982-12-29	femenino	8	4	4	37
EMP0000546	Cecilia	Salvador	1998-11-17	femenino	18	2	8	58
EMP0000547	Santiago	Maldonado	1975-10-10	femenino	13	4	6	54
EMP0000548	Diana	Quintana	1995-12-15	femenino	8	1	6	26
EMP0000549	Inés	Solís	1972-06-15	femenino	1	4	12	39
EMP0000550	Rocío	Cervantes	1991-06-16	femenino	14	3	1	59
EMP0000551	Alicia	Alvarado	1992-07-25	femenino	30	5	11	40
EMP0000552	Julieta	Arce	1986-08-18	femenino	12	4	0	33
EMP0000553	Marta	Soto	1996-07-25	femenino	26	5	9	32
EMP0000554	Teresa	Vega	1985-03-26	femenino	4	4	9	52
EMP0000555	Rosa	Rangel	1979-04-08	femenino	24	3	4	34
EMP0000556	Adriana	López	1971-07-17	femenino	9	3	1	34
EMP0000557	Mireya	Acosta	1996-04-14	femenino	14	4	6	50
EMP0000558	Nadia	Mora	1998-07-12	femenino	13	1	11	23
EMP0000559	Silvia	Bolaños	1995-07-24	femenino	8	5	13	23
EMP0000560	Vanessa	Figueroa	1977-07-12	femenino	1	2	10	20
EMP0000561	Montserrat	Santiago	1986-01-18	femenino	4	1	6	29
EMP0000562	Estrella	Gámez	1974-08-03	femenino	5	4	2	47
EMP0000563	Selene	Sandoval	1978-06-16	femenino	22	1	0	60
EMP0000564	Paloma	Ibarra	1994-10-12	femenino	27	3	3	59
EMP0000565	Lourdes	Santos	1972-09-13	femenino	5	5	7	42
EMP0000566	Marina	Rivas	1973-04-10	femenino	27	1	14	53
EMP0000567	Angélica	Ceballos	1976-04-18	femenino	33	5	6	31
EMP0000568	Claudia	Martín	1996-01-28	femenino	18	3	3	26
EMP0000569	Lia	Hidalgo	1990-07-08	femenino	32	5	15	49
EMP0000570	Karla	Beltrán	1974-03-31	femenino	16	4	13	24
EMP0000571	Patricia	Ayala	1991-11-09	femenino	34	1	9	51
EMP0000572	Mónica	Barraza	1971-08-18	femenino	8	5	4	35
EMP0000573	Lucía	Cantu	1990-09-19	femenino	26	3	13	24
EMP0000574	Evelyn	Zúñiga	1971-09-04	femenino	12	5	3	58
EMP0000575	Estefanía	Téllez	1995-04-26	femenino	15	5	7	47
EMP0000576	Catalina	Franco	1970-11-28	femenino	15	2	0	50
EMP0000577	Tania	Bermúdez	1981-08-24	femenino	32	1	15	45
EMP0000578	Ariana	Salas	1984-01-09	femenino	16	3	11	23
EMP0000579	Gloria	Martinez	1973-03-21	femenino	17	1	13	50
EMP0000580	Elisa	López	1972-07-09	femenino	25	2	4	54
EMP0000581	Gisela	Bravo	1991-02-28	femenino	21	2	15	58
EMP0000582	Cynthia	Pérez	1979-03-16	femenino	19	1	15	39
EMP0000583	Yasmin	Pérez	1984-12-04	femenino	28	3	6	30
EMP0000584	Miranda	Rosales	1976-12-19	femenino	14	4	10	26
EMP0000585	Maya	Cisneros	1971-07-07	femenino	4	1	13	50
EMP0000586	Karla	Jasso	1981-09-06	femenino	2	2	11	52
EMP0000587	Ariadna	Carvajal	1990-02-11	femenino	26	2	12	31
EMP0000588	Mirella	Benítez	1983-07-03	femenino	15	2	8	51
EMP0000589	Lorena	León	1993-04-18	femenino	17	2	7	44
EMP0000590	Sonia	Vargas	1991-11-30	femenino	14	5	2	27
EMP0000591	Belinda	Salguero	1990-08-13	femenino	33	5	1	50
EMP0000592	Maite	Blanco	1977-03-03	femenino	10	1	11	40
EMP0000593	Rebeca	Mena	1979-02-14	femenino	33	3	1	37
EMP0000594	Anahí	Gonzales	1988-08-26	femenino	25	2	0	20
EMP0000595	Amelia	Berrios	1985-10-17	femenino	9	5	15	44
EMP0000596	Cassandra	Aguilera	1978-08-05	femenino	25	1	14	36
EMP0000597	Nora	López	1993-01-01	femenino	30	3	6	39
EMP0000598	Lina	Rivera	1998-12-07	femenino	17	3	2	32
EMP0000599	Carolina	Flores	1970-05-26	femenino	16	3	14	44
EMP0000600	Violeta	Martínez	1990-03-27	femenino	22	5	3	42
EMP0000601	Samantha	Cruz	1997-08-03	femenino	33	4	15	58
EMP0000602	Natalia	Mendoza	1991-08-30	femenino	12	4	7	48
EMP0000603	Valeria	Ríos	1997-09-28	femenino	10	2	3	57
EMP0000604	María Clara	López	1975-09-04	femenino	24	1	3	32
EMP0000605	Luciana	Hernández	1983-04-20	femenino	35	1	3	36
EMP0000606	Juliana	Rojas	1971-04-05	femenino	29	3	15	59
EMP0000607	Bianca	Jiménez	1976-11-15	femenino	26	1	7	36
EMP0000608	Flor	Torres	1983-11-08	femenino	2	4	11	50
EMP0000609	Teresa	Moreno	1993-12-14	femenino	19	4	12	41
EMP0000610	Gloria	Martínez	1970-08-31	femenino	23	1	14	48
EMP0000611	Carmen	Aguilar	1982-01-30	femenino	20	2	0	32
EMP0000612	Marisol	Pérez	1973-11-29	femenino	12	1	3	39
EMP0000613	Lia	Gutiérrez	1992-03-29	femenino	25	4	2	35
EMP0000614	Gina	Ramírez	1991-01-13	femenino	9	1	3	58
EMP0000615	Mia	Sánchez	1973-09-15	femenino	6	4	9	58
EMP0000616	Camila	Vásquez	1970-09-19	femenino	23	5	5	32
EMP0000617	Luz	Ortega	1983-05-05	femenino	29	4	14	29
EMP0000618	Angélica	Alvarez	1973-07-08	femenino	3	1	1	56
EMP0000619	Eliana	Bermúdez	1998-06-29	femenino	4	5	15	46
EMP0000620	Celia	Cano	1994-02-09	femenino	27	3	11	43
EMP0000621	Katherine	Salazar	1987-07-30	femenino	15	1	7	60
EMP0000622	Isabel	Díaz	1994-04-15	femenino	3	1	9	24
EMP0000623	Alicia	Reyes	1995-03-07	femenino	30	4	11	38
EMP0000624	Teresa	Delgado	1971-11-03	femenino	10	4	8	41
EMP0000625	Viviana	Córdova	1977-09-10	femenino	2	5	0	30
EMP0000626	Solange	Aguirre	1980-03-13	femenino	32	5	1	20
EMP0000627	Mercedes	Salinas	1998-04-11	femenino	27	5	0	42
EMP0000628	Maia	Cordero	1989-10-16	femenino	34	4	13	47
EMP0000629	Paz	Fuentes	1994-06-08	femenino	15	3	14	39
EMP0000630	Bianca	Ponce	1995-12-24	femenino	11	4	3	57
EMP0000631	Yolanda	Serrano	1988-07-23	femenino	17	4	7	26
EMP0000632	Raquel	Núñez	1994-12-30	femenino	9	3	9	23
EMP0000633	Claudia	Mora	1988-02-21	femenino	24	4	3	49
EMP0000634	Miriam	Carrillo	1985-11-13	femenino	15	5	2	39
EMP0000635	Nadia	Santiago	1974-02-22	femenino	15	3	0	23
EMP0000636	Noemi	Solano	1984-08-06	femenino	32	2	8	41
EMP0000637	Cinthia	Zamora	1970-06-11	femenino	21	4	7	20
EMP0000638	Rosaura	Ceballos	1992-07-09	femenino	29	4	13	55
EMP0000639	Ariadna	Barraza	1971-03-25	femenino	6	4	11	21
EMP0000640	Selene	Nieves	1993-08-20	femenino	34	2	7	43
EMP0000641	Elisa	Blanco	1979-11-17	femenino	2	5	9	29
EMP0000642	Patricia	Pizarro	1989-03-05	femenino	16	1	5	21
EMP0000643	Verónica	Bravo	1977-09-07	femenino	1	5	3	54
EMP0000644	Aitana	Bolaños	1979-11-27	femenino	5	4	4	59
EMP0000645	Anita	León	1993-09-23	femenino	21	2	1	24
EMP0000646	Fabiola	Vega	1983-08-29	femenino	5	3	4	33
EMP0000647	Rocío	Salas	1983-01-26	femenino	22	1	7	51
EMP0000648	Milagros	Quintana	1991-11-08	femenino	12	5	13	28
EMP0000649	Isidora	Rosales	1977-12-18	femenino	26	5	9	60
EMP0000650	Alondra	Santos	1989-05-05	femenino	16	5	4	50
EMP0000651	Regina	Rivera	1985-05-25	femenino	12	2	10	21
EMP0000652	Silvia	Alvarado	1977-06-02	femenino	16	4	3	24
EMP0000653	Luz Marina	Montalvo	1982-02-14	femenino	24	2	10	50
EMP0000654	Carmen Rosa	Castro	1972-10-29	femenino	7	2	11	42
EMP0000655	Marina	Alcántara	1987-12-18	femenino	9	4	6	44
EMP0000656	Dalia	Vargas	1986-05-21	femenino	6	5	3	56
EMP0000657	María Alejandra	Cruz	1972-05-01	femenino	7	5	3	45
EMP0000658	Verónica	Franco	1971-08-27	femenino	28	3	13	29
EMP0000659	Lourdes	Téllez	1986-08-18	femenino	6	3	7	60
EMP0000660	Amparo	Gómez	1983-01-08	femenino	20	2	12	43
EMP0000661	Cecilia	Moya	1988-01-16	femenino	26	3	7	56
EMP0000662	Carmen Lucía	Sierra	1971-01-24	femenino	12	3	5	35
EMP0000663	Ada	Rivas	1974-04-09	femenino	34	5	4	42
EMP0000664	Frida	Báez	1977-06-11	femenino	14	1	14	22
EMP0000665	Renata	Hidalgo	1978-04-15	femenino	2	5	14	37
EMP0000666	Estela	Mena	1984-03-23	femenino	7	5	7	43
EMP0000667	Yaneli	Orozco	1979-03-26	femenino	11	5	6	49
EMP0000668	Indira	Villarreal	1974-02-27	femenino	12	4	1	30
EMP0000669	Fátima	Benavides	1975-01-06	femenino	20	3	13	50
EMP0000670	Liliana	Acosta	1989-05-23	femenino	20	2	10	40
EMP0000671	Arianna	Cervantes	1975-05-22	femenino	29	2	10	58
EMP0000672	Beatriz	Barrios	1971-10-26	femenino	15	4	15	36
EMP0000673	Paloma	Figueroa	1998-08-31	femenino	19	1	12	43
EMP0000674	Nina	Salvador	1995-02-27	femenino	18	1	12	41
EMP0000675	Mónica	Silva	1981-09-18	femenino	11	1	9	47
EMP0000676	Dulce	Martín	1980-08-28	femenino	28	4	4	43
EMP0000677	Carmen Beatriz	Aguero	1975-01-29	femenino	11	2	4	51
EMP0000678	Inés	Iniguez	1982-03-30	femenino	16	3	11	22
EMP0000679	Gisela	Gonzalez	1973-08-01	femenino	5	5	7	48
EMP0000680	Mirella	Marín	1992-01-18	femenino	24	2	14	51
EMP0000681	Alma	Jaimes	1988-06-29	femenino	17	1	9	22
EMP0000682	Nerida	Valdez	1989-01-19	femenino	33	5	13	29
EMP0000683	Adriana	Salmerón	1978-02-13	femenino	3	1	6	42
EMP0000684	Estefanía	Lara	1993-05-16	femenino	23	3	1	22
EMP0000685	María Teresa	Ortiz	1990-10-10	femenino	14	1	10	56
EMP0000686	Clara Isabel	Calderón	1988-10-31	femenino	28	5	5	42
EMP0000687	Fiona	Pérez	1974-05-16	femenino	10	3	10	25
EMP0000688	Selina	Méndez	1989-06-25	femenino	33	5	9	38
EMP0000689	Ana Sofía	Duarte	1984-02-09	femenino	30	4	13	27
EMP0000690	Zulema	Espinosa	1989-04-04	femenino	14	4	3	58
EMP0000691	Eliana	Vallejo	1995-07-10	femenino	5	5	0	51
EMP0000692	Noelia	Bermúdez	1992-07-02	femenino	6	5	8	58
EMP0000693	Jimena	Téllez	1976-09-04	femenino	15	4	5	58
EMP0000694	Tania	Núñez	1995-07-15	femenino	6	5	5	27
EMP0000695	Sonia	Reyes	1993-03-14	femenino	21	2	3	24
EMP0000696	Mabel	Burgos	1974-05-27	femenino	21	4	3	24
EMP0000697	Gabriela	Peña	1998-09-24	femenino	16	3	3	43
EMP0000698	Mónica	Rangel	1974-09-01	femenino	21	4	6	40
EMP0000699	Ailín	Ledesma	1984-09-12	femenino	31	3	12	43
EMP0000700	María del Pilar	Vera	1987-10-11	femenino	31	1	4	36
EMP0000701	Liam	Smith	1983-08-24	masculino	34	5	13	58
EMP0000702	Mateo	García	1987-09-09	masculino	27	4	9	22
EMP0000703	Noah	Johnson	1996-03-01	masculino	21	1	12	24
EMP0000704	Santiago	Martínez	1973-08-05	masculino	30	5	0	26
EMP0000705	Ethan	Williams	1983-10-07	masculino	15	1	6	30
EMP0000706	Diego	Hernández	1977-08-28	masculino	29	4	6	36
EMP0000707	Lucas	Brown	1980-09-21	masculino	26	3	12	49
EMP0000708	Javier	López	1973-05-22	masculino	15	2	2	51
EMP0000709	Logan	Jones	1983-11-01	masculino	18	5	11	30
EMP0000710	Carlos	González	1996-03-23	masculino	17	3	4	47
EMP0000711	Jackson	Miller	1997-02-25	masculino	16	2	7	33
EMP0000712	Sebastián	Pérez	1987-04-14	masculino	28	5	12	27
EMP0000713	Aiden	Davis	1977-10-25	masculino	11	1	10	41
EMP0000714	Nicolás	Sánchez	1997-05-31	masculino	17	5	1	24
EMP0000715	Dylan	Rodriguez	1981-12-09	masculino	18	1	15	50
EMP0000716	Emilio	Garcia	1993-07-10	masculino	11	2	3	45
EMP0000717	Caden	Ramírez	1970-08-10	masculino	5	1	0	32
EMP0000718	Andrés	Martinez	1976-03-03	masculino	18	4	6	58
EMP0000719	Henry	Taylor	1979-11-01	masculino	28	5	12	55
EMP0000720	Jorge	Flores	1982-06-13	masculino	35	2	13	46
EMP0000721	Isaac	Anderson	1984-02-09	masculino	31	5	0	40
EMP0000722	Daniel	Hernández	1974-11-27	masculino	21	1	12	27
EMP0000723	Gabriel	Wilson	1973-07-12	masculino	11	5	11	30
EMP0000724	Rafael	Vásquez	1979-07-14	masculino	27	3	11	44
EMP0000725	Anthony	Thomas	1975-01-12	masculino	34	4	9	26
EMP0000726	Julio	Morales	1998-04-23	masculino	26	2	4	60
EMP0000727	Samuel	Jackson	1970-08-16	masculino	31	3	8	44
EMP0000728	Cristian	Cruz	1992-06-14	masculino	21	3	5	41
EMP0000729	David	White	1989-06-01	masculino	12	3	10	22
EMP0000730	Adrián	Rivas	1988-09-02	masculino	6	5	7	59
EMP0000731	Julian	Harris	1975-12-27	masculino	12	3	2	55
EMP0000732	Miguel	Ortega	1970-08-12	masculino	24	3	8	58
EMP0000733	Xavier	Martinez	1992-12-14	masculino	2	4	7	28
EMP0000734	Julián	Murphy	1997-04-11	masculino	3	4	11	52
EMP0000735	Oliver	Serrano	1992-08-13	masculino	16	4	15	24
EMP0000736	Ángel	Clark	1994-04-24	masculino	20	3	12	59
EMP0000737	Elijah	Ramirez	1982-02-19	masculino	27	1	6	51
EMP0000738	Luis	Lewis	1980-03-04	masculino	29	3	3	37
EMP0000739	Christopher	Hidalgo	1990-03-15	masculino	21	3	2	58
EMP0000740	Fernando	Hall	1994-09-01	masculino	1	2	10	30
EMP0000741	Zachary	Reyes	1994-06-10	masculino	5	2	3	26
EMP0000742	Matías	Scott	1977-09-12	masculino	22	1	8	35
EMP0000743	Kevin	Díaz	1971-04-25	masculino	7	5	7	34
EMP0000744	Alberto	Young	1993-04-28	masculino	4	5	3	46
EMP0000745	Joshua	Cortez	1993-08-25	masculino	33	4	2	58
EMP0000746	Pablo	Allen	1978-08-21	masculino	18	5	7	24
EMP0000747	Oscar	Palacios	1984-10-19	masculino	19	2	4	48
EMP0000748	Brian	Wright	1992-03-05	masculino	25	1	0	24
EMP0000749	José	Salazar	1972-05-27	masculino	9	2	3	48
EMP0000750	Ricky	Hernandez	1987-05-23	masculino	30	1	10	29
EMP0000751	Alexander	Mitchell	1984-11-22	masculino	22	3	2	23
EMP0000752	Francisco	Castillo	1995-07-10	masculino	30	3	7	48
EMP0000753	Josué	Ramírez	1994-03-09	masculino	9	1	3	36
EMP0000754	Victor	Soto	1982-09-19	masculino	14	3	6	34
EMP0000755	Isaiah	Houghton	1989-04-16	masculino	18	5	11	28
EMP0000756	Mauro	Torres	1972-12-21	masculino	21	1	7	47
EMP0000757	César	Reyes	1976-12-01	masculino	18	3	0	52
EMP0000758	Alan	Bennett	1996-05-14	masculino	17	1	13	29
EMP0000759	Jeremiah	Ayala	1985-12-22	masculino	27	3	9	36
EMP0000760	Bruno	Flores	1994-12-21	masculino	17	5	5	39
EMP0000761	Mateus	Murillo	1994-05-17	masculino	23	1	6	45
EMP0000762	Tobias	Mendez	1976-04-13	masculino	3	5	6	54
EMP0000763	Rafael	Walsh	1997-12-28	masculino	30	3	9	44
EMP0000764	Adolfo	Santiago	1993-09-06	masculino	28	3	0	33
EMP0000765	Bennett	McCarthy	1986-06-08	masculino	31	3	7	31
EMP0000766	Hugo	Guevara	1984-08-12	masculino	6	5	6	32
EMP0000767	Dario	King	1972-10-10	masculino	5	1	6	20
EMP0000768	Emiliano	Pacheco	1994-12-01	masculino	10	3	5	32
EMP0000769	Max	Burke	1998-10-25	masculino	3	4	4	35
EMP0000770	Félix	Aguirre	1998-05-04	masculino	6	4	9	49
EMP0000771	Santino	Sampson	1998-09-11	masculino	5	3	13	60
EMP0000772	Alfredo	Rojas	1998-03-20	masculino	34	2	3	20
EMP0000773	Nico	Meyer	1972-01-05	masculino	5	2	5	46
EMP0000774	Ramon	Palma	1984-04-11	masculino	21	5	8	48
EMP0000775	Cody	Aguilar	1992-10-29	masculino	17	5	1	43
EMP0000776	Raúl	Rivera	1995-03-23	masculino	23	1	7	27
EMP0000777	Stefan	Hayes	1990-11-05	masculino	33	5	6	36
EMP0000778	Joaquín	Salinas	1988-10-07	masculino	19	3	7	46
EMP0000779	Vince	Mata	1980-05-28	masculino	16	4	15	54
EMP0000780	Fernando	Prado	1975-06-26	masculino	23	1	4	45
EMP0000781	Marcos	Higgins	1989-02-10	masculino	22	2	14	43
EMP0000782	Elias	Gonzales	1978-10-21	masculino	21	2	9	39
EMP0000783	Dante	Barrett	1998-07-25	masculino	26	5	3	25
EMP0000784	Rodolfo	Romero	1991-11-06	masculino	27	3	8	49
EMP0000785	Salvador	Hodge	1981-04-07	masculino	23	3	9	60
EMP0000786	Sergio	Peters	1974-11-12	masculino	20	5	13	35
EMP0000787	Wesley	Contreras	1996-10-29	masculino	17	3	7	47
EMP0000788	Ernesto	Sampson	1975-08-12	masculino	20	3	6	41
EMP0000789	Aron	Cano	1977-09-14	masculino	14	2	8	49
EMP0000790	Piero	Vega	1979-12-18	masculino	30	2	11	42
EMP0000791	Felipe	Martinez	1992-06-28	masculino	15	5	1	46
EMP0000792	Brandon	Valdez	1998-11-10	masculino	29	1	5	22
EMP0000793	Edgar	Murray	1991-12-22	masculino	14	2	7	33
EMP0000794	Floyd	Hernandez	1984-09-03	masculino	11	1	13	58
EMP0000795	Luis Miguel	Trujillo	1996-03-01	masculino	4	3	14	52
EMP0000796	Emmett	Wong	1996-02-10	masculino	23	4	2	56
EMP0000797	Alfred	Castro	1989-03-14	masculino	31	3	14	29
EMP0000798	Otto	Jenkins	1981-12-16	masculino	35	5	2	40
EMP0000799	Fito	Serrano	1979-09-20	masculino	27	1	7	52
EMP0000800	Fabián	Hernandez	1991-01-18	masculino	25	2	7	56
EMP0000801	Jayden	Gonzalez	1984-07-25	masculino	25	5	10	51
EMP0000802	Mateo	White	1987-03-10	masculino	32	3	5	51
EMP0000803	Chase	Barajas	1971-02-01	masculino	13	4	0	51
EMP0000804	Leonardo	Holt	1984-05-01	masculino	6	4	1	21
EMP0000805	Colton	Orozco	1987-10-13	masculino	11	1	13	52
EMP0000806	Esteban	Foster	1995-02-20	masculino	13	4	15	27
EMP0000807	Asher	Cervantes	1994-07-22	masculino	32	1	10	44
EMP0000808	Roberto	Hodge	1986-04-29	masculino	32	4	11	44
EMP0000809	Malik	Nunez	1973-11-14	masculino	12	1	15	27
EMP0000810	Bruno	Reyes	1997-01-03	masculino	31	4	5	31
EMP0000811	Gavin	Mendez	1988-07-28	masculino	13	4	1	32
EMP0000812	Hector	Sandoval	1978-01-04	masculino	29	1	15	42
EMP0000813	Tyler	Vasquez	1987-10-24	masculino	7	3	1	26
EMP0000814	Adrian	Valenzuela	1980-02-01	masculino	27	1	13	47
EMP0000815	Quentin	Kelley	1984-07-07	masculino	26	5	12	23
EMP0000816	Anderson	Gonzalez	1992-02-24	masculino	4	4	12	57
EMP0000817	Angel	Mejia	1975-06-15	masculino	27	1	2	51
EMP0000818	Braulio	Calderon	1990-11-28	masculino	34	2	5	25
EMP0000819	Xander	Heath	1989-05-22	masculino	9	4	12	34
EMP0000820	Mariano	Ramos	1971-01-05	masculino	1	5	7	51
EMP0000821	Kai	Stevens	1998-07-11	masculino	6	4	7	28
EMP0000822	Leonel	Aguilar	1996-11-15	masculino	34	1	5	53
EMP0000823	Damon	Chavez	1986-01-26	masculino	3	3	1	58
EMP0000824	Saúl	Gentry	1985-02-16	masculino	15	3	1	37
EMP0000825	Victoriano	Beltran	1997-05-01	masculino	31	4	11	41
EMP0000826	Aarón	Buchanan	1973-06-12	masculino	18	4	7	32
EMP0000827	Harley	Esquivel	1997-04-05	masculino	17	2	12	30
EMP0000828	Roberto	Duran	1970-12-16	masculino	29	4	10	34
EMP0000829	Esteban	Sharpe	1983-05-27	masculino	29	2	6	23
EMP0000830	Nery	Acevedo	1970-09-05	masculino	15	3	7	57
EMP0000831	Brayden	Burton	1991-11-12	masculino	15	2	4	48
EMP0000832	Isaías	Nolasco	1997-02-22	masculino	17	2	3	24
EMP0000833	Mickey	Harris	1988-10-17	masculino	23	5	14	40
EMP0000834	Ismael	Hernandez	1975-10-18	masculino	21	5	6	20
EMP0000835	Rocco	Fuentes	1979-07-14	masculino	9	4	14	38
EMP0000836	Felipe	Graham	1972-07-18	masculino	7	5	2	59
EMP0000837	Ronin	Maldonado	1978-01-29	masculino	12	3	15	48
EMP0000838	Salomon	Curtis	1989-03-16	masculino	3	2	10	48
EMP0000839	Diego	Palacios	1979-09-12	masculino	13	5	6	47
EMP0000840	Chuy	Chavez	1973-02-10	masculino	9	5	9	25
EMP0000841	Mason	Ocampo	1994-08-28	masculino	34	1	5	24
EMP0000842	Alonzo	Cruz	1982-07-28	masculino	31	3	8	57
EMP0000843	Jovanny	Bautista	1987-11-13	masculino	12	2	8	22
EMP0000844	Zion	Pacheco	1977-04-04	masculino	11	1	1	42
EMP0000845	Rami	Soto	1971-01-30	masculino	29	4	15	21
EMP0000846	Darius	Arreola	1992-05-10	masculino	31	4	2	46
EMP0000847	Gonzalo	Franklin	1974-09-09	masculino	6	3	10	45
EMP0000848	Ramon	Moreno	1998-05-25	masculino	29	3	13	57
EMP0000849	Renzo	Delgado	1970-08-12	masculino	29	3	6	41
EMP0000850	Alfie	Valencia	1971-02-27	masculino	11	5	4	37
EMP0000851	Tomas	Ramos	1985-11-12	masculino	27	4	11	54
EMP0000852	Iker	Becerra	1989-08-17	masculino	31	3	8	57
EMP0000853	Vincenzo	Rowland	1981-07-25	masculino	9	1	0	37
EMP0000854	Ezequiel	Cantu	1970-01-23	masculino	10	1	9	45
EMP0000855	Dilan	Lara	1975-12-24	masculino	17	1	6	30
EMP0000856	Tadeo	Hernandez	1996-02-22	masculino	33	4	7	49
EMP0000857	Rico	Hodge	1997-04-23	masculino	8	4	11	59
EMP0000858	Raúl	Davis	1990-09-27	masculino	6	5	2	52
EMP0000859	Alaric	Gonzales	1992-06-26	masculino	16	1	10	29
EMP0000860	Nicolás	Alonso	1988-03-22	masculino	23	1	9	45
EMP0000861	Axl	Rosales	1972-09-11	masculino	18	4	15	59
EMP0000862	Gio	Acosta	1994-08-07	masculino	16	5	2	59
EMP0000863	Damian	Carrillo	1985-03-29	masculino	9	1	4	40
EMP0000864	Felipe	Hodge	1976-08-17	masculino	10	3	11	58
EMP0000865	Rafael	Murray	1992-11-01	masculino	28	5	12	47
EMP0000866	Wilmer	Barrera	1986-08-02	masculino	29	2	11	29
EMP0000867	Emery	Knox	1977-04-30	masculino	27	2	10	38
EMP0000868	Rudy	Santiago	1973-11-06	masculino	6	2	3	39
EMP0000869	Harrison	Martinez	1982-03-28	masculino	24	2	3	36
EMP0000870	Uriah	Mata	1989-02-04	masculino	19	1	5	22
EMP0000871	Milan	Kirk	1992-01-22	masculino	1	3	13	48
EMP0000872	Jonah	Delacruz	1996-02-05	masculino	4	5	5	57
EMP0000873	Sebastian	Morris	1977-01-31	masculino	9	5	15	49
EMP0000874	Aníbal	Salinas	1979-11-17	masculino	17	3	15	54
EMP0000875	Axel	Patel	1977-09-28	masculino	15	5	0	29
EMP0000876	Joaquín	Almeida	1985-04-17	masculino	31	5	10	41
EMP0000877	Enrique	Dixon	1995-05-19	masculino	30	4	9	37
EMP0000878	Lennox	Zamora	1976-01-24	masculino	25	5	14	51
EMP0000879	Alberto	Burns	1988-10-09	masculino	25	4	2	52
EMP0000880	Samuel	Alvarado	1977-11-09	masculino	30	4	7	20
EMP0000881	Archer	Klein	1991-10-29	masculino	15	5	8	33
EMP0000882	Kieran	Gil	1979-09-21	masculino	23	3	10	22
EMP0000883	Camilo	Lopez	1987-09-26	masculino	5	2	1	55
EMP0000884	Brantley	Santos	1987-12-16	masculino	12	2	12	37
EMP0000885	Santiago	Hernandez	1980-05-12	masculino	12	5	1	33
EMP0000886	Yahir	Rodriguez	1990-10-11	masculino	19	4	7	27
EMP0000887	Rafael	Trevino	1988-08-19	masculino	22	1	2	50
EMP0000888	Cameron	Sanders	1993-04-25	masculino	27	3	8	41
EMP0000889	Gael	Salazar	1972-11-29	masculino	34	4	6	39
EMP0000890	Lorenzo	Pérez	1981-01-23	masculino	17	5	10	41
EMP0000891	Wyatt	Baker	1990-08-16	masculino	16	3	6	43
EMP0000892	Joaquín	Alvarez	1982-04-23	masculino	19	2	13	31
EMP0000893	Nolan	Hayes	1981-04-24	masculino	34	2	1	33
EMP0000894	Luis	Hernandez	1973-12-22	masculino	18	2	4	55
EMP0000895	Jasper	Cruz	1976-04-11	masculino	29	4	6	37
EMP0000896	Rafael	Flores	1995-05-04	masculino	32	4	3	59
EMP0000897	Milo	Garza	1979-10-30	masculino	11	3	3	53
EMP0000898	Ezequiel	Chavez	1993-06-03	masculino	25	4	15	32
EMP0000899	Parker	Valenzuela	1985-10-28	masculino	9	3	6	45
EMP0000900	Roderick	Orozco	1989-07-14	masculino	2	4	1	54
EMP0000901	Sofia	Smith	1981-10-18	no mencionar	8	4	11	21
EMP0000902	Liam	García	1981-06-03	no mencionar	18	2	4	33
EMP0000903	Emma	Johnson	1976-07-25	no mencionar	34	4	2	44
EMP0000904	Noah	Martínez	1989-09-16	no mencionar	10	5	8	26
EMP0000905	Olivia	Williams	1981-09-11	no mencionar	17	1	7	33
EMP0000906	Elijah	Hernández	1993-06-22	no mencionar	10	1	13	33
EMP0000907	Ava	Brown	1995-07-06	no mencionar	25	4	8	35
EMP0000908	James	López	1993-12-13	no mencionar	34	3	11	38
EMP0000909	Isabella	Jones	1984-02-10	no mencionar	29	1	13	21
EMP0000910	Logan	González	1973-09-19	no mencionar	30	2	15	49
EMP0000911	Mia	Miller	1981-09-29	no mencionar	23	5	13	55
EMP0000912	Lucas	Pérez	1989-12-09	no mencionar	24	5	8	48
EMP0000913	Charlotte	Davis	1984-12-02	no mencionar	32	1	11	46
EMP0000914	Jackson	Sánchez	1992-03-08	no mencionar	7	3	7	54
EMP0000915	Amelia	Rodriguez	1979-02-01	no mencionar	11	5	15	27
EMP0000916	Aiden	Garcia	1981-08-12	no mencionar	31	1	12	24
EMP0000917	Harper	Ramírez	1974-05-14	no mencionar	5	4	13	34
EMP0000918	Ethan	Martinez	1974-09-14	no mencionar	13	1	0	36
EMP0000919	Ella	Taylor	1992-01-19	no mencionar	6	5	15	29
EMP0000920	Carter	Flores	1985-10-14	no mencionar	5	3	9	52
EMP0000921	Avery	Anderson	1984-12-30	no mencionar	25	4	1	50
EMP0000922	Matthew	Hernández	1980-03-11	no mencionar	25	5	8	26
EMP0000923	Scarlett	Wilson	1992-05-15	no mencionar	8	4	6	36
EMP0000924	David	Vásquez	1988-03-05	no mencionar	17	2	12	50
EMP0000925	Grace	Thomas	1975-12-20	no mencionar	34	3	10	54
EMP0000926	Samuel	Morales	1989-11-01	no mencionar	27	1	9	29
EMP0000927	Chloe	Jackson	1974-06-10	no mencionar	25	4	6	38
EMP0000928	Gabriel	Cruz	1989-10-05	no mencionar	21	2	12	58
EMP0000929	Lily	White	1993-03-25	no mencionar	1	1	0	41
EMP0000930	Henry	Rivas	1978-07-16	no mencionar	14	2	6	20
EMP0000931	Aria	Harris	1984-04-25	no mencionar	8	4	4	58
EMP0000932	Dylan	Ortega	1977-09-20	no mencionar	15	1	12	48
EMP0000933	Zoe	Martinez	1975-08-08	no mencionar	15	2	0	50
EMP0000934	Isaac	Murphy	1974-06-07	no mencionar	27	3	10	34
EMP0000935	Nora	Serrano	1997-09-15	no mencionar	9	3	11	56
EMP0000936	Owen	Clark	1975-02-18	no mencionar	29	5	8	45
EMP0000937	Layla	Ramirez	1975-08-31	no mencionar	27	1	2	33
EMP0000938	Sebastian	Lewis	1979-02-01	no mencionar	29	4	8	33
EMP0000939	Riley	Hidalgo	1987-04-14	no mencionar	3	2	1	36
EMP0000940	Julian	Hall	1973-05-21	no mencionar	2	4	5	45
EMP0000941	Samantha	Reyes	1975-01-27	no mencionar	17	5	6	37
EMP0000942	Hunter	Scott	1991-06-08	no mencionar	11	5	10	60
EMP0000943	Nina	Díaz	1987-01-04	no mencionar	17	5	8	46
EMP0000944	Joshua	Young	1996-01-28	no mencionar	25	1	6	59
EMP0000945	Eva	Cortez	1990-01-20	no mencionar	32	4	9	44
EMP0000946	Adam	Allen	1981-12-25	no mencionar	30	5	14	22
EMP0000947	Camila	Palacios	1979-11-15	no mencionar	8	4	14	58
EMP0000948	Anthony	Wright	1970-12-26	no mencionar	2	5	5	59
EMP0000949	Maya	Salazar	1991-10-15	no mencionar	1	2	15	43
EMP0000950	Miles	Hernandez	1977-01-30	no mencionar	11	3	3	52
EMP0000951	Penelope	Mitchell	1982-12-11	no mencionar	32	3	9	42
EMP0000952	Daniel	Castillo	1985-10-01	no mencionar	5	2	14	42
EMP0000953	Lucy	Ramírez	1984-12-16	no mencionar	3	4	11	56
EMP0000954	Joseph	Soto	1991-03-07	no mencionar	15	3	13	25
EMP0000955	Victoria	Houghton	1981-12-05	no mencionar	22	5	13	58
EMP0000956	Charles	Torres	1994-04-20	no mencionar	11	4	9	31
EMP0000957	Madison	Reyes	1970-05-21	no mencionar	33	4	13	30
EMP0000958	Isaiah	Bennett	1997-11-04	no mencionar	21	5	5	28
EMP0000959	Addison	Ayala	1973-03-06	no mencionar	28	5	11	42
EMP0000960	Jonathan	Flores	1972-11-04	no mencionar	13	5	4	27
EMP0000961	Natalie	Murillo	1996-12-17	no mencionar	12	1	13	24
EMP0000962	Levi	Mendez	1995-11-28	no mencionar	28	3	2	54
EMP0000963	Sierra	Walsh	1972-01-19	no mencionar	31	5	3	33
EMP0000964	Maverick	Santiago	1997-09-23	no mencionar	17	2	8	57
EMP0000965	Jasmine	McCarthy	1981-05-21	no mencionar	2	5	11	36
EMP0000966	Wyatt	Guevara	1970-09-22	no mencionar	9	1	12	45
EMP0000967	Skylar	King	1977-02-16	no mencionar	19	4	5	49
EMP0000968	Asher	Pacheco	1988-10-15	no mencionar	19	5	4	40
EMP0000969	Autumn	Burke	1996-06-20	no mencionar	30	1	15	21
EMP0000970	Thomas	Aguirre	1973-01-30	no mencionar	33	1	7	36
EMP0000971	Savannah	Sampson	1984-05-30	no mencionar	20	1	8	31
EMP0000972	Eli	Rojas	1992-04-25	no mencionar	26	4	2	49
EMP0000973	Piper	Meyer	1976-03-04	no mencionar	9	3	14	44
EMP0000974	Landon	Palma	1982-08-24	no mencionar	10	1	10	29
EMP0000975	Kinsley	Aguilar	1987-06-22	no mencionar	15	2	3	34
EMP0000976	Colton	Rivera	1998-07-29	no mencionar	21	2	12	55
EMP0000977	Alicia	Hayes	1973-06-17	no mencionar	31	2	1	44
EMP0000978	Evan	Salinas	1973-08-07	no mencionar	10	3	1	34
EMP0000979	Paige	Mata	1973-01-22	no mencionar	10	2	3	23
EMP0000980	Micah	Prado	1975-04-12	no mencionar	13	5	2	30
EMP0000981	Emilia	Higgins	1998-10-27	no mencionar	18	3	9	60
EMP0000982	Zachary	Gonzales	1997-03-18	no mencionar	34	4	1	20
EMP0000983	Lyla	Barrett	1989-04-03	no mencionar	25	5	14	25
EMP0000984	Ryder	Romero	1995-07-15	no mencionar	3	5	13	59
EMP0000985	Katherine	Hodge	1978-11-06	no mencionar	8	4	14	28
EMP0000986	Silas	Peters	1991-07-08	no mencionar	25	3	10	49
EMP0000987	Mariana	Contreras	1997-01-11	no mencionar	14	4	4	32
EMP0000988	Jaxon	Sampson	1981-03-26	no mencionar	12	1	4	55
EMP0000989	Julia	Cano	1994-02-09	no mencionar	4	5	4	36
EMP0000990	Luis	Vega	1982-10-22	no mencionar	17	5	11	23
EMP0000991	Adeline	Martinez	1985-04-05	no mencionar	34	1	1	23
EMP0000992	Leo	Valdez	1971-09-16	no mencionar	25	2	10	43
EMP0000993	Raelynn	Murray	1998-03-20	no mencionar	28	1	8	44
EMP0000994	Bennett	Hernandez	1977-12-13	no mencionar	2	5	10	23
EMP0000995	Alice	Trujillo	1990-05-08	no mencionar	25	2	3	37
EMP0000996	Alanis	Wong	1985-03-10	no mencionar	10	5	15	29
EMP0000997	Yessica	Castro	1979-12-06	no mencionar	18	4	5	25
EMP0000998	Esperanza	Jenkins	1994-12-16	no mencionar	10	2	12	50
EMP0000999	Marina	Serrano	1970-10-02	no mencionar	5	2	13	48
EMP0001000	Lucas	Hernandez	1979-06-30	no mencionar	7	5	8	25
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
1	5	1	4	1	Burnout	EMP0000001	2012-01
2	5	1	1	3	Depresion	EMP0000002	2009-01
3	4	5	5	1	Depresion	EMP0000003	2009-01
4	1	2	3	1	Burnout	EMP0000004	2012-01
5	1	1	1	5	Depresion	EMP0000005	2004-01
6	4	1	4	2	Saludable	EMP0000006	2000-02
7	3	5	4	3	Depresion	EMP0000007	2004-01
8	4	2	5	2	Burnout	EMP0000008	2000-02
9	2	2	5	3	Ansiedad	EMP0000009	2016-01
10	3	3	4	3	Depresion	EMP0000010	2016-01
11	3	2	2	5	Depresion	EMP0000011	2023-01
12	4	2	4	3	Ansiedad	EMP0000012	2016-02
13	1	3	4	3	Depresion	EMP0000013	2004-02
14	1	1	1	2	Saludable	EMP0000014	2002-01
15	5	1	1	4	Burnout	EMP0000015	2014-01
16	3	3	5	2	Depresion	EMP0000016	2004-02
17	5	5	3	3	Burnout	EMP0000017	2020-01
18	5	3	4	1	Burnout	EMP0000018	2022-02
19	5	3	5	4	Burnout	EMP0000019	2016-01
20	3	3	3	5	Depresion	EMP0000020	2019-01
21	1	1	5	5	Depresion	EMP0000021	2016-02
22	2	1	5	1	Burnout	EMP0000022	2002-02
23	3	5	3	3	Saludable	EMP0000023	2024-01
24	2	1	3	4	Saludable	EMP0000024	2022-02
25	4	5	2	2	Ansiedad	EMP0000025	2011-02
26	1	5	4	5	Burnout	EMP0000026	2003-01
27	5	3	4	5	Ansiedad	EMP0000027	2023-02
28	2	5	4	1	Saludable	EMP0000028	2006-01
29	5	4	3	1	Saludable	EMP0000029	2024-02
30	5	2	2	1	Ansiedad	EMP0000030	2009-01
31	5	4	2	4	Ansiedad	EMP0000031	2014-01
32	5	5	4	3	Depresion	EMP0000032	2006-01
33	5	3	3	3	Ansiedad	EMP0000033	2022-02
34	3	3	3	5	Ansiedad	EMP0000034	2018-01
35	1	4	2	3	Saludable	EMP0000035	2006-02
36	2	3	4	4	Ansiedad	EMP0000036	2004-01
37	1	3	5	2	Ansiedad	EMP0000037	2020-02
38	3	5	5	2	Ansiedad	EMP0000038	2019-02
39	4	3	4	3	Depresion	EMP0000039	2004-02
40	1	2	1	5	Saludable	EMP0000040	2010-01
41	1	1	2	2	Ansiedad	EMP0000041	2019-01
42	1	5	4	3	Depresion	EMP0000042	2007-01
43	1	1	3	1	Ansiedad	EMP0000043	2004-02
44	5	3	4	1	Burnout	EMP0000044	2000-01
45	3	5	1	1	Saludable	EMP0000045	2024-01
46	1	3	1	3	Burnout	EMP0000046	2006-02
47	5	3	4	4	Depresion	EMP0000047	2017-01
48	4	1	5	3	Burnout	EMP0000048	2019-01
49	1	1	1	5	Depresion	EMP0000049	2012-01
50	3	3	1	5	Saludable	EMP0000050	2024-01
51	5	1	3	3	Saludable	EMP0000051	2017-02
52	1	2	4	3	Depresion	EMP0000052	2017-01
53	4	3	2	1	Depresion	EMP0000053	2022-01
54	5	4	3	4	Saludable	EMP0000054	2009-01
55	4	5	1	2	Ansiedad	EMP0000055	2023-01
56	4	3	4	5	Depresion	EMP0000056	2001-02
57	5	5	2	1	Ansiedad	EMP0000057	2006-02
58	3	4	5	2	Depresion	EMP0000058	2005-01
59	3	3	2	5	Depresion	EMP0000059	2000-01
60	3	1	1	2	Ansiedad	EMP0000060	2000-01
61	1	5	3	1	Depresion	EMP0000061	2023-02
62	3	5	3	5	Ansiedad	EMP0000062	2014-02
63	4	3	1	5	Depresion	EMP0000063	2008-01
64	4	4	5	2	Saludable	EMP0000064	2005-01
65	2	4	5	3	Ansiedad	EMP0000065	2003-02
66	4	1	1	3	Saludable	EMP0000066	2015-02
67	1	5	4	2	Saludable	EMP0000067	2015-02
68	2	4	4	3	Saludable	EMP0000068	2016-01
69	2	4	2	4	Burnout	EMP0000069	2024-02
70	4	3	5	3	Ansiedad	EMP0000070	2005-01
71	5	5	4	5	Depresion	EMP0000071	2006-01
72	5	5	1	2	Burnout	EMP0000072	2011-01
73	4	2	3	1	Saludable	EMP0000073	2001-01
74	2	4	1	5	Depresion	EMP0000074	2003-02
75	1	1	3	4	Burnout	EMP0000075	2016-02
76	5	1	2	5	Saludable	EMP0000076	2021-01
77	5	4	1	3	Ansiedad	EMP0000077	2002-02
78	2	3	3	3	Ansiedad	EMP0000078	2013-02
79	5	5	4	2	Ansiedad	EMP0000079	2007-02
80	1	5	2	1	Depresion	EMP0000080	2000-01
81	3	4	1	2	Saludable	EMP0000081	2008-01
82	5	4	1	4	Ansiedad	EMP0000082	2010-02
83	3	2	2	1	Ansiedad	EMP0000083	2012-02
84	5	3	2	5	Burnout	EMP0000084	2016-02
85	2	4	3	4	Burnout	EMP0000085	2007-02
86	1	3	5	1	Depresion	EMP0000086	2016-02
87	5	5	3	1	Ansiedad	EMP0000087	2023-01
88	2	5	4	4	Ansiedad	EMP0000088	2013-02
89	2	2	3	5	Saludable	EMP0000089	2001-02
90	1	1	2	5	Depresion	EMP0000090	2023-01
91	2	2	1	4	Saludable	EMP0000091	2003-01
92	5	5	2	4	Saludable	EMP0000092	2004-01
93	4	1	5	1	Saludable	EMP0000093	2020-01
94	2	5	4	2	Burnout	EMP0000094	2011-02
95	2	5	1	4	Burnout	EMP0000095	2010-01
96	5	1	1	3	Ansiedad	EMP0000096	2008-01
97	2	1	2	4	Ansiedad	EMP0000097	2013-02
98	4	3	3	5	Saludable	EMP0000098	2011-01
99	2	5	2	2	Burnout	EMP0000099	2014-01
100	1	5	3	5	Saludable	EMP0000100	2024-01
101	5	4	5	4	Ansiedad	EMP0000101	2006-02
102	4	3	2	5	Ansiedad	EMP0000102	2023-02
103	3	1	2	2	Burnout	EMP0000103	2020-02
104	2	4	1	4	Ansiedad	EMP0000104	2011-01
105	3	4	2	5	Burnout	EMP0000105	2005-02
106	5	3	2	4	Saludable	EMP0000106	2017-01
107	5	4	4	3	Burnout	EMP0000107	2012-02
108	1	4	2	1	Burnout	EMP0000108	2022-02
109	4	2	4	3	Saludable	EMP0000109	2002-02
110	3	5	2	1	Depresion	EMP0000110	2013-01
111	3	2	3	3	Burnout	EMP0000111	2000-01
112	3	5	5	5	Saludable	EMP0000112	2024-02
113	3	1	3	3	Depresion	EMP0000113	2009-01
114	2	1	5	2	Burnout	EMP0000114	2000-01
115	1	2	5	3	Ansiedad	EMP0000115	2009-01
116	2	1	1	2	Saludable	EMP0000116	2019-02
117	4	1	1	5	Ansiedad	EMP0000117	2005-02
118	4	4	1	2	Ansiedad	EMP0000118	2000-02
119	2	5	2	5	Saludable	EMP0000119	2024-01
120	1	1	1	5	Burnout	EMP0000120	2022-01
121	2	3	2	5	Saludable	EMP0000121	2014-01
122	2	1	3	1	Depresion	EMP0000122	2010-02
123	5	2	5	4	Depresion	EMP0000123	2007-02
124	2	2	3	3	Ansiedad	EMP0000124	2017-01
125	4	5	3	2	Saludable	EMP0000125	2019-01
126	3	3	2	3	Ansiedad	EMP0000126	2021-02
127	4	4	3	5	Saludable	EMP0000127	2021-01
128	2	4	3	2	Burnout	EMP0000128	2017-01
129	5	2	3	3	Burnout	EMP0000129	2010-01
130	4	5	3	3	Burnout	EMP0000130	2000-02
131	2	3	2	4	Ansiedad	EMP0000131	2013-01
132	5	5	2	2	Saludable	EMP0000132	2007-01
133	2	1	2	5	Ansiedad	EMP0000133	2016-02
134	3	2	4	1	Ansiedad	EMP0000134	2015-01
135	3	2	5	3	Saludable	EMP0000135	2010-02
136	2	3	3	5	Depresion	EMP0000136	2017-01
137	2	3	2	4	Saludable	EMP0000137	2014-01
138	1	2	2	1	Depresion	EMP0000138	2022-01
139	4	3	5	5	Saludable	EMP0000139	2000-02
140	1	1	4	2	Ansiedad	EMP0000140	2007-02
141	3	5	5	5	Ansiedad	EMP0000141	2013-01
142	1	1	2	1	Saludable	EMP0000142	2011-02
143	3	5	4	1	Saludable	EMP0000143	2011-02
144	2	2	3	4	Depresion	EMP0000144	2012-02
145	2	2	1	5	Burnout	EMP0000145	2006-02
146	2	1	2	1	Ansiedad	EMP0000146	2001-02
147	2	2	3	4	Depresion	EMP0000147	2006-01
148	4	2	4	5	Ansiedad	EMP0000148	2020-02
149	3	4	2	2	Burnout	EMP0000149	2022-01
150	3	2	3	4	Burnout	EMP0000150	2015-01
151	3	3	2	1	Saludable	EMP0000151	2015-01
152	2	5	3	5	Saludable	EMP0000152	2023-01
153	3	4	2	4	Saludable	EMP0000153	2010-01
154	4	3	5	3	Ansiedad	EMP0000154	2024-02
155	4	3	4	4	Burnout	EMP0000155	2016-02
156	4	2	5	4	Burnout	EMP0000156	2007-01
157	1	2	2	5	Ansiedad	EMP0000157	2016-01
158	5	3	4	2	Ansiedad	EMP0000158	2015-01
159	2	2	1	1	Depresion	EMP0000159	2000-02
160	4	4	1	5	Depresion	EMP0000160	2016-01
161	4	5	2	3	Ansiedad	EMP0000161	2024-01
162	3	4	2	2	Depresion	EMP0000162	2015-02
163	3	1	2	4	Saludable	EMP0000163	2007-02
164	3	3	4	1	Ansiedad	EMP0000164	2005-01
165	5	4	4	1	Ansiedad	EMP0000165	2014-01
166	1	1	4	2	Saludable	EMP0000166	2017-02
167	5	5	5	3	Saludable	EMP0000167	2005-01
168	2	3	5	4	Ansiedad	EMP0000168	2018-02
169	1	4	1	5	Saludable	EMP0000169	2002-01
170	3	3	1	4	Depresion	EMP0000170	2022-01
171	1	3	5	2	Saludable	EMP0000171	2022-02
172	3	2	3	3	Ansiedad	EMP0000172	2011-02
173	4	4	5	3	Burnout	EMP0000173	2004-01
174	5	3	2	5	Saludable	EMP0000174	2021-02
175	5	5	5	1	Saludable	EMP0000175	2005-02
176	3	3	1	1	Depresion	EMP0000176	2001-02
177	1	3	3	5	Ansiedad	EMP0000177	2021-02
178	1	2	4	1	Ansiedad	EMP0000178	2020-02
179	5	3	4	1	Ansiedad	EMP0000179	2021-02
180	4	1	2	5	Burnout	EMP0000180	2009-02
181	1	5	2	4	Ansiedad	EMP0000181	2007-01
182	2	5	3	4	Depresion	EMP0000182	2021-01
183	4	3	1	2	Saludable	EMP0000183	2012-02
184	1	2	2	3	Burnout	EMP0000184	2017-01
185	1	3	3	3	Depresion	EMP0000185	2019-01
186	1	4	3	2	Burnout	EMP0000186	2005-02
187	4	1	4	3	Saludable	EMP0000187	2002-01
188	3	5	1	2	Saludable	EMP0000188	2012-02
189	3	4	1	1	Burnout	EMP0000189	2005-02
190	2	4	5	1	Depresion	EMP0000190	2018-02
191	5	2	3	4	Burnout	EMP0000191	2006-02
192	2	5	2	1	Ansiedad	EMP0000192	2002-02
193	4	4	3	1	Burnout	EMP0000193	2012-02
194	1	3	5	3	Ansiedad	EMP0000194	2003-01
195	2	3	4	3	Depresion	EMP0000195	2013-02
196	3	5	4	3	Burnout	EMP0000196	2016-02
197	4	4	5	4	Burnout	EMP0000197	2016-01
198	3	4	4	4	Saludable	EMP0000198	2014-02
199	4	4	5	4	Burnout	EMP0000199	2002-02
200	2	4	3	4	Depresion	EMP0000200	2007-02
201	3	3	1	1	Burnout	EMP0000201	2022-01
202	5	5	3	5	Burnout	EMP0000202	2021-02
203	4	2	1	3	Ansiedad	EMP0000203	2021-02
204	1	4	5	1	Ansiedad	EMP0000204	2024-02
205	3	3	1	2	Depresion	EMP0000205	2011-02
206	5	2	5	4	Ansiedad	EMP0000206	2016-01
207	1	3	2	3	Burnout	EMP0000207	2009-02
208	4	1	4	5	Burnout	EMP0000208	2024-01
209	2	3	3	3	Saludable	EMP0000209	2022-02
210	4	4	2	4	Burnout	EMP0000210	2006-02
211	5	4	1	1	Burnout	EMP0000211	2006-01
212	4	2	4	5	Saludable	EMP0000212	2010-01
213	1	5	4	5	Depresion	EMP0000213	2007-02
214	3	3	5	2	Saludable	EMP0000214	2001-01
215	5	2	5	1	Ansiedad	EMP0000215	2012-01
216	3	1	2	5	Depresion	EMP0000216	2020-02
217	5	1	2	4	Saludable	EMP0000217	2024-02
218	5	1	1	5	Saludable	EMP0000218	2017-02
219	1	4	5	5	Saludable	EMP0000219	2012-01
220	1	2	4	1	Burnout	EMP0000220	2020-02
221	5	2	5	1	Saludable	EMP0000221	2013-01
222	1	3	5	3	Saludable	EMP0000222	2019-02
223	1	3	2	5	Burnout	EMP0000223	2015-02
224	1	1	5	2	Ansiedad	EMP0000224	2004-02
225	5	3	4	5	Depresion	EMP0000225	2001-02
226	1	4	4	2	Depresion	EMP0000226	2017-02
227	5	2	1	3	Depresion	EMP0000227	2010-02
228	5	5	4	2	Burnout	EMP0000228	2020-01
229	3	4	4	1	Depresion	EMP0000229	2001-01
230	1	5	3	4	Saludable	EMP0000230	2013-01
231	1	5	1	3	Burnout	EMP0000231	2015-01
232	4	3	4	2	Depresion	EMP0000232	2003-02
233	2	1	3	3	Depresion	EMP0000233	2003-01
234	5	5	5	5	Burnout	EMP0000234	2021-01
235	1	3	5	2	Saludable	EMP0000235	2005-01
236	5	2	2	3	Depresion	EMP0000236	2001-01
237	3	5	2	4	Depresion	EMP0000237	2000-01
238	4	1	4	4	Saludable	EMP0000238	2023-01
239	3	2	3	1	Saludable	EMP0000239	2009-01
240	4	1	5	2	Burnout	EMP0000240	2023-01
241	4	4	1	3	Ansiedad	EMP0000241	2022-02
242	3	5	2	5	Burnout	EMP0000242	2023-01
243	4	3	3	4	Depresion	EMP0000243	2014-01
244	5	1	5	3	Ansiedad	EMP0000244	2016-02
245	1	3	2	1	Ansiedad	EMP0000245	2015-02
246	4	4	3	1	Saludable	EMP0000246	2015-02
247	3	5	3	4	Ansiedad	EMP0000247	2009-02
248	3	5	5	5	Saludable	EMP0000248	2020-02
249	1	2	2	5	Ansiedad	EMP0000249	2001-02
250	5	1	4	3	Depresion	EMP0000250	2007-01
251	5	1	2	3	Saludable	EMP0000251	2007-02
252	4	1	3	2	Saludable	EMP0000252	2004-01
253	4	2	3	1	Depresion	EMP0000253	2022-01
254	3	5	5	5	Burnout	EMP0000254	2014-01
255	4	4	5	2	Ansiedad	EMP0000255	2021-02
256	5	2	1	5	Burnout	EMP0000256	2013-02
257	3	1	4	3	Ansiedad	EMP0000257	2022-01
258	2	5	1	4	Saludable	EMP0000258	2020-01
259	4	5	4	2	Depresion	EMP0000259	2021-01
260	4	1	4	5	Saludable	EMP0000260	2021-02
261	3	2	3	1	Ansiedad	EMP0000261	2010-01
262	5	3	4	1	Ansiedad	EMP0000262	2014-01
263	2	2	2	2	Ansiedad	EMP0000263	2019-02
264	4	4	5	4	Ansiedad	EMP0000264	2007-02
265	4	4	3	5	Depresion	EMP0000265	2019-01
266	5	3	2	5	Ansiedad	EMP0000266	2016-02
267	5	2	3	1	Saludable	EMP0000267	2008-02
268	1	5	5	2	Burnout	EMP0000268	2019-02
269	3	4	5	2	Depresion	EMP0000269	2021-01
270	5	3	3	1	Burnout	EMP0000270	2016-01
271	3	4	5	4	Depresion	EMP0000271	2022-01
272	2	1	4	3	Depresion	EMP0000272	2015-01
273	2	1	2	3	Depresion	EMP0000273	2019-02
274	4	4	1	4	Depresion	EMP0000274	2021-02
275	4	3	4	1	Depresion	EMP0000275	2015-02
276	4	5	4	4	Depresion	EMP0000276	2011-02
277	1	1	5	3	Depresion	EMP0000277	2000-02
278	2	2	3	1	Saludable	EMP0000278	2023-02
279	4	4	2	3	Ansiedad	EMP0000279	2021-01
280	4	4	2	2	Burnout	EMP0000280	2019-02
281	2	3	2	4	Burnout	EMP0000281	2019-01
282	3	5	2	5	Burnout	EMP0000282	2013-01
283	1	1	4	3	Ansiedad	EMP0000283	2010-01
284	3	1	1	1	Saludable	EMP0000284	2020-01
285	5	3	1	1	Burnout	EMP0000285	2018-02
286	3	3	1	1	Burnout	EMP0000286	2019-02
287	5	3	1	3	Depresion	EMP0000287	2002-02
288	2	2	5	4	Depresion	EMP0000288	2002-02
289	1	2	4	3	Saludable	EMP0000289	2013-02
290	1	3	2	5	Ansiedad	EMP0000290	2015-02
291	5	2	2	3	Ansiedad	EMP0000291	2010-01
292	1	1	5	1	Ansiedad	EMP0000292	2004-01
293	5	5	4	1	Depresion	EMP0000293	2016-01
294	3	4	5	3	Saludable	EMP0000294	2011-02
295	4	1	4	4	Ansiedad	EMP0000295	2016-02
296	4	3	1	2	Depresion	EMP0000296	2006-01
297	2	4	1	4	Saludable	EMP0000297	2010-01
298	4	4	4	3	Saludable	EMP0000298	2004-01
299	5	4	5	1	Burnout	EMP0000299	2008-01
300	1	4	5	5	Saludable	EMP0000300	2009-01
301	3	4	1	3	Burnout	EMP0000301	2021-02
302	5	3	3	4	Saludable	EMP0000302	2007-02
303	3	4	5	4	Ansiedad	EMP0000303	2013-01
304	5	2	4	3	Ansiedad	EMP0000304	2009-01
305	3	1	3	3	Ansiedad	EMP0000305	2003-01
306	2	4	3	1	Burnout	EMP0000306	2019-01
307	4	2	4	5	Depresion	EMP0000307	2006-01
308	2	5	3	1	Burnout	EMP0000308	2016-01
309	1	5	5	5	Burnout	EMP0000309	2006-01
310	1	2	2	2	Ansiedad	EMP0000310	2024-01
311	5	5	5	5	Burnout	EMP0000311	2022-02
312	5	3	4	2	Depresion	EMP0000312	2018-01
313	5	1	1	3	Depresion	EMP0000313	2023-02
314	5	4	3	3	Ansiedad	EMP0000314	2009-01
315	4	3	1	3	Burnout	EMP0000315	2006-01
316	1	2	3	3	Burnout	EMP0000316	2007-02
317	4	3	3	5	Ansiedad	EMP0000317	2009-02
318	1	3	4	4	Saludable	EMP0000318	2001-01
319	2	2	4	5	Burnout	EMP0000319	2019-01
320	5	3	5	4	Ansiedad	EMP0000320	2003-02
321	5	1	2	2	Ansiedad	EMP0000321	2021-01
322	2	1	1	4	Burnout	EMP0000322	2021-01
323	4	3	2	4	Saludable	EMP0000323	2021-01
324	5	3	3	2	Burnout	EMP0000324	2002-01
325	2	5	4	2	Saludable	EMP0000325	2010-02
326	3	1	3	3	Ansiedad	EMP0000326	2015-01
327	1	5	1	1	Saludable	EMP0000327	2009-01
328	2	4	3	2	Burnout	EMP0000328	2009-01
329	1	2	4	1	Ansiedad	EMP0000329	2010-02
330	4	4	5	2	Burnout	EMP0000330	2003-02
331	4	2	5	4	Saludable	EMP0000331	2001-01
332	5	3	4	2	Saludable	EMP0000332	2010-02
333	3	4	5	1	Depresion	EMP0000333	2013-02
334	3	1	2	1	Burnout	EMP0000334	2024-01
335	1	2	5	4	Ansiedad	EMP0000335	2002-01
336	1	4	1	5	Burnout	EMP0000336	2016-01
337	4	1	2	2	Depresion	EMP0000337	2002-01
338	3	2	2	3	Burnout	EMP0000338	2012-01
339	2	2	1	4	Depresion	EMP0000339	2023-01
340	3	2	4	4	Saludable	EMP0000340	2002-01
341	3	5	5	1	Burnout	EMP0000341	2012-02
342	5	2	1	3	Ansiedad	EMP0000342	2009-02
343	4	2	2	2	Depresion	EMP0000343	2008-02
344	2	3	5	2	Burnout	EMP0000344	2005-02
345	1	4	3	4	Depresion	EMP0000345	2018-02
346	4	1	5	5	Depresion	EMP0000346	2010-02
347	2	3	2	4	Burnout	EMP0000347	2007-02
348	3	1	5	2	Depresion	EMP0000348	2018-01
349	3	5	3	1	Ansiedad	EMP0000349	2020-02
350	2	1	3	5	Burnout	EMP0000350	2017-02
351	5	1	1	2	Ansiedad	EMP0000351	2021-01
352	4	4	2	3	Depresion	EMP0000352	2002-01
353	4	1	2	3	Depresion	EMP0000353	2004-01
354	4	3	2	2	Ansiedad	EMP0000354	2024-02
355	1	4	1	3	Ansiedad	EMP0000355	2024-02
356	4	1	3	4	Saludable	EMP0000356	2017-02
357	2	5	2	4	Depresion	EMP0000357	2006-01
358	3	2	5	2	Ansiedad	EMP0000358	2005-02
359	5	1	1	2	Depresion	EMP0000359	2012-02
360	2	2	4	4	Burnout	EMP0000360	2010-01
361	5	4	3	3	Burnout	EMP0000361	2010-02
362	2	2	1	1	Ansiedad	EMP0000362	2022-01
363	5	1	5	1	Burnout	EMP0000363	2023-02
364	3	4	4	5	Burnout	EMP0000364	2016-02
365	1	4	5	2	Saludable	EMP0000365	2000-02
366	1	3	5	1	Saludable	EMP0000366	2011-02
367	2	2	5	4	Depresion	EMP0000367	2015-02
368	3	1	1	4	Depresion	EMP0000368	2008-01
369	5	5	2	2	Depresion	EMP0000369	2013-01
370	5	2	2	1	Saludable	EMP0000370	2017-01
371	3	4	2	5	Burnout	EMP0000371	2023-02
372	1	5	5	2	Saludable	EMP0000372	2024-01
373	3	5	3	2	Burnout	EMP0000373	2024-02
374	3	1	5	1	Burnout	EMP0000374	2014-01
375	5	4	2	5	Ansiedad	EMP0000375	2000-01
376	4	1	5	4	Saludable	EMP0000376	2006-02
377	3	4	5	2	Depresion	EMP0000377	2012-01
378	4	3	4	1	Saludable	EMP0000378	2015-01
379	4	4	2	4	Depresion	EMP0000379	2005-02
380	2	2	4	3	Burnout	EMP0000380	2007-01
381	5	5	5	5	Ansiedad	EMP0000381	2020-02
382	5	5	1	1	Saludable	EMP0000382	2019-02
383	1	5	4	1	Burnout	EMP0000383	2024-02
384	5	5	1	3	Burnout	EMP0000384	2006-02
385	2	5	2	2	Burnout	EMP0000385	2017-01
386	5	3	1	1	Burnout	EMP0000386	2016-01
387	1	1	1	3	Depresion	EMP0000387	2006-02
388	3	5	1	1	Ansiedad	EMP0000388	2011-01
389	5	5	2	4	Saludable	EMP0000389	2022-02
390	5	1	2	3	Burnout	EMP0000390	2014-01
391	2	4	5	1	Depresion	EMP0000391	2010-01
392	3	4	3	2	Ansiedad	EMP0000392	2022-02
393	5	2	5	2	Saludable	EMP0000393	2020-02
394	1	5	5	1	Burnout	EMP0000394	2008-01
395	3	3	1	4	Ansiedad	EMP0000395	2002-02
396	4	4	2	2	Burnout	EMP0000396	2009-01
397	4	2	5	1	Ansiedad	EMP0000397	2018-02
398	1	3	2	1	Burnout	EMP0000398	2008-02
399	5	5	3	1	Depresion	EMP0000399	2000-01
400	5	4	5	3	Depresion	EMP0000400	2019-02
401	2	3	1	5	Burnout	EMP0000401	2010-02
402	2	5	3	3	Depresion	EMP0000402	2001-02
403	5	2	5	4	Saludable	EMP0000403	2020-01
404	5	1	3	2	Saludable	EMP0000404	2004-01
405	5	1	4	2	Depresion	EMP0000405	2005-01
406	5	4	1	3	Ansiedad	EMP0000406	2011-01
407	5	1	5	4	Depresion	EMP0000407	2024-01
408	3	4	4	2	Ansiedad	EMP0000408	2016-01
409	2	5	1	4	Burnout	EMP0000409	2011-02
410	3	2	4	3	Depresion	EMP0000410	2023-02
411	3	3	5	4	Ansiedad	EMP0000411	2009-02
412	5	1	4	4	Saludable	EMP0000412	2013-01
413	3	2	4	1	Depresion	EMP0000413	2022-01
414	1	5	5	1	Burnout	EMP0000414	2012-01
415	5	1	3	2	Burnout	EMP0000415	2015-01
416	1	1	2	1	Ansiedad	EMP0000416	2016-02
417	3	4	4	4	Ansiedad	EMP0000417	2020-01
418	4	3	4	5	Burnout	EMP0000418	2019-01
419	4	3	3	1	Depresion	EMP0000419	2023-01
420	2	3	1	5	Burnout	EMP0000420	2009-02
421	4	3	2	4	Burnout	EMP0000421	2000-01
422	4	4	5	4	Burnout	EMP0000422	2016-01
423	4	1	2	3	Saludable	EMP0000423	2013-02
424	2	2	1	2	Depresion	EMP0000424	2007-02
425	5	3	2	3	Saludable	EMP0000425	2001-02
426	2	1	2	2	Burnout	EMP0000426	2023-02
427	4	5	2	2	Burnout	EMP0000427	2022-02
428	3	2	3	3	Ansiedad	EMP0000428	2018-01
429	2	2	2	1	Depresion	EMP0000429	2016-01
430	4	1	1	4	Burnout	EMP0000430	2015-02
431	1	5	4	3	Burnout	EMP0000431	2013-02
432	2	4	3	1	Ansiedad	EMP0000432	2020-01
433	3	3	2	4	Ansiedad	EMP0000433	2018-02
434	4	5	2	4	Burnout	EMP0000434	2019-01
435	1	5	2	1	Burnout	EMP0000435	2001-02
436	3	3	3	2	Burnout	EMP0000436	2024-01
437	3	2	2	1	Saludable	EMP0000437	2011-01
438	3	1	2	3	Ansiedad	EMP0000438	2014-01
439	5	5	4	3	Saludable	EMP0000439	2009-02
440	2	4	2	3	Ansiedad	EMP0000440	2002-02
441	3	1	5	2	Burnout	EMP0000441	2003-01
442	2	1	5	1	Ansiedad	EMP0000442	2000-01
443	1	2	1	2	Saludable	EMP0000443	2020-02
444	3	3	5	5	Burnout	EMP0000444	2017-02
445	4	2	5	4	Depresion	EMP0000445	2020-02
446	5	3	2	1	Burnout	EMP0000446	2011-02
447	4	2	5	5	Depresion	EMP0000447	2006-01
448	3	4	1	5	Ansiedad	EMP0000448	2007-02
449	4	5	3	2	Depresion	EMP0000449	2022-01
450	2	4	4	1	Ansiedad	EMP0000450	2022-02
451	1	1	4	3	Burnout	EMP0000451	2008-02
452	4	5	5	1	Depresion	EMP0000452	2022-02
453	4	5	3	5	Ansiedad	EMP0000453	2011-02
454	4	4	2	4	Ansiedad	EMP0000454	2016-02
455	2	3	1	3	Depresion	EMP0000455	2006-01
456	1	5	5	5	Ansiedad	EMP0000456	2000-01
457	2	4	3	4	Ansiedad	EMP0000457	2005-01
458	4	4	1	1	Ansiedad	EMP0000458	2004-01
459	1	4	1	2	Saludable	EMP0000459	2022-02
460	4	2	1	5	Saludable	EMP0000460	2000-02
461	3	5	4	5	Saludable	EMP0000461	2021-02
462	4	5	3	1	Ansiedad	EMP0000462	2001-02
463	3	1	5	2	Ansiedad	EMP0000463	2014-02
464	4	2	1	1	Ansiedad	EMP0000464	2012-02
465	3	5	1	1	Saludable	EMP0000465	2023-02
466	2	4	5	1	Ansiedad	EMP0000466	2012-02
467	1	1	5	1	Burnout	EMP0000467	2007-01
468	4	1	5	4	Depresion	EMP0000468	2021-01
469	5	2	5	5	Burnout	EMP0000469	2009-02
470	3	4	5	3	Ansiedad	EMP0000470	2001-01
471	4	5	3	2	Saludable	EMP0000471	2024-01
472	1	4	4	2	Depresion	EMP0000472	2022-02
473	2	1	5	3	Burnout	EMP0000473	2014-01
474	3	3	3	3	Saludable	EMP0000474	2020-02
475	2	3	3	1	Ansiedad	EMP0000475	2010-02
476	1	2	4	1	Burnout	EMP0000476	2016-01
477	4	4	4	5	Burnout	EMP0000477	2016-02
478	1	2	1	1	Depresion	EMP0000478	2015-01
479	4	3	2	2	Ansiedad	EMP0000479	2007-02
480	5	3	1	5	Saludable	EMP0000480	2016-02
481	5	2	2	1	Saludable	EMP0000481	2013-02
482	3	2	1	3	Burnout	EMP0000482	2004-01
483	4	1	5	2	Ansiedad	EMP0000483	2019-01
484	4	1	1	2	Depresion	EMP0000484	2014-01
485	5	5	5	4	Saludable	EMP0000485	2006-01
486	3	3	4	2	Saludable	EMP0000486	2010-02
487	5	1	4	2	Saludable	EMP0000487	2005-02
488	5	4	3	2	Saludable	EMP0000488	2008-02
489	3	3	5	1	Depresion	EMP0000489	2004-01
490	1	3	3	4	Ansiedad	EMP0000490	2014-02
491	5	3	3	3	Ansiedad	EMP0000491	2004-02
492	1	1	2	1	Depresion	EMP0000492	2019-02
493	2	4	1	3	Burnout	EMP0000493	2004-02
494	5	5	5	3	Burnout	EMP0000494	2001-02
495	4	2	2	5	Burnout	EMP0000495	2016-02
496	2	5	2	5	Saludable	EMP0000496	2009-02
497	4	1	5	1	Saludable	EMP0000497	2018-02
498	5	4	3	1	Depresion	EMP0000498	2024-01
499	1	4	4	2	Ansiedad	EMP0000499	2017-02
500	3	3	5	4	Depresion	EMP0000500	2024-02
501	5	2	2	1	Ansiedad	EMP0000501	2006-02
502	4	4	4	4	Depresion	EMP0000502	2016-01
503	5	2	2	2	Burnout	EMP0000503	2022-02
504	2	4	4	3	Ansiedad	EMP0000504	2007-01
505	1	2	3	5	Ansiedad	EMP0000505	2001-02
506	4	5	4	3	Burnout	EMP0000506	2001-01
507	4	1	3	1	Ansiedad	EMP0000507	2022-02
508	2	2	5	3	Burnout	EMP0000508	2006-02
509	1	2	3	2	Saludable	EMP0000509	2013-02
510	2	2	4	4	Ansiedad	EMP0000510	2021-02
511	5	4	2	3	Ansiedad	EMP0000511	2010-02
512	2	4	4	3	Saludable	EMP0000512	2019-02
513	2	4	4	3	Burnout	EMP0000513	2020-02
514	3	1	5	5	Saludable	EMP0000514	2010-01
515	5	5	3	5	Burnout	EMP0000515	2001-02
516	3	3	1	5	Burnout	EMP0000516	2022-01
517	4	3	3	5	Burnout	EMP0000517	2020-01
518	3	4	4	4	Burnout	EMP0000518	2016-02
519	2	1	4	2	Saludable	EMP0000519	2004-01
520	5	3	2	1	Burnout	EMP0000520	2022-02
521	5	1	5	3	Depresion	EMP0000521	2018-02
522	5	5	3	3	Ansiedad	EMP0000522	2022-02
523	4	3	2	4	Saludable	EMP0000523	2009-01
524	1	2	1	5	Burnout	EMP0000524	2011-01
525	1	5	1	4	Burnout	EMP0000525	2014-02
526	2	4	1	4	Depresion	EMP0000526	2000-02
527	1	3	4	3	Depresion	EMP0000527	2006-02
528	3	4	4	4	Saludable	EMP0000528	2022-01
529	1	4	5	3	Ansiedad	EMP0000529	2005-01
530	3	3	3	4	Saludable	EMP0000530	2018-02
531	3	3	1	1	Ansiedad	EMP0000531	2003-02
532	3	5	2	4	Ansiedad	EMP0000532	2020-01
533	1	3	4	4	Depresion	EMP0000533	2011-01
534	1	2	1	5	Saludable	EMP0000534	2014-01
535	1	2	1	2	Ansiedad	EMP0000535	2023-01
536	2	1	5	2	Saludable	EMP0000536	2002-02
537	5	4	4	2	Ansiedad	EMP0000537	2021-02
538	2	5	4	2	Burnout	EMP0000538	2003-01
539	1	2	4	2	Ansiedad	EMP0000539	2002-02
540	4	5	2	1	Depresion	EMP0000540	2024-01
541	4	1	1	3	Ansiedad	EMP0000541	2000-02
542	1	2	4	5	Depresion	EMP0000542	2012-02
543	4	1	4	2	Ansiedad	EMP0000543	2019-01
544	3	4	4	5	Depresion	EMP0000544	2006-01
545	3	1	2	2	Depresion	EMP0000545	2011-01
546	1	1	4	5	Ansiedad	EMP0000546	2016-01
547	4	1	4	1	Ansiedad	EMP0000547	2008-01
548	1	3	4	5	Burnout	EMP0000548	2020-02
549	2	1	5	2	Burnout	EMP0000549	2002-02
550	2	3	2	4	Burnout	EMP0000550	2021-02
551	5	5	1	1	Depresion	EMP0000551	2002-02
552	1	3	1	3	Ansiedad	EMP0000552	2005-01
553	4	1	2	2	Burnout	EMP0000553	2022-02
554	3	5	2	1	Burnout	EMP0000554	2002-01
555	3	4	4	2	Burnout	EMP0000555	2017-02
556	3	4	3	1	Ansiedad	EMP0000556	2009-02
557	2	3	5	1	Ansiedad	EMP0000557	2014-01
558	3	1	3	5	Burnout	EMP0000558	2004-01
559	3	5	4	1	Ansiedad	EMP0000559	2017-01
560	5	2	4	5	Burnout	EMP0000560	2015-02
561	3	5	3	5	Ansiedad	EMP0000561	2003-01
562	2	2	3	4	Saludable	EMP0000562	2022-02
563	1	3	4	3	Depresion	EMP0000563	2015-01
564	3	3	3	1	Saludable	EMP0000564	2017-01
565	5	4	1	4	Depresion	EMP0000565	2022-01
566	4	2	4	3	Depresion	EMP0000566	2021-02
567	2	2	2	1	Saludable	EMP0000567	2009-01
568	3	2	3	3	Ansiedad	EMP0000568	2020-01
569	5	4	5	3	Depresion	EMP0000569	2016-01
570	3	5	5	4	Burnout	EMP0000570	2007-01
571	4	4	1	1	Saludable	EMP0000571	2018-01
572	5	5	2	3	Depresion	EMP0000572	2019-02
573	5	4	4	3	Depresion	EMP0000573	2019-02
574	5	2	1	4	Depresion	EMP0000574	2006-01
575	2	2	1	3	Burnout	EMP0000575	2024-02
576	3	2	1	5	Burnout	EMP0000576	2008-02
577	2	2	2	4	Ansiedad	EMP0000577	2024-01
578	3	4	2	5	Saludable	EMP0000578	2012-02
579	1	5	3	3	Ansiedad	EMP0000579	2006-01
580	5	3	2	4	Ansiedad	EMP0000580	2008-02
581	3	5	4	2	Depresion	EMP0000581	2012-01
582	2	5	4	5	Saludable	EMP0000582	2010-01
583	5	4	3	1	Depresion	EMP0000583	2018-02
584	2	3	1	3	Saludable	EMP0000584	2024-02
585	5	2	2	4	Ansiedad	EMP0000585	2019-01
586	4	2	1	2	Saludable	EMP0000586	2020-02
587	5	4	3	4	Ansiedad	EMP0000587	2000-01
588	5	4	5	2	Depresion	EMP0000588	2002-01
589	1	4	1	3	Burnout	EMP0000589	2008-01
590	4	5	1	4	Depresion	EMP0000590	2019-01
591	2	3	2	1	Burnout	EMP0000591	2022-02
592	5	4	5	1	Burnout	EMP0000592	2009-01
593	4	5	5	4	Ansiedad	EMP0000593	2002-01
594	5	3	5	5	Saludable	EMP0000594	2000-02
595	2	1	4	5	Burnout	EMP0000595	2003-02
596	1	5	4	1	Saludable	EMP0000596	2009-02
597	1	4	3	5	Saludable	EMP0000597	2006-01
598	1	1	1	1	Burnout	EMP0000598	2007-01
599	2	1	4	2	Depresion	EMP0000599	2014-01
600	3	5	2	1	Depresion	EMP0000600	2019-01
601	4	5	2	1	Saludable	EMP0000601	2024-02
602	2	3	5	4	Burnout	EMP0000602	2023-02
603	4	3	4	5	Burnout	EMP0000603	2018-02
604	1	5	1	1	Saludable	EMP0000604	2009-01
605	5	2	4	1	Saludable	EMP0000605	2000-01
606	3	3	1	3	Ansiedad	EMP0000606	2021-01
607	2	2	2	5	Depresion	EMP0000607	2024-02
608	1	3	3	2	Ansiedad	EMP0000608	2002-01
609	2	4	2	3	Ansiedad	EMP0000609	2010-01
610	3	1	1	1	Ansiedad	EMP0000610	2014-02
611	1	1	2	5	Ansiedad	EMP0000611	2005-01
612	2	3	1	2	Saludable	EMP0000612	2020-02
613	1	2	3	3	Burnout	EMP0000613	2018-01
614	3	4	5	2	Ansiedad	EMP0000614	2008-02
615	3	4	2	1	Depresion	EMP0000615	2017-02
616	2	3	4	5	Depresion	EMP0000616	2017-02
617	5	4	1	4	Depresion	EMP0000617	2000-01
618	3	1	5	2	Saludable	EMP0000618	2008-01
619	5	3	4	2	Depresion	EMP0000619	2009-01
620	2	1	5	2	Burnout	EMP0000620	2007-02
621	3	4	5	4	Ansiedad	EMP0000621	2022-01
622	5	1	5	2	Ansiedad	EMP0000622	2010-02
623	5	4	4	3	Depresion	EMP0000623	2003-02
624	4	3	1	1	Ansiedad	EMP0000624	2000-01
625	5	2	4	4	Ansiedad	EMP0000625	2012-02
626	2	3	1	2	Ansiedad	EMP0000626	2016-01
627	4	1	2	1	Depresion	EMP0000627	2008-01
628	1	2	3	2	Depresion	EMP0000628	2013-01
629	2	1	3	5	Depresion	EMP0000629	2015-02
630	3	1	4	4	Burnout	EMP0000630	2022-01
631	2	5	3	1	Saludable	EMP0000631	2014-01
632	2	4	1	1	Ansiedad	EMP0000632	2014-01
633	5	2	3	4	Saludable	EMP0000633	2011-01
634	2	4	3	2	Ansiedad	EMP0000634	2009-02
635	3	1	2	5	Ansiedad	EMP0000635	2012-01
636	2	1	1	4	Ansiedad	EMP0000636	2003-01
637	2	5	4	3	Burnout	EMP0000637	2007-02
638	5	4	4	4	Saludable	EMP0000638	2023-02
639	2	2	4	1	Depresion	EMP0000639	2020-01
640	3	5	5	3	Saludable	EMP0000640	2024-01
641	5	3	4	2	Depresion	EMP0000641	2001-02
642	2	5	5	1	Ansiedad	EMP0000642	2004-01
643	4	2	5	1	Depresion	EMP0000643	2005-02
644	3	3	5	2	Burnout	EMP0000644	2003-02
645	1	1	3	5	Saludable	EMP0000645	2009-01
646	1	2	1	4	Saludable	EMP0000646	2021-01
647	4	2	2	1	Burnout	EMP0000647	2006-01
648	3	2	2	4	Ansiedad	EMP0000648	2005-02
649	2	4	3	2	Burnout	EMP0000649	2024-01
650	5	4	1	5	Depresion	EMP0000650	2017-02
651	2	3	4	5	Ansiedad	EMP0000651	2008-01
652	5	1	4	4	Depresion	EMP0000652	2002-02
653	4	5	3	5	Depresion	EMP0000653	2004-01
654	4	5	5	1	Ansiedad	EMP0000654	2023-01
655	4	3	5	3	Depresion	EMP0000655	2007-01
656	1	4	1	5	Depresion	EMP0000656	2013-01
657	4	4	4	4	Ansiedad	EMP0000657	2004-01
658	5	3	4	3	Burnout	EMP0000658	2024-01
659	5	4	5	3	Ansiedad	EMP0000659	2017-02
660	4	3	4	1	Ansiedad	EMP0000660	2013-02
661	3	1	3	3	Burnout	EMP0000661	2012-02
662	1	3	4	3	Ansiedad	EMP0000662	2010-02
663	3	3	2	4	Burnout	EMP0000663	2021-02
664	1	4	2	4	Ansiedad	EMP0000664	2024-01
665	4	3	5	1	Saludable	EMP0000665	2008-01
666	2	2	4	3	Saludable	EMP0000666	2000-02
667	3	1	4	2	Depresion	EMP0000667	2003-02
668	4	1	1	3	Depresion	EMP0000668	2003-02
669	2	3	4	4	Depresion	EMP0000669	2014-02
670	1	2	4	4	Burnout	EMP0000670	2004-01
671	3	4	1	2	Burnout	EMP0000671	2017-02
672	3	4	1	5	Depresion	EMP0000672	2024-02
673	1	4	2	3	Burnout	EMP0000673	2008-02
674	4	3	4	4	Saludable	EMP0000674	2003-02
675	4	1	3	1	Depresion	EMP0000675	2020-01
676	2	3	5	4	Saludable	EMP0000676	2007-01
677	3	2	4	4	Depresion	EMP0000677	2006-01
678	5	1	1	5	Depresion	EMP0000678	2017-01
679	5	2	2	5	Ansiedad	EMP0000679	2024-02
680	2	1	2	1	Depresion	EMP0000680	2015-02
681	3	4	2	1	Burnout	EMP0000681	2009-02
682	2	3	2	4	Ansiedad	EMP0000682	2012-01
683	3	3	5	1	Burnout	EMP0000683	2003-02
684	3	3	3	3	Saludable	EMP0000684	2021-02
685	1	4	3	2	Saludable	EMP0000685	2002-02
686	4	1	3	4	Depresion	EMP0000686	2017-02
687	4	3	3	2	Burnout	EMP0000687	2011-01
688	1	5	2	5	Saludable	EMP0000688	2008-01
689	4	4	3	5	Saludable	EMP0000689	2011-01
690	1	1	1	3	Saludable	EMP0000690	2002-01
691	5	1	3	3	Burnout	EMP0000691	2013-01
692	2	4	3	4	Burnout	EMP0000692	2015-01
693	2	5	3	4	Ansiedad	EMP0000693	2011-02
694	5	4	1	1	Saludable	EMP0000694	2013-01
695	3	2	2	5	Saludable	EMP0000695	2000-01
696	4	2	2	1	Saludable	EMP0000696	2002-02
697	5	4	2	3	Saludable	EMP0000697	2018-01
698	2	2	1	1	Ansiedad	EMP0000698	2014-02
699	2	2	2	4	Depresion	EMP0000699	2013-01
700	5	4	4	3	Depresion	EMP0000700	2014-02
701	3	4	3	2	Saludable	EMP0000701	2005-01
702	1	2	4	3	Saludable	EMP0000702	2017-02
703	4	4	3	2	Saludable	EMP0000703	2024-02
704	4	5	4	5	Depresion	EMP0000704	2005-01
705	4	1	3	3	Burnout	EMP0000705	2001-02
706	4	2	2	5	Ansiedad	EMP0000706	2024-02
707	3	1	2	5	Depresion	EMP0000707	2012-01
708	3	4	4	1	Depresion	EMP0000708	2017-02
709	4	2	2	5	Depresion	EMP0000709	2011-02
710	2	5	2	2	Depresion	EMP0000710	2005-02
711	4	3	1	3	Depresion	EMP0000711	2024-02
712	3	5	5	1	Burnout	EMP0000712	2007-02
713	2	3	3	5	Depresion	EMP0000713	2005-02
714	1	2	3	2	Depresion	EMP0000714	2013-02
715	3	1	1	3	Burnout	EMP0000715	2006-02
716	2	5	2	3	Burnout	EMP0000716	2006-01
717	4	5	1	1	Ansiedad	EMP0000717	2007-02
718	1	5	4	4	Ansiedad	EMP0000718	2008-02
719	3	1	2	1	Burnout	EMP0000719	2019-02
720	2	2	1	2	Burnout	EMP0000720	2008-02
721	5	2	2	5	Saludable	EMP0000721	2001-01
722	2	2	4	5	Depresion	EMP0000722	2013-01
723	1	2	3	3	Saludable	EMP0000723	2007-01
724	2	1	3	4	Depresion	EMP0000724	2022-02
725	1	5	2	1	Ansiedad	EMP0000725	2008-02
726	3	4	5	2	Saludable	EMP0000726	2017-01
727	4	2	1	1	Saludable	EMP0000727	2001-01
728	2	4	3	5	Burnout	EMP0000728	2020-01
729	2	1	5	3	Burnout	EMP0000729	2019-01
730	2	5	1	2	Saludable	EMP0000730	2004-02
731	2	4	3	4	Ansiedad	EMP0000731	2005-02
732	3	5	3	5	Saludable	EMP0000732	2011-02
733	2	2	4	1	Burnout	EMP0000733	2008-01
734	4	1	5	1	Ansiedad	EMP0000734	2023-02
735	3	2	1	5	Ansiedad	EMP0000735	2007-02
736	1	1	4	4	Saludable	EMP0000736	2009-01
737	2	4	4	5	Ansiedad	EMP0000737	2016-01
738	5	2	4	4	Ansiedad	EMP0000738	2007-02
739	1	2	3	4	Saludable	EMP0000739	2012-02
740	4	1	5	1	Ansiedad	EMP0000740	2013-02
741	4	2	5	5	Saludable	EMP0000741	2000-01
742	3	3	3	4	Ansiedad	EMP0000742	2022-02
743	2	4	2	2	Burnout	EMP0000743	2009-02
744	5	3	3	5	Burnout	EMP0000744	2010-01
745	5	3	2	1	Saludable	EMP0000745	2002-01
746	4	3	2	2	Saludable	EMP0000746	2011-01
747	3	3	5	1	Ansiedad	EMP0000747	2013-02
748	5	2	4	2	Ansiedad	EMP0000748	2016-01
749	1	2	3	4	Burnout	EMP0000749	2009-01
750	3	1	4	5	Saludable	EMP0000750	2003-02
751	3	3	1	1	Depresion	EMP0000751	2006-02
752	3	3	3	5	Ansiedad	EMP0000752	2012-01
753	3	5	5	4	Burnout	EMP0000753	2014-01
754	1	4	5	2	Ansiedad	EMP0000754	2020-02
755	2	3	3	2	Ansiedad	EMP0000755	2003-02
756	2	4	3	2	Burnout	EMP0000756	2001-02
757	5	5	5	3	Saludable	EMP0000757	2020-01
758	2	3	4	5	Depresion	EMP0000758	2020-02
759	5	3	3	3	Saludable	EMP0000759	2014-01
760	4	3	1	4	Depresion	EMP0000760	2009-02
761	5	4	1	4	Depresion	EMP0000761	2001-01
762	2	3	3	2	Depresion	EMP0000762	2010-01
763	3	1	5	5	Saludable	EMP0000763	2022-01
764	2	4	2	4	Ansiedad	EMP0000764	2003-01
765	3	2	5	5	Depresion	EMP0000765	2024-02
766	2	2	4	3	Ansiedad	EMP0000766	2009-01
767	4	3	4	3	Depresion	EMP0000767	2023-01
768	5	4	5	4	Depresion	EMP0000768	2012-02
769	1	2	5	2	Burnout	EMP0000769	2017-02
770	1	1	5	2	Ansiedad	EMP0000770	2017-02
771	5	3	3	4	Depresion	EMP0000771	2018-01
772	2	1	4	4	Ansiedad	EMP0000772	2000-01
773	3	4	1	3	Depresion	EMP0000773	2002-01
774	3	1	5	3	Burnout	EMP0000774	2005-01
775	4	5	5	4	Depresion	EMP0000775	2017-02
776	5	2	2	3	Burnout	EMP0000776	2004-01
777	4	4	4	2	Saludable	EMP0000777	2002-01
778	3	2	2	2	Depresion	EMP0000778	2003-01
779	3	5	2	2	Depresion	EMP0000779	2020-01
780	4	2	1	3	Saludable	EMP0000780	2021-02
781	1	3	5	4	Burnout	EMP0000781	2017-02
782	5	5	1	3	Burnout	EMP0000782	2021-02
783	2	3	5	4	Ansiedad	EMP0000783	2020-01
784	5	5	4	5	Saludable	EMP0000784	2003-01
785	2	5	4	2	Ansiedad	EMP0000785	2005-01
786	2	3	5	2	Depresion	EMP0000786	2021-02
787	3	2	5	3	Ansiedad	EMP0000787	2007-01
788	1	1	2	5	Ansiedad	EMP0000788	2005-02
789	4	2	4	1	Ansiedad	EMP0000789	2003-02
790	1	1	4	2	Saludable	EMP0000790	2020-02
791	2	3	5	2	Depresion	EMP0000791	2021-01
792	4	3	1	5	Depresion	EMP0000792	2016-01
793	5	3	1	4	Ansiedad	EMP0000793	2018-02
794	3	3	3	3	Ansiedad	EMP0000794	2006-02
795	1	3	4	4	Ansiedad	EMP0000795	2001-02
796	4	3	4	1	Depresion	EMP0000796	2000-01
797	2	1	2	5	Ansiedad	EMP0000797	2008-02
798	4	3	4	5	Burnout	EMP0000798	2020-01
799	4	4	1	3	Depresion	EMP0000799	2007-02
800	5	3	1	1	Ansiedad	EMP0000800	2010-02
801	5	5	5	4	Ansiedad	EMP0000801	2023-01
802	3	3	5	5	Saludable	EMP0000802	2009-02
803	5	4	5	4	Saludable	EMP0000803	2004-02
804	1	5	4	5	Burnout	EMP0000804	2012-01
805	1	4	2	3	Burnout	EMP0000805	2020-02
806	3	1	3	2	Depresion	EMP0000806	2024-01
807	2	5	1	3	Ansiedad	EMP0000807	2011-02
808	2	2	5	4	Saludable	EMP0000808	2020-02
809	4	5	2	3	Ansiedad	EMP0000809	2000-01
810	1	2	2	5	Ansiedad	EMP0000810	2010-01
811	1	1	1	3	Burnout	EMP0000811	2011-01
812	2	1	4	1	Ansiedad	EMP0000812	2024-01
813	5	3	2	3	Burnout	EMP0000813	2003-01
814	4	3	4	2	Burnout	EMP0000814	2016-01
815	4	2	4	5	Depresion	EMP0000815	2010-01
816	3	2	3	3	Burnout	EMP0000816	2015-01
817	3	3	4	1	Saludable	EMP0000817	2013-02
818	4	1	3	3	Ansiedad	EMP0000818	2015-02
819	2	3	3	3	Burnout	EMP0000819	2022-02
820	5	3	5	1	Ansiedad	EMP0000820	2024-02
821	4	3	4	5	Burnout	EMP0000821	2012-01
822	1	3	3	2	Burnout	EMP0000822	2011-02
823	3	1	1	3	Depresion	EMP0000823	2005-02
824	4	3	1	4	Depresion	EMP0000824	2009-01
825	3	1	5	1	Burnout	EMP0000825	2006-01
826	2	4	1	3	Ansiedad	EMP0000826	2005-01
827	4	5	5	1	Ansiedad	EMP0000827	2006-01
828	3	1	1	2	Saludable	EMP0000828	2014-02
829	2	5	5	4	Saludable	EMP0000829	2014-01
830	4	2	5	2	Ansiedad	EMP0000830	2018-01
831	3	4	1	3	Depresion	EMP0000831	2013-02
832	5	3	5	5	Depresion	EMP0000832	2018-02
833	2	2	2	5	Burnout	EMP0000833	2007-02
834	2	1	4	4	Ansiedad	EMP0000834	2021-02
835	1	5	5	1	Burnout	EMP0000835	2016-02
836	2	1	4	5	Saludable	EMP0000836	2008-01
837	4	5	5	4	Burnout	EMP0000837	2022-02
838	3	4	4	5	Depresion	EMP0000838	2021-02
839	4	1	3	3	Depresion	EMP0000839	2023-02
840	4	1	4	3	Burnout	EMP0000840	2018-01
841	1	4	3	4	Ansiedad	EMP0000841	2006-01
842	2	5	4	4	Depresion	EMP0000842	2019-02
843	1	5	3	5	Burnout	EMP0000843	2016-02
844	5	3	4	5	Depresion	EMP0000844	2023-02
845	2	4	5	4	Ansiedad	EMP0000845	2001-02
846	1	2	4	1	Saludable	EMP0000846	2000-02
847	2	1	3	5	Burnout	EMP0000847	2017-02
848	3	5	4	2	Depresion	EMP0000848	2006-01
849	4	1	3	1	Ansiedad	EMP0000849	2002-01
850	5	3	5	4	Ansiedad	EMP0000850	2011-01
851	2	3	4	1	Burnout	EMP0000851	2006-02
852	1	1	3	4	Burnout	EMP0000852	2012-01
853	2	3	4	5	Ansiedad	EMP0000853	2021-01
854	1	5	2	4	Saludable	EMP0000854	2009-02
855	4	2	5	5	Burnout	EMP0000855	2020-02
856	1	1	2	3	Burnout	EMP0000856	2005-02
857	2	1	1	3	Burnout	EMP0000857	2017-01
858	3	1	5	2	Burnout	EMP0000858	2017-02
859	3	4	3	5	Saludable	EMP0000859	2008-01
860	3	5	5	4	Ansiedad	EMP0000860	2008-01
861	4	3	5	1	Saludable	EMP0000861	2011-01
862	1	2	1	5	Saludable	EMP0000862	2006-02
863	3	5	2	4	Ansiedad	EMP0000863	2014-02
864	3	4	3	5	Burnout	EMP0000864	2010-02
865	1	5	2	5	Saludable	EMP0000865	2018-02
866	5	5	4	4	Depresion	EMP0000866	2001-02
867	2	4	1	3	Ansiedad	EMP0000867	2024-01
868	1	5	5	4	Saludable	EMP0000868	2006-01
869	1	3	1	4	Ansiedad	EMP0000869	2002-01
870	1	2	3	3	Saludable	EMP0000870	2009-01
871	3	4	5	2	Burnout	EMP0000871	2009-01
872	1	4	3	1	Ansiedad	EMP0000872	2001-02
873	3	2	3	4	Burnout	EMP0000873	2008-01
874	5	2	1	1	Depresion	EMP0000874	2001-01
875	4	5	4	5	Ansiedad	EMP0000875	2019-01
876	4	5	3	1	Burnout	EMP0000876	2011-01
877	1	1	2	4	Depresion	EMP0000877	2015-02
878	5	4	3	2	Burnout	EMP0000878	2023-02
879	5	3	4	2	Depresion	EMP0000879	2001-01
880	1	4	2	1	Burnout	EMP0000880	2010-02
881	5	2	3	5	Burnout	EMP0000881	2007-01
882	3	2	2	5	Depresion	EMP0000882	2015-02
883	5	2	4	2	Depresion	EMP0000883	2005-02
884	3	4	5	1	Burnout	EMP0000884	2006-01
885	4	2	3	5	Saludable	EMP0000885	2010-02
886	2	3	5	2	Saludable	EMP0000886	2002-01
887	5	2	4	1	Burnout	EMP0000887	2004-01
888	1	3	5	1	Saludable	EMP0000888	2001-02
889	2	1	5	2	Depresion	EMP0000889	2008-01
890	1	3	5	1	Ansiedad	EMP0000890	2002-02
891	3	5	4	4	Ansiedad	EMP0000891	2010-01
892	4	1	4	1	Depresion	EMP0000892	2006-02
893	3	3	3	4	Depresion	EMP0000893	2018-01
894	5	4	3	1	Depresion	EMP0000894	2006-02
895	1	1	4	4	Saludable	EMP0000895	2002-01
896	3	5	4	1	Depresion	EMP0000896	2018-01
897	4	2	5	5	Depresion	EMP0000897	2000-02
898	2	3	3	2	Saludable	EMP0000898	2016-02
899	1	5	3	3	Saludable	EMP0000899	2017-02
900	4	4	2	1	Ansiedad	EMP0000900	2007-01
901	1	2	5	5	Depresion	EMP0000901	2024-02
902	1	4	3	4	Ansiedad	EMP0000902	2022-02
903	5	4	2	1	Saludable	EMP0000903	2024-02
904	3	5	3	3	Burnout	EMP0000904	2016-01
905	3	1	4	5	Ansiedad	EMP0000905	2018-02
906	2	2	2	1	Depresion	EMP0000906	2014-02
907	5	1	5	4	Burnout	EMP0000907	2017-01
908	3	3	2	2	Ansiedad	EMP0000908	2012-02
909	2	3	5	1	Depresion	EMP0000909	2013-01
910	3	5	4	3	Ansiedad	EMP0000910	2019-01
911	4	2	2	3	Ansiedad	EMP0000911	2007-01
912	3	4	3	2	Burnout	EMP0000912	2000-01
913	3	5	5	1	Ansiedad	EMP0000913	2018-02
914	3	3	4	2	Burnout	EMP0000914	2018-01
915	3	4	1	3	Ansiedad	EMP0000915	2002-02
916	1	2	1	5	Burnout	EMP0000916	2015-02
917	1	2	1	2	Ansiedad	EMP0000917	2016-01
918	1	1	2	5	Depresion	EMP0000918	2023-01
919	4	3	1	4	Burnout	EMP0000919	2006-02
920	3	5	4	3	Ansiedad	EMP0000920	2022-01
921	1	5	2	4	Saludable	EMP0000921	2014-01
922	4	2	5	5	Ansiedad	EMP0000922	2002-01
923	4	1	2	4	Ansiedad	EMP0000923	2010-02
924	5	1	1	1	Burnout	EMP0000924	2016-02
925	3	4	5	1	Burnout	EMP0000925	2005-01
926	2	4	1	4	Burnout	EMP0000926	2022-02
927	4	4	5	2	Burnout	EMP0000927	2019-02
928	2	3	5	4	Saludable	EMP0000928	2018-01
929	1	2	3	3	Ansiedad	EMP0000929	2017-02
930	3	2	3	3	Burnout	EMP0000930	2013-01
931	3	2	5	4	Saludable	EMP0000931	2009-01
932	4	3	5	1	Burnout	EMP0000932	2009-01
933	1	5	1	3	Ansiedad	EMP0000933	2009-01
934	4	3	4	4	Burnout	EMP0000934	2016-02
935	1	5	3	4	Depresion	EMP0000935	2001-02
936	4	2	1	5	Depresion	EMP0000936	2012-01
937	4	5	1	4	Ansiedad	EMP0000937	2012-01
938	3	1	1	5	Ansiedad	EMP0000938	2019-02
939	3	1	4	5	Saludable	EMP0000939	2020-01
940	5	2	4	2	Burnout	EMP0000940	2003-01
941	5	5	4	5	Ansiedad	EMP0000941	2003-02
942	5	5	4	3	Burnout	EMP0000942	2019-01
943	4	5	3	3	Burnout	EMP0000943	2015-01
944	4	2	5	2	Depresion	EMP0000944	2002-01
945	1	3	5	1	Depresion	EMP0000945	2004-01
946	3	2	5	5	Saludable	EMP0000946	2008-02
947	2	4	2	1	Ansiedad	EMP0000947	2006-01
948	3	5	5	1	Ansiedad	EMP0000948	2018-02
949	5	2	1	3	Ansiedad	EMP0000949	2024-02
950	4	3	5	4	Burnout	EMP0000950	2003-01
951	2	5	5	3	Burnout	EMP0000951	2020-02
952	5	3	5	1	Burnout	EMP0000952	2007-01
953	4	4	1	3	Saludable	EMP0000953	2014-02
954	1	3	4	1	Ansiedad	EMP0000954	2020-01
955	3	5	4	3	Burnout	EMP0000955	2006-01
956	2	4	1	2	Depresion	EMP0000956	2023-02
957	4	4	5	2	Ansiedad	EMP0000957	2023-02
958	4	4	5	4	Burnout	EMP0000958	2001-02
959	2	1	5	3	Saludable	EMP0000959	2003-01
960	3	3	3	5	Burnout	EMP0000960	2022-01
961	4	2	1	4	Saludable	EMP0000961	2001-02
962	5	3	4	1	Depresion	EMP0000962	2020-02
963	1	4	2	1	Ansiedad	EMP0000963	2014-02
964	5	5	2	2	Burnout	EMP0000964	2016-01
965	5	1	1	4	Ansiedad	EMP0000965	2021-02
966	5	4	4	1	Depresion	EMP0000966	2022-01
967	2	1	3	4	Depresion	EMP0000967	2004-01
968	1	5	2	4	Burnout	EMP0000968	2023-02
969	4	3	3	1	Ansiedad	EMP0000969	2007-02
970	5	1	2	1	Burnout	EMP0000970	2020-02
971	3	1	3	3	Depresion	EMP0000971	2021-02
972	5	4	5	2	Ansiedad	EMP0000972	2011-02
973	5	3	1	5	Burnout	EMP0000973	2020-01
974	1	4	5	5	Saludable	EMP0000974	2011-02
975	4	5	1	5	Ansiedad	EMP0000975	2013-02
976	5	3	3	1	Burnout	EMP0000976	2009-01
977	2	3	4	2	Ansiedad	EMP0000977	2000-01
978	4	1	4	5	Burnout	EMP0000978	2009-02
979	3	2	1	2	Saludable	EMP0000979	2017-02
980	1	2	2	5	Saludable	EMP0000980	2013-01
981	4	2	3	3	Saludable	EMP0000981	2012-01
982	2	4	4	4	Depresion	EMP0000982	2021-01
983	3	4	5	3	Depresion	EMP0000983	2003-02
984	5	2	4	1	Burnout	EMP0000984	2008-02
985	4	4	4	5	Ansiedad	EMP0000985	2017-01
986	3	2	4	1	Saludable	EMP0000986	2020-02
987	2	1	5	1	Depresion	EMP0000987	2017-01
988	1	5	1	5	Depresion	EMP0000988	2003-02
989	4	1	5	5	Depresion	EMP0000989	2017-02
990	3	5	3	2	Ansiedad	EMP0000990	2013-02
991	2	2	5	4	Ansiedad	EMP0000991	2017-01
992	2	1	4	4	Saludable	EMP0000992	2010-01
993	5	2	2	2	Ansiedad	EMP0000993	2019-02
994	1	4	5	3	Ansiedad	EMP0000994	2001-01
995	2	4	1	4	Burnout	EMP0000995	2017-02
996	5	5	5	1	Depresion	EMP0000996	2000-01
997	1	3	3	5	Saludable	EMP0000997	2003-01
998	5	4	1	4	Saludable	EMP0000998	2004-01
999	2	1	5	3	Burnout	EMP0000999	2014-01
1000	2	4	4	3	Depresion	EMP0001000	2005-02
\.


--
-- Name: edesempenio_codigo_seq; Type: SEQUENCE SET; Schema: public; Owner: dianasanchezordonez
--

SELECT pg_catalog.setval('public.edesempenio_codigo_seq', 1000, true);


--
-- Name: saludmental_codigo_seq; Type: SEQUENCE SET; Schema: public; Owner: dianasanchezordonez
--

SELECT pg_catalog.setval('public.saludmental_codigo_seq', 1000, true);


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
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

