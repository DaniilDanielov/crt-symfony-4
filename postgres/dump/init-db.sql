--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--





--
-- Roles
--

CREATE ROLE "user";
ALTER ROLE "user" WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:ZfNDFj5sN99gJ15mntCx1Q==$WlUbcDnjMcb0jEAMsjDXZMviDRic5Tx7Bi2PM4ZjtWM=:Z30lOm20aCdzVM2FTYHAeZpTKfduIbTXmD04DdP2U00=';






--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: user
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO "user";

\connect template1

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: user
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: user
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: user
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: user
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO "user";

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: user
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- Name: notify_messenger_messages(); Type: FUNCTION; Schema: public; Owner: user
--

CREATE FUNCTION public.notify_messenger_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
            BEGIN
                PERFORM pg_notify('messenger_messages', NEW.queue_name::text);
                RETURN NEW;
            END;
        $$;


ALTER FUNCTION public.notify_messenger_messages() OWNER TO "user";

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: basket; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.basket (
    id integer NOT NULL,
    item_id integer NOT NULL,
    session_id character varying(255) NOT NULL,
    count integer NOT NULL
);


ALTER TABLE public.basket OWNER TO "user";

--
-- Name: basket_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.basket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basket_id_seq OWNER TO "user";

--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


ALTER TABLE public.doctrine_migration_versions OWNER TO "user";

--
-- Name: messenger_messages; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.messenger_messages (
    id bigint NOT NULL,
    body text NOT NULL,
    headers text NOT NULL,
    queue_name character varying(255) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    available_at timestamp(0) without time zone NOT NULL,
    delivered_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.messenger_messages OWNER TO "user";

--
-- Name: messenger_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.messenger_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messenger_messages_id_seq OWNER TO "user";

--
-- Name: messenger_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE public.messenger_messages_id_seq OWNED BY public.messenger_messages.id;


--
-- Name: order; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public."order" (
    id integer NOT NULL,
    session_id character varying(255) NOT NULL,
    status integer NOT NULL,
    username character varying(255) NOT NULL,
    user_phone character varying(255) NOT NULL,
    user_address character varying(255) NOT NULL
);


ALTER TABLE public."order" OWNER TO "user";

--
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_id_seq OWNER TO "user";

--
-- Name: pizzas; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.pizzas (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    image character varying(255) DEFAULT NULL::character varying,
    updated_at timestamp(0) without time zone NOT NULL,
    price integer
);


ALTER TABLE public.pizzas OWNER TO "user";

--
-- Name: pizzas_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.pizzas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pizzas_id_seq OWNER TO "user";

--
-- Name: user; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying(180) NOT NULL,
    roles json NOT NULL,
    password character varying(255) NOT NULL,
    user_full_name character varying(255) DEFAULT NULL::character varying,
    user_phone character varying(255) DEFAULT NULL::character varying,
    user_address character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public."user" OWNER TO "user";

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO "user";

--
-- Name: messenger_messages id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.messenger_messages ALTER COLUMN id SET DEFAULT nextval('public.messenger_messages_id_seq'::regclass);


--
-- Data for Name: basket; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.basket (id, item_id, session_id, count) FROM stdin;
136	1	0ab64a39370e9164ac1ca4c707d11292	4
117	1	13200d9c006852050b1710794f69e76a	5
137	1	7f5a81ca3bc8c3f7aceaf4c207903b40	1
138	1	32e23c1719151697c18c12f4c78b41df	1
139	1	4be673e6e1a2db27343438bc80bf2da4	7
140	1	a9caae112af12349031d7b0d2ecdef7f	1
118	1	a4b279168755ecfea04e206a78221559	13
119	1	ba2d07cf9e9ae6b857ffaaf1a8200898	1
82	1	c1e8a4b6e480c8fa98c09e5747ad7b3f	3
83	4	c1e8a4b6e480c8fa98c09e5747ad7b3f	2
120	1	a3491e361152ea24fd712405bb454058	2
84	1	1d24265b53533beea2d9a2bfe1913813	3
121	1	747e09b7f47dd6323a93a1608df2a271	1
122	1	07e132ca9abacac11e9e9929177a257a	1
86	4	0ea3bba5fd8803c64d63a35002a261a7	1
85	1	0ea3bba5fd8803c64d63a35002a261a7	2
141	1	67e5a13bcdf3378c8260fa5a205ee84c	3
142	4	67e5a13bcdf3378c8260fa5a205ee84c	2
143	10	67e5a13bcdf3378c8260fa5a205ee84c	1
87	1	5def436211c605d0257c16ee1a0d5db5	8
144	1	cde0fa1f94a380cabc11bf29958e56b2	3
145	1	f7f80257f1a6f0be77642bee79df665a	2
146	5	f7f80257f1a6f0be77642bee79df665a	1
88	6	5def436211c605d0257c16ee1a0d5db5	4
147	4	ff7e96478cc9869510d089718709bd5d	2
89	6	1a7b2ed28de25c48d599ab3c09971f8a	2
90	6	8d7af6ab32d669aa47d716f92c637a01	1
91	6	e56afd112181bf3220ff6203b6b7401a	1
92	7	e56afd112181bf3220ff6203b6b7401a	1
148	1	ff7e96478cc9869510d089718709bd5d	1
149	1	6bf5183ed4716e92bdc77f00d9e357e8	1
150	1	f32260870cc4bbf7fdce5b8f3f6ed9d2	1
123	1	99e9cb25e293d15f968a725508e2072c	12
93	6	9541bcffe084b449da2217f8d782694c	7
94	7	9541bcffe084b449da2217f8d782694c	1
124	1	9acbe0f8af28179a879b292a9720ab6e	2
151	1	f373e639a4f314fb5b0b65da3b418725	1
96	9	030bc42cde7b284760123d20dbdf8abd	2
95	6	030bc42cde7b284760123d20dbdf8abd	5
97	6	1ff8a8a4ea5efa5807692bbe57cf8b92	1
98	7	1ff8a8a4ea5efa5807692bbe57cf8b92	1
99	6	1589321197069c677c51b91bd86ac7c9	1
100	6	853f08070aa4eca711c5a825d80418c3	1
101	6	de5d175ddcfaa5a85523b133f613f899	1
102	6	e67aaf4dcfa2ed7988142c72fc04c72d	1
103	6	15f043f547347acccd59b1db52924675	1
104	6	1685dee4a01f6b23b629534f14c46014	1
105	6	1191afdaca0959cf0e28ff276f71c155	1
125	1	f318ad4e8e50d81ad4c1cb3b0b2d7a41	3
106	6	b5b82b34515c11b7f89edd839d506cab	1
107	6	c3a19c3c6e165ede0ac4dc7ee345b4d6	1
108	6	d199e6ca85fb3a34a2ec82c659d0f7d5	1
109	6	c427ae4de3ec1a0f2cb0d924f7a264d8	1
110	6	faef6d68ad5346097100791b1fa41a02	1
111	7	faef6d68ad5346097100791b1fa41a02	1
112	6	42c0ff7a42b2373c4a6fa9afbdea6eef	1
113	3	42c0ff7a42b2373c4a6fa9afbdea6eef	2
114	6	ea452089f50a3c619a6fd543e0029a2d	1
115	6	92864cd3d291708f05bf665427db1bda	1
126	4	f318ad4e8e50d81ad4c1cb3b0b2d7a41	1
116	6	d16656047380d0c1c420d52e69e8c3cf	3
127	1	63d2936ab6854e9d4d9595fd7d88eb20	2
128	1	32cff94c9ef95a1b317fa81db471f09e	1
129	1	5fc6f60d49031277a914c3965177956a	1
152	1	cd95d8f937abd2de7bacc406eeea7908	1
153	1	a913ee8a4e54790b7b2c6dba755aa6c9	1
130	1	5a12d70a6e085adfb4e6cbf437f299cd	4
131	1	6f45e122c91ab629c1fdcb27f5b9a2ea	2
132	1	843100ddd8697cf39efbdd9957c8b09f	1
133	4	843100ddd8697cf39efbdd9957c8b09f	1
134	1	1487bd05ae95cb5de9b3903adadf4caf	1
135	1	00b2c9c55a4f2121aac32f5a080b4d45	1
154	1	cc2d13b104307ce0872e5436483551ac	2
155	1	6290c13118aa9889f37c865ec2ae11e4	1
156	1	75b84343aa9317958fd7a7be12f5b5be	1
157	1	0db0545e48215ad80122cabd4173756a	1
158	1	c308f649f7c81c146bcf0d9369e3ad31	1
159	1	9fed2db52fd731585fb2b2ea44959d58	1
\.


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20211218053747	2021-12-18 05:38:13	99
DoctrineMigrations\\Version20211218074155	2021-12-18 07:42:26	172
DoctrineMigrations\\Version20211218102551	2021-12-18 10:26:25	30
DoctrineMigrations\\Version20211218110459	2021-12-18 11:05:33	177
DoctrineMigrations\\Version20211218185454	2021-12-18 18:55:02	33
DoctrineMigrations\\Version20211222201630	2021-12-22 20:16:35	375
\.


--
-- Data for Name: messenger_messages; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.messenger_messages (id, body, headers, queue_name, created_at, available_at, delivered_at) FROM stdin;
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public."order" (id, session_id, status, username, user_phone, user_address) FROM stdin;
24	443f9729eb88415ea707e7babf225b00	1	321132	1231461030	ул Некрасова д.10
26	f3866ce7ade92b8c27b90a1b3ed780a3	1	Павел	1231461030	ул Некрасова д.10
27	d160aec5f914aa04cea9c9c194de61b0	1	Павел	1231461030	ул Некрасова д.10
28	5e511444f2fe4f1026ce4a51bedd0f0e	1	Павел	1231461030	ул Некрасова д.10
29	c1dafd6859b1268b87e5daf9254e2606	1	Павел	1231461030	ул Некрасова д.10
30	8d7af6ab32d669aa47d716f92c637a01	1	Павел	89784564531	dfg
31	d6aa516c26b57370ff915710ba5ea2d7	1	Павел	1231461030	ул Некрасова д.10
32	c6bac5b84615dd1b5e32ee39820e95b6	1	231	1231461030	dfg
33	7cc502c513ad0e477ba2f8e8cdeefd61	1	231	2342345	dfg
34	382d7bc8bbc09b4f7113eb8cd3729425	1	Павел	1231461030	ул Некрасова д.10
35	243a03c7169b54114b0746ea3ebefd52	1	asdasd	3434534345	asdasd
36	c8e7da376f40be996fc1a43df29bd879	1	Павел	123	ул Некрасова д.10
37	b8ef5b844096794d7883e58f6c412a23	1	Павел	123	asdfsdf
38	0630abd93c5c1351245a5df88fd94e1f	1	Павел	123	asd
39	77ddbbef7dd6e48abe500fbb87b7cc4a	1	Павел	1231461030	ул Некрасова д.10
40	48ebbaf71a83c54dd49d7d93d0bfe889	1	Павел	1231461030	ул Некрасова д.10
41	08ae20918616fa100e78a5eee5146372	1	Павел	1231461030	ул Некрасова д.10
42	a1d591547bcff4f43cbbd19713275e98	1	Павел	1231461030	ул Некрасова д.10
43	80fe18ff1a1f807fdb310a31382e7a82	1	Павел	1231461030	ул Некрасова д.10
44	019c9a535511b7c87811129f3a4491f4	1	Павел	1231461030	ул Некрасова д.10
45	019c9a535511b7c87811129f3a4491f4	1	Павел	1231461030	ул Некрасова д.10
46	019c9a535511b7c87811129f3a4491f4	1	Павел	1231461030	ул Некрасова д.10
47	c4cc16f243e3fa73ec6fbe099e8f7992	1	Павел	1231461030	ул Некрасова д.10
48	9f133979a21498e06eb3167c343c1cd8	1	Павел121	1231461030	ул Некрасова д.10
49	9228b87f9f8885ac944b4390038cf6b3	1	231	1231461030	ул Некрасова д.10
50	235437f035ce68e859713c313ba22d73	1	231	1231461030	ул Некрасова д.10
51	d2f8a08470da603ae3cc75f6f6fb5f2b	1	Павел	1231461030	ул Некрасова д.10
52	e8b17f6c2dc5c038cf88bbf1226b938e	1	Павел	1231461030	ул Некрасова д.10
53	f9c7699726a555cbbf34924677acdfcf	1	Павел	1231461030	ул Некрасова д.10
54	70bb81a769a95f6ba881c5740e4bb8b7	1	Павел	1231461030	ул Некрасова д.10
55	84d8fe3f7d50f1d12b21e02df99ff326	1	Павел	1231461030	ул Некрасова д.10
56	5530556919202aaec29ca16ffed1fda5	1	Павел	1231461030	ул Некрасова д.10
57	f096ee0f2413ed9a36113b52207b808b	1	Павел	1231461030	ул Некрасова д.10
58	69ae89803da88b7cf0395c51a47ab351	1	Павел	21321	ул Некрасова д.10
59	1d9ff38c4e0e1e5da84ef30e22c5c56f	1	Павел	65456	ул Некрасова д.10
60	e56afd112181bf3220ff6203b6b7401a	1	Павел	1231461030	ул Некрасова д.10
61	716b03719ee42c352404ad2689d22d03	1	Павел	1231461030	ул Некрасова д.10
62	aec61c53a438e53b82d224d136b476d7	1	Павел	1231461030	ул Некрасова д.10
63	57124c52b65e5dfe9b6ec633416fea09	1	Павел	1231461030	ул Некрасова д.10
64	141e0b348474dd8ad5b06fd5e537d2cb	1	Павел	1231461030	ул Некрасова д.10
65	15093107ec63fe52e2884a61b1133a01	1	Павел	1231461030	ул Некрасова д.10
66	9541bcffe084b449da2217f8d782694c	1	Павел	1231461030	ул Некрасова д.10
67	030bc42cde7b284760123d20dbdf8abd	1	Павел	1231461030	ул Некрасова д.10
68	1ff8a8a4ea5efa5807692bbe57cf8b92	1	Gtnz	1231461030	ул Некрасова д.10
69	1589321197069c677c51b91bd86ac7c9	1	Катя	89199264028	ул Некрасова д.10
70	853f08070aa4eca711c5a825d80418c3	1	Павел	1231461030	ул Некрасова д.10
71	de5d175ddcfaa5a85523b133f613f899	1	Павел	1231461030	ул Некрасова д.10
72	c427ae4de3ec1a0f2cb0d924f7a264d8	1	Павел	1231461030	ул Некрасова д.10
73	faef6d68ad5346097100791b1fa41a02	1	Павел	1231461030	ул Некрасова д.10
74	42c0ff7a42b2373c4a6fa9afbdea6eef	1	Павел	1231461030	ул Некрасова д.10
75	ea452089f50a3c619a6fd543e0029a2d	1	Павел	1231461030	ул Некрасова д.10
76	92864cd3d291708f05bf665427db1bda	1	Павел	1231461030	ул Некрасова д.10
77	d16656047380d0c1c420d52e69e8c3cf	1	Павел	1231461030	ул Некрасова д.10
78	13200d9c006852050b1710794f69e76a	1	Павел	1231461030	ул Некрасова д.10
79	a4b279168755ecfea04e206a78221559	1	Павел	1231461030	ул Некрасова д.10
80	ba2d07cf9e9ae6b857ffaaf1a8200898	1	Павел	1231461030	ул Некрасова д.10
81	7e81c2d721cd7a801baafbd5cce27601	1	Павел	1231461030	ул Некрасова д.10
82	b2c681a3511bda5fe8ef9960fc1617ba	1	Павел	1231461030	ул Некрасова д.10
83	a3cfaba813d1fe87c1f7d549d5d83896	1	Павел	1231461030	ул Некрасова д.10
84	97e63c66f2c18466b128607faca02846	1	Павел	1231461030	ул Некрасова д.10
85	56f8b9919d8e26b521b458866684a400	1	Павел	1231461030	ул Некрасова д.10
86	a3491e361152ea24fd712405bb454058	1	Павел	1231461030	ул Некрасова д.10
87	747e09b7f47dd6323a93a1608df2a271	1	Павел	1231461030	ул Некрасова д.10
88	07e132ca9abacac11e9e9929177a257a	1	Павел	1231461030	ул Некрасова д.10
89	96442af3d748cee5751341c7557c2650	1	Павел	1231461030	ул Некрасова д.10
90	cf6fc14696636a96892763a102ffe640	1	Павел	1231461030	ул Некрасова д.10
91	99e9cb25e293d15f968a725508e2072c	1	Павел	21321	ул Некрасова д.10
92	9acbe0f8af28179a879b292a9720ab6e	1	Павел	1231461030	10
93	f318ad4e8e50d81ad4c1cb3b0b2d7a41	1	Павел	1231461030	asdasd
94	63d2936ab6854e9d4d9595fd7d88eb20	1	Павел	531	ул Некрасова д.10
95	32cff94c9ef95a1b317fa81db471f09e	1	Павел	1231461030	dfg
96	5fc6f60d49031277a914c3965177956a	1	Павел	1231461030	ул Некрасова д.10
97	5a12d70a6e085adfb4e6cbf437f299cd	1	Павел	1231461030	ул Некрасова д.10
98	6f45e122c91ab629c1fdcb27f5b9a2ea	1	Павел	1231461030	ул Некрасова д.10
99	843100ddd8697cf39efbdd9957c8b09f	1	Павел	1231461030	ул Некрасова д.10
100	1487bd05ae95cb5de9b3903adadf4caf	1	Павел	1231461030	ул Некрасова д.10
101	00b2c9c55a4f2121aac32f5a080b4d45	1	Павел	1231461030	ул Некрасова д.10
102	0ab64a39370e9164ac1ca4c707d11292	1	Павел	1231461030	ул Некрасова д.10
103	7f5a81ca3bc8c3f7aceaf4c207903b40	1	Павел	1231461030	ул Некрасова д.10
104	32e23c1719151697c18c12f4c78b41df	1	Павел	1231461030	ул Некрасова д.10
105	4be673e6e1a2db27343438bc80bf2da4	1	Павел	1231461030	ул Некрасова д.10
106	a9caae112af12349031d7b0d2ecdef7f	1	Павел	1231461030	ул Некрасова д.10
107	67e5a13bcdf3378c8260fa5a205ee84c	1	Павел	1231461030	ул Некрасова д.10
108	cde0fa1f94a380cabc11bf29958e56b2	1	Павел	1231461030	ул Некрасова д.10
109	f7f80257f1a6f0be77642bee79df665a	1	Павел	1231461030	ул Некрасова д.10
110	ff7e96478cc9869510d089718709bd5d	1	Павел	1231461030	ул Некрасова д.10
111	192f5255bdf3140b1d01432f78a9f4be	1	Павел	1231461030	ул Некрасова д.10
112	da0f4ba816391374b933d45f0b198d00	1	Павел	1231461030	ул Некрасова д.10
113	71c5185bdc0ca5d0a9a1c690732c744f	1	Павел	1231461030	ул Некрасова д.10
114	7c7651310e2d32721a47e8f3d8492ab1	1	Павел	1231461030	ул Некрасова д.10
115	a1d05013a6b0260064375e4388eafd3c	1	Павел	1231461030	ул Некрасова д.10
116	1fa84f00690eb20d06fc609a3e27ca89	1	Павел	1231461030	ул Некрасова д.10
117	0c81b6ceefed05d308df1bc9c0f2534d	1	Павел	1231461030	ул Некрасова д.10
118	b3343311291525964c39a24d4b742868	1	Павел	1231461030	ул Некрасова д.10
119	2c073435809bb3861858cee790647497	1	Павел	1231461030	ул Некрасова д.10
120	19fe9c8b619413db6e6ad690ec7911c8	1	Павел	1231461030	ул Некрасова д.10
121	16d8680092d8e443ea5c544b3d4acb04	1	Павел	1231461030	ул Некрасова д.10
122	d20c09d79afeba5fcd28868ac86bf9f3	1	Павел	1231461030	ул Некрасова д.10
123	d31901d12d0d9b961b51e9169452d6fe	1	Павел	1231461030	ул Некрасова д.10
124	6bf5183ed4716e92bdc77f00d9e357e8	1	Павел	1231461030	ул Некрасова д.10
125	2d8e46abade781e0d02f41554cfb42db	1	Павел	1231461030	ул Некрасова д.10
126	f32260870cc4bbf7fdce5b8f3f6ed9d2	1	Павел	1231461030	ул Некрасова д.10
127	f5de8a4b752ba6d87f207ccbde1fcf78	1	Павел	1231461030	ул Некрасова д.10
128	d4eacdf1501c7473f6e003fa7e853f4c	1	Павел	1231461030	ул Некрасова д.10
129	368a6856b3cc176bf9bdd3edbb96747a	1	Павел	1231461030	ул Некрасова д.10
130	89804bea6cbb4740867a06b5dcc0e1ba	1	Павел	1231461030	ул Некрасова д.10
131	fa5265d2fbad80b86c6e360fe333833a	1	Павел	1231461030	ул Некрасова д.10
132	3be2a8d100327a172374cbae874d63f0	1	Павел	1231461030	ул Некрасова д.10
133	fcf5d71e58d8567bd935072d310fee12	1	Павел	1231461030	ул Некрасова д.10
134	fbbf9e1a0dd332cfb723f21a65c66bfb	1	Павел	1231461030	ул Некрасова д.10
135	f373e639a4f314fb5b0b65da3b418725	1	Павел	1231461030	ул Некрасова д.10
136	f2bc1e0c173dd62257ff845034e844dd	1	Павел	1231461030	ул Некрасова д.10
137	cd95d8f937abd2de7bacc406eeea7908	1	Павел	1231461030	ул Некрасова д.10
138	0e4f149cf7670e6f5113c0bed198b9a0	1	Павел	1231461030	ул Некрасова д.10
139	b06410497033eb045ded32b3f5745b87	1	Павел	1231461030	ул Некрасова д.10
140	a913ee8a4e54790b7b2c6dba755aa6c9	1	Павел	1231461030	ул Некрасова д.10
141	cc2d13b104307ce0872e5436483551ac	1	Павел	1231461030	ул Некрасова д.10
142	d0b954cfd813680e2df7e125f196397d	1	Павел	1231461030	ул Некрасова д.10
143	6290c13118aa9889f37c865ec2ae11e4	1	Павел	1231461030	ул Некрасова д.10
144	d0252a36200a8f09a1546a0e62032ba7	1	Павел	1231461030	ул Некрасова д.10
145	75b84343aa9317958fd7a7be12f5b5be	1	Павел	1231461030	ул Некрасова д.10
146	efa8ccc4cf3eedf33f81668ed7717d7d	1	Павел	1231461030	ул Некрасова д.10
147	3283164ee08abca77942623f96ad15c7	1	Павел	1231461030	ул Некрасова д.10
148	e54057161bb66b57b997696aaa7da887	1	Павел	1231461030	ул Некрасова д.10
149	0db0545e48215ad80122cabd4173756a	1	Павел	1231461030	ул Некрасова д.10
150	6cc419c01238976751d50fcbcaa48619	1	Павел	1231461030	ул Некрасова д.10
151	97c6cecb54e73371bd1fc534d6248f23	1	Павел	1231461030	ул Некрасова д.10
152	c308f649f7c81c146bcf0d9369e3ad31	1	Павел	1231461030	ул Некрасова д.10
153	3b37bb5b09a50a44524130f5a9c2cfaa	1	Павел	1231461030	ул Некрасова д.10
154	9fed2db52fd731585fb2b2ea44959d58	1	Павел	1231461030	ул Некрасова д.10
\.


--
-- Data for Name: pizzas; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.pizzas (id, title, description, image, updated_at, price) FROM stdin;
6	Пепперони по-деревенски	<div>Огурцы маринованные, Пепперони, Сыр Моцарелла, Томатный соус</div>	7a5ea8974ed82727dc2cc0427f8ebc18bc085dc4.png	2021-12-18 07:06:05	562
7	Пепперони	<div>Пепперони, Сыр Моцарелла, Томатный соус</div>	ae0033936419eda00b7e043881bb7f9267aa7a95.png	2021-12-18 07:06:23	657
9	Маргарита Гурме	<div>Свежие томаты, Сыр Моцарелла, Томатный соус</div>	ce6944fb9aa25529e912136eeeab457b48742904.png	2021-12-18 07:07:01	568
10	Домашняя	<div>Ветчина, Свежие томаты, Соус Сырный, Сыр Моцарелла</div>	1cc02d4fc186a2df624a7e4a90e95cfac6bfc2e7.png	2021-12-18 07:07:18	569
2	Мясная	<div>Ветчина, Курица, Охотничьи колбаски, Пепперони, Сыр Моцарелла, Томатный соус</div>	1f78e0b3960fd3bbd5ba86290876e468064e5058.png	2021-12-18 07:04:27	655
1	Чикен Сладкий Чили	<div>Курица, Лук, Перец Халапеньо, Сыр Моцарелла, Томатный соус , Соус Сладкий Чили</div>	1a83a70692007873b706cf7143254c2cd81084c2.png	2021-12-18 06:30:20	645
3	Чикен BBQ	<div>Курица, Лук, Соус Карбонара, Сыр Моцарелла, Чипсы EASY PEASY холодец-хрен</div>	6001f3c1791f74943312dfa351cc049a87f0cb9a.png	2021-12-18 07:04:56	564
4	4 сезона	<div>Бекон, Ветчина, Грибы, Курица, Лук, Маслины, Огурцы маринованные, Охотничьи колбаски, Пепперони, Свежие томаты, Соус BBQ, Сыр Моцарелла, Сыр Фета, Томатный соус</div>	8233e69f001abf85ec37a87ceeada4cd973ae76a.png	2021-12-18 07:05:23	564
5	Сырная с ветчиной	<div>Ветчина, Сыр Моцарелла, Томатный соус</div>	5ce8f0fdd89904223d7175c9b11deb72cec522fd.png	2021-12-18 07:05:47	546
8	Домино'c	<div>Бекон, Грибы, Болгарский перец, Курица, Лук, Охотничьи колбаски, Пепперони, Свежие томаты, Сыр Моцарелла, Томатный соус</div>	25db1645cc88496eac3232ffd3591f919572937b.png	2021-12-18 07:06:45	564
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public."user" (id, username, roles, password, user_full_name, user_phone, user_address) FROM stdin;
5	user	[]	$2y$13$e7ngakLbo.jPvzKJYwud0.oG6ZrZHuMe6np05.zQkm.8k/kI/Od0W	\N	\N	\N
4	admin	["ROLE_USER","ROLE_ADMIN"]	$2y$13$SxPW64nDYiO8t3jZO.UIMuGuR4xjafbpGSPZ5g7BlG4LljKB0JYMC	\N	\N	\N
21	manager	["ROLE_USER","ROLE_MANAGER"]	$2y$13$d.FrgV2/KNpH4TCbF7GhGOSmbtn2Uq.PE/61.6sqvMeEUjukN1ibW	\N	\N	\N
22	Павел	[]	$2y$10$U3sxAO2k4fhd07Hiycq0KOzwe3zyV3VEDGYhthpeuBCje3CnTVRRq	\N	1231461030	ул Некрасова д.10
35	Павел21321	[]	$2y$10$/TU27NlLQ1FfQtkaA9e4.O.aszmLMLVzI9JIT1/0H7bY1k0otwIFK	Павел	21321	ул Некрасова д.10
36	Павел65456	[]	$2y$10$NgD.MQK7FVkQ68h2LDgoFumXe/pmv0nwvxZTSJ.uXyLyyxKi1MCt.	Павел	65456	ул Некрасова д.10
37	Катя	[]	$2y$10$oJviyKBYX2JHBLUBZci4HOSIzPTYyG3CHgn1c8.UdFDn/fZi..Re.	Катя	89199264028	ул Некрасова д.10
39	Павел531	[]	$2y$10$JRx5zjJee5nGZiTVWG8y.OJ/QcKa26UcvKEf9pEgJP00of3ULhvZy	Павел	531	ул Некрасова д.10
\.


--
-- Name: basket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.basket_id_seq', 159, true);


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.messenger_messages_id_seq', 1, false);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.order_id_seq', 154, true);


--
-- Name: pizzas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.pizzas_id_seq', 10, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.user_id_seq', 39, true);


--
-- Name: basket basket_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.basket
    ADD CONSTRAINT basket_pkey PRIMARY KEY (id);


--
-- Name: doctrine_migration_versions doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: messenger_messages messenger_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.messenger_messages
    ADD CONSTRAINT messenger_messages_pkey PRIMARY KEY (id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: pizzas pizzas_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.pizzas
    ADD CONSTRAINT pizzas_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: idx_2246507b126f525e; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_2246507b126f525e ON public.basket USING btree (item_id);


--
-- Name: idx_75ea56e016ba31db; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_75ea56e016ba31db ON public.messenger_messages USING btree (delivered_at);


--
-- Name: idx_75ea56e0e3bd61ce; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_75ea56e0e3bd61ce ON public.messenger_messages USING btree (available_at);


--
-- Name: idx_75ea56e0fb7336f0; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_75ea56e0fb7336f0 ON public.messenger_messages USING btree (queue_name);


--
-- Name: uniq_8d93d649f85e0677; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX uniq_8d93d649f85e0677 ON public."user" USING btree (username);


--
-- Name: messenger_messages notify_trigger; Type: TRIGGER; Schema: public; Owner: user
--

CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON public.messenger_messages FOR EACH ROW EXECUTE FUNCTION public.notify_messenger_messages();


--
-- Name: basket fk_2246507b126f525e; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.basket
    ADD CONSTRAINT fk_2246507b126f525e FOREIGN KEY (item_id) REFERENCES public.pizzas(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

