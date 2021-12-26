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
ALTER ROLE "user" WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:a2VJORL5hfGy2d8glV/JnA==$Krr3AJWp01Sn3B7bDr2PP+6At+SaYk92NfmiVVLinz0=:jBNANx09qgak4WZcQ4S1g13OMpzOnpcJT/8GmbHZ8YE=';






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
-- Name: ingredients; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ingredients (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    price integer
);


ALTER TABLE public.ingredients OWNER TO "user";

--
-- Name: ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE public.ingredients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ingredients_id_seq OWNER TO "user";

--
-- Name: ingredients_pizzas; Type: TABLE; Schema: public; Owner: user
--

CREATE TABLE public.ingredients_pizzas (
    ingredients_id integer NOT NULL,
    pizzas_id integer NOT NULL
);


ALTER TABLE public.ingredients_pizzas OWNER TO "user";

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
-- Data for Name: basket; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.basket (id, item_id, session_id, count) FROM stdin;
\.


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20211218053747	2021-12-26 21:39:03	114
DoctrineMigrations\\Version20211218074155	2021-12-26 21:39:03	84
DoctrineMigrations\\Version20211218102551	2021-12-26 21:39:03	1
DoctrineMigrations\\Version20211218110459	2021-12-26 21:39:03	161
DoctrineMigrations\\Version20211218185454	2021-12-26 21:39:04	4
DoctrineMigrations\\Version20211222201630	2021-12-26 21:39:04	155
DoctrineMigrations\\Version20211225205517	2021-12-26 21:39:04	130
\.


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.ingredients (id, name, price) FROM stdin;
\.


--
-- Data for Name: ingredients_pizzas; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.ingredients_pizzas (ingredients_id, pizzas_id) FROM stdin;
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public."order" (id, session_id, status, username, user_phone, user_address) FROM stdin;
\.


--
-- Data for Name: pizzas; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public.pizzas (id, title, description, image, updated_at, price) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: user
--

COPY public."user" (id, username, roles, password, user_full_name, user_phone, user_address) FROM stdin;
\.


--
-- Name: basket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.basket_id_seq', 1, false);


--
-- Name: ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.ingredients_id_seq', 1, false);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.order_id_seq', 1, false);


--
-- Name: pizzas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.pizzas_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('public.user_id_seq', 1, false);


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
-- Name: ingredients_pizzas ingredients_pizzas_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_pizzas
    ADD CONSTRAINT ingredients_pizzas_pkey PRIMARY KEY (ingredients_id, pizzas_id);


--
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (id);


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
-- Name: idx_9011f51c3ec4dce; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_9011f51c3ec4dce ON public.ingredients_pizzas USING btree (ingredients_id);


--
-- Name: idx_9011f51c7f778084; Type: INDEX; Schema: public; Owner: user
--

CREATE INDEX idx_9011f51c7f778084 ON public.ingredients_pizzas USING btree (pizzas_id);


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
-- Name: ingredients_pizzas fk_9011f51c3ec4dce; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_pizzas
    ADD CONSTRAINT fk_9011f51c3ec4dce FOREIGN KEY (ingredients_id) REFERENCES public.ingredients(id) ON DELETE CASCADE;


--
-- Name: ingredients_pizzas fk_9011f51c7f778084; Type: FK CONSTRAINT; Schema: public; Owner: user
--

ALTER TABLE ONLY public.ingredients_pizzas
    ADD CONSTRAINT fk_9011f51c7f778084 FOREIGN KEY (pizzas_id) REFERENCES public.pizzas(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

