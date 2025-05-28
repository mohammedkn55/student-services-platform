--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.5

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
-- Name: dispute_status; Type: TYPE; Schema: public; Owner: neondb_owner
--

CREATE TYPE public.dispute_status AS ENUM (
    'pending',
    'reviewing',
    'resolved_client',
    'resolved_provider',
    'closed'
);


ALTER TYPE public.dispute_status OWNER TO neondb_owner;

--
-- Name: quote_status; Type: TYPE; Schema: public; Owner: neondb_owner
--

CREATE TYPE public.quote_status AS ENUM (
    'pending',
    'accepted',
    'rejected'
);


ALTER TYPE public.quote_status OWNER TO neondb_owner;

--
-- Name: request_status; Type: TYPE; Schema: public; Owner: neondb_owner
--

CREATE TYPE public.request_status AS ENUM (
    'pending',
    'quoted',
    'in_progress',
    'completed',
    'cancelled'
);


ALTER TYPE public.request_status OWNER TO neondb_owner;

--
-- Name: user_role; Type: TYPE; Schema: public; Owner: neondb_owner
--

CREATE TYPE public.user_role AS ENUM (
    'client',
    'provider',
    'admin'
);


ALTER TYPE public.user_role OWNER TO neondb_owner;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: dispute_messages; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.dispute_messages (
    id integer NOT NULL,
    dispute_id integer NOT NULL,
    sender_id integer NOT NULL,
    content text NOT NULL,
    attachment text,
    is_read boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.dispute_messages OWNER TO neondb_owner;

--
-- Name: dispute_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.dispute_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dispute_messages_id_seq OWNER TO neondb_owner;

--
-- Name: dispute_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.dispute_messages_id_seq OWNED BY public.dispute_messages.id;


--
-- Name: disputes; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.disputes (
    id integer NOT NULL,
    request_id integer NOT NULL,
    raised_by_id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    status public.dispute_status DEFAULT 'pending'::public.dispute_status NOT NULL,
    admin_notes text,
    resolution text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    closed_at timestamp without time zone
);


ALTER TABLE public.disputes OWNER TO neondb_owner;

--
-- Name: disputes_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.disputes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.disputes_id_seq OWNER TO neondb_owner;

--
-- Name: disputes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.disputes_id_seq OWNED BY public.disputes.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    request_id integer NOT NULL,
    sender_id integer NOT NULL,
    recipient_id integer NOT NULL,
    content text NOT NULL,
    attachment text,
    is_read boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.messages OWNER TO neondb_owner;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messages_id_seq OWNER TO neondb_owner;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title text NOT NULL,
    message text NOT NULL,
    link text,
    is_read boolean DEFAULT false,
    type text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.notifications OWNER TO neondb_owner;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO neondb_owner;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: quotes; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.quotes (
    id integer NOT NULL,
    request_id integer NOT NULL,
    provider_id integer NOT NULL,
    price double precision NOT NULL,
    delivery_days integer NOT NULL,
    message text,
    status public.quote_status DEFAULT 'pending'::public.quote_status,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.quotes OWNER TO neondb_owner;

--
-- Name: quotes_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.quotes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.quotes_id_seq OWNER TO neondb_owner;

--
-- Name: quotes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.quotes_id_seq OWNED BY public.quotes.id;


--
-- Name: ratings; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.ratings (
    id integer NOT NULL,
    request_id integer NOT NULL,
    rater_id integer NOT NULL,
    rated_id integer NOT NULL,
    score integer NOT NULL,
    comment text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.ratings OWNER TO neondb_owner;

--
-- Name: ratings_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.ratings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ratings_id_seq OWNER TO neondb_owner;

--
-- Name: ratings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.ratings_id_seq OWNED BY public.ratings.id;


--
-- Name: service_categories; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.service_categories (
    id integer NOT NULL,
    name text NOT NULL,
    description text,
    icon text
);


ALTER TABLE public.service_categories OWNER TO neondb_owner;

--
-- Name: service_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.service_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_categories_id_seq OWNER TO neondb_owner;

--
-- Name: service_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.service_categories_id_seq OWNED BY public.service_categories.id;


--
-- Name: service_providers; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.service_providers (
    id integer NOT NULL,
    provider_id integer NOT NULL,
    service_id integer NOT NULL,
    custom_price double precision,
    custom_delivery_days integer,
    is_verified boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.service_providers OWNER TO neondb_owner;

--
-- Name: service_providers_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.service_providers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_providers_id_seq OWNER TO neondb_owner;

--
-- Name: service_providers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.service_providers_id_seq OWNED BY public.service_providers.id;


--
-- Name: service_requests; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.service_requests (
    id integer NOT NULL,
    client_id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    attachments json,
    status public.request_status DEFAULT 'pending'::public.request_status,
    accepted_quote_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    completed_at timestamp without time zone
);


ALTER TABLE public.service_requests OWNER TO neondb_owner;

--
-- Name: service_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.service_requests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_requests_id_seq OWNER TO neondb_owner;

--
-- Name: service_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.service_requests_id_seq OWNED BY public.service_requests.id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.services (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    category_id integer NOT NULL,
    base_price_min double precision NOT NULL,
    base_price_max double precision NOT NULL,
    expected_delivery_days integer NOT NULL,
    is_active boolean DEFAULT true
);


ALTER TABLE public.services OWNER TO neondb_owner;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.services_id_seq OWNER TO neondb_owner;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: session; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.session OWNER TO neondb_owner;

--
-- Name: users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    full_name text NOT NULL,
    role public.user_role NOT NULL,
    profile_image text,
    phone text,
    bio text,
    average_rating double precision DEFAULT 0,
    review_count integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    last_login timestamp without time zone,
    is_active boolean DEFAULT true
);


ALTER TABLE public.users OWNER TO neondb_owner;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO neondb_owner;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: dispute_messages id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.dispute_messages ALTER COLUMN id SET DEFAULT nextval('public.dispute_messages_id_seq'::regclass);


--
-- Name: disputes id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.disputes ALTER COLUMN id SET DEFAULT nextval('public.disputes_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: quotes id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.quotes ALTER COLUMN id SET DEFAULT nextval('public.quotes_id_seq'::regclass);


--
-- Name: ratings id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ratings ALTER COLUMN id SET DEFAULT nextval('public.ratings_id_seq'::regclass);


--
-- Name: service_categories id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service_categories ALTER COLUMN id SET DEFAULT nextval('public.service_categories_id_seq'::regclass);


--
-- Name: service_providers id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service_providers ALTER COLUMN id SET DEFAULT nextval('public.service_providers_id_seq'::regclass);


--
-- Name: service_requests id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service_requests ALTER COLUMN id SET DEFAULT nextval('public.service_requests_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: dispute_messages dispute_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.dispute_messages
    ADD CONSTRAINT dispute_messages_pkey PRIMARY KEY (id);


--
-- Name: disputes disputes_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.disputes
    ADD CONSTRAINT disputes_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: quotes quotes_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.quotes
    ADD CONSTRAINT quotes_pkey PRIMARY KEY (id);


--
-- Name: ratings ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (id);


--
-- Name: service_categories service_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service_categories
    ADD CONSTRAINT service_categories_pkey PRIMARY KEY (id);


--
-- Name: service_providers service_providers_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service_providers
    ADD CONSTRAINT service_providers_pkey PRIMARY KEY (id);


--
-- Name: service_requests service_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.service_requests
    ADD CONSTRAINT service_requests_pkey PRIMARY KEY (id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX "IDX_session_expire" ON public.session USING btree (expire);


--
-- Name: dispute_messages dispute_messages_dispute_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.dispute_messages
    ADD CONSTRAINT dispute_messages_dispute_id_fkey FOREIGN KEY (dispute_id) REFERENCES public.disputes(id);


--
-- Name: dispute_messages dispute_messages_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.dispute_messages
    ADD CONSTRAINT dispute_messages_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: disputes disputes_raised_by_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.disputes
    ADD CONSTRAINT disputes_raised_by_id_fkey FOREIGN KEY (raised_by_id) REFERENCES public.users(id);


--
-- Name: disputes disputes_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.disputes
    ADD CONSTRAINT disputes_request_id_fkey FOREIGN KEY (request_id) REFERENCES public.service_requests(id);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

