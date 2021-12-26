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
-- Drop roles
--

DROP ROLE "user";


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
    user_name character varying(255) DEFAULT NULL::character varying,
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
-- Data for Name: basket; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.basket (id, item_id, session_id, count) FROM stdin;
82	1	c1e8a4b6e480c8fa98c09e5747ad7b3f	3
83	4	c1e8a4b6e480c8fa98c09e5747ad7b3f	2
84	1	1d24265b53533beea2d9a2bfe1913813	3
86	4	0ea3bba5fd8803c64d63a35002a261a7	1
85	1	0ea3bba5fd8803c64d63a35002a261a7	2
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
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public."order" (id, session_id, status, username, user_phone, user_address) FROM stdin;
11	f73635d94c3d2497760cb3f14f3b4698	1	Павел	1231461030	ул Некрасова д.10
12	6e647caf389845091998215a8f6c0c5b	1	Павел	1231461030	ул Некрасова д.10
13	f73635d94c3d2497760cb3f14f3b4698	1	Павел	1231461030	ул Некрасова д.10
14	5e3cf1fd9da26c16aced6326db146e8e	1	ваыва	ываыва	ываыва
15	b8cc85d41c5a1356971d7ca7ecbd14fa	1	Павел	1231461030	ул Некрасова д.10
16	7f63fe1c73d9711b1f7085d71a997505	1	Павел	1231461030	ул Некрасова д.10
17	e49e6617c0138c20bccc11384666fc4b	1	Павел	89199264020	ул Некрасова д.10
18	229549d1d239c2a83a3f691127aa8ff7	1	df	dfg	dfg
19	9b5a89838b51cf70249a564fefd153f8	1	sdffg	dfg	dfg
20	3940216dbe9310896b1dd8b2edbd9c8f	1	Павел	1231461030	ул Некрасова д.10
21	52e7e2e5d79133c3d445c1e7a03cc84c	1	Павел14	dfg	dfg
22	c1e8a4b6e480c8fa98c09e5747ad7b3f	1	Павел2	dfg	dfg
23	1d24265b53533beea2d9a2bfe1913813	1	sdffg	sdf	sdf
\.


--
-- Data for Name: pizzas; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.pizzas (id, title, description, image, updated_at, price) FROM stdin;
1	Чикен Сладкий Чили	<div>Курица, Лук, Перец Халапеньо, Сыр Моцарелла, Томатный соус , Соус Сладкий Чили</div>	1a83a70692007873b706cf7143254c2cd81084c2.png	2021-12-18 06:30:20	1000
4	4 сезона	<div>Бекон, Ветчина, Грибы, Курица, Лук, Маслины, Огурцы маринованные, Охотничьи колбаски, Пепперони, Свежие томаты, Соус BBQ, Сыр Моцарелла, Сыр Фета, Томатный соус</div>	8233e69f001abf85ec37a87ceeada4cd973ae76a.png	2021-12-18 07:05:23	1000
3	Чикен BBQ	<div>Курица, Лук, Соус Карбонара, Сыр Моцарелла, Чипсы EASY PEASY холодец-хрен</div>	6001f3c1791f74943312dfa351cc049a87f0cb9a.png	2021-12-18 07:04:56	1000
5	Сырная с ветчиной	<div>Ветчина, Сыр Моцарелла, Томатный соус</div>	5ce8f0fdd89904223d7175c9b11deb72cec522fd.png	2021-12-18 07:05:47	1000
6	Пепперони по-деревенски	<div>Огурцы маринованные, Пепперони, Сыр Моцарелла, Томатный соус</div>	7a5ea8974ed82727dc2cc0427f8ebc18bc085dc4.png	2021-12-18 07:06:05	1000
7	Пепперони	<div>Пепперони, Сыр Моцарелла, Томатный соус</div>	ae0033936419eda00b7e043881bb7f9267aa7a95.png	2021-12-18 07:06:23	1000
8	Домино'c	<div>Бекон, Грибы, Болгарский перец, Курица, Лук, Охотничьи колбаски, Пепперони, Свежие томаты, Сыр Моцарелла, Томатный соус</div>	25db1645cc88496eac3232ffd3591f919572937b.png	2021-12-18 07:06:45	1000
9	Маргарита Гурме	<div>Свежие томаты, Сыр Моцарелла, Томатный соус</div>	ce6944fb9aa25529e912136eeeab457b48742904.png	2021-12-18 07:07:01	1000
10	Домашняя	<div>Ветчина, Свежие томаты, Соус Сырный, Сыр Моцарелла</div>	1cc02d4fc186a2df624a7e4a90e95cfac6bfc2e7.png	2021-12-18 07:07:18	1000
2	Мясная	<div>Ветчина, Курица, Охотничьи колбаски, Пепперони, Сыр Моцарелла, Томатный соус</div>	1f78e0b3960fd3bbd5ba86290876e468064e5058.png	2021-12-18 07:04:27	1000
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public."user" (id, username, roles, password, user_name, user_phone, user_address) FROM stdin;
5	user	[]	$2y$13$e7ngakLbo.jPvzKJYwud0.oG6ZrZHuMe6np05.zQkm.8k/kI/Od0W	\N	\N	\N
4	admin	["ROLE_USER","ROLE_ADMIN"]	$2y$13$SxPW64nDYiO8t3jZO.UIMuGuR4xjafbpGSPZ5g7BlG4LljKB0JYMC	\N	\N	\N
7	Павел	[]	1	\N	1231461030	ул Некрасова д.10
8	Павел14	[]	1	\N	dfg	dfg
9	Павел2	[]	1	\N	dfg	dfg
10	sdffg	[]	1	\N	sdf	sdf
\.


--
-- Name: basket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.basket_id_seq', 86, true);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.order_id_seq', 23, true);


--
-- Name: pizzas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.pizzas_id_seq', 10, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.user_id_seq', 10, true);


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
-- Name: uniq_8d93d649f85e0677; Type: INDEX; Schema: public; Owner: user
--

CREATE UNIQUE INDEX uniq_8d93d649f85e0677 ON public."user" USING btree (username);


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

