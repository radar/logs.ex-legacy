--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE TABLE accounts (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    owner_id integer,
    subdomain character varying
);


ALTER TABLE accounts OWNER TO ryanbigg;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: ryanbigg
--

CREATE SEQUENCE accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE accounts_id_seq OWNER TO ryanbigg;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ryanbigg
--

ALTER SEQUENCE accounts_id_seq OWNED BY accounts.id;


--
-- Name: accounts_users; Type: TABLE; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE TABLE accounts_users (
    account_id integer,
    user_id integer
);


ALTER TABLE accounts_users OWNER TO ryanbigg;

--
-- Name: books; Type: TABLE; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE TABLE books (
    id integer NOT NULL,
    account integer,
    path character varying,
    title character varying,
    blurb character varying,
    permalink character varying,
    current_commit character varying,
    just_added boolean,
    processing boolean,
    notes_count integer DEFAULT 0,
    hidden boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    account_id integer
);


ALTER TABLE books OWNER TO ryanbigg;

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: ryanbigg
--

CREATE SEQUENCE books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE books_id_seq OWNER TO ryanbigg;

--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ryanbigg
--

ALTER SEQUENCE books_id_seq OWNED BY books.id;


--
-- Name: channels; Type: TABLE; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE TABLE channels (
    id integer NOT NULL,
    name character varying(255),
    hidden boolean DEFAULT false
);


ALTER TABLE channels OWNER TO ryanbigg;

--
-- Name: channels_id_seq; Type: SEQUENCE; Schema: public; Owner: ryanbigg
--

CREATE SEQUENCE channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE channels_id_seq OWNER TO ryanbigg;

--
-- Name: channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ryanbigg
--

ALTER SEQUENCE channels_id_seq OWNED BY channels.id;


--
-- Name: chapters; Type: TABLE; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE TABLE chapters (
    id integer NOT NULL,
    book_id integer,
    "position" integer,
    title character varying,
    file_name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    part character varying,
    permalink character varying
);


ALTER TABLE chapters OWNER TO ryanbigg;

--
-- Name: chapters_id_seq; Type: SEQUENCE; Schema: public; Owner: ryanbigg
--

CREATE SEQUENCE chapters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chapters_id_seq OWNER TO ryanbigg;

--
-- Name: chapters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ryanbigg
--

ALTER SEQUENCE chapters_id_seq OWNED BY chapters.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    note_id integer,
    text text,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE comments OWNER TO ryanbigg;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: ryanbigg
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comments_id_seq OWNER TO ryanbigg;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ryanbigg
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: elements; Type: TABLE; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE TABLE elements (
    id integer NOT NULL,
    chapter_id integer,
    tag character varying,
    title character varying,
    nickname character varying,
    content text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    old boolean DEFAULT false,
    notes_count integer DEFAULT 0
);


ALTER TABLE elements OWNER TO ryanbigg;

--
-- Name: elements_id_seq; Type: SEQUENCE; Schema: public; Owner: ryanbigg
--

CREATE SEQUENCE elements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE elements_id_seq OWNER TO ryanbigg;

--
-- Name: elements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ryanbigg
--

ALTER SEQUENCE elements_id_seq OWNED BY elements.id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE TABLE images (
    id integer NOT NULL,
    chapter_id integer,
    filename character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_file_name character varying,
    image_content_type character varying,
    image_file_size integer,
    image_updated_at timestamp without time zone
);


ALTER TABLE images OWNER TO ryanbigg;

--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: ryanbigg
--

CREATE SEQUENCE images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE images_id_seq OWNER TO ryanbigg;

--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ryanbigg
--

ALTER SEQUENCE images_id_seq OWNED BY images.id;


--
-- Name: invitations; Type: TABLE; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE TABLE invitations (
    id integer NOT NULL,
    email character varying,
    account_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    token character varying
);


ALTER TABLE invitations OWNER TO ryanbigg;

--
-- Name: invitations_id_seq; Type: SEQUENCE; Schema: public; Owner: ryanbigg
--

CREATE SEQUENCE invitations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE invitations_id_seq OWNER TO ryanbigg;

--
-- Name: invitations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ryanbigg
--

ALTER SEQUENCE invitations_id_seq OWNED BY invitations.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: ryanbigg; Tablespace: 
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


ALTER TABLE messages OWNER TO ryanbigg;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: ryanbigg
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE messages_id_seq OWNER TO ryanbigg;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ryanbigg
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE TABLE notes (
    id integer NOT NULL,
    text text,
    element_id integer,
    number integer,
    state character varying DEFAULT 'new'::character varying,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE notes OWNER TO ryanbigg;

--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: ryanbigg
--

CREATE SEQUENCE notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE notes_id_seq OWNER TO ryanbigg;

--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ryanbigg
--

ALTER SEQUENCE notes_id_seq OWNED BY notes.id;


--
-- Name: people; Type: TABLE; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE TABLE people (
    id integer NOT NULL,
    nick character varying(255),
    authorized boolean DEFAULT false,
    created_at timestamp without time zone
);


ALTER TABLE people OWNER TO ryanbigg;

--
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: ryanbigg
--

CREATE SEQUENCE people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE people_id_seq OWNER TO ryanbigg;

--
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ryanbigg
--

ALTER SEQUENCE people_id_seq OWNED BY people.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE schema_migrations OWNER TO ryanbigg;

--
-- Name: tips; Type: TABLE; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE TABLE tips (
    id integer NOT NULL,
    command character varying(255),
    text text
);


ALTER TABLE tips OWNER TO ryanbigg;

--
-- Name: tips_id_seq; Type: SEQUENCE; Schema: public; Owner: ryanbigg
--

CREATE SEQUENCE tips_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tips_id_seq OWNER TO ryanbigg;

--
-- Name: tips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ryanbigg
--

ALTER SEQUENCE tips_id_seq OWNED BY tips.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    author boolean DEFAULT false
);


ALTER TABLE users OWNER TO ryanbigg;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: ryanbigg
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO ryanbigg;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ryanbigg
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ryanbigg
--

ALTER TABLE ONLY accounts ALTER COLUMN id SET DEFAULT nextval('accounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ryanbigg
--

ALTER TABLE ONLY books ALTER COLUMN id SET DEFAULT nextval('books_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ryanbigg
--

ALTER TABLE ONLY channels ALTER COLUMN id SET DEFAULT nextval('channels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ryanbigg
--

ALTER TABLE ONLY chapters ALTER COLUMN id SET DEFAULT nextval('chapters_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ryanbigg
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ryanbigg
--

ALTER TABLE ONLY elements ALTER COLUMN id SET DEFAULT nextval('elements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ryanbigg
--

ALTER TABLE ONLY images ALTER COLUMN id SET DEFAULT nextval('images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ryanbigg
--

ALTER TABLE ONLY invitations ALTER COLUMN id SET DEFAULT nextval('invitations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ryanbigg
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ryanbigg
--

ALTER TABLE ONLY notes ALTER COLUMN id SET DEFAULT nextval('notes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ryanbigg
--

ALTER TABLE ONLY people ALTER COLUMN id SET DEFAULT nextval('people_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ryanbigg
--

ALTER TABLE ONLY tips ALTER COLUMN id SET DEFAULT nextval('tips_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ryanbigg
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: ryanbigg; Tablespace: 
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: books_pkey; Type: CONSTRAINT; Schema: public; Owner: ryanbigg; Tablespace: 
--

ALTER TABLE ONLY books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: channels_pkey; Type: CONSTRAINT; Schema: public; Owner: ryanbigg; Tablespace: 
--

ALTER TABLE ONLY channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- Name: chapters_pkey; Type: CONSTRAINT; Schema: public; Owner: ryanbigg; Tablespace: 
--

ALTER TABLE ONLY chapters
    ADD CONSTRAINT chapters_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: ryanbigg; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: elements_pkey; Type: CONSTRAINT; Schema: public; Owner: ryanbigg; Tablespace: 
--

ALTER TABLE ONLY elements
    ADD CONSTRAINT elements_pkey PRIMARY KEY (id);


--
-- Name: images_pkey; Type: CONSTRAINT; Schema: public; Owner: ryanbigg; Tablespace: 
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: ryanbigg; Tablespace: 
--

ALTER TABLE ONLY invitations
    ADD CONSTRAINT invitations_pkey PRIMARY KEY (id);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: ryanbigg; Tablespace: 
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: notes_pkey; Type: CONSTRAINT; Schema: public; Owner: ryanbigg; Tablespace: 
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: people_pkey; Type: CONSTRAINT; Schema: public; Owner: ryanbigg; Tablespace: 
--

ALTER TABLE ONLY people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- Name: tips_pkey; Type: CONSTRAINT; Schema: public; Owner: ryanbigg; Tablespace: 
--

ALTER TABLE ONLY tips
    ADD CONSTRAINT tips_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: ryanbigg; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: channel_id_idx; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE INDEX channel_id_idx ON messages USING btree (channel_id);


--
-- Name: index_accounts_on_subdomain; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE INDEX index_accounts_on_subdomain ON accounts USING btree (subdomain);


--
-- Name: index_books_on_account; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE INDEX index_books_on_account ON books USING btree (account);


--
-- Name: index_books_on_account_id; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE INDEX index_books_on_account_id ON books USING btree (account_id);


--
-- Name: index_chapters_on_book_id; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE INDEX index_chapters_on_book_id ON chapters USING btree (book_id);


--
-- Name: index_chapters_on_book_id_and_part; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE INDEX index_chapters_on_book_id_and_part ON chapters USING btree (book_id, part);


--
-- Name: index_chapters_on_book_id_and_permalink; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE INDEX index_chapters_on_book_id_and_permalink ON chapters USING btree (book_id, permalink);


--
-- Name: index_comments_on_note_id; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE INDEX index_comments_on_note_id ON comments USING btree (note_id);


--
-- Name: index_elements_on_chapter_id; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE INDEX index_elements_on_chapter_id ON elements USING btree (chapter_id);


--
-- Name: index_images_on_chapter_id; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE INDEX index_images_on_chapter_id ON images USING btree (chapter_id);


--
-- Name: index_invitations_on_token; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE INDEX index_invitations_on_token ON invitations USING btree (token);


--
-- Name: index_notes_on_element_id; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE INDEX index_notes_on_element_id ON notes USING btree (element_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: messages_created_at; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE INDEX messages_created_at ON messages USING btree (created_at);


--
-- Name: person_id_idx; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE INDEX person_id_idx ON messages USING btree (person_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: ryanbigg; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_2e23c0e0de; Type: FK CONSTRAINT; Schema: public; Owner: ryanbigg
--

ALTER TABLE ONLY books
    ADD CONSTRAINT fk_rails_2e23c0e0de FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: ryanbigg
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM ryanbigg;
GRANT ALL ON SCHEMA public TO ryanbigg;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: channels; Type: ACL; Schema: public; Owner: ryanbigg
--

REVOKE ALL ON TABLE channels FROM PUBLIC;
REVOKE ALL ON TABLE channels FROM ryanbigg;
GRANT ALL ON TABLE channels TO ryanbigg;


--
-- Name: channels_id_seq; Type: ACL; Schema: public; Owner: ryanbigg
--

REVOKE ALL ON SEQUENCE channels_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE channels_id_seq FROM ryanbigg;
GRANT ALL ON SEQUENCE channels_id_seq TO ryanbigg;


--
-- Name: messages; Type: ACL; Schema: public; Owner: ryanbigg
--

REVOKE ALL ON TABLE messages FROM PUBLIC;
REVOKE ALL ON TABLE messages FROM ryanbigg;
GRANT ALL ON TABLE messages TO ryanbigg;


--
-- Name: messages_id_seq; Type: ACL; Schema: public; Owner: ryanbigg
--

REVOKE ALL ON SEQUENCE messages_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE messages_id_seq FROM ryanbigg;
GRANT ALL ON SEQUENCE messages_id_seq TO ryanbigg;


--
-- Name: people; Type: ACL; Schema: public; Owner: ryanbigg
--

REVOKE ALL ON TABLE people FROM PUBLIC;
REVOKE ALL ON TABLE people FROM ryanbigg;
GRANT ALL ON TABLE people TO ryanbigg;


--
-- Name: people_id_seq; Type: ACL; Schema: public; Owner: ryanbigg
--

REVOKE ALL ON SEQUENCE people_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE people_id_seq FROM ryanbigg;
GRANT ALL ON SEQUENCE people_id_seq TO ryanbigg;


--
-- Name: schema_migrations; Type: ACL; Schema: public; Owner: ryanbigg
--

REVOKE ALL ON TABLE schema_migrations FROM PUBLIC;
REVOKE ALL ON TABLE schema_migrations FROM ryanbigg;
GRANT ALL ON TABLE schema_migrations TO ryanbigg;


--
-- Name: tips; Type: ACL; Schema: public; Owner: ryanbigg
--

REVOKE ALL ON TABLE tips FROM PUBLIC;
REVOKE ALL ON TABLE tips FROM ryanbigg;
GRANT ALL ON TABLE tips TO ryanbigg;


--
-- Name: tips_id_seq; Type: ACL; Schema: public; Owner: ryanbigg
--

REVOKE ALL ON SEQUENCE tips_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE tips_id_seq FROM ryanbigg;
GRANT ALL ON SEQUENCE tips_id_seq TO ryanbigg;


--
-- PostgreSQL database dump complete
--

