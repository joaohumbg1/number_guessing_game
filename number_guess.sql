--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)

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
-- Name: games; Type: TABLE; Schema: public; Owner: joaohumbg
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    user_id integer NOT NULL,
    number_guesses integer NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now()
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: joaohumbg
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: joaohumbg
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: joaohumbg
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying NOT NULL
);


ALTER TABLE public.users OWNER TO joaohumbg;

--
-- Name: username_username_id_seq; Type: SEQUENCE; Schema: public; Owner: joaohumbg
--

CREATE SEQUENCE public.username_username_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.username_username_id_seq OWNER TO freecodecamp;

--
-- Name: username_username_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: joaohumbg
--

ALTER SEQUENCE public.username_username_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: joaohumbg
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: joaohumbg
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.username_username_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: joaohumbg
--

COPY public.games (game_id, user_id, number_guesses, "timestamp") FROM stdin;
6	7	10	2024-03-11 19:47:24.090148
7	7	11	2024-03-11 19:48:05.080576
8	7	9	2024-03-11 19:48:37.12082
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: joaohumbg
--

COPY public.users (user_id, username) FROM stdin;
7	joaohumbg
\.


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: joaohumbg
--

SELECT pg_catalog.setval('public.games_game_id_seq', 8, true);


--
-- Name: username_username_id_seq; Type: SEQUENCE SET; Schema: public; Owner: joaohumbg
--

SELECT pg_catalog.setval('public.username_username_id_seq', 7, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: joaohumbg
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: users unique_username; Type: CONSTRAINT; Schema: public; Owner: joaohumbg
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_username UNIQUE (username);


--
-- Name: users username_pkey; Type: CONSTRAINT; Schema: public; Owner: joaohumbg
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT username_pkey PRIMARY KEY (user_id);


--
-- Name: games fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: joaohumbg
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

