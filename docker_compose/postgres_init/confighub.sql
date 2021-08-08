--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3 (Ubuntu 13.3-1.pgdg20.04+1)

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
-- Name: absolutefilepath; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.absolutefilepath (
    id bigint NOT NULL,
    diffjson text,
    abspath character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    path character varying(255),
    repositoryid bigint NOT NULL
);


ALTER TABLE public.absolutefilepath OWNER TO confighub;

--
-- Name: absolutefilepath_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.absolutefilepath_audit (
    id bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone,
    diffjson text,
    abspath character varying(255),
    filename character varying(255),
    path character varying(255),
    repositoryid bigint
);


ALTER TABLE public.absolutefilepath_audit OWNER TO confighub;

--
-- Name: accessrule; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.accessrule (
    id bigint NOT NULL,
    diffjson text,
    canedit boolean NOT NULL,
    contextjson text,
    contextmatchtype character varying(255),
    keymatchtype character varying(255),
    matchvalue character varying(255),
    priority integer NOT NULL,
    ruletarget character varying(255) NOT NULL,
    team bigint NOT NULL
);


ALTER TABLE public.accessrule OWNER TO confighub;

--
-- Name: accessrule_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.accessrule_audit (
    id bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone,
    diffjson text,
    canedit boolean,
    contextjson text,
    contextmatchtype character varying(255),
    keymatchtype character varying(255),
    matchvalue character varying(255),
    priority integer,
    ruletarget character varying(255),
    team bigint
);


ALTER TABLE public.accessrule_audit OWNER TO confighub;

--
-- Name: accessrule_ctxlevel; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.accessrule_ctxlevel (
    accessrule_id bigint NOT NULL,
    context_id bigint NOT NULL
);


ALTER TABLE public.accessrule_ctxlevel OWNER TO confighub;

--
-- Name: account; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.account (
    id bigint NOT NULL,
    diffjson text,
    city character varying(255),
    company character varying(255),
    country character varying(255),
    name character varying(255) NOT NULL,
    website character varying(255),
    organization_id bigint,
    user_id bigint
);


ALTER TABLE public.account OWNER TO confighub;

--
-- Name: account_repository; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.account_repository (
    account_id bigint NOT NULL,
    repositories_id bigint NOT NULL
);


ALTER TABLE public.account_repository OWNER TO confighub;

--
-- Name: ctxlevel; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.ctxlevel (
    id bigint NOT NULL,
    diffjson text,
    depth character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    repositoryid bigint NOT NULL
);


ALTER TABLE public.ctxlevel OWNER TO confighub;

--
-- Name: ctxlevel_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.ctxlevel_audit (
    id bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone,
    diffjson text,
    depth character varying(255),
    name character varying(255),
    type character varying(255),
    repositoryid bigint
);


ALTER TABLE public.ctxlevel_audit OWNER TO confighub;

--
-- Name: ctxlevel_ctxlevel; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.ctxlevel_ctxlevel (
    groups_id bigint NOT NULL,
    members_id bigint NOT NULL
);


ALTER TABLE public.ctxlevel_ctxlevel OWNER TO confighub;

--
-- Name: ctxlevel_ctxlevel_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.ctxlevel_ctxlevel_audit (
    rev bigint NOT NULL,
    groups_id bigint NOT NULL,
    members_id bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone
);


ALTER TABLE public.ctxlevel_ctxlevel_audit OWNER TO confighub;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO confighub;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO confighub;

--
-- Name: email; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.email (
    id bigint NOT NULL,
    diffjson text,
    email character varying(255) NOT NULL,
    user_id bigint
);


ALTER TABLE public.email OWNER TO confighub;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: confighub
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO confighub;

--
-- Name: organization; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.organization (
    id bigint NOT NULL,
    diffjson text,
    createdate timestamp without time zone NOT NULL,
    name character varying(255),
    account_id bigint
);


ALTER TABLE public.organization OWNER TO confighub;

--
-- Name: organization_admins; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.organization_admins (
    organization_id bigint NOT NULL,
    administrators_id bigint NOT NULL
);


ALTER TABLE public.organization_admins OWNER TO confighub;

--
-- Name: organization_owners; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.organization_owners (
    organization_id bigint NOT NULL,
    owners_id bigint NOT NULL
);


ALTER TABLE public.organization_owners OWNER TO confighub;

--
-- Name: property; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.property (
    id bigint NOT NULL,
    diffjson text,
    active boolean,
    contextjson text,
    contextweight integer NOT NULL,
    value text,
    repositoryid bigint NOT NULL,
    absolutefilepath bigint,
    propertykey_id bigint NOT NULL
);


ALTER TABLE public.property OWNER TO confighub;

--
-- Name: property_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.property_audit (
    id bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone,
    diffjson text,
    active boolean,
    contextjson text,
    contextweight integer,
    value text,
    repositoryid bigint,
    absolutefilepath bigint,
    propertykey_id bigint
);


ALTER TABLE public.property_audit OWNER TO confighub;

--
-- Name: property_ctxlevel; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.property_ctxlevel (
    properties_id bigint NOT NULL,
    context_id bigint NOT NULL
);


ALTER TABLE public.property_ctxlevel OWNER TO confighub;

--
-- Name: property_ctxlevel_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.property_ctxlevel_audit (
    rev bigint NOT NULL,
    properties_id bigint NOT NULL,
    context_id bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone
);


ALTER TABLE public.property_ctxlevel_audit OWNER TO confighub;

--
-- Name: propertykey; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.propertykey (
    id bigint NOT NULL,
    diffjson text,
    deprecated boolean,
    propertykey character varying(255) NOT NULL,
    pushvalueenabled boolean,
    readme text,
    valuedatatype character varying(255) NOT NULL,
    repositoryid bigint NOT NULL,
    securityprofile_id bigint
);


ALTER TABLE public.propertykey OWNER TO confighub;

--
-- Name: propertykey_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.propertykey_audit (
    id bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone,
    diffjson text,
    deprecated boolean,
    propertykey character varying(255),
    pushvalueenabled boolean,
    readme text,
    valuedatatype character varying(255),
    repositoryid bigint,
    securityprofile_id bigint
);


ALTER TABLE public.propertykey_audit OWNER TO confighub;

--
-- Name: repofile; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.repofile (
    id bigint NOT NULL,
    diffjson text,
    active boolean,
    contextjson text,
    contextweight integer NOT NULL,
    content text NOT NULL,
    repositoryid bigint NOT NULL,
    absfilepath_id bigint NOT NULL,
    securityprofile_id bigint
);


ALTER TABLE public.repofile OWNER TO confighub;

--
-- Name: repofile_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.repofile_audit (
    id bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone,
    diffjson text,
    active boolean,
    contextjson text,
    contextweight integer,
    content text,
    repositoryid bigint,
    absfilepath_id bigint,
    securityprofile_id bigint
);


ALTER TABLE public.repofile_audit OWNER TO confighub;

--
-- Name: repofile_ctxlevel; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.repofile_ctxlevel (
    files_id bigint NOT NULL,
    context_id bigint NOT NULL
);


ALTER TABLE public.repofile_ctxlevel OWNER TO confighub;

--
-- Name: repofile_ctxlevel_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.repofile_ctxlevel_audit (
    rev bigint NOT NULL,
    files_id bigint NOT NULL,
    context_id bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone
);


ALTER TABLE public.repofile_ctxlevel_audit OWNER TO confighub;

--
-- Name: repofile_propertykey; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.repofile_propertykey (
    files_id bigint NOT NULL,
    keys_id bigint NOT NULL
);


ALTER TABLE public.repofile_propertykey OWNER TO confighub;

--
-- Name: repofile_propertykey_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.repofile_propertykey_audit (
    rev bigint NOT NULL,
    files_id bigint NOT NULL,
    keys_id bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone
);


ALTER TABLE public.repofile_propertykey_audit OWNER TO confighub;

--
-- Name: repository; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.repository (
    id bigint NOT NULL,
    diffjson text,
    accesscontrolenabled boolean,
    active boolean,
    admincontextcontrolled boolean DEFAULT false,
    allowtokenfreeapipull boolean DEFAULT false,
    allowtokenfreeapipush boolean DEFAULT false,
    contextclustersenabled boolean DEFAULT false,
    createdate timestamp without time zone NOT NULL,
    demo boolean,
    depth character varying(255) NOT NULL,
    depthlabels character varying(255) NOT NULL,
    description character varying(255),
    isprivate boolean NOT NULL,
    name character varying(255) NOT NULL,
    securityprofilesenabled boolean DEFAULT true,
    valuetypeenabled boolean DEFAULT true,
    accountid bigint,
    confirmcontextchange boolean DEFAULT false
);


ALTER TABLE public.repository OWNER TO confighub;

--
-- Name: repository_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.repository_audit (
    id bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone,
    diffjson text,
    accesscontrolenabled boolean,
    active boolean,
    admincontextcontrolled boolean,
    allowtokenfreeapipull boolean,
    allowtokenfreeapipush boolean,
    contextclustersenabled boolean,
    demo boolean,
    depth character varying(255),
    depthlabels character varying(255),
    description character varying(255),
    isprivate boolean,
    name character varying(255),
    securityprofilesenabled boolean,
    valuetypeenabled boolean,
    accountid bigint,
    confirmcontextchange boolean DEFAULT false
);


ALTER TABLE public.repository_audit OWNER TO confighub;

--
-- Name: repository_team; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.repository_team (
    repository_id bigint NOT NULL,
    teams_id bigint NOT NULL
);


ALTER TABLE public.repository_team OWNER TO confighub;

--
-- Name: revisionentry; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.revisionentry (
    id bigint NOT NULL,
    appid character varying(255),
    changecomment text,
    commitgroup character varying(255),
    notify boolean,
    repositoryid bigint,
    revtype text,
    searchkey text,
    "timestamp" bigint,
    type character varying(255),
    userid bigint
);


ALTER TABLE public.revisionentry OWNER TO confighub;

--
-- Name: securityprofile; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.securityprofile (
    id bigint NOT NULL,
    diffjson text,
    cipher character varying(255),
    name character varying(255) NOT NULL,
    sppassword character varying(255) NOT NULL,
    repositoryid bigint NOT NULL
);


ALTER TABLE public.securityprofile OWNER TO confighub;

--
-- Name: securityprofile_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.securityprofile_audit (
    id bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone,
    diffjson text,
    cipher character varying(255),
    name character varying(255),
    sppassword character varying(2048),
    repositoryid bigint
);


ALTER TABLE public.securityprofile_audit OWNER TO confighub;

--
-- Name: systemconfig; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.systemconfig (
    id bigint NOT NULL,
    diffjson text,
    configgroup character varying(255) NOT NULL,
    encrypted boolean,
    configkey character varying(255) NOT NULL,
    value character varying(512)
);


ALTER TABLE public.systemconfig OWNER TO confighub;

--
-- Name: tag; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.tag (
    id bigint NOT NULL,
    diffjson text,
    name character varying(255) NOT NULL,
    readme character varying(255),
    ts bigint NOT NULL,
    repositoryid bigint NOT NULL
);


ALTER TABLE public.tag OWNER TO confighub;

--
-- Name: tag_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.tag_audit (
    id bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone,
    diffjson text,
    name character varying(255),
    readme character varying(255),
    ts bigint,
    repositoryid bigint
);


ALTER TABLE public.tag_audit OWNER TO confighub;

--
-- Name: team; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.team (
    id bigint NOT NULL,
    diffjson text,
    createdate timestamp without time zone NOT NULL,
    description character varying(255),
    name character varying(255) NOT NULL,
    stoponfirstmatch boolean,
    unmatchededitable boolean,
    repositoryid bigint NOT NULL
);


ALTER TABLE public.team OWNER TO confighub;

--
-- Name: team_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.team_audit (
    id bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone,
    diffjson text,
    description character varying(255),
    name character varying(255),
    stoponfirstmatch boolean,
    unmatchededitable boolean,
    repositoryid bigint
);


ALTER TABLE public.team_audit OWNER TO confighub;

--
-- Name: team_token; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.team_token (
    team_id bigint NOT NULL,
    tokens_id bigint NOT NULL
);


ALTER TABLE public.team_token OWNER TO confighub;

--
-- Name: team_token_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.team_token_audit (
    rev bigint NOT NULL,
    team_id bigint NOT NULL,
    tokens_id bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone
);


ALTER TABLE public.team_token_audit OWNER TO confighub;

--
-- Name: team_useraccount; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.team_useraccount (
    team_id bigint NOT NULL,
    members_id bigint NOT NULL
);


ALTER TABLE public.team_useraccount OWNER TO confighub;

--
-- Name: team_useraccount_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.team_useraccount_audit (
    rev bigint NOT NULL,
    team_id bigint NOT NULL,
    members_id bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone
);


ALTER TABLE public.team_useraccount_audit OWNER TO confighub;

--
-- Name: token; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.token (
    id bigint NOT NULL,
    diffjson text,
    active boolean,
    createdon bigint,
    expires bigint,
    forcekeypushenabled boolean,
    managedby character varying(255) NOT NULL,
    name character varying(255),
    token character varying(450),
    managingteamid bigint,
    repository_id bigint NOT NULL,
    teamrulesid bigint,
    useraccountid bigint
);


ALTER TABLE public.token OWNER TO confighub;

--
-- Name: token_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.token_audit (
    id bigint NOT NULL,
    rev bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone,
    diffjson text,
    active boolean,
    createdon bigint,
    expires bigint,
    forcekeypushenabled boolean,
    managedby character varying(255),
    name character varying(255),
    managingteamid bigint,
    repository_id bigint,
    teamrulesid bigint,
    useraccountid bigint
);


ALTER TABLE public.token_audit OWNER TO confighub;

--
-- Name: token_securityprofile; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.token_securityprofile (
    tokens_id bigint NOT NULL,
    securityprofiles_id bigint NOT NULL
);


ALTER TABLE public.token_securityprofile OWNER TO confighub;

--
-- Name: token_securityprofile_audit; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.token_securityprofile_audit (
    rev bigint NOT NULL,
    tokens_id bigint NOT NULL,
    securityprofiles_id bigint NOT NULL,
    revtype smallint,
    revend bigint,
    revend_tstmp timestamp without time zone
);


ALTER TABLE public.token_securityprofile_audit OWNER TO confighub;

--
-- Name: useraccount; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.useraccount (
    id bigint NOT NULL,
    diffjson text,
    active boolean,
    confighubadmin boolean,
    createdate timestamp without time zone NOT NULL,
    emailblog boolean,
    emailrepocritical boolean,
    name character varying(255),
    userpassword character varying(255),
    timezone character varying(255),
    account_id bigint NOT NULL,
    email_id bigint NOT NULL,
    account_type character varying(255) NOT NULL
);


ALTER TABLE public.useraccount OWNER TO confighub;

--
-- Name: useraccount_organization; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.useraccount_organization (
    useraccount_id bigint NOT NULL,
    organizations_id bigint NOT NULL
);


ALTER TABLE public.useraccount_organization OWNER TO confighub;

--
-- Name: useraccount_token; Type: TABLE; Schema: public; Owner: confighub
--

CREATE TABLE public.useraccount_token (
    useraccount_id bigint NOT NULL,
    tokens_id bigint NOT NULL
);


ALTER TABLE public.useraccount_token OWNER TO confighub;

--
-- Data for Name: absolutefilepath; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.absolutefilepath (id, diffjson, abspath, filename, path, repositoryid) FROM stdin;
43	\N	test_file	test_file	\N	6
\.


--
-- Data for Name: absolutefilepath_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.absolutefilepath_audit (id, rev, revtype, revend, revend_tstmp, diffjson, abspath, filename, path, repositoryid) FROM stdin;
20	28	2	\N	\N	\N	test_file	test_file	\N	6
20	22	0	28	2021-07-25 22:15:56.749	\N	test_file	test_file	\N	6
35	38	2	\N	\N	\N	test_file	test_file	\N	6
35	37	0	38	2021-08-07 22:58:17.262	\N	test_file	test_file	\N	6
39	42	2	\N	\N	\N	test	test	\N	6
39	41	0	42	2021-08-07 23:08:48.258	\N	test	test	\N	6
43	45	0	\N	\N	\N	test_file	test_file	\N	6
\.


--
-- Data for Name: accessrule; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.accessrule (id, diffjson, canedit, contextjson, contextmatchtype, keymatchtype, matchvalue, priority, ruletarget, team) FROM stdin;
\.


--
-- Data for Name: accessrule_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.accessrule_audit (id, rev, revtype, revend, revend_tstmp, diffjson, canedit, contextjson, contextmatchtype, keymatchtype, matchvalue, priority, ruletarget, team) FROM stdin;
\.


--
-- Data for Name: accessrule_ctxlevel; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.accessrule_ctxlevel (accessrule_id, context_id) FROM stdin;
\.


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.account (id, diffjson, city, company, country, name, website, organization_id, user_id) FROM stdin;
2	\N	\N	\N	\N	test	\N	\N	1
5	\N	\N	\N	\N	test-organization	\N	4	\N
\.


--
-- Data for Name: account_repository; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.account_repository (account_id, repositories_id) FROM stdin;
5	6
\.


--
-- Data for Name: ctxlevel; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.ctxlevel (id, diffjson, depth, name, type, repositoryid) FROM stdin;
8	\N	D1	dev	Standalone	6
10	\N	D1	prod	Standalone	6
12	\N	D0	backend-app-1	Standalone	6
18	\N	D0	demo-app	Standalone	6
\.


--
-- Data for Name: ctxlevel_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.ctxlevel_audit (id, rev, revtype, revend, revend_tstmp, diffjson, depth, name, type, repositoryid) FROM stdin;
10	11	0	\N	\N	\N	D1	prod	Standalone	6
12	13	0	\N	\N	\N	D0	backend-app-1	Standalone	6
8	9	0	22	2021-07-25 21:45:19.913	\N	D1	dev	Standalone	6
18	22	0	25	2021-07-25 21:45:44.218	\N	D0	demo-app	Standalone	6
8	22	1	25	2021-07-25 21:45:44.218	\N	D1	dev	Standalone	6
18	25	1	27	2021-07-25 22:14:12.926	\N	D0	demo-app	Standalone	6
8	25	1	27	2021-07-25 22:14:12.926	\N	D1	dev	Standalone	6
18	27	1	28	2021-07-25 22:15:56.749	\N	D0	demo-app	Standalone	6
8	27	1	28	2021-07-25 22:15:56.749	\N	D1	dev	Standalone	6
18	28	1	33	2021-08-07 22:48:26.805	\N	D0	demo-app	Standalone	6
8	28	1	33	2021-08-07 22:48:26.805	\N	D1	dev	Standalone	6
18	33	1	37	2021-08-07 22:56:45.015	\N	D0	demo-app	Standalone	6
8	33	1	37	2021-08-07 22:56:45.015	\N	D1	dev	Standalone	6
18	37	1	38	2021-08-07 22:58:17.262	\N	D0	demo-app	Standalone	6
8	37	1	38	2021-08-07 22:58:17.262	\N	D1	dev	Standalone	6
18	38	1	45	2021-08-07 23:11:34.985	\N	D0	demo-app	Standalone	6
8	38	1	45	2021-08-07 23:11:34.985	\N	D1	dev	Standalone	6
18	45	1	47	2021-08-07 23:13:21.998	\N	D0	demo-app	Standalone	6
8	45	1	47	2021-08-07 23:13:21.998	\N	D1	dev	Standalone	6
18	47	1	50	2021-08-07 23:13:35.281	\N	D0	demo-app	Standalone	6
8	47	1	50	2021-08-07 23:13:35.281	\N	D1	dev	Standalone	6
18	50	1	51	2021-08-08 12:20:54.673	\N	D0	demo-app	Standalone	6
8	50	1	51	2021-08-08 12:20:54.673	\N	D1	dev	Standalone	6
18	51	1	54	2021-08-08 12:21:47.162	\N	D0	demo-app	Standalone	6
8	51	1	54	2021-08-08 12:21:47.162	\N	D1	dev	Standalone	6
18	54	1	55	2021-08-08 12:21:49.161	\N	D0	demo-app	Standalone	6
8	54	1	55	2021-08-08 12:21:49.161	\N	D1	dev	Standalone	6
18	55	1	58	2021-08-08 12:21:59.6	\N	D0	demo-app	Standalone	6
8	55	1	58	2021-08-08 12:21:59.6	\N	D1	dev	Standalone	6
18	58	1	62	2021-08-08 15:35:01.167	\N	D0	demo-app	Standalone	6
8	58	1	62	2021-08-08 15:35:01.167	\N	D1	dev	Standalone	6
18	62	1	67	2021-08-08 15:36:22.443	\N	D0	demo-app	Standalone	6
8	62	1	67	2021-08-08 15:36:22.443	\N	D1	dev	Standalone	6
18	67	1	68	2021-08-08 16:01:47.04	\N	D0	demo-app	Standalone	6
8	67	1	68	2021-08-08 16:01:47.04	\N	D1	dev	Standalone	6
18	68	1	73	2021-08-08 16:01:52.587	\N	D0	demo-app	Standalone	6
8	68	1	73	2021-08-08 16:01:52.587	\N	D1	dev	Standalone	6
18	73	1	76	2021-08-08 16:15:06.464	\N	D0	demo-app	Standalone	6
8	73	1	76	2021-08-08 16:15:06.464	\N	D1	dev	Standalone	6
18	76	1	79	2021-08-08 19:28:06.195	\N	D0	demo-app	Standalone	6
8	76	1	79	2021-08-08 19:28:06.195	\N	D1	dev	Standalone	6
18	79	1	84	2021-08-08 19:28:12.253	\N	D0	demo-app	Standalone	6
8	79	1	84	2021-08-08 19:28:12.253	\N	D1	dev	Standalone	6
18	84	1	87	2021-08-08 19:33:44.12	\N	D0	demo-app	Standalone	6
8	84	1	87	2021-08-08 19:33:44.12	\N	D1	dev	Standalone	6
18	87	1	90	2021-08-08 19:39:52.402	\N	D0	demo-app	Standalone	6
8	87	1	90	2021-08-08 19:39:52.402	\N	D1	dev	Standalone	6
18	93	1	\N	\N	\N	D0	demo-app	Standalone	6
8	93	1	\N	\N	\N	D1	dev	Standalone	6
18	90	1	93	2021-08-08 19:40:31.192	\N	D0	demo-app	Standalone	6
8	90	1	93	2021-08-08 19:40:31.192	\N	D1	dev	Standalone	6
\.


--
-- Data for Name: ctxlevel_ctxlevel; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.ctxlevel_ctxlevel (groups_id, members_id) FROM stdin;
\.


--
-- Data for Name: ctxlevel_ctxlevel_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.ctxlevel_ctxlevel_audit (rev, groups_id, members_id, revtype, revend, revend_tstmp) FROM stdin;
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
v1.8-type-changes-1	edoarsla	db/changes/v1.8-type-changes.yml	2021-07-25 21:02:19.228313	1	MARK_RAN	7:43be6a9ab9e6fd890cfc8d1a4cbca6c3	modifyDataType columnName=value, tableName=property; modifyDataType columnName=contextjson, tableName=property		\N	3.5.3	\N	\N	7239739124
v1.8-type-changes-2	edoarsla	db/changes/v1.8-type-changes.yml	2021-07-25 21:02:19.241677	2	MARK_RAN	7:ae61c6e0bfbc4c40408d336509f983c2	modifyDataType columnName=value, tableName=property_audit; modifyDataType columnName=contextjson, tableName=property_audit		\N	3.5.3	\N	\N	7239739124
v1.8-type-changes-3	edoarsla	db/changes/v1.8-type-changes.yml	2021-07-25 21:02:19.252046	3	MARK_RAN	7:46b69880b4e325cc5b79f34d9621db48	modifyDataType columnName=contextjson, tableName=repofile; modifyDataType columnName=content, tableName=repofile		\N	3.5.3	\N	\N	7239739124
v1.8-type-changes-4	edoarsla	db/changes/v1.8-type-changes.yml	2021-07-25 21:02:19.263335	4	MARK_RAN	7:4036a3e21c5e7b5e57c994640de71344	modifyDataType columnName=contextjson, tableName=repofile_audit; modifyDataType columnName=content, tableName=repofile_audit		\N	3.5.3	\N	\N	7239739124
v1.8-type-changes-5	edoarsla	db/changes/v1.8-type-changes.yml	2021-07-25 21:02:19.273215	5	MARK_RAN	7:0223de0bf3deac6952c53dfab198517c	modifyDataType columnName=contextjson, tableName=accessrule		\N	3.5.3	\N	\N	7239739124
v1.8-type-changes-6	edoarsla	db/changes/v1.8-type-changes.yml	2021-07-25 21:02:19.283364	6	MARK_RAN	7:1b393a38e14f2346d99a3a68f670de52	modifyDataType columnName=contextjson, tableName=accessrule_audit		\N	3.5.3	\N	\N	7239739124
v1.8-type-changes-7	edoarsla	db/changes/v1.8-type-changes.yml	2021-07-25 21:02:19.293309	7	MARK_RAN	7:1091f81d33d98ebc2373831892478bad	modifyDataType columnName=revtype, tableName=revisionentry; modifyDataType columnName=searchkey, tableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.8-type-changes-8	edoarsla	db/changes/v1.8-type-changes.yml	2021-07-25 21:02:19.305752	8	MARK_RAN	7:4562fb2b005e706088baf735d1a456f3	modifyDataType columnName=token, tableName=token		\N	3.5.3	\N	\N	7239739124
v1.7-schema-0	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.316793	9	EXECUTED	7:afe897bea20bc08d1681087c94d0967d	createSequence sequenceName=hibernate_sequence		\N	3.5.3	\N	\N	7239739124
v1.7-schema-mysql-0	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.326249	10	MARK_RAN	7:554493e1bf08f3dd3e19fb355a55299d	createTable tableName=hibernate_sequence; insert tableName=hibernate_sequence		\N	3.5.3	\N	\N	7239739124
v1.7-schema-1	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.370154	11	EXECUTED	7:8cdfce79d4b64b3154b75b8757d31560	createTable tableName=absolutefilepath; createIndex indexName=AFP_repoIndex, tableName=absolutefilepath; createIndex indexName=FKlxiorvj8k9qshy951bovehh1y, tableName=absolutefilepath; addUniqueConstraint constraintName=UKrncnvsdk64t5vjteltar1wwcw,...		\N	3.5.3	\N	\N	7239739124
v1.7-schema-2	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.414273	12	EXECUTED	7:605f1613e36270e423b2db02abd05e77	createTable tableName=absolutefilepath_audit; createIndex indexName=FKmf1aigrdb5hbs9b5trysdyuee, tableName=absolutefilepath_audit; createIndex indexName=FKsq3dtvsa6x95tydm8jma44vnd, tableName=absolutefilepath_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-3	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.454697	13	EXECUTED	7:a18d0ef9a9600e90c477d713531038ec	createTable tableName=accessrule; createIndex indexName=FK15h7tel8t9lve1m86923l9y3r, tableName=accessrule		\N	3.5.3	\N	\N	7239739124
v1.7-schema-4	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.50863	14	EXECUTED	7:bff0559644e9f5e95d27bf76b0ec6bfa	createTable tableName=accessrule_audit; createIndex indexName=FKhfvxctssq2074bv5q94bstvpt, tableName=accessrule_audit; createIndex indexName=FKmleuvr9dmidmj2irgprmppijg, tableName=accessrule_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-5	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.538059	15	EXECUTED	7:f3c054375e552e68e6945a5e5aaa7097	createTable tableName=accessrule_level; createIndex indexName=FKo2ovx2b8iggg2579gxugicge, tableName=accessrule_level		\N	3.5.3	\N	\N	7239739124
v1.7-schema-6	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.583604	16	EXECUTED	7:c51dc0eafca25ccc12809c6494e12158	createTable tableName=account; createIndex indexName=FK7kvnw36vqhel8kfy750s2u8u4, tableName=account; createIndex indexName=FKqc9uuldfqmt5qhf6f99f3b169, tableName=account		\N	3.5.3	\N	\N	7239739124
v1.7-schema-7	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.607812	17	EXECUTED	7:78222dd7722e299f15aa4fea254ae9d6	createTable tableName=account_repository; createIndex indexName=FKtmpj15ythpr8eoxmw7t2qv7yx, tableName=account_repository		\N	3.5.3	\N	\N	7239739124
v1.7-schema-8	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.641795	18	EXECUTED	7:0eee46ad559761cbaba566c52e262ab4	createTable tableName=email; createIndex indexName=FKj35ma95suq1bsrm0q606r21d6, tableName=email		\N	3.5.3	\N	\N	7239739124
v1.7-schema-9	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.682065	19	EXECUTED	7:cb2300ced4569fe4c9c6fce0dd53005f	createTable tableName=level; createIndex indexName=FKsxkfkathmadso50q5j6jwvojp, tableName=level; createIndex indexName=LVL_repoIndex, tableName=level; addUniqueConstraint constraintName=UKhgt86bme51u315n6co4rs5ov4, tableName=level		\N	3.5.3	\N	\N	7239739124
v1.7-schema-10	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.720378	20	EXECUTED	7:cf69e3b9c8f740b23a71bf21e60dfddb	createTable tableName=level_audit; createIndex indexName=FKebfp0dnlt1doat9sbrlf5t797, tableName=level_audit; createIndex indexName=FKibnoavw0n8sbh9h53tleyc0i, tableName=level_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-11	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.744023	21	EXECUTED	7:1e0463d4acd41e3e38dd00e21dc8b1c2	createTable tableName=level_level; createIndex indexName=FKnfrngot3489w6q16r32k31q77, tableName=level_level		\N	3.5.3	\N	\N	7239739124
v1.7-schema-12	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.767558	22	EXECUTED	7:197a06010d5faf262eef383ca3b97f29	createTable tableName=level_level_audit; createIndex indexName=FKs9ux7hkhefghun48f10l057yf, tableName=level_level_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-13	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.796784	23	EXECUTED	7:cc9689672f296345c68bad2132d2bbbe	createTable tableName=organization; createIndex indexName=FKsn7d4pawxvy2d39pg6irxvd1x, tableName=organization		\N	3.5.3	\N	\N	7239739124
v1.7-schema-14	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.819915	24	EXECUTED	7:702dc980b36ce7cbecb2b7c909102d12	createTable tableName=organization_admins; createIndex indexName=FK8en1506e58hvi7f2jrdja5ymv, tableName=organization_admins		\N	3.5.3	\N	\N	7239739124
v1.7-schema-15	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.843777	25	EXECUTED	7:d4b374d82ce52b8dfedc3f367c93a092	createTable tableName=organization_owners; createIndex indexName=FKhjxr3b54tih2jo065ft6itkbu, tableName=organization_owners		\N	3.5.3	\N	\N	7239739124
v1.7-schema-16	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.912052	26	EXECUTED	7:2dbe72f873e640a9d78f5e3491bac114	createTable tableName=property; createIndex indexName=FK8nbbs6blxqx3fjm2s51of8oxs, tableName=property; createIndex indexName=FKfxn0wmkpx8k8x2g2r5xyq3jup, tableName=property; createIndex indexName=FKrcfwuulcd2xveojqygbw2j82c, tableName=property; cr...		\N	3.5.3	\N	\N	7239739124
v1.7-schema-17	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.956711	27	EXECUTED	7:5c52651145fbc85956317f7551c35d26	createTable tableName=propertykey; createIndex indexName=FK96xe4gylfsnkofd6y707ktpqk, tableName=propertykey; createIndex indexName=FKlp5w4yjeg4n40cbn4difypkoi, tableName=propertykey; createIndex indexName=PROP_KEY_repoIndex, tableName=propertykey;...		\N	3.5.3	\N	\N	7239739124
v1.7-schema-18	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:19.992745	28	EXECUTED	7:14d542584b84341b52d17da63afd5915	createTable tableName=propertykey_audit; createIndex indexName=FK3glih1wqjtqqysgev5o25gpcm, tableName=propertykey_audit; createIndex indexName=FK8u2evprtwju2drlgqg093ob36, tableName=propertykey_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-19	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.029902	29	EXECUTED	7:f23fc40af72ec19570fc1e62d2f15907	createTable tableName=property_audit; createIndex indexName=FKkw5u1a474bmuixelc44tj160l, tableName=property_audit; createIndex indexName=FKpkx75xd400my1b5ugiidvcqfc, tableName=property_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-20	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.052523	30	EXECUTED	7:7e1f8793a835770b210767f0284f6024	createTable tableName=property_level; createIndex indexName=FKoftlhmr6mf7q48dv8ieht7xlq, tableName=property_level		\N	3.5.3	\N	\N	7239739124
v1.7-schema-21	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.075365	31	EXECUTED	7:7c4de851edd4c0db5f4dab3156b19ac1	createTable tableName=property_level_audit; createIndex indexName=FK836wucyouiewg9olc674m8q9u, tableName=property_level_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-22	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.114364	32	EXECUTED	7:7a870a147466891467e25f9955b6f3ae	createTable tableName=repofile; createIndex indexName=FK4pgaa1lemvlmwtbq1iyub9oix, tableName=repofile; createIndex indexName=FKb5arhv2gq2foi6fyninyrc6oq, tableName=repofile; createIndex indexName=FKc1l7gul4nbp2k4ksqpiu1ak88, tableName=repofile		\N	3.5.3	\N	\N	7239739124
v1.7-schema-23	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.14936	33	EXECUTED	7:e7aeeaf12115809d3ff43b3fe3a5d250	createTable tableName=repofile_audit; createIndex indexName=FKorkynioy6e4qjvq5x1vf8pk3r, tableName=repofile_audit; createIndex indexName=FKpoow0vujn78pvplo2ge5icq1j, tableName=repofile_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-24	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.174703	34	EXECUTED	7:3be434732bf6758d66272376c6f271d6	createTable tableName=repofile_level; createIndex indexName=FK3qvvwt9wwa78lbicgsuigds5n, tableName=repofile_level		\N	3.5.3	\N	\N	7239739124
v1.7-schema-25	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.199157	35	EXECUTED	7:6d2978ba311642a54d35c27cdaf949a9	createTable tableName=repofile_level_audit; createIndex indexName=FK8jvey1udvbi0tptxty36bwphq, tableName=repofile_level_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-26	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.222609	36	EXECUTED	7:d63f38067f357ed1c1478d29a52a0822	createTable tableName=repofile_propertykey; createIndex indexName=FKciasf7bo3pegn0i9413dkwx85, tableName=repofile_propertykey		\N	3.5.3	\N	\N	7239739124
v1.7-schema-27	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.246575	37	EXECUTED	7:624394be1720edf2ff46a88fbec3ca6e	createTable tableName=repofile_propertykey_audit; createIndex indexName=FK2d5fcxo0ajndhid47y38m59su, tableName=repofile_propertykey_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-28	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.287963	38	EXECUTED	7:bc513dd430a492787518d1dcda65b246	createTable tableName=repository; createIndex indexName=FKhb1y76p3uwq7ldt1v3yw1toob, tableName=repository; createIndex indexName=REPO_repoIndex, tableName=repository; addUniqueConstraint constraintName=UKgsxkucdri6drlvmgecqpktajm, tableName=reposi...		\N	3.5.3	\N	\N	7239739124
v1.7-schema-29	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.322014	39	EXECUTED	7:0de52853d2ac94c7a348823fa33a7ef1	createTable tableName=repository_audit; createIndex indexName=FK1g7o4xgai71drg488yerd26ip, tableName=repository_audit; createIndex indexName=FKbet1447sj0vowh21luyg1pxr0, tableName=repository_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-30	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.347071	40	EXECUTED	7:7ad9035a24f1a0e24ddd675606453902	createTable tableName=repository_team		\N	3.5.3	\N	\N	7239739124
v1.7-schema-31	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.371722	41	EXECUTED	7:9f6428982c72fafd57696d5f09e65efe	createTable tableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-32	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.406053	42	EXECUTED	7:ae2fc0bc54139b446340d68b1559d66e	createTable tableName=securityprofile; createIndex indexName=FKm533bmbvjxyettlu30lht2phk, tableName=securityprofile; addUniqueConstraint constraintName=UKj43c2tldwxfjjepnlg6pcfn2o, tableName=securityprofile		\N	3.5.3	\N	\N	7239739124
v1.7-schema-33	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.441287	43	EXECUTED	7:ce93468703cf53ed9b92a67f52f03283	createTable tableName=securityprofile_audit; createIndex indexName=FKagqpsul1wfulvktp1h6gc2pv, tableName=securityprofile_audit; createIndex indexName=FKi4dmghntqndf73lkh14fv1ehx, tableName=securityprofile_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-34	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.475374	44	EXECUTED	7:99be0e742381f9dd4ab42e2596d25054	createTable tableName=tag; createIndex indexName=FKos0n7c0b8uw03eebjttoj73p9, tableName=tag; addUniqueConstraint constraintName=UKp0yolsd976qvlmq2geqy0vs0o, tableName=tag		\N	3.5.3	\N	\N	7239739124
v1.7-schema-35	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.510161	45	EXECUTED	7:a7d42763b729d928d295a4cb63b5b215	createTable tableName=tag_audit; createIndex indexName=FK9wwqqg64jxy3c43qh0a2l4p9q, tableName=tag_audit; createIndex indexName=FKgba3e96fgs78m9vl3lwr9xth6, tableName=tag_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-36	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.550791	46	EXECUTED	7:96771f0c2590260ead2bb8a52ac79747	createTable tableName=team; createIndex indexName=FKb1al5ppjmeiehaqdyk0tu7ts3, tableName=team; addUniqueConstraint constraintName=UK7colvq35hr23h1s8yor42o0ne, tableName=team		\N	3.5.3	\N	\N	7239739124
v1.7-schema-37	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.589573	47	EXECUTED	7:b2aa9d8f230f25ed3ea56c0420f1a1a4	createTable tableName=team_audit; createIndex indexName=FKdfcuec9a2x33kv56vf4q0d4vl, tableName=team_audit; createIndex indexName=FKjc27bq8culudyyove36o8ryjs, tableName=team_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-38	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.616187	48	EXECUTED	7:ee781d33e4cf890f08fc2c2a1cf563bb	createTable tableName=team_token; createIndex indexName=FKrd0ijhb2h4mojpsjf9ilnw6vh, tableName=team_token		\N	3.5.3	\N	\N	7239739124
v1.7-schema-39	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.64069	49	EXECUTED	7:646d1aab4ea0e3ecfe41a457e40022ab	createTable tableName=team_token_audit; createIndex indexName=FK95jswh4td882mk7cgfcxuakaq, tableName=team_token_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-40	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.666631	50	EXECUTED	7:fbffb34baf3f42828af476a4c5672804	createTable tableName=team_useraccount; createIndex indexName=FK2s6fk214jdgsq52b62leyx88y, tableName=team_useraccount		\N	3.5.3	\N	\N	7239739124
v1.7-schema-41	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.69054	51	EXECUTED	7:ab16e8565a385b7fa05338a918ea331d	createTable tableName=team_useraccount_audit; createIndex indexName=FK38698ptunglrx8d89jk1rth9d, tableName=team_useraccount_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-42	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.737858	52	EXECUTED	7:cf4b51acb44b4a11729458caf979a664	createTable tableName=token; createIndex indexName=FKfkvc5xu83bm52meoudrcw56rh, tableName=token; createIndex indexName=FKm0kbpcvdwm30mvbg69r73ohy7, tableName=token; createIndex indexName=FKnp2lq4pjxnidp562y85bugosa, tableName=token; createIndex in...		\N	3.5.3	\N	\N	7239739124
v1.7-schema-43	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.773855	53	EXECUTED	7:d3d9e8e3d65c2beac56273659ff0b02a	createTable tableName=token_audit; createIndex indexName=FKd5ifxen605502nk64fisrwbmp, tableName=token_audit; createIndex indexName=FKrqcpuenwpuam8s451n7w9vcih, tableName=token_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-44	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.79705	54	EXECUTED	7:4b3c18d75e4a4c5c79e4f7146ae0d550	createTable tableName=token_securityprofile; createIndex indexName=FKg2a1v8p9luy9q7et0iqnfxiql, tableName=token_securityprofile		\N	3.5.3	\N	\N	7239739124
v1.7-schema-45	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.820005	55	EXECUTED	7:9898f00689015ab92d44e984356f0704	createTable tableName=token_securityprofile_audit; createIndex indexName=FKntqc411w5b3ps0xtqfpxsl8gl, tableName=token_securityprofile_audit		\N	3.5.3	\N	\N	7239739124
v1.7-schema-46	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.853626	56	EXECUTED	7:31ea78ef37e083b816dd3850d7cba5a5	createTable tableName=useraccount		\N	3.5.3	\N	\N	7239739124
v1.7-schema-47	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.879547	57	EXECUTED	7:3e531aba2f781eb3c8569c39bb79e909	createTable tableName=useraccount_organization; createIndex indexName=FK7jk87189k20odo56i0n2gavp, tableName=useraccount_organization		\N	3.5.3	\N	\N	7239739124
v1.7-schema-48	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:20.902358	58	EXECUTED	7:0c7500beb18bc3f100b71d3f2f5b64c8	createTable tableName=useraccount_token; createIndex indexName=FK1oica1rpw2l41ultyiw6cue5p, tableName=useraccount_token		\N	3.5.3	\N	\N	7239739124
v1.7-schema-127	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:21.182164	59	EXECUTED	7:8623ea8bdaa322a152d9fa76984da2c1	addForeignKeyConstraint baseTableName=level_level_audit, constraintName=FK1448qxyrva8dgm5fbiyg5aqrt, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-128	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:21.459822	60	EXECUTED	7:2084f2de7b3e98ffa7f8b7b14ac482f2	addForeignKeyConstraint baseTableName=accessrule, constraintName=FK15h7tel8t9lve1m86923l9y3r, referencedTableName=team		\N	3.5.3	\N	\N	7239739124
v1.7-schema-129	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:21.746371	61	EXECUTED	7:52194835b66ec0615a7ca2a290c3c2e1	addForeignKeyConstraint baseTableName=useraccount_token, constraintName=FK1al1ccnkukmmmeubmn7kn16e3, referencedTableName=useraccount		\N	3.5.3	\N	\N	7239739124
v1.7-schema-130	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:22.042366	62	EXECUTED	7:02ea3a1f2176ed43d8f91b9d6373d2f8	addForeignKeyConstraint baseTableName=repository_audit, constraintName=FK1g7o4xgai71drg488yerd26ip, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-131	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:22.347227	63	EXECUTED	7:782485d964fa62eb6fed5e35b91fb251	addForeignKeyConstraint baseTableName=team_useraccount_audit, constraintName=FK1hbcekgaloqo39dm4ov5wnmgt, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-132	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:22.65877	64	EXECUTED	7:9db5ed1d55985c88450b795634dbaf62	addForeignKeyConstraint baseTableName=useraccount_token, constraintName=FK1oica1rpw2l41ultyiw6cue5p, referencedTableName=token		\N	3.5.3	\N	\N	7239739124
v1.7-schema-133	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:22.974137	65	EXECUTED	7:a4e9cd9a7b036665343fce9fc8ec888d	addForeignKeyConstraint baseTableName=repository_team, constraintName=FK22qwgbo9a86gco5dcevrqilme, referencedTableName=team		\N	3.5.3	\N	\N	7239739124
v1.7-schema-134	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:23.288474	66	EXECUTED	7:bce7ac30098380dca9f0cae47bed6a27	addForeignKeyConstraint baseTableName=repofile_propertykey_audit, constraintName=FK2d5fcxo0ajndhid47y38m59su, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-135	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:23.629999	67	EXECUTED	7:de4652138030e26147fc5c555a206f65	addForeignKeyConstraint baseTableName=team_token_audit, constraintName=FK2lahsao17rxfgidjots4dygqv, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-136	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:23.962905	68	EXECUTED	7:d2e789ed4f11b01b0303bad309cdd722	addForeignKeyConstraint baseTableName=team_useraccount, constraintName=FK2s6fk214jdgsq52b62leyx88y, referencedTableName=useraccount		\N	3.5.3	\N	\N	7239739124
v1.7-schema-137	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:24.284975	69	EXECUTED	7:a75954556b6a34ce0e7d143120942cc6	addForeignKeyConstraint baseTableName=team_useraccount_audit, constraintName=FK38698ptunglrx8d89jk1rth9d, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-138	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:24.609942	70	EXECUTED	7:c0d9e20afd6c19a7d32e9e7be05f35e2	addForeignKeyConstraint baseTableName=propertykey_audit, constraintName=FK3glih1wqjtqqysgev5o25gpcm, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-139	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:24.942898	71	EXECUTED	7:73c4388dcae98b172b6ed41e318359f6	addForeignKeyConstraint baseTableName=repofile_level, constraintName=FK3qvvwt9wwa78lbicgsuigds5n, referencedTableName=level		\N	3.5.3	\N	\N	7239739124
v1.7-schema-140	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:25.293538	72	EXECUTED	7:28115e6cdd0ad8c6c5d14111b3fe9402	addForeignKeyConstraint baseTableName=repofile, constraintName=FK4pgaa1lemvlmwtbq1iyub9oix, referencedTableName=repository		\N	3.5.3	\N	\N	7239739124
v1.7-schema-141	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:25.640314	73	EXECUTED	7:c9b2ab1f9fe130c35a37c24c6a113d99	addForeignKeyConstraint baseTableName=token_securityprofile_audit, constraintName=FK5l0uk7jwq2jpsv0r77q8htyc8, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-142	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:26.00616	74	EXECUTED	7:0af9dc5ec8cdbe5b839599af314c8449	addForeignKeyConstraint baseTableName=property_level, constraintName=FK6b08s72yy4sfrsllugts5ijh4, referencedTableName=property		\N	3.5.3	\N	\N	7239739124
v1.7-schema-143	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:26.346407	75	EXECUTED	7:32057b6164d9eddf741a5d19f4fdc68d	addForeignKeyConstraint baseTableName=useraccount_organization, constraintName=FK7jk87189k20odo56i0n2gavp, referencedTableName=organization		\N	3.5.3	\N	\N	7239739124
v1.7-schema-144	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:26.700473	76	EXECUTED	7:9ef11471de55e477718350dad0c78348	addForeignKeyConstraint baseTableName=account, constraintName=FK7kvnw36vqhel8kfy750s2u8u4, referencedTableName=useraccount		\N	3.5.3	\N	\N	7239739124
v1.7-schema-145	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:27.076333	77	EXECUTED	7:984323b213b0f978e4e47486aefb50ab	addForeignKeyConstraint baseTableName=property_level_audit, constraintName=FK836wucyouiewg9olc674m8q9u, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-146	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:27.447077	78	EXECUTED	7:4fd70f435cfeac82adf3ef8d5085a44a	addForeignKeyConstraint baseTableName=organization_admins, constraintName=FK8en1506e58hvi7f2jrdja5ymv, referencedTableName=useraccount		\N	3.5.3	\N	\N	7239739124
v1.7-schema-147	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:27.80804	79	EXECUTED	7:85b4673d2aae53affa76a599dd6b408a	addForeignKeyConstraint baseTableName=repofile_level_audit, constraintName=FK8jvey1udvbi0tptxty36bwphq, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-148	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:28.169434	80	EXECUTED	7:cf0eb482a2736d3d3c98bed5fc81fb18	addForeignKeyConstraint baseTableName=property, constraintName=FK8nbbs6blxqx3fjm2s51of8oxs, referencedTableName=absolutefilepath		\N	3.5.3	\N	\N	7239739124
v1.7-schema-149	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:28.544672	81	EXECUTED	7:039d302f36180195eef3b6c3b9953fd1	addForeignKeyConstraint baseTableName=propertykey_audit, constraintName=FK8u2evprtwju2drlgqg093ob36, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-150	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:28.921498	82	EXECUTED	7:8b2c98ef1fc917861c798a2492f1297b	addForeignKeyConstraint baseTableName=team_token_audit, constraintName=FK95jswh4td882mk7cgfcxuakaq, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-151	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:29.292505	83	EXECUTED	7:42ea026a026844919b900eff14fd7eee	addForeignKeyConstraint baseTableName=propertykey, constraintName=FK96xe4gylfsnkofd6y707ktpqk, referencedTableName=repository		\N	3.5.3	\N	\N	7239739124
v1.7-schema-152	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:29.667414	84	EXECUTED	7:5572d5fe50c1e38d0d220d264bccc158	addForeignKeyConstraint baseTableName=tag_audit, constraintName=FK9wwqqg64jxy3c43qh0a2l4p9q, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-153	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:30.056578	85	EXECUTED	7:14cdf1d42e18ad473806bbf979384f16	addForeignKeyConstraint baseTableName=organization_admins, constraintName=FKa353w23sbtn5ibi9x4hia9f1h, referencedTableName=organization		\N	3.5.3	\N	\N	7239739124
v1.7-schema-154	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:30.438329	86	EXECUTED	7:192dc861e5588b144f37bb71ff95604d	addForeignKeyConstraint baseTableName=securityprofile_audit, constraintName=FKagqpsul1wfulvktp1h6gc2pv, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-155	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:30.834721	87	EXECUTED	7:682ba586246b3bb6716ebd19612389ce	addForeignKeyConstraint baseTableName=repository_team, constraintName=FKalmpp97k4ppnccn4n8gl8r5tw, referencedTableName=repository		\N	3.5.3	\N	\N	7239739124
v1.7-schema-156	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:31.22653	88	EXECUTED	7:a42c56fe154d172a6d509239bebc1c19	addForeignKeyConstraint baseTableName=team, constraintName=FKb1al5ppjmeiehaqdyk0tu7ts3, referencedTableName=repository		\N	3.5.3	\N	\N	7239739124
v1.7-schema-157	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:31.629243	89	EXECUTED	7:1cbad7b72ff428a11f1aeb6e4c9f4b0c	addForeignKeyConstraint baseTableName=repofile, constraintName=FKb5arhv2gq2foi6fyninyrc6oq, referencedTableName=absolutefilepath		\N	3.5.3	\N	\N	7239739124
v1.7-schema-158	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:32.04622	90	EXECUTED	7:cbe91eb28cd0b71be18417e4c5268339	addForeignKeyConstraint baseTableName=repository_audit, constraintName=FKbet1447sj0vowh21luyg1pxr0, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-159	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:32.467159	91	EXECUTED	7:28e0304ea797cb39a9b82c91eb0ac7d6	addForeignKeyConstraint baseTableName=organization_owners, constraintName=FKbpmd37bd3t3hhfs9leshxgy8m, referencedTableName=organization		\N	3.5.3	\N	\N	7239739124
v1.7-schema-160	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:32.891588	92	EXECUTED	7:c6ea1ca58c6d77ee15c2e30e55395dc9	addForeignKeyConstraint baseTableName=repofile, constraintName=FKc1l7gul4nbp2k4ksqpiu1ak88, referencedTableName=securityprofile		\N	3.5.3	\N	\N	7239739124
v1.7-schema-161	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:33.303237	93	EXECUTED	7:cd0a9836c668502140320b94df4dfe6a	addForeignKeyConstraint baseTableName=repofile_propertykey, constraintName=FKciasf7bo3pegn0i9413dkwx85, referencedTableName=propertykey		\N	3.5.3	\N	\N	7239739124
v1.7-schema-162	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:33.721833	94	EXECUTED	7:1f5c15b0337a035f25f96273addfd430	addForeignKeyConstraint baseTableName=token_audit, constraintName=FKd5ifxen605502nk64fisrwbmp, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-163	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:34.160461	95	EXECUTED	7:279b8b646b753fbfdf83b518c1d25f7a	addForeignKeyConstraint baseTableName=team_audit, constraintName=FKdfcuec9a2x33kv56vf4q0d4vl, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-164	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:34.58488	96	EXECUTED	7:81f9e8eecb5eafd2fed3260bcec286d1	addForeignKeyConstraint baseTableName=level_audit, constraintName=FKebfp0dnlt1doat9sbrlf5t797, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-165	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:35.019284	97	EXECUTED	7:261e9a11fde0d8392998be9ac1d0bbb4	addForeignKeyConstraint baseTableName=team_token, constraintName=FKebm3i4ccp3uenj1t38rf49f3h, referencedTableName=team		\N	3.5.3	\N	\N	7239739124
v1.7-schema-166	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:35.456506	98	EXECUTED	7:25a83b600599e8c697538f16b9254c78	addForeignKeyConstraint baseTableName=useraccount, constraintName=FKfbnisnh4h1e4uahl4vbw6w72s, referencedTableName=email		\N	3.5.3	\N	\N	7239739124
v1.7-schema-167	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:35.894778	99	EXECUTED	7:c5bd8cb7b0458b6cc30d083dddc3aacd	addForeignKeyConstraint baseTableName=token, constraintName=FKfkvc5xu83bm52meoudrcw56rh, referencedTableName=repository		\N	3.5.3	\N	\N	7239739124
v1.7-schema-168	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:36.337629	100	EXECUTED	7:129202f81ab1910fbb58d9b0348f2289	addForeignKeyConstraint baseTableName=property, constraintName=FKfxn0wmkpx8k8x2g2r5xyq3jup, referencedTableName=repository		\N	3.5.3	\N	\N	7239739124
v1.7-schema-169	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:36.792856	101	EXECUTED	7:15604be6c5490c0df7dd77dec032061f	addForeignKeyConstraint baseTableName=token_securityprofile, constraintName=FKg2a1v8p9luy9q7et0iqnfxiql, referencedTableName=securityprofile		\N	3.5.3	\N	\N	7239739124
v1.7-schema-170	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:37.24697	102	EXECUTED	7:436608cb559eb041c78c119262786fd1	addForeignKeyConstraint baseTableName=accessrule_level, constraintName=FKg4ujll811jdecxkqd3enp2h10, referencedTableName=accessrule		\N	3.5.3	\N	\N	7239739124
v1.7-schema-171	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:37.701804	103	EXECUTED	7:32e4a8a73f1f94900f7ab29b3775b75c	addForeignKeyConstraint baseTableName=tag_audit, constraintName=FKgba3e96fgs78m9vl3lwr9xth6, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-172	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:38.195268	104	EXECUTED	7:5a00efbdefc6ceb873c0a4a6a365496b	addForeignKeyConstraint baseTableName=repository, constraintName=FKhb1y76p3uwq7ldt1v3yw1toob, referencedTableName=account		\N	3.5.3	\N	\N	7239739124
v1.7-schema-173	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:38.709357	105	EXECUTED	7:378ff6f7371367019a033b67b86cce53	addForeignKeyConstraint baseTableName=accessrule_audit, constraintName=FKhfvxctssq2074bv5q94bstvpt, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-174	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:39.186802	106	EXECUTED	7:d44a358f6b0f8b917d7ef83fc9b9526d	addForeignKeyConstraint baseTableName=level_level, constraintName=FKhhv8eqkow45xc3ua1mywrccrl, referencedTableName=level		\N	3.5.3	\N	\N	7239739124
v1.7-schema-175	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:39.672569	107	EXECUTED	7:e4d0ae491b6a16ed27d5cf43effc07a5	addForeignKeyConstraint baseTableName=organization_owners, constraintName=FKhjxr3b54tih2jo065ft6itkbu, referencedTableName=useraccount		\N	3.5.3	\N	\N	7239739124
v1.7-schema-176	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:40.16552	108	EXECUTED	7:334f4ce169ae35fccfa1c59ac2e20639	addForeignKeyConstraint baseTableName=securityprofile_audit, constraintName=FKi4dmghntqndf73lkh14fv1ehx, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-177	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:40.654184	109	EXECUTED	7:704e461232c5d06d10609756eba75982	addForeignKeyConstraint baseTableName=level_audit, constraintName=FKibnoavw0n8sbh9h53tleyc0i, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-178	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:41.150799	110	EXECUTED	7:4786db1b80e150f9c58af8cbeb03f2b4	addForeignKeyConstraint baseTableName=useraccount_organization, constraintName=FKiti8ob1yjytcaxc16svv5vr4f, referencedTableName=useraccount		\N	3.5.3	\N	\N	7239739124
v1.7-schema-179	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:41.638592	111	EXECUTED	7:28871fee5c607e7028e150d6fe422cbe	addForeignKeyConstraint baseTableName=team_useraccount, constraintName=FKj149w80dksbl9j6sihff5nfie, referencedTableName=team		\N	3.5.3	\N	\N	7239739124
v1.7-schema-180	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:42.1418	112	EXECUTED	7:09dc24f540bd8885c7359f6eec80628b	addForeignKeyConstraint baseTableName=email, constraintName=FKj35ma95suq1bsrm0q606r21d6, referencedTableName=useraccount		\N	3.5.3	\N	\N	7239739124
v1.7-schema-181	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:42.660885	113	EXECUTED	7:3d6e4ac645520b8aca4467c9ed8ee2b9	addForeignKeyConstraint baseTableName=team_audit, constraintName=FKjc27bq8culudyyove36o8ryjs, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-182	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:43.179282	114	EXECUTED	7:a0f727a0fefd199dff3a1898d12c3712	addForeignKeyConstraint baseTableName=property_audit, constraintName=FKkw5u1a474bmuixelc44tj160l, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-183	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:43.684372	115	EXECUTED	7:7a637f6b30a1f151331852146ce01d93	addForeignKeyConstraint baseTableName=propertykey, constraintName=FKlp5w4yjeg4n40cbn4difypkoi, referencedTableName=securityprofile		\N	3.5.3	\N	\N	7239739124
v1.7-schema-184	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:44.191671	116	EXECUTED	7:ee3650261b97d7ece25ac5700f902d23	addForeignKeyConstraint baseTableName=absolutefilepath, constraintName=FKlxiorvj8k9qshy951bovehh1y, referencedTableName=repository		\N	3.5.3	\N	\N	7239739124
v1.7-schema-185	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:44.938054	117	EXECUTED	7:7ff9d600b67d703a62c7aad22ef109b6	addForeignKeyConstraint baseTableName=token, constraintName=FKm0kbpcvdwm30mvbg69r73ohy7, referencedTableName=team		\N	3.5.3	\N	\N	7239739124
v1.7-schema-186	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:45.444621	118	EXECUTED	7:f69d67ddcbe2e1698ec4cb9935c217ab	addForeignKeyConstraint baseTableName=securityprofile, constraintName=FKm533bmbvjxyettlu30lht2phk, referencedTableName=repository		\N	3.5.3	\N	\N	7239739124
v1.7-schema-187	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:45.965405	119	EXECUTED	7:75487acbe452e372c3c49cc5a89e31b6	addForeignKeyConstraint baseTableName=absolutefilepath_audit, constraintName=FKmf1aigrdb5hbs9b5trysdyuee, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-188	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:46.490764	120	EXECUTED	7:8a1859ebe823e319788a1274951c484d	addForeignKeyConstraint baseTableName=accessrule_audit, constraintName=FKmleuvr9dmidmj2irgprmppijg, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-189	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:47.015185	121	EXECUTED	7:891a8db2660eba29a62177b87d665d56	addForeignKeyConstraint baseTableName=repofile_level_audit, constraintName=FKn3l2a92chgd2g2kfmg8wgul3e, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-190	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:47.547255	122	EXECUTED	7:1782d43885e516cb301207c96772db74	addForeignKeyConstraint baseTableName=level_level, constraintName=FKnfrngot3489w6q16r32k31q77, referencedTableName=level		\N	3.5.3	\N	\N	7239739124
v1.7-schema-191	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:48.077444	123	EXECUTED	7:21adba75d148d524bf201017381dbbf0	addForeignKeyConstraint baseTableName=token, constraintName=FKnp2lq4pjxnidp562y85bugosa, referencedTableName=team		\N	3.5.3	\N	\N	7239739124
v1.7-schema-192	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:48.616086	124	EXECUTED	7:fa77a3a50dbe0708769a00b6943f8615	addForeignKeyConstraint baseTableName=token_securityprofile_audit, constraintName=FKntqc411w5b3ps0xtqfpxsl8gl, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-193	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:49.16719	125	EXECUTED	7:f9b729398bc17ca917bfa70d9ea6e001	addForeignKeyConstraint baseTableName=accessrule_level, constraintName=FKo2ovx2b8iggg2579gxugicge, referencedTableName=level		\N	3.5.3	\N	\N	7239739124
v1.7-schema-194	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:49.706893	126	EXECUTED	7:de1785338e1e76e8979001fee21ce742	addForeignKeyConstraint baseTableName=property_level, constraintName=FKoftlhmr6mf7q48dv8ieht7xlq, referencedTableName=level		\N	3.5.3	\N	\N	7239739124
v1.7-schema-195	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:50.254336	127	EXECUTED	7:dc6f6f72c2519220f8893ee35e8d454b	addForeignKeyConstraint baseTableName=repofile_audit, constraintName=FKorkynioy6e4qjvq5x1vf8pk3r, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-196	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:50.803084	128	EXECUTED	7:8807cdb1ccefd8f3d11536780502abc3	addForeignKeyConstraint baseTableName=tag, constraintName=FKos0n7c0b8uw03eebjttoj73p9, referencedTableName=repository		\N	3.5.3	\N	\N	7239739124
v1.7-schema-197	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:51.363065	129	EXECUTED	7:ddbb14ac2dc32e0c750fe868e69dc612	addForeignKeyConstraint baseTableName=property_audit, constraintName=FKpkx75xd400my1b5ugiidvcqfc, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-198	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:51.940293	130	EXECUTED	7:b3a71b6cc9688b7dfa46fadc3835e3d8	addForeignKeyConstraint baseTableName=repofile_audit, constraintName=FKpoow0vujn78pvplo2ge5icq1j, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-199	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:52.50155	131	EXECUTED	7:74e2ddad8a69b3e31b78fa7454490d1e	addForeignKeyConstraint baseTableName=account_repository, constraintName=FKq0b8e8gdcgimxh0i5y1krixl4, referencedTableName=account		\N	3.5.3	\N	\N	7239739124
v1.7-schema-200	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:53.067009	132	EXECUTED	7:22775e7c9c5f867c34e2f00f0c9d85f9	addForeignKeyConstraint baseTableName=repofile_propertykey_audit, constraintName=FKq5nqoa66y1cee05x7thcey1q4, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-201	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:53.632483	133	EXECUTED	7:2d10fe2eb704ca8b516bbc855876a5bd	addForeignKeyConstraint baseTableName=token_securityprofile, constraintName=FKq9j69wnbepqwbp4sjs7w3hjkt, referencedTableName=token		\N	3.5.3	\N	\N	7239739124
v1.7-schema-202	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:54.205213	134	EXECUTED	7:bd90d1bbfa15718d2e1c1d2751e80a1e	addForeignKeyConstraint baseTableName=account, constraintName=FKqc9uuldfqmt5qhf6f99f3b169, referencedTableName=organization		\N	3.5.3	\N	\N	7239739124
v1.7-schema-203	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:54.775648	135	EXECUTED	7:f3f076c71fce5e10638e40787358c0ce	addForeignKeyConstraint baseTableName=repofile_level, constraintName=FKqo0kehfrhnsnolc4pqibkn1d1, referencedTableName=repofile		\N	3.5.3	\N	\N	7239739124
v1.7-schema-204	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:55.362595	136	EXECUTED	7:b9d16719071fc9ccd25dc338a982ed66	addForeignKeyConstraint baseTableName=token, constraintName=FKr9y7im342i9i2ed65av30qi6m, referencedTableName=useraccount		\N	3.5.3	\N	\N	7239739124
v1.7-schema-205	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:55.950786	137	EXECUTED	7:a78fc696f66cea0498303a36095f2d62	addForeignKeyConstraint baseTableName=useraccount, constraintName=FKrb18a15tkq1iu4yccla6s8w0f, referencedTableName=account		\N	3.5.3	\N	\N	7239739124
v1.7-schema-206	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:56.54588	138	EXECUTED	7:f69e012a2f335bd618ddd2e73469ac86	addForeignKeyConstraint baseTableName=property, constraintName=FKrcfwuulcd2xveojqygbw2j82c, referencedTableName=propertykey		\N	3.5.3	\N	\N	7239739124
v1.7-schema-207	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:57.139565	139	EXECUTED	7:b68e47a0700ad308871ade2b7cf16dfd	addForeignKeyConstraint baseTableName=team_token, constraintName=FKrd0ijhb2h4mojpsjf9ilnw6vh, referencedTableName=token		\N	3.5.3	\N	\N	7239739124
v1.7-schema-208	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:57.732572	140	EXECUTED	7:b1cc57ae274da64362f56435989380e5	addForeignKeyConstraint baseTableName=token_audit, constraintName=FKrqcpuenwpuam8s451n7w9vcih, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-209	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:58.329829	141	EXECUTED	7:522ab1cde71216bdcdf434580698a0b2	addForeignKeyConstraint baseTableName=level_level_audit, constraintName=FKs9ux7hkhefghun48f10l057yf, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-210	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:58.957886	142	EXECUTED	7:6da291f59d4d9c7add22b3a764174eef	addForeignKeyConstraint baseTableName=organization, constraintName=FKsn7d4pawxvy2d39pg6irxvd1x, referencedTableName=account		\N	3.5.3	\N	\N	7239739124
v1.7-schema-211	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:02:59.594656	143	EXECUTED	7:22efd9a361ba0cf77081b00a18f39b82	addForeignKeyConstraint baseTableName=absolutefilepath_audit, constraintName=FKsq3dtvsa6x95tydm8jma44vnd, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-212	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:03:00.213008	144	EXECUTED	7:4908d381d12daadef9193630bacd018c	addForeignKeyConstraint baseTableName=property_level_audit, constraintName=FKsvw023dj20q9le8hqyr9k5sho, referencedTableName=revisionentry		\N	3.5.3	\N	\N	7239739124
v1.7-schema-213	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:03:00.852259	145	EXECUTED	7:9e1985eb3f23d812d037f179aa028f71	addForeignKeyConstraint baseTableName=level, constraintName=FKsxkfkathmadso50q5j6jwvojp, referencedTableName=repository		\N	3.5.3	\N	\N	7239739124
v1.7-schema-214	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:03:01.49915	146	EXECUTED	7:fbffb96cd52bf6866e1ef88f0da76a71	addForeignKeyConstraint baseTableName=account_repository, constraintName=FKtmpj15ythpr8eoxmw7t2qv7yx, referencedTableName=repository		\N	3.5.3	\N	\N	7239739124
v1.7-schema-215	edoarsla	db/changes/v1.7-schema.yml	2021-07-25 21:03:02.139165	147	EXECUTED	7:22a351e4b582b468b1cf21d3b2a24090	addForeignKeyConstraint baseTableName=repofile_propertykey, constraintName=FKtol4trfdypgs3jp6feqhj3wjf, referencedTableName=repofile		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-1	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.148406	148	MARK_RAN	7:769000bb6c8f219a2495e92321c2a502	renameTable newTableName=absolutefilepath_, oldTableName=AbsoluteFilePath; renameTable newTableName=absolutefilepath, oldTableName=absolutefilepath_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-2	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.156951	149	MARK_RAN	7:93f826a5bdc8fe0e3123dcac7621629e	renameTable newTableName=absolutefilepath_audit_, oldTableName=AbsoluteFilePath_Audit; renameTable newTableName=absolutefilepath_audit, oldTableName=absolutefilepath_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-3	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.165725	150	MARK_RAN	7:15a154721dc76783b5ffbfdc76c7bdeb	renameTable newTableName=accessrule_, oldTableName=AccessRule; renameTable newTableName=accessrule, oldTableName=accessrule_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-4	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.174003	151	MARK_RAN	7:088ef45540330d7acc12b2ec236e34e4	renameTable newTableName=accessrule_audit_, oldTableName=AccessRule_Audit; renameTable newTableName=accessrule_audit, oldTableName=accessrule_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-5	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.184469	152	MARK_RAN	7:4c76be84ace7d7e333db79633746a930	renameTable newTableName=accessrule_level_, oldTableName=AccessRule_Level; renameTable newTableName=accessrule_level, oldTableName=accessrule_level_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-6	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.194224	153	MARK_RAN	7:ea58864b2fa9ac8020010ad704822bc3	renameTable newTableName=account_, oldTableName=Account; renameTable newTableName=account, oldTableName=account_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-7	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.202722	154	MARK_RAN	7:2802fed8196bcca765de10abd4e02b37	renameTable newTableName=account_repository_, oldTableName=Account_Repository; renameTable newTableName=account_repository, oldTableName=account_repository_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-8	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.21112	155	MARK_RAN	7:342160c768751e5ba1eca69892d19b97	renameTable newTableName=email_, oldTableName=Email; renameTable newTableName=email, oldTableName=email_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-9	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.220698	156	MARK_RAN	7:767b94bf39e2f3c0a1fe26142be2d2d4	renameTable newTableName=level_, oldTableName=Level; renameTable newTableName=level, oldTableName=level_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-10	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.229399	157	MARK_RAN	7:a25b3a933bbbc6d1b93cf7b2cd567ac9	renameTable newTableName=level_audit_, oldTableName=Level_Audit; renameTable newTableName=level_audit, oldTableName=level_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-11	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.238032	158	MARK_RAN	7:a009d404f0e0db7a8810d802e3cb3028	renameTable newTableName=level_level_, oldTableName=Level_Level; renameTable newTableName=level_level, oldTableName=level_level_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-12	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.247466	159	MARK_RAN	7:c47e0298ecf4ab1c3ef67019b6db6905	renameTable newTableName=level_level_audit_, oldTableName=Level_Level_Audit; renameTable newTableName=level_level_audit, oldTableName=level_level_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-13	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.256599	160	MARK_RAN	7:a1bd870b8c7f5d7906e0f1d8bf2b9df5	renameTable newTableName=organization_, oldTableName=Organization; renameTable newTableName=organization, oldTableName=organization_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-14	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.265535	161	MARK_RAN	7:03c5eca2fe5cc5c61a748a1b675a1413	renameTable newTableName=organization_admins_, oldTableName=Organization_Admins; renameTable newTableName=organization_admins, oldTableName=organization_admins_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-15	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.274329	162	MARK_RAN	7:1f9eadc1b422f43f8d93fb64e0a0a72e	renameTable newTableName=organization_owners_, oldTableName=Organization_Owners; renameTable newTableName=organization_owners, oldTableName=organization_owners_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-16	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.282906	163	MARK_RAN	7:f051c70fa1f36009fa263a1df92db13c	renameTable newTableName=property_, oldTableName=Property; renameTable newTableName=property, oldTableName=property_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-17	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.291449	164	MARK_RAN	7:30bbb6297062798771e90ce3b505fee1	renameTable newTableName=propertykey_, oldTableName=PropertyKey; renameTable newTableName=propertykey, oldTableName=propertykey_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-18	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.300659	165	MARK_RAN	7:1890169791dc0fe824b8d9272719699f	renameTable newTableName=propertykey_audit_, oldTableName=PropertyKey_Audit; renameTable newTableName=propertykey_audit, oldTableName=propertykey_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-19	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.309142	166	MARK_RAN	7:70119b3d21881518d5687132ca82e6d8	renameTable newTableName=property_audit_, oldTableName=Property_Audit; renameTable newTableName=property_audit, oldTableName=property_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-20	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.317925	167	MARK_RAN	7:d873ffa20a2721fb276ebb61a73d552f	renameTable newTableName=property_level_, oldTableName=Property_Level; renameTable newTableName=property_level, oldTableName=property_level_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-21	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.326655	168	MARK_RAN	7:799a8526c5fa9a81d72935b5f9daa302	renameTable newTableName=property_level_audit_, oldTableName=Property_Level_Audit; renameTable newTableName=property_level_audit, oldTableName=property_level_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-22	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.335746	169	MARK_RAN	7:e762b2e4991a70d3a074883b37aaf01d	renameTable newTableName=repofile_, oldTableName=RepoFile; renameTable newTableName=repofile, oldTableName=repofile_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-23	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.345074	170	MARK_RAN	7:74616a1ea61e9dda99f42c9a27d8a146	renameTable newTableName=repofile_audit_, oldTableName=RepoFile_Audit; renameTable newTableName=repofile_audit, oldTableName=repofile_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-24	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.354239	171	MARK_RAN	7:fcc243586e56f296bc0d1f238fa83931	renameTable newTableName=repofile_level_, oldTableName=RepoFile_Level; renameTable newTableName=repofile_level, oldTableName=repofile_level_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-25	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.362949	172	MARK_RAN	7:48b7f5ea84ef7160284a6c185ee4ac75	renameTable newTableName=repofile_level_audit_, oldTableName=RepoFile_Level_Audit; renameTable newTableName=repofile_level_audit, oldTableName=repofile_level_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-26	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.372077	173	MARK_RAN	7:e094b5b53f63a0564b65f1344e2f10d9	renameTable newTableName=repofile_propertykey_, oldTableName=RepoFile_PropertyKey; renameTable newTableName=repofile_propertykey, oldTableName=repofile_propertykey_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-27	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.380856	174	MARK_RAN	7:b18686d2607cca55ca2964772f427113	renameTable newTableName=repofile_propertykey_audit_, oldTableName=RepoFile_PropertyKey_Audit; renameTable newTableName=repofile_propertykey_audit, oldTableName=repofile_propertykey_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-28	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.389254	175	MARK_RAN	7:f954f60e453a88e055bd05c0b4016f7b	renameTable newTableName=repository_, oldTableName=Repository; renameTable newTableName=repository, oldTableName=repository_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-29	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.39794	176	MARK_RAN	7:042528cf6a43c02fd11248f7b6d489ad	renameTable newTableName=repository_audit_, oldTableName=Repository_Audit; renameTable newTableName=repository_audit, oldTableName=repository_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-30	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.407225	177	MARK_RAN	7:663ff17ac23242e634e5f45520bfdb80	renameTable newTableName=repository_team_, oldTableName=Repository_Team; renameTable newTableName=repository_team, oldTableName=repository_team_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-31	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.416337	178	MARK_RAN	7:3dfe6e6ec868742e1846d2248ca8cba5	renameTable newTableName=revisionentry_, oldTableName=RevisionEntry; renameTable newTableName=revisionentry, oldTableName=revisionentry_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-32	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.425067	179	MARK_RAN	7:df59a0649943166cb36956c16bc0c091	renameTable newTableName=securityprofile_, oldTableName=SecurityProfile; renameTable newTableName=securityprofile, oldTableName=securityprofile_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-33	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.43437	180	MARK_RAN	7:5fd26e28b48e18fb8215860b43bd6795	renameTable newTableName=securityprofile_audit_, oldTableName=SecurityProfile_Audit; renameTable newTableName=securityprofile_audit, oldTableName=securityprofile_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-34	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.445089	181	MARK_RAN	7:06272808165e889965713b9f17e5bcdf	renameTable newTableName=tag_, oldTableName=Tag; renameTable newTableName=tag, oldTableName=tag_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-35	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.455523	182	MARK_RAN	7:19f0cff4713e47b5155f4d2a8b23d15b	renameTable newTableName=tag_audit_, oldTableName=Tag_Audit; renameTable newTableName=tag_audit, oldTableName=tag_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-36	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.46541	183	MARK_RAN	7:f20080b991ba59c3a2e7ef7cb45d81d1	renameTable newTableName=team_, oldTableName=Team; renameTable newTableName=team, oldTableName=team_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-37	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.475009	184	MARK_RAN	7:b761435ff3ec6bca6b63ea1a247a7a61	renameTable newTableName=team_audit_, oldTableName=Team_Audit; renameTable newTableName=team_audit, oldTableName=team_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-38	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.48473	185	MARK_RAN	7:9595c103c1f1a2d2436a82ae8f5eb9c2	renameTable newTableName=team_token_, oldTableName=Team_Token; renameTable newTableName=team_token, oldTableName=team_token_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-39	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.493447	186	MARK_RAN	7:2e7bc7950330fb82e9c9af11859f35d4	renameTable newTableName=team_token_audit_, oldTableName=Team_Token_Audit; renameTable newTableName=team_token_audit, oldTableName=team_token_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-40	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.5066	187	MARK_RAN	7:a3d74b39b6a1644106b73b3839691702	renameTable newTableName=team_useraccount_, oldTableName=Team_UserAccount; renameTable newTableName=team_useraccount, oldTableName=team_useraccount_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-41	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.527727	188	MARK_RAN	7:f800469719a7a8315f6fde527e98c9b2	renameTable newTableName=team_useraccount_audit_, oldTableName=Team_UserAccount_Audit; renameTable newTableName=team_useraccount_audit, oldTableName=team_useraccount_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-42	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.539555	189	MARK_RAN	7:f1952bcbea1e324c694f13d9019885b0	renameTable newTableName=token_, oldTableName=Token; renameTable newTableName=token, oldTableName=token_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-43	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.549572	190	MARK_RAN	7:d957240a7d0a3f5117309bdec86ae7c0	renameTable newTableName=token_audit_, oldTableName=Token_Audit; renameTable newTableName=token_audit, oldTableName=token_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-44	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.558988	191	MARK_RAN	7:21c8db151149ed3e55f4c90bbe65ec7b	renameTable newTableName=token_securityprofile_, oldTableName=Token_SecurityProfile; renameTable newTableName=token_securityprofile, oldTableName=token_securityprofile_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-45	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.568587	192	MARK_RAN	7:8b68bbf8e67e18241710b2f5b9bb370e	renameTable newTableName=token_securityprofile_audit_, oldTableName=Token_SecurityProfile_Audit; renameTable newTableName=token_securityprofile_audit, oldTableName=token_securityprofile_audit_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-46	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.579269	193	MARK_RAN	7:2f488163580a2169ad689b4895ed9373	renameTable newTableName=useraccount_, oldTableName=UserAccount; renameTable newTableName=useraccount, oldTableName=useraccount_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-47	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.588569	194	MARK_RAN	7:695cd44e83d56b60fa3260fdce3c77b3	renameTable newTableName=useraccount_organization_, oldTableName=UserAccount_Organization; renameTable newTableName=useraccount_organization, oldTableName=useraccount_organization_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-camel-case-48	edoarsla	db/changes/v1.8-camel-case.yml	2021-07-25 21:03:02.597389	195	MARK_RAN	7:5ecdaaeeea63dce4f8e44d17a75e02f2	renameTable newTableName=useraccount_token_, oldTableName=UserAccount_Token; renameTable newTableName=useraccount_token, oldTableName=useraccount_token_		\N	3.5.3	\N	\N	7239739124
v1.8-schema-0001	edoarsla	db/changes/v1.8-schema.yml	2021-07-25 21:03:02.605853	196	EXECUTED	7:51feb799a2fd667918dd9003a97641df	renameTable newTableName=ctxlevel, oldTableName=level; renameTable newTableName=accessrule_ctxlevel, oldTableName=accessrule_level; renameTable newTableName=property_ctxlevel, oldTableName=property_level; renameTable newTableName=property_ctxlevel...		\N	3.5.3	\N	\N	7239739124
v1.8-schema-0002	edoarsla	db/changes/v1.8-schema.yml	2021-07-25 21:03:02.640208	197	EXECUTED	7:a4d85f72f069f461e700a23335e866f6	createTable tableName=systemconfig; createIndex indexName=system_config_index, tableName=systemconfig; addUniqueConstraint constraintName=uk_r3juf5ghb12odn7dwiaxulbx0, tableName=systemconfig; addUniqueConstraint constraintName=ukq42ipys8wps81i1q3t...		\N	3.5.3	\N	\N	7239739124
v1.8-schema-0003	edoarsla	db/changes/v1.8-schema.yml	2021-07-25 21:03:02.646746	198	EXECUTED	7:3fa8be48b7451802fa1177bb36864819	renameColumn newColumnName=userpassword, oldColumnName=password, tableName=useraccount; renameColumn newColumnName=sppassword, oldColumnName=password, tableName=securityprofile; renameColumn newColumnName=sppassword, oldColumnName=password, tableN...		\N	3.5.3	\N	\N	7239739124
v1.8-schema-0004	edoarsla	db/changes/v1.8-schema.yml	2021-07-25 21:03:02.654627	199	EXECUTED	7:5cd6ce42482cfa04e5150c6c073a9509	addColumn tableName=useraccount; addNotNullConstraint columnName=account_type, tableName=useraccount		\N	3.5.3	\N	\N	7239739124
v1.8-schema-0005	edoarsla	db/changes/v1.8-schema.yml	2021-07-25 21:03:02.662339	200	EXECUTED	7:dcb207d1974e9246c170de4059208ec7	dropNotNullConstraint columnName=userpassword, tableName=useraccount		\N	3.5.3	\N	\N	7239739124
v1.9-schema-0001	ngolini	db/changes/v1.9-schema.yml	2021-07-25 21:03:02.669235	201	EXECUTED	7:1d2bbecafee2bae470d22284ddd3a5cc	addColumn tableName=repository		\N	3.5.3	\N	\N	7239739124
v1.9-schema-0002	ngolini	db/changes/v1.9-schema.yml	2021-07-25 21:03:02.675321	202	EXECUTED	7:6e95db2f6b674fbd31b95d5e5a887b6d	addColumn tableName=repository_audit		\N	3.5.3	\N	\N	7239739124
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: email; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.email (id, diffjson, email, user_id) FROM stdin;
3	\N	test@test.com	1
\.


--
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.organization (id, diffjson, createdate, name, account_id) FROM stdin;
4	\N	2021-07-25 19:06:27.198	\N	5
\.


--
-- Data for Name: organization_admins; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.organization_admins (organization_id, administrators_id) FROM stdin;
\.


--
-- Data for Name: organization_owners; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.organization_owners (organization_id, owners_id) FROM stdin;
4	1
\.


--
-- Data for Name: property; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.property (id, diffjson, active, contextjson, contextweight, value, repositoryid, absolutefilepath, propertykey_id) FROM stdin;
69	{"value":"[\\"Value 1\\",\\"Value 2\\"]"}	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	This is a simple string	6	\N	70
81	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	["Value 1","Value 2"]	6	\N	83
91	{"value":{"key_1":"Value 1","key_2":"Value 2"}}	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	{"key_1":"Key 1 Value","key_2":"Key 2 Value"}	6	\N	92
\.


--
-- Data for Name: property_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.property_audit (id, rev, revtype, revend, revend_tstmp, diffjson, active, contextjson, contextweight, value, repositoryid, absolutefilepath, propertykey_id) FROM stdin;
23	27	2	\N	\N	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	This is a simple string	6	\N	24
23	25	0	27	2021-07-25 22:14:12.926	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	This is a simple string	6	\N	24
30	47	2	\N	\N	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	This is a simple string	6	\N	31
30	33	0	47	2021-08-07 23:13:21.998	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	This is a simple string	6	\N	31
48	51	2	\N	\N	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	This is a simple string	6	\N	49
48	50	0	51	2021-08-08 12:20:54.673	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	This is a simple string	6	\N	49
52	55	2	\N	\N	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	This is a simple string	6	\N	53
52	54	0	55	2021-08-08 12:21:49.161	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	This is a simple string	6	\N	53
56	58	0	59	2021-08-08 13:00:56.884	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	This is a simple string	6	\N	57
56	59	1	60	2021-08-08 15:15:19.473	{"value":"This is a simple string"}	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	["Value 1","Value 2"]	6	\N	57
56	60	1	61	2021-08-08 15:15:35.047	{"value":"[\\"Value 1\\",\\"Value 2\\"]"}	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	Value 1\r\nValue 2	6	\N	57
56	62	2	\N	\N	{"value":"Value 1\\r\\nValue 2","vdt":"Text"}	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	Test value	6	\N	57
56	61	1	62	2021-08-08 15:35:01.167	{"value":"Value 1\\r\\nValue 2","vdt":"Text"}	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	Test value	6	\N	57
63	68	2	\N	\N	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	["Value 1","Value 2"]	6	\N	65
63	67	0	68	2021-08-08 16:01:47.04	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	["Value 1","Value 2"]	6	\N	65
69	77	1	\N	\N	{"value":"[\\"Value 1\\",\\"Value 2\\"]"}	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	This is a simple string	6	\N	70
69	73	0	77	2021-08-08 16:15:51.311	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	["Value 1","Value 2"]	6	\N	70
74	76	0	78	2021-08-08 19:18:11.055	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	["Value 1","Value 2"]	6	\N	75
74	79	2	\N	\N	{"value":"[\\"Value 1\\",\\"Value 2\\"]"}	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	{}	6	\N	75
74	78	1	79	2021-08-08 19:28:06.195	{"value":"[\\"Value 1\\",\\"Value 2\\"]"}	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	{}	6	\N	75
81	84	0	\N	\N	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	["Value 1","Value 2"]	6	\N	83
85	87	0	88	2021-08-08 19:36:05.397	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	{}	6	\N	86
85	88	1	89	2021-08-08 19:39:27.388	{"value":{}}	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	{"key_2":"Value 2","key_1":"Value 1"}	6	\N	86
85	90	2	\N	\N	{"value":{"key_2":"Value 2","key_1":"Value 1"}}	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	{"key_1":"Value 1","key_2":"Value 2"}	6	\N	86
85	89	1	90	2021-08-08 19:39:52.402	{"value":{"key_2":"Value 2","key_1":"Value 1"}}	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	{"key_1":"Value 1","key_2":"Value 2"}	6	\N	86
91	94	1	\N	\N	{"value":{"key_1":"Value 1","key_2":"Value 2"}}	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	{"key_1":"Key 1 Value","key_2":"Key 2 Value"}	6	\N	92
91	93	0	94	2021-08-08 20:49:57.249	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	{"key_1":"Value 1","key_2":"Value 2"}	6	\N	92
\.


--
-- Data for Name: property_ctxlevel; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.property_ctxlevel (properties_id, context_id) FROM stdin;
69	18
69	8
81	18
81	8
91	18
91	8
\.


--
-- Data for Name: property_ctxlevel_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.property_ctxlevel_audit (rev, properties_id, context_id, revtype, revend, revend_tstmp) FROM stdin;
27	23	18	2	\N	\N
27	23	8	2	\N	\N
25	23	18	0	27	2021-07-25 22:14:12.926
25	23	8	0	27	2021-07-25 22:14:12.926
47	30	18	2	\N	\N
47	30	8	2	\N	\N
33	30	18	0	47	2021-08-07 23:13:21.998
33	30	8	0	47	2021-08-07 23:13:21.998
51	48	18	2	\N	\N
51	48	8	2	\N	\N
50	48	18	0	51	2021-08-08 12:20:54.673
50	48	8	0	51	2021-08-08 12:20:54.673
55	52	18	2	\N	\N
55	52	8	2	\N	\N
54	52	18	0	55	2021-08-08 12:21:49.161
54	52	8	0	55	2021-08-08 12:21:49.161
62	56	18	2	\N	\N
62	56	8	2	\N	\N
58	56	18	0	62	2021-08-08 15:35:01.167
58	56	8	0	62	2021-08-08 15:35:01.167
68	63	18	2	\N	\N
68	63	8	2	\N	\N
67	63	18	0	68	2021-08-08 16:01:47.04
67	63	8	0	68	2021-08-08 16:01:47.04
73	69	18	0	\N	\N
73	69	8	0	\N	\N
79	74	18	2	\N	\N
79	74	8	2	\N	\N
76	74	18	0	79	2021-08-08 19:28:06.195
76	74	8	0	79	2021-08-08 19:28:06.195
84	81	18	0	\N	\N
84	81	8	0	\N	\N
90	85	18	2	\N	\N
90	85	8	2	\N	\N
87	85	18	0	90	2021-08-08 19:39:52.402
87	85	8	0	90	2021-08-08 19:39:52.402
93	91	18	0	\N	\N
93	91	8	0	\N	\N
\.


--
-- Data for Name: propertykey; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.propertykey (id, diffjson, deprecated, propertykey, pushvalueenabled, readme, valuedatatype, repositoryid, securityprofile_id) FROM stdin;
70	{"vdt":"List"}	f	text_value_test	t		Text	6	\N
83	\N	f	list_value_test	t		List	6	\N
92	\N	f	map_value_test	t		Map	6	\N
\.


--
-- Data for Name: propertykey_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.propertykey_audit (id, rev, revtype, revend, revend_tstmp, diffjson, deprecated, propertykey, pushvalueenabled, readme, valuedatatype, repositoryid, securityprofile_id) FROM stdin;
24	27	2	\N	\N	\N	f	text_value_test	t		Text	6	\N
24	25	0	27	2021-07-25 22:14:12.926	\N	f	text_value_test	t		Text	6	\N
31	47	2	\N	\N	\N	f	text_value_test	t		Text	6	\N
31	33	0	47	2021-08-07 23:13:21.998	\N	f	text_value_test	t		Text	6	\N
49	51	2	\N	\N	\N	f	text_value_test	t		Text	6	\N
49	50	0	51	2021-08-08 12:20:54.673	\N	f	text_value_test	t		Text	6	\N
53	55	2	\N	\N	\N	f	text_value_test	t		Text	6	\N
53	54	0	55	2021-08-08 12:21:49.161	\N	f	text_value_test	t		Text	6	\N
57	58	0	59	2021-08-08 13:00:56.884	\N	f	text_value_test	t		Text	6	\N
57	59	1	60	2021-08-08 15:15:19.473	{"vdt":"Text"}	f	text_value_test	t		List	6	\N
57	62	2	\N	\N	{"vdt":"List"}	f	text_value_test	t		Text	6	\N
57	60	1	62	2021-08-08 15:35:01.167	{"vdt":"List"}	f	text_value_test	t		Text	6	\N
65	68	2	\N	\N	\N	f	text_value_test	t		List	6	\N
65	67	0	68	2021-08-08 16:01:47.04	\N	f	text_value_test	t		List	6	\N
70	77	1	\N	\N	{"vdt":"List"}	f	text_value_test	t		Text	6	\N
70	73	0	77	2021-08-08 16:15:51.311	\N	f	text_value_test	t		List	6	\N
75	76	0	78	2021-08-08 19:18:11.055	\N	f	list_value_test	t		List	6	\N
75	79	2	\N	\N	{"vdt":"List"}	f	list_value_test	t		Map	6	\N
75	78	1	79	2021-08-08 19:28:06.195	{"vdt":"List"}	f	list_value_test	t		Map	6	\N
83	84	0	\N	\N	\N	f	list_value_test	t		List	6	\N
86	90	2	\N	\N	\N	f	map_value_test	t		Map	6	\N
86	87	0	90	2021-08-08 19:39:52.402	\N	f	map_value_test	t		Map	6	\N
92	93	0	\N	\N	\N	f	map_value_test	t		Map	6	\N
\.


--
-- Data for Name: repofile; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.repofile (id, diffjson, active, contextjson, contextweight, content, repositoryid, absfilepath_id, securityprofile_id) FROM stdin;
44	{}	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	The content of the file	6	43	\N
\.


--
-- Data for Name: repofile_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.repofile_audit (id, rev, revtype, revend, revend_tstmp, diffjson, active, contextjson, contextweight, content, repositoryid, absfilepath_id, securityprofile_id) FROM stdin;
21	28	2	\N	\N	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	The content of the file	6	20	\N
21	22	0	28	2021-07-25 22:15:56.749	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	The content of the file	6	20	\N
36	38	2	\N	\N	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	The content of the file	6	35	\N
36	37	0	38	2021-08-07 22:58:17.262	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	The content of the file	6	35	\N
40	42	2	\N	\N	\N	t	[{"p":2560},{"p":5120}]	0	asdfas	6	39	\N
40	41	0	42	2021-08-07 23:08:48.258	\N	t	[{"p":2560},{"p":5120}]	0	asdfas	6	39	\N
44	46	1	\N	\N	{}	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	The content of the file	6	43	\N
44	45	0	46	2021-08-07 23:13:08.15	\N	t	[{"p":2560,"n":"dev","t":0,"w":2560},{"p":5120,"n":"demo-app","t":0,"w":5120}]	7680	The content of the file	6	43	\N
\.


--
-- Data for Name: repofile_ctxlevel; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.repofile_ctxlevel (files_id, context_id) FROM stdin;
44	18
44	8
\.


--
-- Data for Name: repofile_ctxlevel_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.repofile_ctxlevel_audit (rev, files_id, context_id, revtype, revend, revend_tstmp) FROM stdin;
28	21	18	2	\N	\N
28	21	8	2	\N	\N
22	21	18	0	28	2021-07-25 22:15:56.749
22	21	8	0	28	2021-07-25 22:15:56.749
38	36	18	2	\N	\N
38	36	8	2	\N	\N
37	36	18	0	38	2021-08-07 22:58:17.262
37	36	8	0	38	2021-08-07 22:58:17.262
45	44	18	0	\N	\N
45	44	8	0	\N	\N
\.


--
-- Data for Name: repofile_propertykey; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.repofile_propertykey (files_id, keys_id) FROM stdin;
\.


--
-- Data for Name: repofile_propertykey_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.repofile_propertykey_audit (rev, files_id, keys_id, revtype, revend, revend_tstmp) FROM stdin;
\.


--
-- Data for Name: repository; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.repository (id, diffjson, accesscontrolenabled, active, admincontextcontrolled, allowtokenfreeapipull, allowtokenfreeapipush, contextclustersenabled, createdate, demo, depth, depthlabels, description, isprivate, name, securityprofilesenabled, valuetypeenabled, accountid, confirmcontextchange) FROM stdin;
6	\N	f	t	f	f	f	f	2021-07-25 19:07:02.175	f	D1	Application,Environment	\N	t	demo	t	t	5	f
\.


--
-- Data for Name: repository_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.repository_audit (id, rev, revtype, revend, revend_tstmp, diffjson, accesscontrolenabled, active, admincontextcontrolled, allowtokenfreeapipull, allowtokenfreeapipush, contextclustersenabled, demo, depth, depthlabels, description, isprivate, name, securityprofilesenabled, valuetypeenabled, accountid, confirmcontextchange) FROM stdin;
6	7	0	\N	\N	\N	f	t	f	f	f	f	f	D1	Application,Environment	\N	t	demo	t	t	5	f
\.


--
-- Data for Name: repository_team; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.repository_team (repository_id, teams_id) FROM stdin;
\.


--
-- Data for Name: revisionentry; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.revisionentry (id, appid, changecomment, commitgroup, notify, repositoryid, revtype, searchkey, "timestamp", type, userid) FROM stdin;
7	\N	\N	RepoSettings	f	6	{"6":"Add"}	\N	1627240020184	Repository	1
9	\N	\N	Config	f	6	{"8":"Add"}	\N	1627240028794	ContextItem	1
11	\N	\N	Config	f	6	{"10":"Add"}	\N	1627240034114	ContextItem	1
13	\N	\N	Config	f	6	{"12":"Add"}	\N	1627240084184	ContextItem	1
15	\N	\N	Security	f	6	{"14":"Add"}	\N	1627247574790	SecurityProfile	1
17	\N	\N	Tokens	f	6	{"16":"Add"}	\N	1627247605794	Token	1
22	\N	Managed by Terraform	Files	f	6	{"18":"Add","20":"Add","21":"Add"}	\N	1627249519913	AbsoluteFilePath,ContextItem,RepoFile	\N
25	\N	Managed by Terraform	Config	f	6	{"23":"Add","24":"Add"}	\N	1627249544218	Property,PropertyKey	\N
27	\N	\N	Config	f	6	{"23":"Delete","24":"Delete"}	|text_value_test|	1627251252926	Property,PropertyKey	\N
28	\N	\N	Files	f	6	{"20":"Delete","21":"Delete"}	\N	1627251356749	AbsoluteFilePath,RepoFile	1
33	\N	Managed by Terraform	Config	f	6	{"30":"Add","31":"Add"}	\N	1628376506805	Property,PropertyKey	\N
37	\N	Managed by Terraform	Files	f	6	{"35":"Add","36":"Add"}	\N	1628377005015	RepoFile,AbsoluteFilePath	\N
38	\N	\N	Files	f	6	{"35":"Delete","36":"Delete"}	\N	1628377097262	RepoFile,AbsoluteFilePath	1
41	\N		Files	f	6	{"39":"Add","40":"Add"}	\N	1628377391438	RepoFile,AbsoluteFilePath	1
42	\N	\N	Files	f	6	{"39":"Delete","40":"Delete"}	\N	1628377728258	RepoFile,AbsoluteFilePath	\N
45	\N		Files	f	6	{"43":"Add","44":"Add"}	\N	1628377894985	RepoFile,AbsoluteFilePath	1
46	\N	Managed by Terraform	Files	f	6	{"44":"Modify"}	\N	1628377988150	RepoFile	\N
47	\N	\N	Config	f	6	{"30":"Delete","31":"Delete"}	|text_value_test|	1628378001998	Property,PropertyKey	\N
50	\N	Managed by Terraform	Config	f	6	{"48":"Add","49":"Add"}	\N	1628378015281	Property,PropertyKey	\N
51	\N	\N	Config	f	6	{"48":"Delete","49":"Delete"}	|text_value_test|	1628425254673	Property,PropertyKey	\N
54	\N	Managed by Terraform	Files	f	6	{"52":"Add","53":"Add","44":"Modify"}	|text_value_test|	1628425307162	RepoFile,Property,PropertyKey	\N
55	\N	\N	Config	f	6	{"52":"Delete","53":"Delete"}	|text_value_test|	1628425309161	Property,PropertyKey	\N
58	\N	Managed by Terraform	Config	f	6	{"56":"Add","57":"Add"}	\N	1628425319600	Property,PropertyKey	\N
59	\N	Managed by Terraform	Config	f	6	{"52":"Modify","53":"Modify","56":"Modify","57":"Modify"}	|text_value_test|	1628427656884	Property,PropertyKey	\N
60	\N		Config	f	6	{"57":"Modify"}	\N	1628435719473	PropertyKey	1
61	\N		Config	f	6	{"56":"Modify"}	\N	1628435735047	Property	1
62	\N	\N	Config	f	6	{"56":"Delete","57":"Delete"}	|text_value_test|	1628436901167	Property,PropertyKey	1
67	\N	Managed by Terraform	Config	f	6	{"65":"Add","63":"Add"}	\N	1628436982443	Property,PropertyKey	\N
68	\N	\N	Config	f	6	{"65":"Delete","63":"Delete"}	|text_value_test|	1628438507040	Property,PropertyKey	1
73	\N	Managed by Terraform	Config	f	6	{"69":"Add","70":"Add"}	\N	1628438512587	Property,PropertyKey	\N
76	\N	Managed by Terraform	Config	f	6	{"69":"Delete","70":"Delete","74":"Add","75":"Add"}	|text_value_test|list_value_test|	1628439306464	Property,PropertyKey	\N
77	\N	Managed by Terraform	Config	f	6	{"69":"Modify","70":"Modify"}	\N	1628439351311	Property,PropertyKey	\N
78	\N	Managed by Terraform	Config	f	6	{"65":"Delete","74":"Modify","75":"Modify","63":"Delete"}	|text_value_test|list_value_test|	1628450291055	Property,PropertyKey	\N
79	\N	\N	Config	f	6	{"65":"Delete","69":"Modify","70":"Modify","74":"Delete","75":"Delete","63":"Delete"}	|text_value_test|list_value_test|	1628450886195	Property,PropertyKey	1
84	\N	Managed by Terraform	Config	f	6	{"81":"Add","83":"Add","69":"Delete","70":"Delete"}	|text_value_test|list_value_test|	1628450892253	Property,PropertyKey	\N
87	\N	Managed by Terraform	Config	f	6	{"69":"Delete","85":"Add","70":"Delete","86":"Add"}	|map_value_test|text_value_test|	1628451224120	Property,PropertyKey	\N
88	\N	Managed by Terraform	Config	f	6	{"85":"Modify","86":"Modify"}	\N	1628451365397	Property,PropertyKey	\N
89	\N	Managed by Terraform	Config	f	6	{"69":"Modify","85":"Modify","70":"Modify","86":"Modify"}	|map_value_test|	1628451567388	Property,PropertyKey	\N
90	\N	\N	Config	f	6	{"85":"Delete","86":"Delete"}	|map_value_test|	1628451592402	Property,PropertyKey	1
93	\N	Managed by Terraform	Config	f	6	{"65":"Delete","85":"Delete","86":"Delete","91":"Add","92":"Add","63":"Delete"}	|map_value_test|text_value_test|	1628451631192	Property,PropertyKey	\N
94	\N	Managed by Terraform	Config	f	6	{"81":"Modify","83":"Modify","69":"Modify","70":"Modify","91":"Modify","92":"Modify"}	|map_value_test|	1628455797249	Property,PropertyKey	\N
\.


--
-- Data for Name: securityprofile; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.securityprofile (id, diffjson, cipher, name, sppassword, repositoryid) FROM stdin;
14	\N	AES_CBC_PKCS5Padding	demo-security-group	SqNwySVpCtueM/wKd091kg==	6
\.


--
-- Data for Name: securityprofile_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.securityprofile_audit (id, rev, revtype, revend, revend_tstmp, diffjson, cipher, name, sppassword, repositoryid) FROM stdin;
14	15	0	\N	\N	\N	AES_CBC_PKCS5Padding	demo-security-group	SqNwySVpCtueM/wKd091kg==	6
\.


--
-- Data for Name: systemconfig; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.systemconfig (id, diffjson, configgroup, encrypted, configkey, value) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.tag (id, diffjson, name, readme, ts, repositoryid) FROM stdin;
\.


--
-- Data for Name: tag_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.tag_audit (id, rev, revtype, revend, revend_tstmp, diffjson, name, readme, ts, repositoryid) FROM stdin;
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.team (id, diffjson, createdate, description, name, stoponfirstmatch, unmatchededitable, repositoryid) FROM stdin;
\.


--
-- Data for Name: team_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.team_audit (id, rev, revtype, revend, revend_tstmp, diffjson, description, name, stoponfirstmatch, unmatchededitable, repositoryid) FROM stdin;
\.


--
-- Data for Name: team_token; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.team_token (team_id, tokens_id) FROM stdin;
\.


--
-- Data for Name: team_token_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.team_token_audit (rev, team_id, tokens_id, revtype, revend, revend_tstmp) FROM stdin;
\.


--
-- Data for Name: team_useraccount; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.team_useraccount (team_id, members_id) FROM stdin;
\.


--
-- Data for Name: team_useraccount_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.team_useraccount_audit (rev, team_id, members_id, revtype, revend, revend_tstmp) FROM stdin;
\.


--
-- Data for Name: token; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.token (id, diffjson, active, createdon, expires, forcekeypushenabled, managedby, name, token, managingteamid, repository_id, teamrulesid, useraccountid) FROM stdin;
16	\N	t	1627247605776	\N	t	All	demo-token	eyJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJDb25maWdIdWIiLCJyaWQiOjYsInRzIjotNTQ0OTk5NDA3fQ.CkTMvi3bBYs69cJlbBG--coBybW9sbl6O4_das8cfL0	\N	6	\N	\N
\.


--
-- Data for Name: token_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.token_audit (id, rev, revtype, revend, revend_tstmp, diffjson, active, createdon, expires, forcekeypushenabled, managedby, name, managingteamid, repository_id, teamrulesid, useraccountid) FROM stdin;
16	17	0	\N	\N	\N	t	1627247605776	\N	t	All	demo-token	\N	6	\N	\N
\.


--
-- Data for Name: token_securityprofile; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.token_securityprofile (tokens_id, securityprofiles_id) FROM stdin;
16	14
\.


--
-- Data for Name: token_securityprofile_audit; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.token_securityprofile_audit (rev, tokens_id, securityprofiles_id, revtype, revend, revend_tstmp) FROM stdin;
17	16	14	0	\N	\N
\.


--
-- Data for Name: useraccount; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.useraccount (id, diffjson, active, confighubadmin, createdate, emailblog, emailrepocritical, name, userpassword, timezone, account_id, email_id, account_type) FROM stdin;
1	\N	t	f	2021-07-25 19:06:04.482	t	t	\N	1000:5b42403535646639326463:50b50ae47dcfc778204c7b3f78b7d7a778f65bbf05a2bf0f334ad99d8b85839d18a02134028a248c1e18aa7f9f8aae910660216d491ca74376ea361763184f04	\N	2	3	LOCAL
\.


--
-- Data for Name: useraccount_organization; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.useraccount_organization (useraccount_id, organizations_id) FROM stdin;
1	4
\.


--
-- Data for Name: useraccount_token; Type: TABLE DATA; Schema: public; Owner: confighub
--

COPY public.useraccount_token (useraccount_id, tokens_id) FROM stdin;
\.


--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: confighub
--

SELECT pg_catalog.setval('public.hibernate_sequence', 94, true);


--
-- Name: team UK7colvq35hr23h1s8yor42o0ne; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT "UK7colvq35hr23h1s8yor42o0ne" UNIQUE (name, repositoryid);


--
-- Name: repository UKgsxkucdri6drlvmgecqpktajm; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repository
    ADD CONSTRAINT "UKgsxkucdri6drlvmgecqpktajm" UNIQUE (name, accountid);


--
-- Name: ctxlevel UKhgt86bme51u315n6co4rs5ov4; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.ctxlevel
    ADD CONSTRAINT "UKhgt86bme51u315n6co4rs5ov4" UNIQUE (name, depth, repositoryid);


--
-- Name: securityprofile UKj43c2tldwxfjjepnlg6pcfn2o; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.securityprofile
    ADD CONSTRAINT "UKj43c2tldwxfjjepnlg6pcfn2o" UNIQUE (name, repositoryid);


--
-- Name: propertykey UKkgk1sxx690tdpxj9hsfv28uba; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.propertykey
    ADD CONSTRAINT "UKkgk1sxx690tdpxj9hsfv28uba" UNIQUE (propertykey, repositoryid);


--
-- Name: tag UKp0yolsd976qvlmq2geqy0vs0o; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT "UKp0yolsd976qvlmq2geqy0vs0o" UNIQUE (name, repositoryid);


--
-- Name: absolutefilepath UKrncnvsdk64t5vjteltar1wwcw; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.absolutefilepath
    ADD CONSTRAINT "UKrncnvsdk64t5vjteltar1wwcw" UNIQUE (abspath, repositoryid);


--
-- Name: account account_name_key; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_name_key UNIQUE (name);


--
-- Name: email email_email_key; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT email_email_key UNIQUE (email);


--
-- Name: absolutefilepath pk_absolutefilepath; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.absolutefilepath
    ADD CONSTRAINT pk_absolutefilepath PRIMARY KEY (id);


--
-- Name: absolutefilepath_audit pk_absolutefilepath_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.absolutefilepath_audit
    ADD CONSTRAINT pk_absolutefilepath_audit PRIMARY KEY (id, rev);


--
-- Name: accessrule pk_accessrule; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.accessrule
    ADD CONSTRAINT pk_accessrule PRIMARY KEY (id);


--
-- Name: accessrule_audit pk_accessrule_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.accessrule_audit
    ADD CONSTRAINT pk_accessrule_audit PRIMARY KEY (id, rev);


--
-- Name: accessrule_ctxlevel pk_accessrule_level; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.accessrule_ctxlevel
    ADD CONSTRAINT pk_accessrule_level PRIMARY KEY (accessrule_id, context_id);


--
-- Name: account pk_account; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT pk_account PRIMARY KEY (id);


--
-- Name: account_repository pk_account_repository; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.account_repository
    ADD CONSTRAINT pk_account_repository PRIMARY KEY (account_id, repositories_id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: email pk_email; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT pk_email PRIMARY KEY (id);


--
-- Name: ctxlevel pk_level; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.ctxlevel
    ADD CONSTRAINT pk_level PRIMARY KEY (id);


--
-- Name: ctxlevel_audit pk_level_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.ctxlevel_audit
    ADD CONSTRAINT pk_level_audit PRIMARY KEY (id, rev);


--
-- Name: ctxlevel_ctxlevel pk_level_level; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.ctxlevel_ctxlevel
    ADD CONSTRAINT pk_level_level PRIMARY KEY (groups_id, members_id);


--
-- Name: ctxlevel_ctxlevel_audit pk_level_level_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.ctxlevel_ctxlevel_audit
    ADD CONSTRAINT pk_level_level_audit PRIMARY KEY (rev, groups_id, members_id);


--
-- Name: organization pk_organization; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.organization
    ADD CONSTRAINT pk_organization PRIMARY KEY (id);


--
-- Name: organization_admins pk_organization_admins; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.organization_admins
    ADD CONSTRAINT pk_organization_admins PRIMARY KEY (organization_id, administrators_id);


--
-- Name: organization_owners pk_organization_owners; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.organization_owners
    ADD CONSTRAINT pk_organization_owners PRIMARY KEY (organization_id, owners_id);


--
-- Name: property pk_property; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT pk_property PRIMARY KEY (id);


--
-- Name: property_audit pk_property_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.property_audit
    ADD CONSTRAINT pk_property_audit PRIMARY KEY (id, rev);


--
-- Name: property_ctxlevel pk_property_level; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.property_ctxlevel
    ADD CONSTRAINT pk_property_level PRIMARY KEY (properties_id, context_id);


--
-- Name: property_ctxlevel_audit pk_property_level_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.property_ctxlevel_audit
    ADD CONSTRAINT pk_property_level_audit PRIMARY KEY (rev, properties_id, context_id);


--
-- Name: propertykey pk_propertykey; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.propertykey
    ADD CONSTRAINT pk_propertykey PRIMARY KEY (id);


--
-- Name: propertykey_audit pk_propertykey_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.propertykey_audit
    ADD CONSTRAINT pk_propertykey_audit PRIMARY KEY (id, rev);


--
-- Name: repofile pk_repofile; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile
    ADD CONSTRAINT pk_repofile PRIMARY KEY (id);


--
-- Name: repofile_audit pk_repofile_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile_audit
    ADD CONSTRAINT pk_repofile_audit PRIMARY KEY (id, rev);


--
-- Name: repofile_ctxlevel pk_repofile_level; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile_ctxlevel
    ADD CONSTRAINT pk_repofile_level PRIMARY KEY (files_id, context_id);


--
-- Name: repofile_ctxlevel_audit pk_repofile_level_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile_ctxlevel_audit
    ADD CONSTRAINT pk_repofile_level_audit PRIMARY KEY (rev, files_id, context_id);


--
-- Name: repofile_propertykey pk_repofile_propertykey; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile_propertykey
    ADD CONSTRAINT pk_repofile_propertykey PRIMARY KEY (files_id, keys_id);


--
-- Name: repofile_propertykey_audit pk_repofile_propertykey_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile_propertykey_audit
    ADD CONSTRAINT pk_repofile_propertykey_audit PRIMARY KEY (rev, files_id, keys_id);


--
-- Name: repository pk_repository; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repository
    ADD CONSTRAINT pk_repository PRIMARY KEY (id);


--
-- Name: repository_audit pk_repository_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repository_audit
    ADD CONSTRAINT pk_repository_audit PRIMARY KEY (id, rev);


--
-- Name: repository_team pk_repository_team; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repository_team
    ADD CONSTRAINT pk_repository_team PRIMARY KEY (repository_id, teams_id);


--
-- Name: revisionentry pk_revisionentry; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.revisionentry
    ADD CONSTRAINT pk_revisionentry PRIMARY KEY (id);


--
-- Name: securityprofile pk_securityprofile; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.securityprofile
    ADD CONSTRAINT pk_securityprofile PRIMARY KEY (id);


--
-- Name: securityprofile_audit pk_securityprofile_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.securityprofile_audit
    ADD CONSTRAINT pk_securityprofile_audit PRIMARY KEY (id, rev);


--
-- Name: tag pk_tag; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT pk_tag PRIMARY KEY (id);


--
-- Name: tag_audit pk_tag_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.tag_audit
    ADD CONSTRAINT pk_tag_audit PRIMARY KEY (id, rev);


--
-- Name: team pk_team; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT pk_team PRIMARY KEY (id);


--
-- Name: team_audit pk_team_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team_audit
    ADD CONSTRAINT pk_team_audit PRIMARY KEY (id, rev);


--
-- Name: team_token pk_team_token; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team_token
    ADD CONSTRAINT pk_team_token PRIMARY KEY (team_id, tokens_id);


--
-- Name: team_token_audit pk_team_token_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team_token_audit
    ADD CONSTRAINT pk_team_token_audit PRIMARY KEY (rev, team_id, tokens_id);


--
-- Name: team_useraccount pk_team_useraccount; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team_useraccount
    ADD CONSTRAINT pk_team_useraccount PRIMARY KEY (team_id, members_id);


--
-- Name: team_useraccount_audit pk_team_useraccount_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team_useraccount_audit
    ADD CONSTRAINT pk_team_useraccount_audit PRIMARY KEY (rev, team_id, members_id);


--
-- Name: token pk_token; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT pk_token PRIMARY KEY (id);


--
-- Name: token_audit pk_token_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.token_audit
    ADD CONSTRAINT pk_token_audit PRIMARY KEY (id, rev);


--
-- Name: token_securityprofile pk_token_securityprofile; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.token_securityprofile
    ADD CONSTRAINT pk_token_securityprofile PRIMARY KEY (tokens_id, securityprofiles_id);


--
-- Name: token_securityprofile_audit pk_token_securityprofile_audit; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.token_securityprofile_audit
    ADD CONSTRAINT pk_token_securityprofile_audit PRIMARY KEY (rev, tokens_id, securityprofiles_id);


--
-- Name: useraccount pk_useraccount; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.useraccount
    ADD CONSTRAINT pk_useraccount PRIMARY KEY (id);


--
-- Name: useraccount_organization pk_useraccount_organization; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.useraccount_organization
    ADD CONSTRAINT pk_useraccount_organization PRIMARY KEY (useraccount_id, organizations_id);


--
-- Name: useraccount_token pk_useraccount_token; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.useraccount_token
    ADD CONSTRAINT pk_useraccount_token PRIMARY KEY (useraccount_id, tokens_id);


--
-- Name: repository_team repository_team_teams_id_key; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repository_team
    ADD CONSTRAINT repository_team_teams_id_key UNIQUE (teams_id);


--
-- Name: systemconfig systemconfig_pkey; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.systemconfig
    ADD CONSTRAINT systemconfig_pkey PRIMARY KEY (id);


--
-- Name: systemconfig uk_r3juf5ghb12odn7dwiaxulbx0; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.systemconfig
    ADD CONSTRAINT uk_r3juf5ghb12odn7dwiaxulbx0 UNIQUE (configkey);


--
-- Name: systemconfig ukq42ipys8wps81i1q3ti6nwa2u; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.systemconfig
    ADD CONSTRAINT ukq42ipys8wps81i1q3ti6nwa2u UNIQUE (configgroup, configkey);


--
-- Name: useraccount useraccount_account_id_key; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.useraccount
    ADD CONSTRAINT useraccount_account_id_key UNIQUE (account_id);


--
-- Name: useraccount useraccount_email_id_key; Type: CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.useraccount
    ADD CONSTRAINT useraccount_email_id_key UNIQUE (email_id);


--
-- Name: AFP_repoIndex; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "AFP_repoIndex" ON public.absolutefilepath USING btree (id, repositoryid, abspath);


--
-- Name: FK15h7tel8t9lve1m86923l9y3r; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK15h7tel8t9lve1m86923l9y3r" ON public.accessrule USING btree (team);


--
-- Name: FK1g7o4xgai71drg488yerd26ip; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK1g7o4xgai71drg488yerd26ip" ON public.repository_audit USING btree (rev);


--
-- Name: FK1oica1rpw2l41ultyiw6cue5p; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK1oica1rpw2l41ultyiw6cue5p" ON public.useraccount_token USING btree (tokens_id);


--
-- Name: FK2d5fcxo0ajndhid47y38m59su; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK2d5fcxo0ajndhid47y38m59su" ON public.repofile_propertykey_audit USING btree (revend);


--
-- Name: FK2s6fk214jdgsq52b62leyx88y; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK2s6fk214jdgsq52b62leyx88y" ON public.team_useraccount USING btree (members_id);


--
-- Name: FK38698ptunglrx8d89jk1rth9d; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK38698ptunglrx8d89jk1rth9d" ON public.team_useraccount_audit USING btree (revend);


--
-- Name: FK3glih1wqjtqqysgev5o25gpcm; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK3glih1wqjtqqysgev5o25gpcm" ON public.propertykey_audit USING btree (rev);


--
-- Name: FK3qvvwt9wwa78lbicgsuigds5n; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK3qvvwt9wwa78lbicgsuigds5n" ON public.repofile_ctxlevel USING btree (context_id);


--
-- Name: FK4pgaa1lemvlmwtbq1iyub9oix; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK4pgaa1lemvlmwtbq1iyub9oix" ON public.repofile USING btree (repositoryid);


--
-- Name: FK7jk87189k20odo56i0n2gavp; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK7jk87189k20odo56i0n2gavp" ON public.useraccount_organization USING btree (organizations_id);


--
-- Name: FK7kvnw36vqhel8kfy750s2u8u4; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK7kvnw36vqhel8kfy750s2u8u4" ON public.account USING btree (user_id);


--
-- Name: FK836wucyouiewg9olc674m8q9u; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK836wucyouiewg9olc674m8q9u" ON public.property_ctxlevel_audit USING btree (revend);


--
-- Name: FK8en1506e58hvi7f2jrdja5ymv; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK8en1506e58hvi7f2jrdja5ymv" ON public.organization_admins USING btree (administrators_id);


--
-- Name: FK8jvey1udvbi0tptxty36bwphq; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK8jvey1udvbi0tptxty36bwphq" ON public.repofile_ctxlevel_audit USING btree (revend);


--
-- Name: FK8nbbs6blxqx3fjm2s51of8oxs; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK8nbbs6blxqx3fjm2s51of8oxs" ON public.property USING btree (absolutefilepath);


--
-- Name: FK8u2evprtwju2drlgqg093ob36; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK8u2evprtwju2drlgqg093ob36" ON public.propertykey_audit USING btree (revend);


--
-- Name: FK95jswh4td882mk7cgfcxuakaq; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK95jswh4td882mk7cgfcxuakaq" ON public.team_token_audit USING btree (revend);


--
-- Name: FK96xe4gylfsnkofd6y707ktpqk; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK96xe4gylfsnkofd6y707ktpqk" ON public.propertykey USING btree (repositoryid);


--
-- Name: FK9wwqqg64jxy3c43qh0a2l4p9q; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FK9wwqqg64jxy3c43qh0a2l4p9q" ON public.tag_audit USING btree (rev);


--
-- Name: FKagqpsul1wfulvktp1h6gc2pv; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKagqpsul1wfulvktp1h6gc2pv" ON public.securityprofile_audit USING btree (rev);


--
-- Name: FKb1al5ppjmeiehaqdyk0tu7ts3; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKb1al5ppjmeiehaqdyk0tu7ts3" ON public.team USING btree (repositoryid);


--
-- Name: FKb5arhv2gq2foi6fyninyrc6oq; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKb5arhv2gq2foi6fyninyrc6oq" ON public.repofile USING btree (absfilepath_id);


--
-- Name: FKbet1447sj0vowh21luyg1pxr0; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKbet1447sj0vowh21luyg1pxr0" ON public.repository_audit USING btree (revend);


--
-- Name: FKc1l7gul4nbp2k4ksqpiu1ak88; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKc1l7gul4nbp2k4ksqpiu1ak88" ON public.repofile USING btree (securityprofile_id);


--
-- Name: FKciasf7bo3pegn0i9413dkwx85; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKciasf7bo3pegn0i9413dkwx85" ON public.repofile_propertykey USING btree (keys_id);


--
-- Name: FKd5ifxen605502nk64fisrwbmp; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKd5ifxen605502nk64fisrwbmp" ON public.token_audit USING btree (revend);


--
-- Name: FKdfcuec9a2x33kv56vf4q0d4vl; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKdfcuec9a2x33kv56vf4q0d4vl" ON public.team_audit USING btree (revend);


--
-- Name: FKebfp0dnlt1doat9sbrlf5t797; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKebfp0dnlt1doat9sbrlf5t797" ON public.ctxlevel_audit USING btree (revend);


--
-- Name: FKfkvc5xu83bm52meoudrcw56rh; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKfkvc5xu83bm52meoudrcw56rh" ON public.token USING btree (repository_id);


--
-- Name: FKfxn0wmkpx8k8x2g2r5xyq3jup; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKfxn0wmkpx8k8x2g2r5xyq3jup" ON public.property USING btree (repositoryid);


--
-- Name: FKg2a1v8p9luy9q7et0iqnfxiql; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKg2a1v8p9luy9q7et0iqnfxiql" ON public.token_securityprofile USING btree (securityprofiles_id);


--
-- Name: FKgba3e96fgs78m9vl3lwr9xth6; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKgba3e96fgs78m9vl3lwr9xth6" ON public.tag_audit USING btree (revend);


--
-- Name: FKhb1y76p3uwq7ldt1v3yw1toob; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKhb1y76p3uwq7ldt1v3yw1toob" ON public.repository USING btree (accountid);


--
-- Name: FKhfvxctssq2074bv5q94bstvpt; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKhfvxctssq2074bv5q94bstvpt" ON public.accessrule_audit USING btree (revend);


--
-- Name: FKhjxr3b54tih2jo065ft6itkbu; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKhjxr3b54tih2jo065ft6itkbu" ON public.organization_owners USING btree (owners_id);


--
-- Name: FKi4dmghntqndf73lkh14fv1ehx; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKi4dmghntqndf73lkh14fv1ehx" ON public.securityprofile_audit USING btree (revend);


--
-- Name: FKibnoavw0n8sbh9h53tleyc0i; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKibnoavw0n8sbh9h53tleyc0i" ON public.ctxlevel_audit USING btree (rev);


--
-- Name: FKj35ma95suq1bsrm0q606r21d6; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKj35ma95suq1bsrm0q606r21d6" ON public.email USING btree (user_id);


--
-- Name: FKjc27bq8culudyyove36o8ryjs; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKjc27bq8culudyyove36o8ryjs" ON public.team_audit USING btree (rev);


--
-- Name: FKkw5u1a474bmuixelc44tj160l; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKkw5u1a474bmuixelc44tj160l" ON public.property_audit USING btree (revend);


--
-- Name: FKlp5w4yjeg4n40cbn4difypkoi; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKlp5w4yjeg4n40cbn4difypkoi" ON public.propertykey USING btree (securityprofile_id);


--
-- Name: FKlxiorvj8k9qshy951bovehh1y; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKlxiorvj8k9qshy951bovehh1y" ON public.absolutefilepath USING btree (repositoryid);


--
-- Name: FKm0kbpcvdwm30mvbg69r73ohy7; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKm0kbpcvdwm30mvbg69r73ohy7" ON public.token USING btree (managingteamid);


--
-- Name: FKm533bmbvjxyettlu30lht2phk; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKm533bmbvjxyettlu30lht2phk" ON public.securityprofile USING btree (repositoryid);


--
-- Name: FKmf1aigrdb5hbs9b5trysdyuee; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKmf1aigrdb5hbs9b5trysdyuee" ON public.absolutefilepath_audit USING btree (revend);


--
-- Name: FKmleuvr9dmidmj2irgprmppijg; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKmleuvr9dmidmj2irgprmppijg" ON public.accessrule_audit USING btree (rev);


--
-- Name: FKnfrngot3489w6q16r32k31q77; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKnfrngot3489w6q16r32k31q77" ON public.ctxlevel_ctxlevel USING btree (members_id);


--
-- Name: FKnp2lq4pjxnidp562y85bugosa; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKnp2lq4pjxnidp562y85bugosa" ON public.token USING btree (teamrulesid);


--
-- Name: FKntqc411w5b3ps0xtqfpxsl8gl; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKntqc411w5b3ps0xtqfpxsl8gl" ON public.token_securityprofile_audit USING btree (revend);


--
-- Name: FKo2ovx2b8iggg2579gxugicge; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKo2ovx2b8iggg2579gxugicge" ON public.accessrule_ctxlevel USING btree (context_id);


--
-- Name: FKoftlhmr6mf7q48dv8ieht7xlq; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKoftlhmr6mf7q48dv8ieht7xlq" ON public.property_ctxlevel USING btree (context_id);


--
-- Name: FKorkynioy6e4qjvq5x1vf8pk3r; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKorkynioy6e4qjvq5x1vf8pk3r" ON public.repofile_audit USING btree (revend);


--
-- Name: FKos0n7c0b8uw03eebjttoj73p9; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKos0n7c0b8uw03eebjttoj73p9" ON public.tag USING btree (repositoryid);


--
-- Name: FKpkx75xd400my1b5ugiidvcqfc; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKpkx75xd400my1b5ugiidvcqfc" ON public.property_audit USING btree (rev);


--
-- Name: FKpoow0vujn78pvplo2ge5icq1j; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKpoow0vujn78pvplo2ge5icq1j" ON public.repofile_audit USING btree (rev);


--
-- Name: FKqc9uuldfqmt5qhf6f99f3b169; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKqc9uuldfqmt5qhf6f99f3b169" ON public.account USING btree (organization_id);


--
-- Name: FKr9y7im342i9i2ed65av30qi6m; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKr9y7im342i9i2ed65av30qi6m" ON public.token USING btree (useraccountid);


--
-- Name: FKrcfwuulcd2xveojqygbw2j82c; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKrcfwuulcd2xveojqygbw2j82c" ON public.property USING btree (propertykey_id);


--
-- Name: FKrd0ijhb2h4mojpsjf9ilnw6vh; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKrd0ijhb2h4mojpsjf9ilnw6vh" ON public.team_token USING btree (tokens_id);


--
-- Name: FKrqcpuenwpuam8s451n7w9vcih; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKrqcpuenwpuam8s451n7w9vcih" ON public.token_audit USING btree (rev);


--
-- Name: FKs9ux7hkhefghun48f10l057yf; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKs9ux7hkhefghun48f10l057yf" ON public.ctxlevel_ctxlevel_audit USING btree (revend);


--
-- Name: FKsn7d4pawxvy2d39pg6irxvd1x; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKsn7d4pawxvy2d39pg6irxvd1x" ON public.organization USING btree (account_id);


--
-- Name: FKsq3dtvsa6x95tydm8jma44vnd; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKsq3dtvsa6x95tydm8jma44vnd" ON public.absolutefilepath_audit USING btree (rev);


--
-- Name: FKsxkfkathmadso50q5j6jwvojp; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKsxkfkathmadso50q5j6jwvojp" ON public.ctxlevel USING btree (repositoryid);


--
-- Name: FKtmpj15ythpr8eoxmw7t2qv7yx; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "FKtmpj15ythpr8eoxmw7t2qv7yx" ON public.account_repository USING btree (repositories_id);


--
-- Name: LVL_repoIndex; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "LVL_repoIndex" ON public.ctxlevel USING btree (id, repositoryid);


--
-- Name: PROP_KEY_repoIndex; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "PROP_KEY_repoIndex" ON public.propertykey USING btree (id, repositoryid);


--
-- Name: PROP_repoIndex; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "PROP_repoIndex" ON public.property USING btree (id, propertykey_id, repositoryid);


--
-- Name: REPO_repoIndex; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX "REPO_repoIndex" ON public.repository USING btree (id, name, accountid);


--
-- Name: system_config_index; Type: INDEX; Schema: public; Owner: confighub
--

CREATE INDEX system_config_index ON public.systemconfig USING btree (id, configgroup, configkey);


--
-- Name: ctxlevel_ctxlevel_audit FK1448qxyrva8dgm5fbiyg5aqrt; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.ctxlevel_ctxlevel_audit
    ADD CONSTRAINT "FK1448qxyrva8dgm5fbiyg5aqrt" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: accessrule FK15h7tel8t9lve1m86923l9y3r; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.accessrule
    ADD CONSTRAINT "FK15h7tel8t9lve1m86923l9y3r" FOREIGN KEY (team) REFERENCES public.team(id);


--
-- Name: useraccount_token FK1al1ccnkukmmmeubmn7kn16e3; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.useraccount_token
    ADD CONSTRAINT "FK1al1ccnkukmmmeubmn7kn16e3" FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: repository_audit FK1g7o4xgai71drg488yerd26ip; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repository_audit
    ADD CONSTRAINT "FK1g7o4xgai71drg488yerd26ip" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: team_useraccount_audit FK1hbcekgaloqo39dm4ov5wnmgt; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team_useraccount_audit
    ADD CONSTRAINT "FK1hbcekgaloqo39dm4ov5wnmgt" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: useraccount_token FK1oica1rpw2l41ultyiw6cue5p; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.useraccount_token
    ADD CONSTRAINT "FK1oica1rpw2l41ultyiw6cue5p" FOREIGN KEY (tokens_id) REFERENCES public.token(id);


--
-- Name: repository_team FK22qwgbo9a86gco5dcevrqilme; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repository_team
    ADD CONSTRAINT "FK22qwgbo9a86gco5dcevrqilme" FOREIGN KEY (teams_id) REFERENCES public.team(id);


--
-- Name: repofile_propertykey_audit FK2d5fcxo0ajndhid47y38m59su; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile_propertykey_audit
    ADD CONSTRAINT "FK2d5fcxo0ajndhid47y38m59su" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: team_token_audit FK2lahsao17rxfgidjots4dygqv; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team_token_audit
    ADD CONSTRAINT "FK2lahsao17rxfgidjots4dygqv" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: team_useraccount FK2s6fk214jdgsq52b62leyx88y; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team_useraccount
    ADD CONSTRAINT "FK2s6fk214jdgsq52b62leyx88y" FOREIGN KEY (members_id) REFERENCES public.useraccount(id);


--
-- Name: team_useraccount_audit FK38698ptunglrx8d89jk1rth9d; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team_useraccount_audit
    ADD CONSTRAINT "FK38698ptunglrx8d89jk1rth9d" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: propertykey_audit FK3glih1wqjtqqysgev5o25gpcm; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.propertykey_audit
    ADD CONSTRAINT "FK3glih1wqjtqqysgev5o25gpcm" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: repofile_ctxlevel FK3qvvwt9wwa78lbicgsuigds5n; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile_ctxlevel
    ADD CONSTRAINT "FK3qvvwt9wwa78lbicgsuigds5n" FOREIGN KEY (context_id) REFERENCES public.ctxlevel(id);


--
-- Name: repofile FK4pgaa1lemvlmwtbq1iyub9oix; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile
    ADD CONSTRAINT "FK4pgaa1lemvlmwtbq1iyub9oix" FOREIGN KEY (repositoryid) REFERENCES public.repository(id);


--
-- Name: token_securityprofile_audit FK5l0uk7jwq2jpsv0r77q8htyc8; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.token_securityprofile_audit
    ADD CONSTRAINT "FK5l0uk7jwq2jpsv0r77q8htyc8" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: property_ctxlevel FK6b08s72yy4sfrsllugts5ijh4; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.property_ctxlevel
    ADD CONSTRAINT "FK6b08s72yy4sfrsllugts5ijh4" FOREIGN KEY (properties_id) REFERENCES public.property(id);


--
-- Name: useraccount_organization FK7jk87189k20odo56i0n2gavp; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.useraccount_organization
    ADD CONSTRAINT "FK7jk87189k20odo56i0n2gavp" FOREIGN KEY (organizations_id) REFERENCES public.organization(id);


--
-- Name: account FK7kvnw36vqhel8kfy750s2u8u4; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT "FK7kvnw36vqhel8kfy750s2u8u4" FOREIGN KEY (user_id) REFERENCES public.useraccount(id);


--
-- Name: property_ctxlevel_audit FK836wucyouiewg9olc674m8q9u; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.property_ctxlevel_audit
    ADD CONSTRAINT "FK836wucyouiewg9olc674m8q9u" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: organization_admins FK8en1506e58hvi7f2jrdja5ymv; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.organization_admins
    ADD CONSTRAINT "FK8en1506e58hvi7f2jrdja5ymv" FOREIGN KEY (administrators_id) REFERENCES public.useraccount(id);


--
-- Name: repofile_ctxlevel_audit FK8jvey1udvbi0tptxty36bwphq; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile_ctxlevel_audit
    ADD CONSTRAINT "FK8jvey1udvbi0tptxty36bwphq" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: property FK8nbbs6blxqx3fjm2s51of8oxs; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT "FK8nbbs6blxqx3fjm2s51of8oxs" FOREIGN KEY (absolutefilepath) REFERENCES public.absolutefilepath(id);


--
-- Name: propertykey_audit FK8u2evprtwju2drlgqg093ob36; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.propertykey_audit
    ADD CONSTRAINT "FK8u2evprtwju2drlgqg093ob36" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: team_token_audit FK95jswh4td882mk7cgfcxuakaq; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team_token_audit
    ADD CONSTRAINT "FK95jswh4td882mk7cgfcxuakaq" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: propertykey FK96xe4gylfsnkofd6y707ktpqk; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.propertykey
    ADD CONSTRAINT "FK96xe4gylfsnkofd6y707ktpqk" FOREIGN KEY (repositoryid) REFERENCES public.repository(id);


--
-- Name: tag_audit FK9wwqqg64jxy3c43qh0a2l4p9q; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.tag_audit
    ADD CONSTRAINT "FK9wwqqg64jxy3c43qh0a2l4p9q" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: organization_admins FKa353w23sbtn5ibi9x4hia9f1h; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.organization_admins
    ADD CONSTRAINT "FKa353w23sbtn5ibi9x4hia9f1h" FOREIGN KEY (organization_id) REFERENCES public.organization(id);


--
-- Name: securityprofile_audit FKagqpsul1wfulvktp1h6gc2pv; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.securityprofile_audit
    ADD CONSTRAINT "FKagqpsul1wfulvktp1h6gc2pv" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: repository_team FKalmpp97k4ppnccn4n8gl8r5tw; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repository_team
    ADD CONSTRAINT "FKalmpp97k4ppnccn4n8gl8r5tw" FOREIGN KEY (repository_id) REFERENCES public.repository(id);


--
-- Name: team FKb1al5ppjmeiehaqdyk0tu7ts3; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT "FKb1al5ppjmeiehaqdyk0tu7ts3" FOREIGN KEY (repositoryid) REFERENCES public.repository(id);


--
-- Name: repofile FKb5arhv2gq2foi6fyninyrc6oq; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile
    ADD CONSTRAINT "FKb5arhv2gq2foi6fyninyrc6oq" FOREIGN KEY (absfilepath_id) REFERENCES public.absolutefilepath(id);


--
-- Name: repository_audit FKbet1447sj0vowh21luyg1pxr0; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repository_audit
    ADD CONSTRAINT "FKbet1447sj0vowh21luyg1pxr0" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: organization_owners FKbpmd37bd3t3hhfs9leshxgy8m; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.organization_owners
    ADD CONSTRAINT "FKbpmd37bd3t3hhfs9leshxgy8m" FOREIGN KEY (organization_id) REFERENCES public.organization(id);


--
-- Name: repofile FKc1l7gul4nbp2k4ksqpiu1ak88; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile
    ADD CONSTRAINT "FKc1l7gul4nbp2k4ksqpiu1ak88" FOREIGN KEY (securityprofile_id) REFERENCES public.securityprofile(id);


--
-- Name: repofile_propertykey FKciasf7bo3pegn0i9413dkwx85; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile_propertykey
    ADD CONSTRAINT "FKciasf7bo3pegn0i9413dkwx85" FOREIGN KEY (keys_id) REFERENCES public.propertykey(id);


--
-- Name: token_audit FKd5ifxen605502nk64fisrwbmp; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.token_audit
    ADD CONSTRAINT "FKd5ifxen605502nk64fisrwbmp" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: team_audit FKdfcuec9a2x33kv56vf4q0d4vl; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team_audit
    ADD CONSTRAINT "FKdfcuec9a2x33kv56vf4q0d4vl" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: ctxlevel_audit FKebfp0dnlt1doat9sbrlf5t797; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.ctxlevel_audit
    ADD CONSTRAINT "FKebfp0dnlt1doat9sbrlf5t797" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: team_token FKebm3i4ccp3uenj1t38rf49f3h; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team_token
    ADD CONSTRAINT "FKebm3i4ccp3uenj1t38rf49f3h" FOREIGN KEY (team_id) REFERENCES public.team(id);


--
-- Name: useraccount FKfbnisnh4h1e4uahl4vbw6w72s; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.useraccount
    ADD CONSTRAINT "FKfbnisnh4h1e4uahl4vbw6w72s" FOREIGN KEY (email_id) REFERENCES public.email(id);


--
-- Name: token FKfkvc5xu83bm52meoudrcw56rh; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT "FKfkvc5xu83bm52meoudrcw56rh" FOREIGN KEY (repository_id) REFERENCES public.repository(id);


--
-- Name: property FKfxn0wmkpx8k8x2g2r5xyq3jup; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT "FKfxn0wmkpx8k8x2g2r5xyq3jup" FOREIGN KEY (repositoryid) REFERENCES public.repository(id);


--
-- Name: token_securityprofile FKg2a1v8p9luy9q7et0iqnfxiql; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.token_securityprofile
    ADD CONSTRAINT "FKg2a1v8p9luy9q7et0iqnfxiql" FOREIGN KEY (securityprofiles_id) REFERENCES public.securityprofile(id);


--
-- Name: accessrule_ctxlevel FKg4ujll811jdecxkqd3enp2h10; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.accessrule_ctxlevel
    ADD CONSTRAINT "FKg4ujll811jdecxkqd3enp2h10" FOREIGN KEY (accessrule_id) REFERENCES public.accessrule(id);


--
-- Name: tag_audit FKgba3e96fgs78m9vl3lwr9xth6; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.tag_audit
    ADD CONSTRAINT "FKgba3e96fgs78m9vl3lwr9xth6" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: repository FKhb1y76p3uwq7ldt1v3yw1toob; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repository
    ADD CONSTRAINT "FKhb1y76p3uwq7ldt1v3yw1toob" FOREIGN KEY (accountid) REFERENCES public.account(id);


--
-- Name: accessrule_audit FKhfvxctssq2074bv5q94bstvpt; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.accessrule_audit
    ADD CONSTRAINT "FKhfvxctssq2074bv5q94bstvpt" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: ctxlevel_ctxlevel FKhhv8eqkow45xc3ua1mywrccrl; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.ctxlevel_ctxlevel
    ADD CONSTRAINT "FKhhv8eqkow45xc3ua1mywrccrl" FOREIGN KEY (groups_id) REFERENCES public.ctxlevel(id);


--
-- Name: organization_owners FKhjxr3b54tih2jo065ft6itkbu; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.organization_owners
    ADD CONSTRAINT "FKhjxr3b54tih2jo065ft6itkbu" FOREIGN KEY (owners_id) REFERENCES public.useraccount(id);


--
-- Name: securityprofile_audit FKi4dmghntqndf73lkh14fv1ehx; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.securityprofile_audit
    ADD CONSTRAINT "FKi4dmghntqndf73lkh14fv1ehx" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: ctxlevel_audit FKibnoavw0n8sbh9h53tleyc0i; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.ctxlevel_audit
    ADD CONSTRAINT "FKibnoavw0n8sbh9h53tleyc0i" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: useraccount_organization FKiti8ob1yjytcaxc16svv5vr4f; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.useraccount_organization
    ADD CONSTRAINT "FKiti8ob1yjytcaxc16svv5vr4f" FOREIGN KEY (useraccount_id) REFERENCES public.useraccount(id);


--
-- Name: team_useraccount FKj149w80dksbl9j6sihff5nfie; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team_useraccount
    ADD CONSTRAINT "FKj149w80dksbl9j6sihff5nfie" FOREIGN KEY (team_id) REFERENCES public.team(id);


--
-- Name: email FKj35ma95suq1bsrm0q606r21d6; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.email
    ADD CONSTRAINT "FKj35ma95suq1bsrm0q606r21d6" FOREIGN KEY (user_id) REFERENCES public.useraccount(id);


--
-- Name: team_audit FKjc27bq8culudyyove36o8ryjs; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team_audit
    ADD CONSTRAINT "FKjc27bq8culudyyove36o8ryjs" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: property_audit FKkw5u1a474bmuixelc44tj160l; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.property_audit
    ADD CONSTRAINT "FKkw5u1a474bmuixelc44tj160l" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: propertykey FKlp5w4yjeg4n40cbn4difypkoi; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.propertykey
    ADD CONSTRAINT "FKlp5w4yjeg4n40cbn4difypkoi" FOREIGN KEY (securityprofile_id) REFERENCES public.securityprofile(id);


--
-- Name: absolutefilepath FKlxiorvj8k9qshy951bovehh1y; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.absolutefilepath
    ADD CONSTRAINT "FKlxiorvj8k9qshy951bovehh1y" FOREIGN KEY (repositoryid) REFERENCES public.repository(id);


--
-- Name: token FKm0kbpcvdwm30mvbg69r73ohy7; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT "FKm0kbpcvdwm30mvbg69r73ohy7" FOREIGN KEY (managingteamid) REFERENCES public.team(id);


--
-- Name: securityprofile FKm533bmbvjxyettlu30lht2phk; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.securityprofile
    ADD CONSTRAINT "FKm533bmbvjxyettlu30lht2phk" FOREIGN KEY (repositoryid) REFERENCES public.repository(id);


--
-- Name: absolutefilepath_audit FKmf1aigrdb5hbs9b5trysdyuee; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.absolutefilepath_audit
    ADD CONSTRAINT "FKmf1aigrdb5hbs9b5trysdyuee" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: accessrule_audit FKmleuvr9dmidmj2irgprmppijg; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.accessrule_audit
    ADD CONSTRAINT "FKmleuvr9dmidmj2irgprmppijg" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: repofile_ctxlevel_audit FKn3l2a92chgd2g2kfmg8wgul3e; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile_ctxlevel_audit
    ADD CONSTRAINT "FKn3l2a92chgd2g2kfmg8wgul3e" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: ctxlevel_ctxlevel FKnfrngot3489w6q16r32k31q77; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.ctxlevel_ctxlevel
    ADD CONSTRAINT "FKnfrngot3489w6q16r32k31q77" FOREIGN KEY (members_id) REFERENCES public.ctxlevel(id);


--
-- Name: token FKnp2lq4pjxnidp562y85bugosa; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT "FKnp2lq4pjxnidp562y85bugosa" FOREIGN KEY (teamrulesid) REFERENCES public.team(id);


--
-- Name: token_securityprofile_audit FKntqc411w5b3ps0xtqfpxsl8gl; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.token_securityprofile_audit
    ADD CONSTRAINT "FKntqc411w5b3ps0xtqfpxsl8gl" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: accessrule_ctxlevel FKo2ovx2b8iggg2579gxugicge; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.accessrule_ctxlevel
    ADD CONSTRAINT "FKo2ovx2b8iggg2579gxugicge" FOREIGN KEY (context_id) REFERENCES public.ctxlevel(id);


--
-- Name: property_ctxlevel FKoftlhmr6mf7q48dv8ieht7xlq; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.property_ctxlevel
    ADD CONSTRAINT "FKoftlhmr6mf7q48dv8ieht7xlq" FOREIGN KEY (context_id) REFERENCES public.ctxlevel(id);


--
-- Name: repofile_audit FKorkynioy6e4qjvq5x1vf8pk3r; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile_audit
    ADD CONSTRAINT "FKorkynioy6e4qjvq5x1vf8pk3r" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: tag FKos0n7c0b8uw03eebjttoj73p9; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT "FKos0n7c0b8uw03eebjttoj73p9" FOREIGN KEY (repositoryid) REFERENCES public.repository(id);


--
-- Name: property_audit FKpkx75xd400my1b5ugiidvcqfc; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.property_audit
    ADD CONSTRAINT "FKpkx75xd400my1b5ugiidvcqfc" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: repofile_audit FKpoow0vujn78pvplo2ge5icq1j; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile_audit
    ADD CONSTRAINT "FKpoow0vujn78pvplo2ge5icq1j" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: account_repository FKq0b8e8gdcgimxh0i5y1krixl4; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.account_repository
    ADD CONSTRAINT "FKq0b8e8gdcgimxh0i5y1krixl4" FOREIGN KEY (account_id) REFERENCES public.account(id);


--
-- Name: repofile_propertykey_audit FKq5nqoa66y1cee05x7thcey1q4; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile_propertykey_audit
    ADD CONSTRAINT "FKq5nqoa66y1cee05x7thcey1q4" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: token_securityprofile FKq9j69wnbepqwbp4sjs7w3hjkt; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.token_securityprofile
    ADD CONSTRAINT "FKq9j69wnbepqwbp4sjs7w3hjkt" FOREIGN KEY (tokens_id) REFERENCES public.token(id);


--
-- Name: account FKqc9uuldfqmt5qhf6f99f3b169; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT "FKqc9uuldfqmt5qhf6f99f3b169" FOREIGN KEY (organization_id) REFERENCES public.organization(id);


--
-- Name: repofile_ctxlevel FKqo0kehfrhnsnolc4pqibkn1d1; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile_ctxlevel
    ADD CONSTRAINT "FKqo0kehfrhnsnolc4pqibkn1d1" FOREIGN KEY (files_id) REFERENCES public.repofile(id);


--
-- Name: token FKr9y7im342i9i2ed65av30qi6m; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT "FKr9y7im342i9i2ed65av30qi6m" FOREIGN KEY (useraccountid) REFERENCES public.useraccount(id);


--
-- Name: useraccount FKrb18a15tkq1iu4yccla6s8w0f; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.useraccount
    ADD CONSTRAINT "FKrb18a15tkq1iu4yccla6s8w0f" FOREIGN KEY (account_id) REFERENCES public.account(id);


--
-- Name: property FKrcfwuulcd2xveojqygbw2j82c; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.property
    ADD CONSTRAINT "FKrcfwuulcd2xveojqygbw2j82c" FOREIGN KEY (propertykey_id) REFERENCES public.propertykey(id);


--
-- Name: team_token FKrd0ijhb2h4mojpsjf9ilnw6vh; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.team_token
    ADD CONSTRAINT "FKrd0ijhb2h4mojpsjf9ilnw6vh" FOREIGN KEY (tokens_id) REFERENCES public.token(id);


--
-- Name: token_audit FKrqcpuenwpuam8s451n7w9vcih; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.token_audit
    ADD CONSTRAINT "FKrqcpuenwpuam8s451n7w9vcih" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: ctxlevel_ctxlevel_audit FKs9ux7hkhefghun48f10l057yf; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.ctxlevel_ctxlevel_audit
    ADD CONSTRAINT "FKs9ux7hkhefghun48f10l057yf" FOREIGN KEY (revend) REFERENCES public.revisionentry(id);


--
-- Name: organization FKsn7d4pawxvy2d39pg6irxvd1x; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.organization
    ADD CONSTRAINT "FKsn7d4pawxvy2d39pg6irxvd1x" FOREIGN KEY (account_id) REFERENCES public.account(id);


--
-- Name: absolutefilepath_audit FKsq3dtvsa6x95tydm8jma44vnd; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.absolutefilepath_audit
    ADD CONSTRAINT "FKsq3dtvsa6x95tydm8jma44vnd" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: property_ctxlevel_audit FKsvw023dj20q9le8hqyr9k5sho; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.property_ctxlevel_audit
    ADD CONSTRAINT "FKsvw023dj20q9le8hqyr9k5sho" FOREIGN KEY (rev) REFERENCES public.revisionentry(id);


--
-- Name: ctxlevel FKsxkfkathmadso50q5j6jwvojp; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.ctxlevel
    ADD CONSTRAINT "FKsxkfkathmadso50q5j6jwvojp" FOREIGN KEY (repositoryid) REFERENCES public.repository(id);


--
-- Name: account_repository FKtmpj15ythpr8eoxmw7t2qv7yx; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.account_repository
    ADD CONSTRAINT "FKtmpj15ythpr8eoxmw7t2qv7yx" FOREIGN KEY (repositories_id) REFERENCES public.repository(id);


--
-- Name: repofile_propertykey FKtol4trfdypgs3jp6feqhj3wjf; Type: FK CONSTRAINT; Schema: public; Owner: confighub
--

ALTER TABLE ONLY public.repofile_propertykey
    ADD CONSTRAINT "FKtol4trfdypgs3jp6feqhj3wjf" FOREIGN KEY (files_id) REFERENCES public.repofile(id);


--
-- PostgreSQL database dump complete
--

