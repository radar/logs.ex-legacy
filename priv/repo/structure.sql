--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;
--
--
-- Name: channels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE channels (
    id integer NOT NULL,
    name character varying(255),
    hidden boolean DEFAULT false
);


--
-- Name: channels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE channels_id_seq OWNED BY channels.id;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE messages (
    id integer NOT NULL,
    text text,
    channel_id integer,
    person_id integer,
    created_at timestamp without time zone,
    type character varying(255),
    hidden boolean DEFAULT true
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE people (
    id integer NOT NULL,
    nick character varying(255),
    authorized boolean DEFAULT false,
    created_at timestamp without time zone
);


--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE people_id_seq OWNED BY people.id;

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: tips; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tips (
    id integer NOT NULL,
    command character varying(255),
    text text
);


--
-- Name: tips_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tips_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tips_id_seq OWNED BY tips.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY channels ALTER COLUMN id SET DEFAULT nextval('channels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);



--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY people ALTER COLUMN id SET DEFAULT nextval('people_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tips ALTER COLUMN id SET DEFAULT nextval('tips_id_seq'::regclass);


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);

--
-- Name: channels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);

--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: people_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);

--
-- Name: tips_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tips
    ADD CONSTRAINT tips_pkey PRIMARY KEY (id);


--
-- Name: channel_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX channel_id_idx ON messages USING btree (channel_id);

--
-- Name: messages_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX messages_created_at ON messages USING btree (created_at);


--
-- Name: messages_person_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX messages_person_id ON messages USING btree (created_at, person_id);


--
-- Name: person_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX person_id_idx ON messages USING btree (person_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO "schema_migrations" (version) VALUES (20120901104043), (20120901105023), (20120901114303), (20130423062927), (20131023214343), (20150726213653), (20150726214234), (20150726214453), (20150726214643), (20150726214841), (20150726215155), (20150726220042), (20150726220233), (20150831070841), (20150831071240), (20150831071626), (20150831220030), (20150901211929), (20150901214927), (20150902220500), (20150903074947), (20150904214749), (20150907031755), (20151009224007), (20151011212918), (20151018053438), (20151025204832);

