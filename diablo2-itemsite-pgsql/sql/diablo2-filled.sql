--
-- PostgreSQL database dump
--

SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pgsql
--

COMMENT ON SCHEMA public IS 'Standard public schema';


--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: pgsql
--

CREATE PROCEDURAL LANGUAGE plpgsql;


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: char_item; Type: TABLE; Schema: public; Owner: diablo2; Tablespace: 
--

CREATE TABLE char_item (
    charid integer NOT NULL,
    itemid integer NOT NULL,
    ethereal character(1) DEFAULT 'N'::bpchar NOT NULL,
    CONSTRAINT char_item_ethereal_check CHECK (((ethereal = 'Y'::bpchar) OR (ethereal = 'N'::bpchar)))
);


ALTER TABLE public.char_item OWNER TO diablo2;

--
-- Name: charid_seq; Type: SEQUENCE; Schema: public; Owner: diablo2
--

CREATE SEQUENCE charid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.charid_seq OWNER TO diablo2;

--
-- Name: charid_seq; Type: SEQUENCE SET; Schema: public; Owner: diablo2
--

SELECT pg_catalog.setval('charid_seq', 43, true);


--
-- Name: charachter; Type: TABLE; Schema: public; Owner: diablo2; Tablespace: 
--

CREATE TABLE charachter (
    charid integer DEFAULT nextval('charid_seq'::regclass) NOT NULL,
    "class" character(2) NOT NULL,
    name character varying(32) NOT NULL,
    "level" integer NOT NULL,
    version integer NOT NULL,
    CONSTRAINT charachter_class_check CHECK (((((((("class" = 'am'::bpchar) OR ("class" = 'as'::bpchar)) OR ("class" = 'ba'::bpchar)) OR ("class" = 'dr'::bpchar)) OR ("class" = 'ne'::bpchar)) OR ("class" = 'pa'::bpchar)) OR ("class" = 'so'::bpchar))),
    CONSTRAINT charachter_level_check CHECK ((("level" >= 1) AND ("level" <= 99))),
    CONSTRAINT charachter_version_check CHECK (((version >= 109) AND (version <= 111)))
);


ALTER TABLE public.charachter OWNER TO diablo2;

--
-- Name: itemid_seq; Type: SEQUENCE; Schema: public; Owner: diablo2
--

CREATE SEQUENCE itemid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.itemid_seq OWNER TO diablo2;

--
-- Name: itemid_seq; Type: SEQUENCE SET; Schema: public; Owner: diablo2
--

SELECT pg_catalog.setval('itemid_seq', 534, true);


--
-- Name: item; Type: TABLE; Schema: public; Owner: diablo2; Tablespace: 
--

CREATE TABLE item (
    itemid integer DEFAULT nextval('itemid_seq'::regclass) NOT NULL,
    name character varying(64) NOT NULL,
    itemtypeid integer NOT NULL,
    itemsetid integer,
    sockets integer,
    req_level integer,
    req_str integer,
    req_dex integer,
    version integer,
    CONSTRAINT item_req_dex_check CHECK (((req_dex > 0) AND (req_dex <= 300))),
    CONSTRAINT item_req_level_check CHECK (((req_level >= 2) AND (req_level <= 99))),
    CONSTRAINT item_req_str_check CHECK (((req_str > 0) AND (req_str <= 300))),
    CONSTRAINT item_sockets_check CHECK (((sockets >= 0) AND (sockets <= 6))),
    CONSTRAINT item_version_check CHECK (((version >= 109) AND (version <= 111)))
);


ALTER TABLE public.item OWNER TO diablo2;

--
-- Name: item_item_prop; Type: TABLE; Schema: public; Owner: diablo2; Tablespace: 
--

CREATE TABLE item_item_prop (
    itemid integer NOT NULL,
    itempropid integer NOT NULL,
    value integer,
    value_min integer,
    value_max integer,
    value_perlevel double precision,
    CONSTRAINT item_item_prop_check CHECK ((((((((value IS NOT NULL) AND (value_min IS NULL)) AND (value_max IS NULL)) AND (value_perlevel IS NULL)) OR ((((value IS NULL) AND (value_min IS NOT NULL)) AND (value_max IS NOT NULL)) AND (value_perlevel IS NULL))) OR ((((value IS NULL) AND (value_min IS NULL)) AND (value_max IS NULL)) AND (value_perlevel IS NOT NULL))) OR ((((value IS NULL) AND (value_min IS NULL)) AND (value_max IS NULL)) AND (value_perlevel IS NULL))))
);


ALTER TABLE public.item_item_prop OWNER TO diablo2;

--
-- Name: item_itemprop_cache; Type: TABLE; Schema: public; Owner: diablo2; Tablespace: 
--

CREATE TABLE item_itemprop_cache (
    itemid integer NOT NULL,
    itempropid integer NOT NULL,
    value integer,
    value_min integer,
    value_max integer,
    CONSTRAINT item_itemprop_cache_check CHECK (((((value IS NOT NULL) AND (value_min IS NULL)) AND (value_max IS NULL)) OR (((value IS NULL) AND (value_min IS NOT NULL)) AND (value_max IS NOT NULL))))
);


ALTER TABLE public.item_itemprop_cache OWNER TO diablo2;

--
-- Name: item_spell; Type: TABLE; Schema: public; Owner: diablo2; Tablespace: 
--

CREATE TABLE item_spell (
    itemid integer NOT NULL,
    spellid integer NOT NULL,
    "type" character(1) NOT NULL,
    level_val integer,
    level_min integer,
    level_max integer,
    pct_val integer,
    pct_min integer,
    pct_max integer,
    num_charges integer,
    CONSTRAINT item_spell_check CHECK (((((level_val IS NOT NULL) AND (level_min IS NULL)) AND (level_max IS NULL)) OR (((level_val IS NULL) AND (level_min IS NOT NULL)) AND (level_max IS NOT NULL)))),
    CONSTRAINT item_spell_check1 CHECK ((("type" <> 'C'::bpchar) OR (num_charges IS NOT NULL))),
    CONSTRAINT item_spell_check2 CHECK (((("type" = 'C'::bpchar) OR ("type" = 'S'::bpchar)) OR ((((pct_val IS NOT NULL) AND (pct_min IS NULL)) AND (pct_max IS NULL)) OR (((pct_val IS NULL) AND (pct_min IS NOT NULL)) AND (pct_max IS NOT NULL))))),
    CONSTRAINT item_spell_type_check CHECK ((((((((("type" = 'O'::bpchar) OR ("type" = 'W'::bpchar)) OR ("type" = 'A'::bpchar)) OR ("type" = 'C'::bpchar)) OR ("type" = 'S'::bpchar)) OR ("type" = 'I'::bpchar)) OR ("type" = 'L'::bpchar)) OR ("type" = 'K'::bpchar)))
);


ALTER TABLE public.item_spell OWNER TO diablo2;

--
-- Name: item_type_prop; Type: TABLE; Schema: public; Owner: diablo2; Tablespace: 
--

CREATE TABLE item_type_prop (
    itemtypeid integer NOT NULL,
    itempropid integer NOT NULL,
    value integer,
    value_min integer,
    value_max integer,
    CONSTRAINT item_type_prop_check CHECK ((((((value IS NOT NULL) AND (value_min IS NULL)) AND (value_max IS NULL)) OR (((value IS NULL) AND (value_min IS NOT NULL)) AND (value_max IS NOT NULL))) OR (((value IS NULL) AND (value_min IS NULL)) AND (value_max IS NULL))))
);


ALTER TABLE public.item_type_prop OWNER TO diablo2;

--
-- Name: itemcatid_seq; Type: SEQUENCE; Schema: public; Owner: diablo2
--

CREATE SEQUENCE itemcatid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.itemcatid_seq OWNER TO diablo2;

--
-- Name: itemcatid_seq; Type: SEQUENCE SET; Schema: public; Owner: diablo2
--

SELECT pg_catalog.setval('itemcatid_seq', 28, true);


--
-- Name: itemcategory; Type: TABLE; Schema: public; Owner: diablo2; Tablespace: 
--

CREATE TABLE itemcategory (
    itemcatid integer DEFAULT nextval('itemcatid_seq'::regclass) NOT NULL,
    name character varying(32) NOT NULL
);


ALTER TABLE public.itemcategory OWNER TO diablo2;

--
-- Name: itempropid_seq; Type: SEQUENCE; Schema: public; Owner: diablo2
--

CREATE SEQUENCE itempropid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.itempropid_seq OWNER TO diablo2;

--
-- Name: itempropid_seq; Type: SEQUENCE SET; Schema: public; Owner: diablo2
--

SELECT pg_catalog.setval('itempropid_seq', 491, true);


--
-- Name: itemproperty; Type: TABLE; Schema: public; Owner: diablo2; Tablespace: 
--

CREATE TABLE itemproperty (
    itempropid integer DEFAULT nextval('itempropid_seq'::regclass) NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.itemproperty OWNER TO diablo2;

--
-- Name: itemsetid_seq; Type: SEQUENCE; Schema: public; Owner: diablo2
--

CREATE SEQUENCE itemsetid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.itemsetid_seq OWNER TO diablo2;

--
-- Name: itemsetid_seq; Type: SEQUENCE SET; Schema: public; Owner: diablo2
--

SELECT pg_catalog.setval('itemsetid_seq', 32, true);


--
-- Name: itemset; Type: TABLE; Schema: public; Owner: diablo2; Tablespace: 
--

CREATE TABLE itemset (
    itemsetid integer DEFAULT nextval('itemsetid_seq'::regclass) NOT NULL,
    name character varying(64) NOT NULL
);


ALTER TABLE public.itemset OWNER TO diablo2;

--
-- Name: itemtypeid_seq; Type: SEQUENCE; Schema: public; Owner: diablo2
--

CREATE SEQUENCE itemtypeid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.itemtypeid_seq OWNER TO diablo2;

--
-- Name: itemtypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: diablo2
--

SELECT pg_catalog.setval('itemtypeid_seq', 499, true);


--
-- Name: itemtype; Type: TABLE; Schema: public; Owner: diablo2; Tablespace: 
--

CREATE TABLE itemtype (
    itemtypeid integer DEFAULT nextval('itemtypeid_seq'::regclass) NOT NULL,
    name character varying(64) NOT NULL,
    itemcatid integer NOT NULL,
    itemclasscatid integer,
    "level" integer NOT NULL,
    tc integer,
    sockets integer,
    req_level integer,
    req_str integer,
    req_dex integer,
    CONSTRAINT itemtype_level_check CHECK ((("level" >= 0) AND ("level" <= 2))),
    CONSTRAINT itemtype_req_dex_check CHECK (((req_dex > 0) AND (req_dex <= 300))),
    CONSTRAINT itemtype_req_level_check CHECK (((req_level >= 2) AND (req_level <= 99))),
    CONSTRAINT itemtype_req_str_check CHECK (((req_str > 0) AND (req_str <= 300))),
    CONSTRAINT itemtype_sockets_check CHECK (((sockets >= 0) AND (sockets <= 6))),
    CONSTRAINT itemtype_tc_check CHECK (((tc >= 3) AND (tc <= 90)))
);


ALTER TABLE public.itemtype OWNER TO diablo2;

--
-- Name: spellid_seq; Type: SEQUENCE; Schema: public; Owner: diablo2
--

CREATE SEQUENCE spellid_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.spellid_seq OWNER TO diablo2;

--
-- Name: spellid_seq; Type: SEQUENCE SET; Schema: public; Owner: diablo2
--

SELECT pg_catalog.setval('spellid_seq', 197, true);


--
-- Name: spell; Type: TABLE; Schema: public; Owner: diablo2; Tablespace: 
--

CREATE TABLE spell (
    spellid integer DEFAULT nextval('spellid_seq'::regclass) NOT NULL,
    name character varying(32) NOT NULL,
    charachter character(2),
    CONSTRAINT spell_char_check CHECK ((((((((charachter = 'am'::bpchar) OR (charachter = 'as'::bpchar)) OR (charachter = 'ba'::bpchar)) OR (charachter = 'dr'::bpchar)) OR (charachter = 'ne'::bpchar)) OR (charachter = 'pa'::bpchar)) OR (charachter = 'so'::bpchar)))
);


ALTER TABLE public.spell OWNER TO diablo2;

--
-- Data for Name: char_item; Type: TABLE DATA; Schema: public; Owner: diablo2
--

--
-- Data for Name: charachter; Type: TABLE DATA; Schema: public; Owner: diablo2
--

--
-- Data for Name: item; Type: TABLE DATA; Schema: public; Owner: diablo2
--

COPY item (itemid, name, itemtypeid, itemsetid, sockets, req_level, req_str, req_dex, version) FROM stdin;
1	Ginther's Rift	448	\N	\N	37	85	60	109
2	Blackhorn's Face	252	\N	\N	41	55	\N	109
3	Dwarf Star	278	\N	\N	45	\N	\N	109
4	Langer Briser	189	\N	\N	32	52	61	109
5	Skewer of Krinitz	432	\N	\N	10	25	25	109
6	Soulfeast Tine	407	\N	\N	35	64	76	109
7	Stormstrike	161	\N	\N	25	30	40	109
8	Rattlecage	28	\N	\N	29	70	\N	109
9	Boneflesh	27	\N	\N	26	65	\N	109
10	Azurewrath	434	\N	\N	13	43	\N	109
11	Manald Heal	278	\N	\N	15	\N	\N	109
12	Ironstone	285	\N	\N	27	53	\N	109
13	Bloodrise	283	\N	\N	15	36	\N	109
14	Hawkmail	21	\N	\N	15	44	\N	109
15	Leadcrow	185	\N	\N	9	21	27	109
16	Hellplague	436	\N	\N	22	55	39	109
17	Kinemil's Awl	440	\N	\N	23	56	34	109
18	Dark Clan Crusher	288	\N	\N	34	25	\N	109
19	Bverrit Keep	366	\N	\N	19	75	\N	109
20	Wall of the Eyeless	367	\N	\N	20	25	\N	109
21	The Jade Tan Do	199	\N	\N	19	\N	45	109
22	The Meat Scraper	340	\N	\N	41	80	\N	109
23	The Patriarch	443	\N	\N	29	100	60	109
24	Coldkill	92	\N	\N	36	25	25	109
25	Nagelring	278	\N	\N	15	\N	\N	109
26	Crescent Moon	279	\N	\N	60	\N	\N	109
27	Stone of Jordan	278	\N	\N	29	\N	\N	109
28	Atma's Scarab	279	\N	\N	60	\N	\N	109
29	Raven Frost	278	\N	\N	45	\N	\N	109
30	Bul-Kathos' Wedding Band	278	\N	\N	58	\N	\N	109
32	Nokozan Relic	279	\N	\N	10	\N	\N	109
33	The Eye of Etlich	279	\N	\N	15	\N	\N	109
34	The Mahim-Oak Curio	279	\N	\N	25	\N	\N	109
35	Saracen's Chance	279	\N	\N	47	\N	\N	109
36	The Cat's Eye	279	\N	\N	50	\N	\N	109
37	Soul Harvest	336	\N	\N	19	41	41	109
38	Venom Ward	22	\N	\N	20	30	\N	109
39	Goblin Toe	145	\N	\N	22	50	\N	109
40	Rakescar	86	\N	\N	27	67	\N	109
41	Wizendraw	162	\N	\N	26	40	50	109
42	Rusthandle	353	\N	\N	18	37	\N	109
43	Goldskin	29	\N	\N	28	80	\N	109
44	Torch of Iro	484	\N	\N	5	\N	\N	109
45	Thundergod's Vigor	136	\N	\N	47	110	\N	109
46	Sparking Mail	23	\N	\N	17	48	\N	109
47	Visceratuant	369	\N	\N	28	38	\N	109
48	The Hand of Broc	224	\N	\N	6	\N	\N	109
49	Deathspade	83	\N	\N	9	32	\N	109
50	Pelta Lunata	361	\N	\N	2	12	\N	109
51	Razortine	401	\N	\N	12	38	24	109
52	Tearhaunch	146	\N	\N	29	70	\N	109
53	The Grim Reaper	339	\N	\N	29	80	80	109
54	Snakecord	128	\N	\N	12	\N	\N	109
55	Woestave	338	\N	\N	28	75	47	109
56	Endlesshail	168	\N	\N	36	58	73	109
57	Bladebone	84	\N	\N	15	43	\N	109
58	Blastbark	164	\N	\N	28	50	65	109
59	Warlord's Trust	97	\N	\N	35	73	\N	109
60	Hotspur	142	\N	\N	6	\N	\N	109
61	Bladebuckle	131	\N	\N	29	60	\N	109
62	Bing Sz Wang	453	\N	\N	43	64	\N	109
63	Butcher's Pupil	93	\N	\N	39	68	\N	109
64	Raven Claw	159	\N	\N	15	22	19	109
65	The Iron Jang Bong	419	\N	\N	28	\N	\N	109
66	Wormskull	246	\N	\N	21	\N	\N	109
67	Lycander's Flank	9	\N	\N	42	115	98	109
68	Arreat's Face	121	\N	\N	42	118	\N	109
69	Homunculus	313	\N	\N	42	58	\N	109
70	The Oculus	394	\N	\N	42	\N	\N	109
71	Bartuc's Cut-Throat	73	\N	\N	42	79	79	109
72	Herald Of Zakarum	327	\N	\N	40	104	\N	109
73	Lycander's Aim	7	\N	\N	43	95	118	109
74	Ialal's Mane	218	\N	\N	42	65	\N	109
75	Titan's Revenge	10	\N	\N	42	25	109	109
76	Biggin's Bonnet	239	\N	\N	3	\N	\N	109
77	Tarnhelm	240	\N	\N	15	15	\N	109
78	Coif of Glory	241	\N	\N	14	26	\N	109
79	Duskdeep	242	\N	\N	17	41	\N	109
80	Howltusk	243	\N	\N	25	63	\N	109
81	The Face of Horror	244	\N	\N	20	23	\N	109
82	Undead Crown	245	\N	\N	29	55	\N	109
83	Greyform	16	\N	\N	7	12	\N	109
84	Blinkbat's Form	17	\N	\N	12	15	\N	109
85	The Centurion	18	\N	\N	14	20	\N	109
86	Twitchthroe	19	\N	\N	16	27	\N	109
87	Darkglow	20	\N	\N	14	36	\N	109
88	Iceblink	24	\N	\N	22	51	\N	109
89	Heavenly Garb	25	\N	\N	29	41	\N	109
90	Rockfleece	26	\N	\N	28	50	\N	109
91	Silks of the Victor	30	\N	\N	28	100	\N	109
92	Umbral Disk	362	\N	\N	9	22	\N	109
93	Stormguild	363	\N	\N	13	34	\N	109
94	Steelclash	364	\N	\N	17	47	\N	109
95	Swordback Hold	365	\N	\N	15	30	\N	109
96	The Ward	368	\N	\N	26	60	\N	109
97	Bloodfist	225	\N	\N	9	\N	\N	109
98	Chance Guard	226	\N	\N	15	25	\N	109
99	Magefist	227	\N	\N	23	45	\N	109
100	Frostburn	228	\N	\N	29	60	\N	109
101	Gorefoot	143	\N	\N	9	18	\N	109
102	Treads of Cthon	144	\N	\N	15	30	\N	109
103	Lenymo	127	\N	\N	7	\N	\N	109
104	Nightsmoke	129	\N	\N	20	25	\N	109
105	Goldwrap	130	\N	\N	27	45	\N	109
106	Peasant Crown	247	\N	\N	28	20	\N	109
107	Rockstopper	248	\N	\N	31	43	\N	109
108	Stealskull	249	\N	\N	35	59	\N	109
109	Darksight Helm	250	\N	\N	38	82	\N	109
110	Valkyrie Wing	251	\N	\N	44	115	\N	109
111	Crown of Thieves	253	\N	\N	49	103	\N	109
112	Vampire Gaze	254	\N	\N	41	58	\N	109
113	The Spirit Shroud	31	\N	\N	28	38	\N	109
114	Skin of the Vipermagi	32	\N	\N	29	43	\N	109
115	Skin of the Flayed One	33	\N	\N	31	50	\N	109
116	Iron Pelt	34	\N	\N	33	61	\N	109
117	Crow Caw	36	\N	\N	37	86	\N	109
118	Spirit Forge	35	\N	5	35	74	\N	109
119	Duriel's Shell	37	\N	\N	41	65	\N	109
120	Shaftstop	38	\N	\N	38	92	\N	109
121	Skullder's Ire	39	\N	\N	42	97	\N	109
122	Que-Hegan's Wisdom	40	\N	\N	51	55	\N	109
123	Guardian Angel	42	\N	\N	45	118	\N	109
124	Toothrow	41	\N	\N	48	103	\N	109
125	Atma's Wail	43	\N	\N	51	125	\N	109
126	Black Hades	44	\N	5	53	140	\N	109
127	Corpsemourn	45	\N	\N	55	170	\N	109
128	Moser's Blessed Circle	370	\N	5	31	53	\N	109
129	Stormchaser	371	\N	\N	35	71	\N	109
130	Tiamat's Rebuke	372	\N	\N	38	91	\N	109
131	Lance Guard	373	\N	\N	35	65	\N	109
132	Gerke's Sanctuary	374	\N	\N	44	133	\N	109
133	Lidless Wall	375	\N	\N	41	58	\N	109
134	Radament's Sphere	376	\N	\N	50	110	\N	109
135	Venom Grip	229	\N	\N	29	20	\N	109
136	Gravepalm	230	\N	\N	32	20	\N	109
137	Ghoulhide	231	\N	\N	36	58	\N	109
138	Lava Gout	232	\N	\N	42	68	\N	109
139	Hellmouth	233	\N	\N	47	110	\N	109
140	Infernostride	147	\N	\N	29	20	\N	109
141	Waterwalk	148	\N	\N	32	18	\N	109
142	Silkweave	149	\N	\N	36	65	\N	109
143	War Traveller	150	\N	\N	42	95	\N	109
144	Gore Rider	151	\N	\N	48	93	\N	109
145	String of Ears	132	\N	\N	29	20	\N	109
146	Razortail	133	\N	\N	32	20	\N	109
147	Gloom's Trap	134	\N	\N	36	58	\N	109
148	Snowclash	135	\N	\N	42	88	\N	109
149	Harlequin Crest	255	\N	\N	52	50	\N	109
150	Veil of Steel	259	\N	\N	73	192	\N	109
151	The Gladiator's Bane	49	\N	\N	85	111	\N	109
152	Arkaine's Valor	54	\N	\N	85	165	\N	109
153	Blackoak Shield	378	\N	\N	61	100	\N	109
154	Stormshield	380	\N	\N	73	157	\N	109
155	Nosferatu's Coil	138	\N	\N	51	50	\N	109
156	The Gnasher	82	\N	\N	5	\N	\N	109
157	Skull Splitter	85	\N	\N	21	49	33	109
158	Axe of Fechmar	87	\N	\N	8	35	\N	109
159	Goreshovel	88	\N	\N	14	48	\N	109
160	The Chieftain	89	\N	\N	19	54	\N	109
161	Brainhew	90	\N	\N	25	63	39	109
162	The Humongous	91	\N	\N	29	84	\N	109
163	Pluckeye	157	\N	\N	7	\N	15	109
164	Witherstring	158	\N	\N	13	\N	28	109
165	Rogue's Bow	160	\N	\N	20	25	35	109
166	Hellclap	163	\N	\N	27	35	55	109
167	Ichorsting	186	\N	\N	18	40	33	109
168	Hellcast	187	\N	\N	27	60	40	109
169	Doomslinger	188	\N	\N	28	40	50	109
170	Gull	197	\N	\N	4	\N	\N	109
171	The Diggler	197	\N	\N	11	\N	25	109
172	Spectral Shard	200	\N	\N	25	35	51	109
173	Felloak	280	\N	\N	3	\N	\N	109
174	Stoutnail	281	\N	\N	5	\N	\N	109
175	Crushflange	282	\N	\N	9	27	\N	109
176	The General's Tan Do Li Ga	284	\N	\N	21	41	35	109
177	Bonesnap	286	\N	\N	24	69	\N	109
178	Steeldriver	287	\N	\N	29	50	\N	109
179	Dimoak's Hew	334	\N	\N	8	40	\N	109
180	Steelgoad	335	\N	\N	14	50	\N	109
181	The Battlebranch	337	\N	\N	25	62	\N	109
182	Knell Striker	352	\N	\N	5	25	\N	109
183	Stormeye	354	\N	\N	30	55	\N	109
184	The Dragon Chang	400	\N	\N	8	\N	\N	109
185	Bloodthief	402	\N	\N	17	40	50	109
186	Lance of Yaggai	403	\N	\N	22	54	35	109
187	The Tannr Gorerod	404	\N	\N	27	60	45	109
188	Bane Ash	415	\N	\N	5	\N	\N	109
189	Serpent Lord	416	\N	\N	9	\N	\N	109
190	Spire of Lazarus	417	\N	\N	18	\N	\N	109
191	The Salamander	418	\N	\N	21	\N	\N	109
192	Rixot's Keen	430	\N	\N	2	\N	\N	109
193	Blood Crescent	431	\N	\N	7	\N	21	109
194	Gleamscythe	433	\N	\N	13	33	\N	109
195	Griswold's Edge	435	\N	\N	17	48	\N	109
196	Culwen's Point	437	\N	\N	29	71	45	109
197	Shadowfang	438	\N	\N	12	35	27	109
198	Soulflay	439	\N	\N	19	47	\N	109
199	Blacktongue	441	\N	\N	26	62	\N	109
200	Ripsaw	442	\N	\N	26	70	49	109
201	Maelstrom	485	\N	\N	14	\N	\N	109
202	Gravespine	486	\N	\N	20	\N	\N	109
203	Ume's Lament	487	\N	\N	28	\N	\N	109
204	Islestrike	94	\N	\N	43	85	\N	109
205	Pompeii's Wrath	95	\N	\N	45	94	70	109
206	Guardian Naga	96	\N	\N	48	121	\N	109
207	Spellsteel	98	\N	\N	39	37	\N	109
208	Stormrider	99	\N	\N	41	101	\N	109
209	Boneslayer Blade	100	\N	\N	42	115	79	109
210	The Minotaur	101	\N	\N	45	125	\N	109
211	Skystrike	165	\N	\N	28	25	43	109
212	Riphook	166	\N	\N	31	25	62	109
213	Kuko Shakaku	167	\N	\N	33	53	49	109
214	Witchwild String	169	\N	\N	39	65	80	109
215	Cliffkiller	170	\N	\N	41	80	95	109
216	Magewrath	171	\N	\N	43	73	103	109
217	Goldstrike Arch	172	\N	\N	46	95	118	109
218	Pus Spitter	190	\N	\N	36	32	28	109
219	Buriza-Do Kyanon	191	\N	\N	41	110	80	109
220	Demon Machine	192	\N	\N	49	80	95	109
221	Spineripper	201	\N	\N	32	25	\N	109
222	Heart Carver	202	\N	\N	36	25	58	109
223	Blackbog's Sharp	203	\N	\N	38	25	68	109
224	Stormspike	204	\N	\N	41	47	97	109
225	Fleshrender	289	\N	\N	38	30	\N	109
226	Sureshril Frost	290	\N	\N	39	61	\N	109
227	Moonfall	291	\N	\N	42	74	\N	109
228	Baezil's Vortex	292	\N	\N	45	82	73	109
229	Earthshaker	293	\N	\N	43	100	\N	109
230	Bloodtree Stump	294	\N	\N	48	124	\N	109
231	The Gavel of Pain	295	\N	\N	45	169	\N	109
232	Blackleach Blade	341	\N	\N	42	50	\N	109
233	Athena's Wrath	342	\N	\N	42	82	82	109
234	Pierre Tombale Couant	343	\N	\N	43	113	67	109
235	Husoldal Evo	344	\N	\N	44	133	91	109
236	Grim's Burning Dead	345	\N	\N	45	70	70	109
237	Zakarum's Hand	355	\N	\N	37	58	\N	109
238	The Fetid Sprinkler	356	\N	\N	38	76	\N	109
239	Hand of Blessed Light	357	\N	\N	42	103	\N	109
240	The Impaler	405	\N	\N	31	25	25	109
241	Kelpie Snare	406	\N	\N	33	77	25	109
242	Hone Sundan	408	\N	5	37	101	\N	109
243	Spire of Honor	409	\N	\N	39	110	88	109
245	Ribcracker	421	\N	\N	31	25	\N	109
246	Chromatic Ire	422	\N	\N	35	25	\N	109
247	Warpspear	423	\N	\N	39	25	\N	109
248	Skull Collector	424	\N	\N	41	25	\N	109
249	Bloodletter	444	\N	\N	30	25	\N	109
250	Coldsteel Eye	445	\N	\N	31	25	52	109
251	Hexfire	446	\N	\N	33	58	58	109
252	Blade of Ali Baba	447	\N	5	35	70	42	109
253	Headstriker	449	\N	\N	39	92	43	109
254	Plague Bearer	450	\N	\N	41	103	79	109
255	The Atlantean	451	\N	\N	42	127	88	109
256	Crainte Vomir	452	\N	\N	42	73	61	109
257	The Vile Husk	454	\N	\N	44	104	71	109
258	Cloudcrack	455	\N	\N	45	113	20	109
259	Todesfaelle Flamme	456	\N	\N	46	125	94	109
260	Swordguard	457	\N	\N	48	85	55	109
261	Death Bit	476	\N	\N	44	25	52	109
262	The Scalper	478	\N	\N	57	80	25	109
263	Suicide Branch	488	\N	\N	33	25	\N	109
264	Carin Shard	489	\N	\N	35	25	\N	109
265	Arm Of King Leoric	490	\N	\N	36	25	\N	109
266	Blackhand Key	491	\N	\N	41	25	\N	109
267	Messerschmidt's Reaver	110	\N	\N	70	167	59	109
268	Hellslayer	109	\N	\N	66	189	33	109
269	Eaglehorn	178	\N	\N	69	97	121	109
270	Windforce	180	\N	\N	74	134	167	109
271	Baranar's Star	299	\N	\N	65	153	44	109
272	The Cranium Basher	303	\N	\N	87	253	\N	109
273	Schaefer's Hammer	301	\N	\N	79	189	\N	109
274	Lightsabre	462	\N	\N	58	25	136	109
275	Doombringer	469	\N	\N	69	163	103	109
276	The Grandfather	471	\N	\N	81	108	110	109
277	Stormspire	351	\N	\N	70	188	140	109
278	Wizardspike	205	\N	\N	61	38	75	109
279	Angelic Mantle	20	1	\N	12	36	\N	109
280	Angelic Sickle	432	1	\N	12	25	25	109
281	Angelic Halo	278	1	\N	12	\N	\N	109
282	Angelic Wings	279	1	\N	12	\N	\N	109
283	Arcanna's Deathwand	419	2	\N	15	\N	\N	109
284	Arcanna's Head	240	2	\N	15	15	\N	109
285	Arcanna's Flesh	25	2	\N	15	41	\N	109
286	Arcanna's Sign	279	2	\N	15	\N	\N	109
287	Arctic Furs	16	3	\N	2	\N	\N	109
288	Arctic Binding	128	3	\N	2	\N	\N	109
289	Arctic Mitts	227	3	\N	3	45	\N	109
290	Arctic Horn	163	3	\N	2	35	55	109
291	Berserker's Headgear	241	4	\N	3	51	\N	109
292	Beserker's Hatchet	84	4	\N	3	43	\N	109
293	Berserker's Hauberk	24	4	\N	3	51	\N	109
294	Cathan's Visage	244	5	\N	11	23	\N	109
295	Cathan's Mesh	23	5	\N	11	24	\N	109
296	Cathan's Rule	418	5	\N	11	\N	\N	109
297	Cathan's Sigil	279	5	\N	11	\N	\N	109
298	Cathan's Seal	278	5	\N	11	\N	\N	109
299	Civerb's Cudgel	353	6	\N	9	37	\N	109
300	Civerb's Icon	279	6	\N	9	\N	\N	109
301	Civerb's Ward	363	6	\N	9	34	\N	109
302	Cleglaw's Tooth	436	7	\N	4	55	39	109
303	Cleglaw's Pincers	226	7	\N	4	25	\N	109
304	Cleglaw's Claw	362	7	\N	4	22	\N	109
305	Death's Touch	437	8	\N	6	71	45	109
306	Death's Hand	224	8	\N	6	\N	\N	109
307	Death's Guard	127	8	\N	6	\N	\N	109
308	Hsarus' Iron Fist	361	9	\N	3	12	\N	109
309	Hsarus' Iron Stay	129	9	\N	3	25	\N	109
310	Hsarus' Iron Heel	144	9	\N	3	30	\N	109
311	Infernal Cranium	239	10	\N	5	\N	\N	109
312	Infernal Sign	130	10	\N	5	45	\N	109
313	Infernal Torch	487	10	\N	5	\N	\N	109
314	Iratha's Coil	245	11	\N	15	55	\N	109
315	Iratha's Collar	279	11	\N	15	\N	\N	109
316	Iratha's Cord	130	11	\N	15	45	\N	109
317	Iratha's Cuff	227	11	\N	15	45	\N	109
318	Isenhart's Lightbrand	435	12	\N	8	48	\N	109
319	Isenhart's Horns	242	12	\N	8	41	\N	109
320	Isenhart's Case	22	12	\N	8	30	\N	109
321	Isenhart's Parry	368	12	\N	8	60	\N	109
322	Milabrega's Diadem	245	13	\N	17	55	\N	109
323	Milabrega's Robe	30	13	\N	17	100	\N	109
324	Milabrega's Orb	364	13	\N	17	47	\N	109
325	Milabrega's Rod	354	13	\N	17	55	\N	109
326	Sigon's Visor	243	14	\N	6	53	\N	109
327	Sigon's Shelter	28	14	\N	6	70	\N	109
328	Sigon's Sabot	146	14	\N	5	70	\N	109
329	Sigon's Guard	366	14	\N	6	75	\N	109
330	Sigon's Wrap	131	14	\N	6	60	\N	109
331	Sigon's Gage	228	14	\N	6	60	\N	109
332	Tancred's Skull	246	15	\N	20	25	\N	109
333	Tancred's Spine	29	15	\N	20	80	\N	109
334	Tancred's Hobnails	142	15	\N	20	\N	\N	109
335	Tancred's Crowbill	85	15	\N	20	49	33	109
336	Tancred's Weird	279	15	\N	20	\N	\N	109
337	Vidala's Barb	162	16	\N	14	40	50	109
338	Vidala's Ambush	17	16	\N	14	15	\N	109
339	Vidala's Fetlock	145	16	\N	14	50	\N	109
340	Vidala's Snare	279	16	\N	14	\N	\N	109
341	Aldur's Stony Gaze	216	17	\N	36	56	\N	109
342	Aldur's Advance	150	17	\N	45	95	\N	109
343	Aldur's Deception	59	17	\N	76	115	\N	109
344	Aldur's Rhythm	291	17	\N	42	74	\N	109
345	Bul-Kathos' Sacred Charge	471	18	\N	63	189	110	109
346	Bul-Kathos' Tribal Guardian	465	18	\N	66	147	124	109
347	Cow King's Horns	247	19	\N	25	20	\N	109
348	Cow King's Hide	19	19	\N	18	27	\N	109
349	Cow King's Hooves	143	19	\N	13	18	\N	109
350	Telling of Beads	279	20	\N	30	\N	\N	109
351	Laying of Hands	234	20	\N	63	50	\N	109
352	Dark Adherent	46	20	\N	43	77	\N	109
353	Rite of Passage	147	20	\N	29	20	\N	109
354	Credendum	139	20	\N	65	106	\N	109
355	Griswold's Heart	45	21	5	45	102	\N	109
356	Griswold's Valor	261	21	5	69	105	\N	109
357	Griswold's Redemption	360	21	5	53	59	42	109
358	Griswold's Honor	333	21	5	68	148	\N	109
359	Haemosu's Adament	37	22	\N	44	52	\N	109
360	Dangoon's Teaching	298	22	\N	68	145	46	109
361	Taebaek's Glory	384	22	\N	81	185	\N	109
362	Ondal's Almighty	259	22	\N	69	116	\N	109
363	Hwanin's Splendor	253	23	\N	45	103	\N	109
364	Hwanin's Justice	341	23	\N	28	95	\N	109
365	Hwanin's Refuge	36	23	\N	30	86	\N	109
366	Hwanin's Blessing	129	23	\N	35	25	\N	109
367	Immortal King's Will	116	24	\N	47	65	\N	109
368	Immortal King's Stone Crusher	302	24	\N	76	225	\N	109
369	Immortal King's Soul Cage	60	24	\N	76	232	\N	109
370	Immortal King's Detail	136	24	\N	29	110	\N	109
371	Immortal King's Forge	233	24	\N	30	110	\N	109
372	Immortal King's Pillar	151	24	\N	31	125	\N	109
373	M'avina's True Sight	184	25	\N	64	\N	\N	109
374	M'avina's Caster	12	25	\N	70	108	52	109
375	M'avina's Embrace	56	25	\N	70	122	\N	109
376	M'avina's Icy Clutch	232	25	\N	32	88	\N	109
377	M'avina's Tenet	133	25	\N	45	20	\N	109
378	Natalya's Totem	254	26	\N	59	58	\N	109
379	Natalya's Mark	81	26	\N	79	118	118	109
380	Natalya's Shadow	51	26	\N	73	149	\N	109
381	Natalya's Soul	149	26	\N	25	65	\N	109
382	Naj's Circlet	181	27	\N	28	\N	\N	109
383	Naj's Light Plate	57	27	\N	71	79	\N	109
384	Naj's Puzzler	427	27	\N	78	44	37	109
385	Guillaume's Face	251	28	\N	34	115	\N	109
386	Whitstan's Guard	370	28	\N	29	53	\N	109
387	Magnus' Skin	230	28	\N	37	20	\N	109
388	Wilhelm's Pride	135	28	\N	42	88	\N	109
389	Sander's Paragon	239	29	\N	25	\N	\N	109
390	Sander's Superstition	486	29	\N	25	\N	\N	109
391	Sander's Taboo	225	29	\N	28	\N	\N	109
392	Sander's Riprap	143	29	\N	20	18	\N	109
393	Sazabi's Mental Sheath	250	30	\N	43	82	\N	109
394	Sazabi's Cobalt Redeemer	464	30	\N	73	99	109	109
395	Sazabi's Ghost Liberator	54	30	\N	67	165	\N	109
396	Tal Rasha's Lidless Eye	394	31	\N	65	\N	\N	109
397	Tal Rasha's Horadric Crest	252	31	\N	66	65	\N	109
398	Tal Rasha's Guardianship	58	31	\N	71	84	\N	109
399	Tal Rasha's Fine-Spun Cloth	134	31	\N	53	47	\N	109
400	Tal Rasha's Adjudication	279	31	\N	67	\N	\N	109
401	Trang-Oul's Guise	262	32	\N	65	108	\N	109
402	Trang-Oul's Scales	44	32	\N	49	84	\N	109
403	Trang-Oul's Wing	312	32	\N	54	50	\N	109
404	Trang-Oul's Girth	140	32	\N	62	91	\N	109
405	Trang-Oul's Claws	231	32	\N	45	58	\N	109
244	Razorswitch	420	\N	\N	28	18	\N	109
406	Mara's Kaleidoscope	279	\N	\N	67	\N	\N	109
407	Carrion Wind	278	\N	\N	60	\N	\N	110
408	Nature's Peace	278	\N	\N	69	\N	\N	110
409	Wisp Projector	278	\N	\N	76	\N	\N	110
410	The Rising Sun	279	\N	\N	65	\N	\N	110
411	Seraph's Hymn	279	\N	\N	65	\N	\N	110
412	Metalgrid	279	\N	\N	81	\N	\N	110
413	Annihilus	496	\N	\N	70	\N	\N	110
414	Gheed's Fortune	497	\N	\N	62	\N	\N	110
415	Hellfire Torch	498	\N	\N	75	\N	\N	111
424	Kira's Guardian	183	\N	\N	77	\N	\N	110
425	Griffon's Eye	184	\N	\N	76	\N	\N	110
426	Stoneraven	13	\N	\N	65	114	142	110
427	Thunderstroke	15	\N	\N	69	107	151	110
428	Blood Raven's Charge	11	\N	\N	71	87	187	110
429	Shadow Killer	78	\N	\N	71	100	100	110
430	Jade Talon	76	\N	\N	66	105	105	110
431	Firelizard's Talons	79	\N	\N	67	113	113	110
432	Darkforce Spawn	318	\N	\N	65	106	\N	110
433	Boneflame	317	\N	\N	72	95	\N	110
434	Wolfhowl	123	\N	\N	79	121	\N	110
435	Demonhorn's Edge	124	\N	\N	61	151	\N	110
436	Halaberd's Reign	125	\N	\N	77	174	\N	110
437	Eschuta's Temper	396	\N	\N	72	\N	\N	110
438	Death's Fathom	399	\N	\N	73	\N	\N	110
439	Cerebus' Bite	219	\N	\N	63	86	\N	110
440	Ravenlore	222	\N	\N	74	113	\N	110
441	Spirit Keeper	221	\N	\N	67	104	\N	110
442	Alma Negra	330	\N	\N	77	109	\N	110
443	Dragonscale	332	\N	\N	80	142	\N	110
444	The Gnasher	82	\N	\N	5	\N	\N	110
446	Raven Claw	159	\N	\N	15	22	19	110
447	Wizendraw	162	\N	\N	26	40	50	110
449	Snowclash	135	\N	\N	42	88	\N	110
451	Boneslayer Blade	100	\N	\N	41	101	\N	110
452	Kuko Shakaku	167	\N	\N	33	53	49	110
453	Witchwild String	169	\N	\N	39	65	80	110
454	Demon Machine	192	\N	\N	49	80	95	110
457	Steel Shade	257	\N	\N	62	109	\N	110
458	Nightwing's Veil	259	\N	\N	67	96	\N	110
459	Andariel's Visage	260	\N	\N	67	96	\N	110
460	Crown of Ages	261	\N	\N	82	174	\N	110
461	Giant Skull	262	\N	\N	65	106	\N	110
462	Ormus' Robes	46	\N	\N	75	77	\N	110
463	Arkaine's Valor	54	\N	\N	85	165	\N	110
464	Leviathan	56	\N	\N	65	174	\N	110
465	Steel Carapace	59	\N	\N	66	230	\N	110
466	Templar's Might	60	\N	\N	74	232	\N	110
467	Tyrael's Might	60	\N	\N	84	\N	\N	110
469	Spike Thorn	381	\N	\N	70	118	\N	110
470	Medusa's Gaze	382	\N	\N	76	219	\N	110
471	Head Hunter's Glory	383	\N	\N	75	106	\N	110
472	Spirit Ward	383	\N	\N	68	185	\N	110
473	Dracul's Grasp	235	\N	\N	76	50	\N	110
474	Soul Drainer	236	\N	\N	74	106	\N	110
475	Steelrend	238	\N	\N	70	185	\N	110
476	Sandstorm Trek	153	\N	\N	64	91	\N	110
477	Marrowwalk	154	\N	\N	66	118	\N	110
478	Shadow Dancer	156	\N	\N	71	167	\N	110
479	Arachnid Mesh	137	\N	\N	80	50	\N	110
480	Nosferatu's Coil	138	\N	\N	51	50	\N	110
481	Verdungo's Hearty Cord	139	\N	\N	63	106	\N	110
482	Razor's Edge	102	\N	\N	67	125	67	110
483	Rune Master	104	\N	\N	72	145	45	110
484	Cranebeak	105	\N	\N	63	133	54	110
485	Death Cleaver	106	\N	\N	70	138	59	110
486	Ethereal Edge	108	\N	\N	74	156	55	110
487	Hellslayer	109	\N	\N	66	189	33	110
488	Executioner's Justice	111	\N	\N	75	164	55	110
489	Widowmaker	179	\N	\N	65	72	146	110
490	Hellrack	195	\N	\N	76	163	77	110
491	Gut Siphon	196	\N	\N	71	141	98	110
492	Fleshripper	207	\N	\N	68	42	86	110
493	Ghostflame	208	\N	\N	66	55	57	110
494	Demon's Arch	275	\N	\N	68	127	95	110
495	Wraith Flight	276	\N	\N	76	79	127	110
496	Gargoyle's Bite	277	\N	\N	70	76	145	110
497	Nord's Tenderizer	296	\N	\N	68	88	43	110
498	Demon Limb	297	\N	\N	65	153	44	110
499	Horizon's Tornado	300	\N	\N	64	100	62	110
500	Stormlash	300	\N	\N	82	125	77	110
501	Stone Crusher	301	\N	\N	68	189	\N	110
503	Earth Shifter	303	\N	\N	69	253	\N	110
504	Bonehew	346	\N	\N	64	195	75	110
505	The Reaper's Toll	348	\N	\N	75	114	89	110
506	Tomb Reaver	349	\N	\N	84	165	103	110
508	Heaven's Light	358	\N	\N	61	125	65	110
509	The Redeemer	358	\N	\N	72	50	26	110
510	Astreon's Iron Ward	360	\N	\N	66	97	70	110
511	Arioc's Needle	410	\N	\N	81	155	120	110
512	Viperfork	412	\N	\N	71	132	134	110
513	Steel Pillar	414	\N	\N	69	165	106	110
514	Ondal's Wisdom	427	\N	\N	66	44	37	110
515	Mang Song's Lesson	429	\N	\N	82	34	\N	110
516	Djinn Slayer	459	\N	\N	65	138	95	110
517	Bloodmoon	460	\N	\N	61	109	122	110
519	Azurewrath	462	\N	\N	85	25	136	110
520	Frostwind	464	\N	\N	70	99	109	110
521	Flamebellow	468	\N	\N	71	185	87	110
522	Warshrike	481	\N	\N	75	45	142	110
523	Gimmershred	482	\N	\N	70	88	108	110
524	Lacerator	483	\N	\N	68	96	122	110
525	Boneshade	494	\N	\N	79	25	\N	110
526	Death's Web	495	\N	\N	66	25	\N	110
527	Rainbow Facet (1)	499	\N	\N	49	\N	\N	110
528	Rainbow Facet (2)	499	\N	\N	49	\N	\N	110
529	Rainbow Facet (3)	499	\N	\N	49	\N	\N	110
530	Rainbow Facet (4)	499	\N	\N	49	\N	\N	110
531	Rainbow Facet (5)	499	\N	\N	49	\N	\N	110
532	Rainbow Facet (6)	499	\N	\N	49	\N	\N	110
533	Rainbow Facet (7)	499	\N	\N	49	\N	\N	110
534	Rainbow Facet (8)	499	\N	\N	49	\N	\N	110
502	Windhammer	302	\N	\N	68	225	\N	110
\.


--
-- Data for Name: item_item_prop; Type: TABLE DATA; Schema: public; Owner: diablo2
--

COPY item_item_prop (itemid, itempropid, value, value_min, value_max, value_perlevel) FROM stdin;
1	14	\N	100	150	\N
1	15	\N	50	120	\N
1	16	30	\N	\N	\N
1	17	\N	7	12	\N
2	18	\N	180	220	\N
2	19	20	\N	\N	\N
2	20	25	\N	\N	\N
2	21	20	\N	\N	\N
2	22	15	\N	\N	\N
3	23	15	\N	\N	\N
3	24	15	\N	\N	\N
3	25	40	\N	\N	\N
3	26	40	\N	\N	\N
3	27	100	\N	\N	\N
3	17	\N	12	15	\N
4	14	\N	170	200	\N
4	28	\N	10	30	\N
4	29	33	\N	\N	\N
4	30	\N	1	212	\N
4	26	30	\N	\N	\N
4	31	\N	30	60	\N
5	14	50	\N	\N	\N
5	32	\N	3	7	\N
5	33	7	\N	\N	\N
5	34	10	\N	\N	\N
5	35	10	\N	\N	\N
6	14	\N	150	190	\N
6	36	-20	\N	\N	\N
6	37	7	\N	\N	\N
6	33	7	\N	\N	\N
6	38	20	\N	\N	\N
7	14	\N	70	90	\N
7	30	\N	1	30	\N
7	39	28	\N	\N	\N
7	22	25	\N	\N	\N
7	35	8	\N	\N	\N
8	5	200	\N	\N	\N
8	40	25	\N	\N	\N
8	41	40	\N	\N	\N
8	39	45	\N	\N	\N
9	18	\N	100	120	\N
9	37	5	\N	\N	\N
9	29	25	\N	\N	\N
9	39	35	\N	\N	\N
10	14	100	\N	\N	\N
10	15	\N	5	10	\N
10	42	\N	3	6	\N
10	43	4	\N	\N	\N
10	44	50	\N	\N	\N
10	31	10	\N	\N	\N
11	33	\N	4	7	\N
11	45	\N	5	8	\N
11	46	20	\N	\N	\N
11	26	20	\N	\N	\N
12	14	\N	100	150	\N
12	47	150	\N	\N	\N
12	30	\N	1	10	\N
12	39	\N	100	150	\N
12	35	10	\N	\N	\N
13	14	120	\N	\N	\N
13	47	150	\N	\N	\N
13	29	25	\N	\N	\N
13	48	10	\N	\N	\N
13	37	5	\N	\N	\N
13	49	50	\N	\N	\N
13	51	2	\N	\N	\N
14	18	\N	80	100	\N
14	52	10	\N	\N	\N
107	22	\N	20	40	\N
14	54	15	\N	\N	\N
15	14	70	\N	\N	\N
15	44	25	\N	\N	\N
15	39	40	\N	\N	\N
15	55	30	\N	\N	\N
15	26	10	\N	\N	\N
15	34	10	\N	\N	\N
16	14	\N	70	80	\N
16	56	2	\N	\N	\N
16	57	\N	25	75	\N
16	58	\N	28	56	\N
16	37	5	\N	\N	\N
16	33	5	\N	\N	\N
17	14	\N	80	100	\N
17	39	\N	100	150	\N
17	57	\N	6	40	\N
17	59	20	\N	\N	\N
18	14	195	\N	\N	\N
18	61	200	\N	\N	\N
18	47	150	\N	\N	\N
18	62	200	\N	\N	\N
18	49	\N	20	25	\N
18	63	15	\N	\N	\N
18	64	2	\N	\N	\N
19	65	\N	80	120	\N
19	5	30	\N	\N	\N
19	66	10	\N	\N	\N
19	67	75	\N	\N	\N
19	35	5	\N	\N	\N
19	17	5	\N	\N	\N
20	18	\N	30	40	\N
20	5	10	\N	\N	\N
20	68	5	\N	\N	\N
20	69	20	\N	\N	\N
20	33	3	\N	\N	\N
20	55	20	\N	\N	\N
21	39	\N	100	150	\N
21	70	180	\N	\N	\N
21	55	95	\N	\N	\N
21	71	20	\N	\N	\N
22	14	\N	150	200	\N
22	29	50	\N	\N	\N
22	48	30	\N	\N	\N
22	37	10	\N	\N	\N
22	31	25	\N	\N	\N
23	14	\N	100	120	\N
23	27	100	\N	\N	\N
23	17	3	\N	\N	\N
23	73	3	\N	\N	\N
24	14	\N	150	190	\N
24	48	30	\N	\N	\N
24	42	40	\N	\N	\N
24	43	2	\N	\N	\N
24	76	15	\N	\N	\N
24	54	15	\N	\N	\N
25	17	3	\N	\N	\N
25	39	\N	50	75	\N
25	77	3	\N	\N	\N
25	31	\N	15	30	\N
26	78	10	\N	\N	\N
26	59	45	\N	\N	\N
26	37	\N	3	6	\N
26	33	\N	11	15	\N
26	17	10	\N	\N	\N
26	51	-2	\N	\N	\N
27	79	1	\N	\N	\N
27	80	25	\N	\N	\N
27	30	\N	1	12	\N
27	59	20	\N	\N	\N
28	49	20	\N	\N	\N
28	70	\N	29	39	\N
28	55	75	\N	\N	\N
28	51	3	\N	\N	\N
28	77	5	\N	\N	\N
29	39	\N	150	250	\N
29	42	\N	15	45	\N
29	34	\N	15	20	\N
29	59	40	\N	\N	\N
29	82	20	\N	\N	\N
30	79	1	\N	\N	\N
30	26	\N	\N	\N	0.5
30	37	\N	3	5	\N
30	25	50	\N	\N	\N
393	22	\N	15	20	\N
60	87	15	\N	\N	\N
123	87	15	\N	\N	\N
140	87	10	\N	\N	\N
32	86	20	\N	\N	\N
32	67	50	\N	\N	\N
32	87	10	\N	\N	\N
32	57	\N	3	6	\N
32	51	3	\N	\N	\N
33	51	\N	1	5	\N
33	79	1	\N	\N	\N
33	37	\N	3	7	\N
33	42	\N	1	5	\N
33	89	\N	10	40	\N
34	5	10	\N	\N	\N
34	18	10	\N	\N	\N
34	49	10	\N	\N	\N
34	83	10	\N	\N	\N
34	90	10	\N	\N	\N
34	91	10	\N	\N	\N
34	34	10	\N	\N	\N
34	35	10	\N	\N	\N
35	83	\N	15	25	\N
35	34	12	\N	\N	\N
35	91	12	\N	\N	\N
35	90	12	\N	\N	\N
35	35	12	\N	\N	\N
36	52	30	\N	\N	\N
36	48	20	\N	\N	\N
36	5	100	\N	\N	\N
36	34	25	\N	\N	\N
37	14	88	\N	\N	\N
37	39	45	\N	\N	\N
37	33	10	\N	\N	\N
37	29	30	\N	\N	\N
37	91	5	\N	\N	\N
37	83	20	\N	\N	\N
38	18	61	\N	\N	\N
38	71	15	\N	\N	\N
38	55	90	\N	\N	\N
38	94	50	\N	\N	\N
38	51	2	\N	\N	\N
39	40	25	\N	\N	\N
39	18	53	\N	\N	\N
39	5	15	\N	\N	\N
39	73	1	\N	\N	\N
39	17	1	\N	\N	\N
39	51	-1	\N	\N	\N
40	48	30	\N	\N	\N
40	14	94	\N	\N	\N
40	39	50	\N	\N	\N
40	95	38	\N	\N	\N
40	55	50	\N	\N	\N
41	48	20	\N	\N	\N
41	14	80	\N	\N	\N
41	39	61	\N	\N	\N
41	91	15	\N	\N	\N
41	59	30	\N	\N	\N
41	54	26	\N	\N	\N
42	96	1	\N	\N	\N
42	14	58	\N	\N	\N
42	32	\N	3	7	\N
42	47	110	\N	\N	\N
42	37	8	\N	\N	\N
42	17	1	\N	\N	\N
43	18	120	\N	\N	\N
43	77	10	\N	\N	\N
43	27	100	\N	\N	\N
43	51	2	\N	\N	\N
44	100	1	\N	\N	\N
44	57	\N	5	9	\N
44	37	6	\N	\N	\N
44	91	10	\N	\N	\N
44	46	5	\N	\N	\N
44	51	3	\N	\N	\N
44	47	150	\N	\N	\N
45	30	\N	1	50	\N
45	18	191	\N	\N	\N
45	35	20	\N	\N	\N
45	90	20	\N	\N	\N
45	102	10	\N	\N	\N
45	21	20	\N	\N	\N
46	30	\N	1	20	\N
46	14	79	\N	\N	\N
46	22	30	\N	\N	\N
46	20	14	\N	\N	\N
47	105	1	\N	\N	\N
47	106	30	\N	\N	\N
47	66	30	\N	\N	\N
47	14	145	\N	\N	\N
47	20	10	\N	\N	\N
48	33	3	\N	\N	\N
48	37	3	\N	\N	\N
48	18	18	\N	\N	\N
48	5	10	\N	\N	\N
48	59	20	\N	\N	\N
48	55	10	\N	\N	\N
49	14	70	\N	\N	\N
49	107	8	\N	\N	\N
49	49	15	\N	\N	\N
49	68	4	\N	\N	\N
50	106	40	\N	\N	\N
50	66	20	\N	\N	\N
50	18	30	\N	\N	\N
50	5	30	\N	\N	\N
50	35	2	\N	\N	\N
50	90	10	\N	\N	\N
50	91	10	\N	\N	\N
51	48	30	\N	\N	\N
51	14	35	\N	\N	\N
51	108	50	\N	\N	\N
51	19	25	\N	\N	\N
51	35	15	\N	\N	\N
51	34	8	\N	\N	\N
52	52	20	\N	\N	\N
52	18	80	\N	\N	\N
52	65	35	\N	\N	\N
52	35	5	\N	\N	\N
52	34	5	\N	\N	\N
53	14	20	\N	\N	\N
53	107	15	\N	\N	\N
53	33	5	\N	\N	\N
53	44	100	\N	\N	\N
54	95	12	\N	\N	\N
54	18	21	\N	\N	\N
54	5	10	\N	\N	\N
54	45	5	\N	\N	\N
54	55	25	\N	\N	\N
54	94	50	\N	\N	\N
55	14	20	\N	\N	\N
55	29	50	\N	\N	\N
55	110	3	\N	\N	\N
55	19	50	\N	\N	\N
55	111	-50	\N	\N	\N
55	51	-3	\N	\N	\N
56	14	182	\N	\N	\N
56	42	\N	15	30	\N
56	89	50	\N	\N	\N
56	59	40	\N	\N	\N
56	54	35	\N	\N	\N
57	48	20	\N	\N	\N
57	14	45	\N	\N	\N
57	47	100	\N	\N	\N
57	62	40	\N	\N	\N
57	57	\N	8	12	\N
57	5	20	\N	\N	\N
58	113	1	\N	\N	\N
58	14	87	\N	\N	\N
58	33	3	\N	\N	\N
58	35	5	\N	\N	\N
59	14	175	\N	\N	\N
59	5	75	\N	\N	\N
59	90	\N	\N	\N	0.5
59	45	20	\N	\N	\N
59	83	10	\N	\N	\N
60	57	\N	3	6	\N
60	18	16	\N	\N	\N
60	5	6	\N	\N	\N
60	26	15	\N	\N	\N
60	67	45	\N	\N	\N
61	86	30	\N	\N	\N
61	18	92	\N	\N	\N
61	5	30	\N	\N	\N
61	35	5	\N	\N	\N
61	34	10	\N	\N	\N
61	73	3	\N	\N	\N
61	77	8	\N	\N	\N
62	14	147	\N	\N	\N
62	42	\N	50	140	\N
62	117	2	\N	\N	\N
62	35	20	\N	\N	\N
62	36	-30	\N	\N	\N
63	48	30	\N	\N	\N
63	14	193	\N	\N	\N
63	32	\N	30	50	\N
63	44	35	\N	\N	\N
63	29	25	\N	\N	\N
64	14	69	\N	\N	\N
64	49	50	\N	\N	\N
64	35	3	\N	\N	\N
64	34	3	\N	\N	\N
65	105	2	\N	\N	\N
65	69	20	\N	\N	\N
65	14	100	\N	\N	\N
65	49	50	\N	\N	\N
65	5	30	\N	\N	\N
65	47	150	\N	\N	\N
66	100	1	\N	\N	\N
66	121	80	\N	\N	\N
66	37	5	\N	\N	\N
66	59	10	\N	\N	\N
66	55	25	\N	\N	\N
67	14	\N	150	200	\N
67	32	\N	25	50	\N
67	113	2	\N	\N	\N
67	48	30	\N	\N	\N
67	37	\N	5	9	\N
67	35	20	\N	\N	\N
67	90	20	\N	\N	\N
67	18	20	\N	\N	\N
68	18	\N	150	200	\N
68	86	30	\N	\N	\N
68	49	20	\N	\N	\N
68	123	2	\N	\N	\N
68	37	\N	3	6	\N
68	83	30	\N	\N	\N
68	35	20	\N	\N	\N
68	34	20	\N	\N	\N
69	18	\N	150	200	\N
69	78	25	\N	\N	\N
69	66	40	\N	\N	\N
69	106	30	\N	\N	\N
69	100	2	\N	\N	\N
69	91	20	\N	\N	\N
69	46	33	\N	\N	\N
69	83	40	\N	\N	\N
141	87	5	\N	\N	\N
70	105	3	\N	\N	\N
70	68	5	\N	\N	\N
70	83	20	\N	\N	\N
70	69	30	\N	\N	\N
70	90	20	\N	\N	\N
70	91	20	\N	\N	\N
70	18	20	\N	\N	\N
70	31	50	\N	\N	\N
71	14	\N	150	200	\N
71	32	\N	25	50	\N
71	86	30	\N	\N	\N
71	49	20	\N	\N	\N
71	37	\N	5	9	\N
71	35	20	\N	\N	\N
71	34	20	\N	\N	\N
71	127	2	\N	\N	\N
72	18	\N	150	200	\N
72	66	30	\N	\N	\N
72	106	30	\N	\N	\N
72	49	20	\N	\N	\N
72	35	20	\N	\N	\N
72	90	20	\N	\N	\N
72	83	50	\N	\N	\N
72	96	2	\N	\N	\N
73	14	\N	150	200	\N
73	32	\N	25	50	\N
73	48	20	\N	\N	\N
73	113	2	\N	\N	\N
73	33	\N	5	8	\N
73	91	20	\N	\N	\N
73	34	20	\N	\N	\N
73	18	20	\N	\N	\N
74	18	\N	150	200	\N
74	86	30	\N	\N	\N
74	49	20	\N	\N	\N
187	87	15	\N	\N	\N
74	83	30	\N	\N	\N
74	68	5	\N	\N	\N
74	35	20	\N	\N	\N
75	14	\N	150	200	\N
75	32	\N	25	50	\N
75	113	2	\N	\N	\N
75	37	\N	5	9	\N
75	52	30	\N	\N	\N
75	35	20	\N	\N	\N
75	34	20	\N	\N	\N
76	14	30	\N	\N	\N
76	5	14	\N	\N	\N
76	39	30	\N	\N	\N
76	59	15	\N	\N	\N
76	26	15	\N	\N	\N
77	79	1	\N	\N	\N
77	31	\N	25	50	\N
77	27	75	\N	\N	\N
78	5	10	\N	\N	\N
78	20	7	\N	\N	\N
78	22	15	\N	\N	\N
94	96	1	\N	\N	\N
79	18	\N	30	50	\N
79	5	\N	10	20	\N
79	73	7	\N	\N	\N
79	83	15	\N	\N	\N
79	28	8	\N	\N	\N
79	51	-2	\N	\N	\N
80	78	35	\N	\N	\N
80	18	80	\N	\N	\N
80	17	2	\N	\N	\N
80	77	3	\N	\N	\N
80	41	25	\N	\N	\N
81	5	25	\N	\N	\N
81	47	50	\N	\N	\N
119	54	50	\N	\N	\N
81	83	10	\N	\N	\N
81	35	20	\N	\N	\N
82	18	\N	30	60	\N
119	67	20	\N	\N	\N
119	22	20	\N	\N	\N
82	37	5	\N	\N	\N
82	55	50	\N	\N	\N
82	5	40	\N	\N	\N
83	5	20	\N	\N	\N
83	37	5	\N	\N	\N
83	17	3	\N	\N	\N
83	54	20	\N	\N	\N
83	67	20	\N	\N	\N
83	34	10	\N	\N	\N
84	5	25	\N	\N	\N
84	89	50	\N	\N	\N
84	52	10	\N	\N	\N
84	86	40	\N	\N	\N
84	57	\N	3	6	\N
85	5	30	\N	\N	\N
85	45	5	\N	\N	\N
85	39	50	\N	\N	\N
85	59	15	\N	\N	\N
119	55	20	\N	\N	\N
85	26	15	\N	\N	\N
85	138	25	\N	\N	\N
85	73	2	\N	\N	\N
86	5	25	\N	\N	\N
86	66	25	\N	\N	\N
86	86	20	\N	\N	\N
86	48	20	\N	\N	\N
86	34	10	\N	\N	\N
86	35	10	\N	\N	\N
87	18	\N	70	100	\N
87	142	50	\N	\N	\N
87	39	20	\N	\N	\N
87	83	10	\N	\N	\N
87	51	3	\N	\N	\N
88	18	\N	70	80	\N
88	54	30	\N	\N	\N
88	17	1	\N	\N	\N
88	51	4	\N	\N	\N
89	18	100	\N	\N	\N
89	46	25	\N	\N	\N
89	83	10	\N	\N	\N
89	91	15	\N	\N	\N
89	47	50	\N	\N	\N
89	143	100	\N	\N	\N
90	18	\N	100	130	\N
90	36	-10	\N	\N	\N
90	144	10	\N	\N	\N
90	35	5	\N	\N	\N
90	73	5	\N	\N	\N
91	18	\N	100	120	\N
91	33	5	\N	\N	\N
91	51	2	\N	\N	\N
92	18	\N	40	50	\N
92	5	30	\N	\N	\N
92	66	30	\N	\N	\N
92	26	20	\N	\N	\N
92	34	10	\N	\N	\N
92	51	-2	\N	\N	\N
93	18	\N	50	60	\N
93	5	30	\N	\N	\N
93	66	30	\N	\N	\N
93	22	25	\N	\N	\N
93	30	\N	1	6	\N
93	20	3	\N	\N	\N
93	17	1	\N	\N	\N
94	18	\N	60	100	\N
94	5	20	\N	\N	\N
94	66	25	\N	\N	\N
94	106	20	\N	\N	\N
94	83	15	\N	\N	\N
94	51	3	\N	\N	\N
94	73	3	\N	\N	\N
95	5	10	\N	\N	\N
95	66	20	\N	\N	\N
95	29	50	\N	\N	\N
95	77	10	\N	\N	\N
96	18	100	\N	\N	\N
96	5	40	\N	\N	\N
96	66	10	\N	\N	\N
96	83	\N	30	50	\N
96	17	2	\N	\N	\N
96	35	10	\N	\N	\N
97	18	\N	10	20	\N
97	5	10	\N	\N	\N
97	48	10	\N	\N	\N
97	86	30	\N	\N	\N
97	26	40	\N	\N	\N
97	107	5	\N	\N	\N
98	18	\N	20	30	\N
98	5	15	\N	\N	\N
98	39	25	\N	\N	\N
98	31	\N	25	40	\N
98	27	200	\N	\N	\N
98	51	2	\N	\N	\N
99	18	\N	20	30	\N
99	5	10	\N	\N	\N
99	56	1	\N	\N	\N
99	69	20	\N	\N	\N
99	46	25	\N	\N	\N
99	57	\N	1	6	\N
100	18	\N	10	20	\N
100	5	30	\N	\N	\N
100	14	5	\N	\N	\N
100	148	40	\N	\N	\N
100	42	\N	1	6	\N
100	43	2	\N	\N	\N
101	18	\N	20	30	\N
101	52	20	\N	\N	\N
101	33	2	\N	\N	\N
101	77	2	\N	\N	\N
101	5	12	\N	\N	\N
102	18	\N	30	40	\N
102	5	12	\N	\N	\N
102	38	50	\N	\N	\N
102	52	30	\N	\N	\N
102	89	50	\N	\N	\N
102	26	10	\N	\N	\N
103	46	30	\N	\N	\N
103	83	5	\N	\N	\N
103	59	15	\N	\N	\N
103	51	1	\N	\N	\N
104	18	\N	30	50	\N
104	5	15	\N	\N	\N
104	78	50	\N	\N	\N
104	73	2	\N	\N	\N
104	83	10	\N	\N	\N
104	59	20	\N	\N	\N
105	18	\N	40	60	\N
105	5	25	\N	\N	\N
105	48	10	\N	\N	\N
105	31	30	\N	\N	\N
105	27	\N	50	80	\N
105	51	2	\N	\N	\N
106	18	100	\N	\N	\N
107	54	\N	20	40	\N
106	52	15	\N	\N	\N
106	45	\N	6	12	\N
106	91	20	\N	\N	\N
106	90	20	\N	\N	\N
107	18	\N	160	220	\N
107	144	10	\N	\N	\N
107	86	30	\N	\N	\N
107	90	15	\N	\N	\N
108	18	\N	200	240	\N
108	48	10	\N	\N	\N
108	86	10	\N	\N	\N
108	37	5	\N	\N	\N
108	33	5	\N	\N	\N
108	31	\N	30	50	\N
109	5	\N	2	198	\N
109	33	5	\N	\N	\N
109	51	-4	\N	\N	\N
110	65	\N	150	200	\N
110	113	\N	1	2	\N
110	52	20	\N	\N	\N
110	86	20	\N	\N	\N
110	68	\N	2	4	\N
111	18	\N	160	200	\N
111	37	\N	9	12	\N
111	67	33	\N	\N	\N
111	59	35	\N	\N	\N
111	26	50	\N	\N	\N
111	34	25	\N	\N	\N
111	27	\N	80	100	\N
112	18	100	\N	\N	\N
112	42	\N	6	22	\N
112	43	4	\N	\N	\N
112	38	15	\N	\N	\N
112	37	\N	6	8	\N
112	33	\N	6	8	\N
112	73	\N	15	20	\N
112	17	\N	10	15	\N
113	18	150	\N	\N	\N
95	18	\N	30	60	\N
113	45	10	\N	\N	\N
113	17	\N	7	11	\N
114	18	120	\N	\N	\N
107	67	\N	20	50	\N
114	69	30	\N	\N	\N
114	17	\N	9	13	\N
114	83	\N	20	35	\N
115	18	\N	150	190	\N
109	67	\N	20	40	\N
115	37	\N	5	7	\N
115	45	\N	15	25	\N
115	77	15	\N	\N	\N
116	18	\N	50	100	\N
116	5	\N	3	297	\N
116	73	\N	15	20	\N
116	17	\N	10	16	\N
116	26	25	\N	\N	\N
117	18	\N	150	180	\N
117	48	15	\N	\N	\N
117	86	15	\N	\N	\N
117	29	35	\N	\N	\N
117	34	15	\N	\N	\N
118	18	\N	120	160	\N
118	26	\N	\N	\N	1.25
118	67	5	\N	\N	\N
118	57	\N	20	65	\N
118	35	15	\N	\N	\N
118	51	4	\N	\N	\N
119	18	\N	160	200	\N
119	5	\N	\N	\N	1.25
119	26	\N	1	99	\N
119	35	15	\N	\N	\N
120	18	\N	160	220	\N
120	144	30	\N	\N	\N
120	89	250	\N	\N	\N
120	26	60	\N	\N	\N
121	18	\N	160	200	\N
121	31	\N	\N	\N	1.25
121	79	1	\N	\N	\N
121	17	10	\N	\N	\N
122	18	\N	140	160	\N
122	79	1	\N	\N	\N
122	68	3	\N	\N	\N
122	69	20	\N	\N	\N
122	86	20	\N	\N	\N
122	17	\N	6	10	\N
122	91	15	\N	\N	\N
123	18	\N	180	200	\N
123	66	20	\N	\N	\N
123	106	30	\N	\N	\N
123	62	\N	\N	\N	2.5
123	96	1	\N	\N	\N
123	51	4	\N	\N	\N
123	71	15	\N	\N	\N
123	76	15	\N	\N	\N
123	102	15	\N	\N	\N
124	18	\N	160	220	\N
124	5	\N	40	60	\N
124	29	40	\N	\N	\N
124	67	15	\N	\N	\N
124	35	10	\N	\N	\N
124	77	\N	20	40	\N
125	18	\N	120	160	\N
125	5	\N	2	198	\N
125	86	30	\N	\N	\N
125	45	10	\N	\N	\N
125	80	15	\N	\N	\N
125	34	15	\N	\N	\N
125	31	20	\N	\N	\N
126	18	\N	140	200	\N
126	61	\N	30	60	\N
126	62	\N	200	250	\N
126	51	-2	\N	\N	\N
127	18	\N	150	180	\N
127	57	\N	12	36	\N
127	54	35	\N	\N	\N
127	90	10	\N	\N	\N
127	35	8	\N	\N	\N
128	18	\N	180	220	\N
128	66	25	\N	\N	\N
128	106	30	\N	\N	\N
128	83	25	\N	\N	\N
129	18	\N	160	220	\N
129	66	20	\N	\N	\N
129	106	10	\N	\N	\N
129	39	150	\N	\N	\N
129	22	50	\N	\N	\N
129	30	\N	1	60	\N
130	18	\N	140	200	\N
130	42	\N	27	53	\N
130	43	3	\N	\N	\N
130	57	\N	35	95	\N
130	30	\N	1	120	\N
130	83	\N	25	35	\N
131	18	\N	70	120	\N
131	78	15	\N	\N	\N
131	86	30	\N	\N	\N
131	44	20	\N	\N	\N
131	26	50	\N	\N	\N
131	77	47	\N	\N	\N
132	18	\N	180	240	\N
132	66	30	\N	\N	\N
132	83	\N	20	30	\N
132	45	15	\N	\N	\N
132	73	\N	11	16	\N
132	17	\N	14	18	\N
133	18	\N	80	130	\N
133	79	1	\N	\N	\N
133	80	10	\N	\N	\N
133	69	20	\N	\N	\N
133	68	\N	3	5	\N
133	91	10	\N	\N	\N
133	51	1	\N	\N	\N
134	18	\N	160	200	\N
134	66	20	\N	\N	\N
134	106	20	\N	\N	\N
134	55	75	\N	\N	\N
134	70	80	\N	\N	\N
135	18	\N	130	160	\N
135	5	\N	15	25	\N
135	40	5	\N	\N	\N
135	70	60	\N	\N	\N
135	37	5	\N	\N	\N
135	71	5	\N	\N	\N
135	55	30	\N	\N	\N
136	18	\N	140	180	\N
136	47	\N	100	200	\N
136	143	\N	100	200	\N
136	91	10	\N	\N	\N
136	35	10	\N	\N	\N
137	18	\N	150	190	\N
137	143	\N	4	396	\N
137	47	\N	2	198	\N
137	33	4	\N	\N	\N
137	26	20	\N	\N	\N
138	18	\N	150	200	\N
138	57	\N	13	46	\N
138	48	20	\N	\N	\N
138	67	24	\N	\N	\N
139	18	\N	150	200	\N
139	57	\N	15	72	\N
140	18	\N	120	150	\N
140	5	15	\N	\N	\N
140	52	20	\N	\N	\N
140	67	30	\N	\N	\N
140	57	\N	12	33	\N
140	27	\N	47	70	\N
140	51	2	\N	\N	\N
141	18	\N	180	210	\N
141	52	20	\N	\N	\N
141	89	100	\N	\N	\N
141	34	15	\N	\N	\N
141	25	40	\N	\N	\N
141	26	\N	45	65	\N
142	18	\N	150	190	\N
142	52	30	\N	\N	\N
142	68	5	\N	\N	\N
142	80	10	\N	\N	\N
142	89	200	\N	\N	\N
143	18	\N	150	190	\N
143	52	25	\N	\N	\N
143	90	10	\N	\N	\N
143	35	10	\N	\N	\N
143	32	\N	15	25	\N
143	138	40	\N	\N	\N
143	77	\N	5	10	\N
143	31	\N	30	50	\N
144	18	\N	160	200	\N
144	52	30	\N	\N	\N
144	29	10	\N	\N	\N
144	40	15	\N	\N	\N
144	44	15	\N	\N	\N
144	36	-25	\N	\N	\N
144	25	20	\N	\N	\N
145	18	\N	150	180	\N
145	5	15	\N	\N	\N
145	37	\N	6	8	\N
145	73	\N	10	15	\N
148	82	15	\N	\N	\N
146	18	\N	120	150	\N
146	5	15	\N	\N	\N
146	28	10	\N	\N	\N
146	34	15	\N	\N	\N
146	77	\N	\N	\N	1
147	18	\N	120	150	\N
147	33	5	\N	\N	\N
147	80	15	\N	\N	\N
147	46	15	\N	\N	\N
147	90	15	\N	\N	\N
147	51	-3	\N	\N	\N
148	18	\N	130	170	\N
148	76	15	\N	\N	\N
148	42	\N	13	21	\N
139	23	15	\N	\N	\N
149	26	\N	\N	\N	1.5
149	59	\N	\N	\N	1.5
149	144	10	\N	\N	\N
149	31	50	\N	\N	\N
149	35	2	\N	\N	\N
149	34	2	\N	\N	\N
149	90	2	\N	\N	\N
149	91	2	\N	\N	\N
150	18	60	\N	\N	\N
150	5	140	\N	\N	\N
150	83	50	\N	\N	\N
150	35	15	\N	\N	\N
150	90	15	\N	\N	\N
150	51	-4	\N	\N	\N
151	18	\N	150	200	\N
151	5	50	\N	\N	\N
151	86	30	\N	\N	\N
151	94	50	\N	\N	\N
151	77	20	\N	\N	\N
151	73	\N	15	20	\N
151	17	\N	15	20	\N
152	18	200	\N	\N	\N
152	179	\N	1	2	\N
152	90	\N	\N	\N	0.5
152	86	30	\N	\N	\N
152	73	\N	10	15	\N
153	18	\N	160	200	\N
153	34	\N	\N	\N	0.5
153	26	\N	\N	\N	1.25
153	106	50	\N	\N	\N
154	5	\N	\N	\N	3.75
154	66	25	\N	\N	\N
154	106	35	\N	\N	\N
154	144	35	\N	\N	\N
154	54	60	\N	\N	\N
154	22	25	\N	\N	\N
154	35	30	\N	\N	\N
154	20	10	\N	\N	\N
155	19	10	\N	\N	\N
155	68	2	\N	\N	\N
155	37	5	\N	\N	\N
155	35	15	\N	\N	\N
155	48	10	\N	\N	\N
155	51	-3	\N	\N	\N
156	14	\N	60	70	\N
156	40	20	\N	\N	\N
156	29	50	\N	\N	\N
156	39	30	\N	\N	\N
157	14	\N	60	100	\N
157	30	\N	1	15	\N
157	39	\N	50	100	\N
157	29	15	\N	\N	\N
157	110	2	\N	\N	\N
157	46	20	\N	\N	\N
158	14	\N	70	90	\N
158	117	3	\N	\N	\N
158	54	50	\N	\N	\N
158	51	2	\N	\N	\N
159	14	\N	40	50	\N
159	28	9	\N	\N	\N
153	82	\N	\N	\N	0.625
159	48	30	\N	\N	\N
159	35	25	\N	\N	\N
160	14	100	\N	\N	\N
160	48	20	\N	\N	\N
160	30	\N	1	40	\N
160	83	\N	10	20	\N
160	68	6	\N	\N	\N
161	14	\N	50	80	\N
161	107	14	\N	\N	\N
161	57	\N	15	35	\N
161	33	\N	10	13	\N
161	59	25	\N	\N	\N
161	51	4	\N	\N	\N
162	14	\N	80	120	\N
162	32	\N	8	25	\N
162	40	33	\N	\N	\N
162	36	20	\N	\N	\N
162	35	\N	20	30	\N
163	14	100	\N	\N	\N
163	39	28	\N	\N	\N
163	33	3	\N	\N	\N
163	26	10	\N	\N	\N
163	68	2	\N	\N	\N
163	51	2	\N	\N	\N
164	14	\N	40	50	\N
164	32	\N	1	3	\N
164	48	30	\N	\N	\N
164	39	50	\N	\N	\N
165	14	\N	40	60	\N
165	47	100	\N	\N	\N
165	44	30	\N	\N	\N
165	48	50	\N	\N	\N
165	39	60	\N	\N	\N
165	83	10	\N	\N	\N
166	14	\N	70	90	\N
166	57	\N	15	50	\N
166	48	10	\N	\N	\N
166	39	\N	50	75	\N
166	56	1	\N	\N	\N
166	67	40	\N	\N	\N
166	34	12	\N	\N	\N
167	14	50	\N	\N	\N
167	95	30	\N	\N	\N
167	48	20	\N	\N	\N
167	39	50	\N	\N	\N
167	34	20	\N	\N	\N
168	14	\N	70	80	\N
168	57	\N	15	35	\N
168	48	20	\N	\N	\N
168	39	70	\N	\N	\N
168	67	15	\N	\N	\N
169	14	\N	60	100	\N
169	48	30	\N	\N	\N
169	113	1	\N	\N	\N
169	26	15	\N	\N	\N
170	32	\N	1	15	\N
170	31	100	\N	\N	\N
170	59	-5	\N	\N	\N
171	14	50	\N	\N	\N
171	48	30	\N	\N	\N
171	54	25	\N	\N	\N
171	67	25	\N	\N	\N
171	34	10	\N	\N	\N
172	69	50	\N	\N	\N
172	39	55	\N	\N	\N
172	83	10	\N	\N	\N
172	59	50	\N	\N	\N
173	14	\N	70	80	\N
173	47	150	\N	\N	\N
173	57	\N	6	8	\N
173	22	60	\N	\N	\N
173	67	20	\N	\N	\N
174	14	100	\N	\N	\N
174	47	150	\N	\N	\N
174	90	7	\N	\N	\N
174	77	\N	3	10	\N
174	17	2	\N	\N	\N
175	14	\N	50	60	\N
175	47	150	\N	\N	\N
175	40	33	\N	\N	\N
175	67	50	\N	\N	\N
175	35	15	\N	\N	\N
175	51	2	\N	\N	\N
176	14	\N	50	60	\N
176	47	150	\N	\N	\N
176	32	\N	1	20	\N
176	48	20	\N	\N	\N
176	33	5	\N	\N	\N
176	19	50	\N	\N	\N
176	5	25	\N	\N	\N
177	14	\N	200	300	\N
177	47	\N	50	200	\N
177	40	40	\N	\N	\N
177	54	30	\N	\N	\N
177	67	30	\N	\N	\N
178	14	\N	150	250	\N
178	47	150	\N	\N	\N
178	48	40	\N	\N	\N
178	36	-50	\N	\N	\N
179	14	100	\N	\N	\N
179	48	20	\N	\N	\N
179	34	15	\N	\N	\N
179	5	-8	\N	\N	\N
180	14	\N	60	80	\N
180	44	30	\N	\N	\N
180	39	30	\N	\N	\N
180	83	5	\N	\N	\N
180	41	75	\N	\N	\N
181	14	\N	50	70	\N
181	48	30	\N	\N	\N
181	39	\N	50	100	\N
181	37	7	\N	\N	\N
181	34	10	\N	\N	\N
182	47	150	\N	\N	\N
182	40	25	\N	\N	\N
182	39	35	\N	\N	\N
182	55	20	\N	\N	\N
182	67	20	\N	\N	\N
182	59	15	\N	\N	\N
183	14	\N	80	120	\N
183	47	150	\N	\N	\N
183	42	\N	3	5	\N
183	43	3	\N	\N	\N
183	30	\N	1	6	\N
183	45	10	\N	\N	\N
184	47	200	\N	\N	\N
184	107	10	\N	\N	\N
184	57	\N	3	6	\N
184	39	35	\N	\N	\N
184	51	2	\N	\N	\N
185	14	\N	50	70	\N
185	29	35	\N	\N	\N
185	37	\N	8	12	\N
185	26	26	\N	\N	\N
185	35	10	\N	\N	\N
186	30	\N	1	60	\N
186	83	15	\N	\N	\N
186	48	40	\N	\N	\N
186	77	8	\N	\N	\N
187	14	\N	80	100	\N
187	57	\N	23	54	\N
187	39	60	\N	\N	\N
187	67	15	\N	\N	\N
187	26	30	\N	\N	\N
187	51	3	\N	\N	\N
188	14	\N	50	60	\N
188	47	150	\N	\N	\N
188	48	20	\N	\N	\N
188	59	30	\N	\N	\N
188	67	50	\N	\N	\N
188	57	\N	4	6	\N
189	14	\N	30	40	\N
189	47	150	\N	\N	\N
189	95	12	\N	\N	\N
189	33	100	\N	\N	\N
189	108	50	\N	\N	\N
189	59	10	\N	\N	\N
189	55	50	\N	\N	\N
189	51	-1	\N	\N	\N
190	47	150	\N	\N	\N
190	30	\N	1	28	\N
190	105	1	\N	\N	\N
190	46	43	\N	\N	\N
190	91	15	\N	\N	\N
190	73	5	\N	\N	\N
190	22	75	\N	\N	\N
191	47	150	\N	\N	\N
191	57	\N	15	32	\N
191	67	30	\N	\N	\N
191	56	2	\N	\N	\N
192	14	100	\N	\N	\N
192	107	5	\N	\N	\N
192	40	25	\N	\N	\N
192	49	20	\N	\N	\N
192	5	25	\N	\N	\N
192	51	2	\N	\N	\N
193	14	\N	60	80	\N
193	29	33	\N	\N	\N
193	48	15	\N	\N	\N
193	37	15	\N	\N	\N
193	83	15	\N	\N	\N
193	26	15	\N	\N	\N
193	51	4	\N	\N	\N
194	14	\N	60	100	\N
194	42	\N	3	5	\N
194	43	2	\N	\N	\N
194	48	20	\N	\N	\N
194	5	20	\N	\N	\N
194	59	30	\N	\N	\N
194	51	3	\N	\N	\N
195	14	\N	80	120	\N
195	57	\N	10	25	\N
195	48	10	\N	\N	\N
195	39	100	\N	\N	\N
195	35	12	\N	\N	\N
196	14	\N	70	80	\N
196	79	1	\N	\N	\N
196	94	50	\N	\N	\N
196	48	20	\N	\N	\N
196	86	20	\N	\N	\N
196	39	60	\N	\N	\N
197	14	100	\N	\N	\N
197	42	\N	10	30	\N
197	43	3	\N	\N	\N
197	33	9	\N	\N	\N
197	37	9	\N	\N	\N
197	54	20	\N	\N	\N
197	51	-2	\N	\N	\N
198	14	\N	70	100	\N
198	48	10	\N	\N	\N
198	37	4	\N	\N	\N
198	33	\N	4	10	\N
198	83	5	\N	\N	\N
199	14	\N	50	60	\N
199	58	113	\N	\N	\N
199	39	50	\N	\N	\N
199	55	50	\N	\N	\N
200	14	\N	80	100	\N
200	28	15	\N	\N	\N
200	29	80	\N	\N	\N
200	33	6	\N	\N	\N
201	47	150	\N	\N	\N
201	30	\N	1	9	\N
201	59	13	\N	\N	\N
201	69	30	\N	\N	\N
201	22	40	\N	\N	\N
202	47	150	\N	\N	\N
202	100	2	\N	\N	\N
202	42	\N	14	8	\N
202	43	3	\N	\N	\N
202	33	5	\N	\N	\N
202	59	\N	25	50	\N
202	34	10	\N	\N	\N
202	35	10	\N	\N	\N
203	47	150	\N	\N	\N
203	100	2	\N	\N	\N
203	69	20	\N	\N	\N
203	59	40	\N	\N	\N
204	14	\N	170	190	\N
204	40	25	\N	\N	\N
209	143	\N	\N	\N	5
204	89	50	\N	\N	\N
204	91	10	\N	\N	\N
204	90	10	\N	\N	\N
204	34	10	\N	\N	\N
204	35	10	\N	\N	\N
205	14	\N	140	170	\N
205	57	\N	35	150	\N
205	19	50	\N	\N	\N
206	14	\N	150	180	\N
206	28	20	\N	\N	\N
206	201	250	\N	\N	\N
206	55	30	\N	\N	\N
206	77	15	\N	\N	\N
207	14	165	\N	\N	\N
207	69	10	\N	\N	\N
207	36	-60	\N	\N	\N
207	46	25	\N	\N	\N
207	59	100	\N	\N	\N
207	17	\N	12	15	\N
208	14	100	\N	\N	\N
208	32	\N	35	75	\N
208	30	\N	1	200	\N
208	20	15	\N	\N	\N
209	14	\N	180	220	\N
209	47	\N	\N	\N	2.5
209	210	\N	16	20	\N
209	48	20	\N	\N	\N
209	49	35	\N	\N	\N
209	35	8	\N	\N	\N
210	14	\N	140	200	\N
210	32	\N	20	30	\N
210	19	50	\N	\N	\N
210	40	30	\N	\N	\N
210	110	2	\N	\N	\N
210	35	\N	15	20	\N
211	14	\N	150	200	\N
211	30	\N	1	250	\N
211	16	30	\N	\N	\N
211	39	100	\N	\N	\N
211	113	1	\N	\N	\N
211	91	10	\N	\N	\N
212	14	\N	180	220	\N
212	19	30	\N	\N	\N
212	29	30	\N	\N	\N
212	48	30	\N	\N	\N
212	37	\N	7	10	\N
212	59	35	\N	\N	\N
213	14	\N	150	180	\N
213	57	\N	40	180	\N
214	14	\N	150	170	\N
214	44	\N	1	99	\N
214	83	40	\N	\N	\N
215	14	\N	190	230	\N
215	32	\N	5	30	\N
215	113	2	\N	\N	\N
215	89	80	\N	\N	\N
215	26	50	\N	\N	\N
216	14	\N	120	150	\N
216	32	\N	20	50	\N
216	39	\N	200	250	\N
216	113	1	\N	\N	\N
216	33	15	\N	\N	\N
216	17	\N	9	13	\N
216	34	10	\N	\N	\N
217	14	\N	200	250	\N
217	61	\N	100	200	\N
217	47	\N	100	200	\N
217	48	50	\N	\N	\N
217	45	12	\N	\N	\N
217	49	\N	100	150	\N
218	14	\N	150	220	\N
218	121	150	\N	\N	\N
218	36	-60	\N	\N	\N
218	39	\N	5	495	\N
218	48	10	\N	\N	\N
218	100	2	\N	\N	\N
218	71	10	\N	\N	\N
218	55	25	\N	\N	\N
219	14	\N	150	200	\N
219	28	\N	\N	\N	2.5
219	42	\N	32	196	\N
219	43	4	\N	\N	\N
219	117	3	\N	\N	\N
219	5	\N	75	150	\N
219	34	35	\N	\N	\N
219	48	80	\N	\N	\N
220	14	123	\N	\N	\N
220	28	66	\N	\N	\N
220	39	632	\N	\N	\N
220	5	321	\N	\N	\N
220	59	36	\N	\N	\N
221	14	\N	200	240	\N
221	32	\N	15	27	\N
221	48	15	\N	\N	\N
221	100	1	\N	\N	\N
221	37	8	\N	\N	\N
221	34	10	\N	\N	\N
222	14	\N	190	240	\N
222	32	\N	15	35	\N
222	44	35	\N	\N	\N
223	201	488	\N	\N	\N
223	32	\N	15	45	\N
223	48	30	\N	\N	\N
223	19	50	\N	\N	\N
223	5	50	\N	\N	\N
224	14	150	\N	\N	\N
224	30	\N	1	120	\N
224	22	\N	\N	\N	1
224	20	20	\N	\N	\N
225	14	\N	130	200	\N
225	32	\N	35	50	\N
225	47	150	\N	\N	\N
225	44	20	\N	\N	\N
225	40	20	\N	\N	\N
225	29	25	\N	\N	\N
226	14	\N	150	180	\N
226	32	\N	5	10	\N
226	47	150	\N	\N	\N
226	42	\N	63	112	\N
226	117	3	\N	\N	\N
227	14	\N	120	150	\N
227	32	\N	10	15	\N
227	47	150	\N	\N	\N
227	57	\N	55	115	\N
227	17	\N	9	12	\N
228	14	\N	160	200	\N
228	47	150	\N	\N	\N
228	30	\N	1	150	\N
228	48	20	\N	\N	\N
228	22	25	\N	\N	\N
228	59	100	\N	\N	\N
229	14	180	\N	\N	\N
229	47	150	\N	\N	\N
229	48	30	\N	\N	\N
230	14	\N	180	220	\N
230	47	150	\N	\N	\N
230	40	50	\N	\N	\N
230	83	20	\N	\N	\N
230	35	25	\N	\N	\N
231	14	\N	130	160	\N
231	32	\N	12	30	\N
231	47	150	\N	\N	\N
231	77	26	\N	\N	\N
232	14	\N	100	140	\N
232	28	\N	\N	\N	1.25
232	36	-25	\N	\N	\N
232	51	-2	\N	\N	\N
232	37	8	\N	\N	\N
233	14	\N	150	180	\N
233	28	\N	1	99	\N
233	26	\N	1	99	\N
233	48	30	\N	\N	\N
233	64	\N	1	3	\N
233	34	15	\N	\N	\N
234	14	\N	160	220	\N
234	32	\N	12	20	\N
234	44	55	\N	\N	\N
234	39	\N	100	200	\N
234	123	3	\N	\N	\N
234	33	6	\N	\N	\N
234	86	30	\N	\N	\N
235	14	\N	160	200	\N
235	32	\N	20	32	\N
235	48	20	\N	\N	\N
235	39	\N	200	250	\N
235	45	20	\N	\N	\N
236	14	\N	140	180	\N
236	57	\N	131	232	\N
236	100	3	\N	\N	\N
236	108	50	\N	\N	\N
236	18	20	\N	\N	\N
236	39	\N	200	250	\N
236	67	45	\N	\N	\N
236	36	-50	\N	\N	\N
236	77	8	\N	\N	\N
237	14	\N	180	220	\N
237	47	150	\N	\N	\N
237	48	30	\N	\N	\N
237	33	8	\N	\N	\N
237	46	10	\N	\N	\N
237	24	15	\N	\N	\N
238	14	\N	160	190	\N
238	32	\N	15	25	\N
238	47	150	\N	\N	\N
238	96	2	\N	\N	\N
238	70	160	\N	\N	\N
238	39	\N	150	200	\N
239	14	\N	130	160	\N
239	32	\N	20	45	\N
239	47	150	\N	\N	\N
239	96	2	\N	\N	\N
239	49	100	\N	\N	\N
239	46	15	\N	\N	\N
239	5	50	\N	\N	\N
239	51	4	\N	\N	\N
240	14	\N	140	170	\N
240	29	40	\N	\N	\N
240	48	20	\N	\N	\N
240	39	150	\N	\N	\N
241	14	\N	140	180	\N
241	32	\N	30	50	\N
241	19	75	\N	\N	\N
241	26	\N	\N	\N	1.25
241	67	50	\N	\N	\N
241	35	10	\N	\N	\N
242	14	\N	160	200	\N
242	32	\N	20	40	\N
242	40	45	\N	\N	\N
243	14	\N	150	200	\N
243	32	\N	20	40	\N
248	31	\N	\N	\N	1
243	86	20	\N	\N	\N
243	45	20	\N	\N	\N
243	49	25	\N	\N	\N
243	18	25	\N	\N	\N
243	51	3	\N	\N	\N
244	47	150	\N	\N	\N
244	79	1	\N	\N	\N
244	69	30	\N	\N	\N
244	17	15	\N	\N	\N
244	83	50	\N	\N	\N
244	59	175	\N	\N	\N
244	26	80	\N	\N	\N
244	77	15	\N	\N	\N
245	14	\N	200	300	\N
245	32	\N	30	65	\N
245	47	150	\N	\N	\N
245	40	50	\N	\N	\N
245	48	50	\N	\N	\N
245	86	50	\N	\N	\N
245	18	100	\N	\N	\N
245	5	100	\N	\N	\N
245	34	15	\N	\N	\N
246	47	150	\N	\N	\N
246	69	20	\N	\N	\N
246	105	3	\N	\N	\N
246	245	\N	20	25	\N
246	83	\N	20	40	\N
246	20	20	\N	\N	\N
247	47	150	\N	\N	\N
253	44	\N	\N	\N	0.75
247	105	3	\N	\N	\N
248	47	150	\N	\N	\N
248	68	20	\N	\N	\N
248	80	20	\N	\N	\N
248	79	2	\N	\N	\N
249	32	\N	12	45	\N
249	39	90	\N	\N	\N
249	48	20	\N	\N	\N
249	138	10	\N	\N	\N
249	37	8	\N	\N	\N
250	14	\N	200	250	\N
250	254	50	\N	\N	\N
250	48	20	\N	\N	\N
250	33	6	\N	\N	\N
250	19	30	\N	\N	\N
251	14	\N	140	160	\N
251	32	\N	35	40	\N
251	56	3	\N	\N	\N
251	67	25	\N	\N	\N
252	14	\N	60	120	\N
252	27	\N	\N	\N	2.5
252	31	\N	1	99	\N
252	59	15	\N	\N	\N
252	34	\N	5	15	\N
253	14	150	\N	\N	\N
253	28	\N	\N	\N	1
253	35	15	\N	\N	\N
254	14	150	\N	\N	\N
254	32	\N	10	45	\N
254	121	300	\N	\N	\N
254	55	45	\N	\N	\N
255	14	\N	200	250	\N
255	96	2	\N	\N	\N
255	49	50	\N	\N	\N
255	5	75	\N	\N	\N
255	90	8	\N	\N	\N
255	34	12	\N	\N	\N
255	35	16	\N	\N	\N
256	14	\N	160	200	\N
256	48	50	\N	\N	\N
256	19	35	\N	\N	\N
256	111	-70	\N	\N	\N
256	52	20	\N	\N	\N
256	144	10	\N	\N	\N
257	14	\N	150	200	\N
257	47	\N	\N	\N	7.5
257	143	\N	\N	\N	10
257	58	250	\N	\N	\N
257	55	50	\N	\N	\N
258	14	\N	150	200	\N
258	30	\N	1	240	\N
258	102	10	\N	\N	\N
258	5	30	\N	\N	\N
258	20	15	\N	\N	\N
258	51	2	\N	\N	\N
259	14	\N	120	160	\N
259	57	\N	50	200	\N
259	67	40	\N	\N	\N
260	14	\N	170	180	\N
260	5	\N	5	495	\N
260	78	30	\N	\N	\N
260	36	-50	\N	\N	\N
260	83	\N	10	20	\N
260	86	20	\N	\N	\N
260	66	20	\N	\N	\N
260	89	100	\N	\N	\N
260	142	200	\N	\N	\N
261	14	\N	130	180	\N
261	44	40	\N	\N	\N
261	39	\N	200	450	\N
261	37	\N	7	9	\N
261	33	\N	4	6	\N
262	14	\N	150	200	\N
262	29	33	\N	\N	\N
262	68	4	\N	\N	\N
262	48	20	\N	\N	\N
262	49	25	\N	\N	\N
262	37	\N	4	6	\N
263	47	150	\N	\N	\N
259	23	10	\N	\N	\N
263	69	50	\N	\N	\N
263	80	10	\N	\N	\N
263	83	10	\N	\N	\N
263	26	40	\N	\N	\N
263	77	25	\N	\N	\N
264	47	150	\N	\N	\N
264	59	\N	\N	\N	1.25
251	87	10	\N	\N	\N
264	100	1	\N	\N	\N
264	69	10	\N	\N	\N
264	86	30	\N	\N	\N
264	45	5	\N	\N	\N
265	47	150	\N	\N	\N
265	59	\N	\N	\N	1.25
265	69	10	\N	\N	\N
266	47	150	\N	\N	\N
266	100	2	\N	\N	\N
266	78	20	\N	\N	\N
266	69	30	\N	\N	\N
266	67	37	\N	\N	\N
266	26	50	\N	\N	\N
266	51	-2	\N	\N	\N
267	14	200	\N	\N	\N
267	28	\N	\N	\N	2.5
267	57	\N	20	240	\N
267	49	100	\N	\N	\N
267	91	15	\N	\N	\N
267	90	15	\N	\N	\N
267	34	15	\N	\N	\N
267	35	15	\N	\N	\N
268	14	100	\N	\N	\N
274	21	25	\N	\N	\N
268	57	\N	150	250	\N
268	35	\N	\N	\N	0.5
268	90	\N	\N	\N	0.5
268	26	25	\N	\N	\N
269	14	200	\N	\N	\N
269	274	\N	\N	\N	2
269	113	1	\N	\N	\N
269	39	\N	\N	\N	6
269	34	25	\N	\N	\N
270	14	250	\N	\N	\N
270	28	\N	\N	\N	3.125
270	48	20	\N	\N	\N
270	33	\N	6	8	\N
270	24	30	\N	\N	\N
270	35	10	\N	\N	\N
270	34	5	\N	\N	\N
271	14	200	\N	\N	\N
271	47	150	\N	\N	\N
271	57	\N	1	200	\N
271	30	\N	1	200	\N
271	42	\N	1	200	\N
271	48	50	\N	\N	\N
271	49	200	\N	\N	\N
271	34	15	\N	\N	\N
271	35	15	\N	\N	\N
272	14	\N	200	240	\N
272	32	\N	20	20	\N
272	47	150	\N	\N	\N
272	40	75	\N	\N	\N
272	48	20	\N	\N	\N
272	83	25	\N	\N	\N
272	35	25	\N	\N	\N
273	14	\N	100	130	\N
273	28	\N	2	198	\N
273	30	\N	50	200	\N
273	47	150	\N	\N	\N
273	48	20	\N	\N	\N
273	39	\N	8	792	\N
273	22	75	\N	\N	\N
273	26	50	\N	\N	\N
273	51	1	\N	\N	\N
274	14	\N	150	200	\N
274	32	\N	10	30	\N
274	15	\N	60	120	\N
274	30	\N	1	200	\N
274	33	\N	5	8	\N
274	48	20	\N	\N	\N
274	51	7	\N	\N	\N
275	14	\N	180	250	\N
275	32	\N	30	100	\N
275	49	40	\N	\N	\N
275	280	20	\N	\N	\N
275	37	\N	5	7	\N
276	14	\N	150	250	\N
276	28	\N	\N	\N	2.5
276	49	50	\N	\N	\N
276	26	80	\N	\N	\N
276	34	20	\N	\N	\N
276	35	20	\N	\N	\N
276	90	20	\N	\N	\N
276	91	20	\N	\N	\N
277	14	\N	150	250	\N
277	30	\N	1	237	\N
277	48	30	\N	\N	\N
277	22	50	\N	\N	\N
277	35	10	\N	\N	\N
277	20	27	\N	\N	\N
278	59	\N	\N	\N	2
278	69	50	\N	\N	\N
278	46	15	\N	\N	\N
278	80	15	\N	\N	\N
278	83	75	\N	\N	\N
279	18	40	\N	\N	\N
279	73	3	\N	\N	\N
280	47	350	\N	\N	\N
280	39	75	\N	\N	\N
281	45	6	\N	\N	\N
281	26	20	\N	\N	\N
282	78	20	\N	\N	\N
282	51	3	\N	\N	\N
283	105	1	\N	\N	\N
283	44	25	\N	\N	\N
283	47	150	\N	\N	\N
284	45	4	\N	\N	\N
284	77	2	\N	\N	\N
285	51	2	\N	\N	\N
285	73	3	\N	\N	\N
286	46	20	\N	\N	\N
286	59	15	\N	\N	\N
287	18	\N	275	325	\N
287	83	10	\N	\N	\N
288	54	40	\N	\N	\N
288	5	30	\N	\N	\N
289	26	20	\N	\N	\N
289	48	10	\N	\N	\N
290	14	50	\N	\N	\N
290	49	20	\N	\N	\N
291	5	15	\N	\N	\N
291	67	25	\N	\N	\N
292	49	30	\N	\N	\N
292	33	5	\N	\N	\N
293	123	1	\N	\N	\N
293	17	2	\N	\N	\N
294	54	25	\N	\N	\N
294	59	20	\N	\N	\N
295	5	15	\N	\N	\N
295	36	-50	\N	\N	\N
296	56	1	\N	\N	\N
296	283	10	\N	\N	\N
296	47	150	\N	\N	\N
297	20	5	\N	\N	\N
297	86	10	\N	\N	\N
298	37	6	\N	\N	\N
298	73	2	\N	\N	\N
299	28	\N	\N	\N	1
299	28	\N	17	23	\N
299	47	150	\N	\N	\N
299	39	75	\N	\N	\N
300	45	4	\N	\N	\N
300	46	40	\N	\N	\N
301	5	15	\N	\N	\N
302	44	50	\N	\N	\N
302	49	30	\N	\N	\N
303	19	25	\N	\N	\N
304	94	75	\N	\N	\N
304	5	17	\N	\N	\N
305	14	25	\N	\N	\N
305	37	4	\N	\N	\N
306	94	75	\N	\N	\N
306	55	50	\N	\N	\N
307	5	20	\N	\N	\N
308	73	2	\N	\N	\N
308	35	10	\N	\N	\N
309	54	20	\N	\N	\N
309	26	20	\N	\N	\N
310	52	20	\N	\N	\N
310	67	25	\N	\N	\N
311	78	20	\N	\N	\N
311	83	10	\N	\N	\N
312	5	25	\N	\N	\N
312	26	20	\N	\N	\N
313	100	1	\N	\N	\N
313	47	150	\N	\N	\N
314	22	30	\N	\N	\N
314	67	30	\N	\N	\N
315	94	75	\N	\N	\N
315	55	30	\N	\N	\N
316	5	25	\N	\N	\N
316	107	5	\N	\N	\N
317	54	30	\N	\N	\N
318	107	10	\N	\N	\N
318	48	20	\N	\N	\N
319	73	2	\N	\N	\N
319	34	6	\N	\N	\N
320	17	2	\N	\N	\N
320	5	40	\N	\N	\N
321	20	4	\N	\N	\N
321	5	40	\N	\N	\N
322	59	15	\N	\N	\N
322	26	15	\N	\N	\N
323	73	2	\N	\N	\N
323	77	3	\N	\N	\N
324	5	25	\N	\N	\N
324	31	20	\N	\N	\N
325	14	50	\N	\N	\N
325	47	150	\N	\N	\N
325	96	1	\N	\N	\N
326	5	25	\N	\N	\N
326	59	30	\N	\N	\N
327	18	25	\N	\N	\N
327	22	30	\N	\N	\N
328	52	20	\N	\N	\N
328	54	40	\N	\N	\N
350	55	\N	35	50	\N
330	67	20	\N	\N	\N
330	26	20	\N	\N	\N
331	39	20	\N	\N	\N
331	35	10	\N	\N	\N
332	14	10	\N	\N	\N
332	39	40	\N	\N	\N
333	26	40	\N	\N	\N
333	35	15	\N	\N	\N
334	24	25	\N	\N	\N
334	34	10	\N	\N	\N
335	14	80	\N	\N	\N
335	39	75	\N	\N	\N
336	73	2	\N	\N	\N
336	17	1	\N	\N	\N
337	30	\N	1	20	\N
338	5	50	\N	\N	\N
338	34	11	\N	\N	\N
339	52	30	\N	\N	\N
339	25	150	\N	\N	\N
340	54	20	\N	\N	\N
340	26	15	\N	\N	\N
341	5	90	\N	\N	\N
341	86	24	\N	\N	\N
341	51	5	\N	\N	\N
341	46	17	\N	\N	\N
341	54	25	\N	\N	\N
342	52	40	\N	\N	\N
342	25	180	\N	\N	\N
342	78	10	\N	\N	\N
342	24	32	\N	\N	\N
342	26	50	\N	\N	\N
343	5	300	\N	\N	\N
343	36	-50	\N	\N	\N
343	22	30	\N	\N	\N
343	34	15	\N	\N	\N
343	35	20	\N	\N	\N
344	14	200	\N	\N	\N
344	61	200	\N	\N	\N
344	47	150	\N	\N	\N
344	30	\N	50	75	\N
344	48	30	\N	\N	\N
344	37	10	\N	\N	\N
344	33	5	\N	\N	\N
345	40	35	\N	\N	\N
345	14	200	\N	\N	\N
345	83	20	\N	\N	\N
345	48	20	\N	\N	\N
346	14	200	\N	\N	\N
346	287	50	\N	\N	\N
346	67	50	\N	\N	\N
346	35	20	\N	\N	\N
346	48	20	\N	\N	\N
347	5	75	\N	\N	\N
347	77	10	\N	\N	\N
348	18	60	\N	\N	\N
348	83	18	\N	\N	\N
348	26	30	\N	\N	\N
349	5	\N	25	35	\N
349	52	30	\N	\N	\N
349	57	\N	25	35	\N
349	34	20	\N	\N	\N
349	31	25	\N	\N	\N
350	79	1	\N	\N	\N
350	54	18	\N	\N	\N
350	77	\N	8	10	\N
351	5	25	\N	\N	\N
351	48	20	\N	\N	\N
351	61	350	\N	\N	\N
351	67	50	\N	\N	\N
352	5	\N	305	415	\N
352	67	24	\N	\N	\N
352	287	\N	4	6	\N
353	5	25	\N	\N	\N
353	52	30	\N	\N	\N
353	25	\N	15	25	\N
354	5	50	\N	\N	\N
354	83	15	\N	\N	\N
354	34	10	\N	\N	\N
354	35	10	\N	\N	\N
355	5	500	\N	\N	\N
355	36	-40	\N	\N	\N
355	35	20	\N	\N	\N
356	18	\N	50	70	\N
356	36	-40	\N	\N	\N
356	83	5	\N	\N	\N
356	31	\N	20	30	\N
357	14	175	\N	\N	\N
357	47	350	\N	\N	\N
357	36	-20	\N	\N	\N
357	48	40	\N	\N	\N
358	106	65	\N	\N	\N
358	5	108	\N	\N	\N
359	5	500	\N	\N	\N
359	36	-20	\N	\N	\N
359	26	75	\N	\N	\N
360	47	150	\N	\N	\N
360	48	40	\N	\N	\N
360	57	\N	20	30	\N
361	5	50	\N	\N	\N
361	66	25	\N	\N	\N
361	22	30	\N	\N	\N
361	106	30	\N	\N	\N
361	59	100	\N	\N	\N
361	77	30	\N	\N	\N
362	86	24	\N	\N	\N
362	36	-40	\N	\N	\N
362	5	50	\N	\N	\N
362	34	15	\N	\N	\N
362	35	10	\N	\N	\N
363	18	100	\N	\N	\N
363	45	20	\N	\N	\N
363	17	10	\N	\N	\N
363	54	37	\N	\N	\N
364	18	200	\N	\N	\N
364	30	\N	5	25	\N
364	48	40	\N	\N	\N
364	39	330	\N	\N	\N
365	5	200	\N	\N	\N
365	55	27	\N	\N	\N
365	26	100	\N	\N	\N
366	5	\N	\N	\N	1.5
366	30	\N	3	33	\N
366	78	12	\N	\N	\N
367	51	4	\N	\N	\N
367	5	125	\N	\N	\N
367	27	37	\N	\N	\N
368	14	200	\N	\N	\N
368	61	200	\N	\N	\N
368	47	150	\N	\N	\N
368	48	40	\N	\N	\N
368	40	\N	35	40	\N
369	5	400	\N	\N	\N
369	55	50	\N	\N	\N
370	5	36	\N	\N	\N
370	22	31	\N	\N	\N
370	67	28	\N	\N	\N
370	35	25	\N	\N	\N
371	5	65	\N	\N	\N
371	34	20	\N	\N	\N
371	35	20	\N	\N	\N
372	5	75	\N	\N	\N
372	52	40	\N	\N	\N
372	39	110	\N	\N	\N
372	26	44	\N	\N	\N
373	5	150	\N	\N	\N
373	45	10	\N	\N	\N
373	59	25	\N	\N	\N
373	48	30	\N	\N	\N
374	14	188	\N	\N	\N
374	48	40	\N	\N	\N
374	39	50	\N	\N	\N
375	36	-30	\N	\N	\N
375	17	\N	5	12	\N
375	5	\N	4	396	\N
375	5	350	\N	\N	\N
376	5	\N	45	50	\N
376	42	\N	6	18	\N
376	27	56	\N	\N	\N
376	35	10	\N	\N	\N
376	34	15	\N	\N	\N
377	5	50	\N	\N	\N
377	52	20	\N	\N	\N
377	51	5	\N	\N	\N
377	33	5	\N	\N	\N
378	5	135	\N	\N	\N
378	17	3	\N	\N	\N
378	83	10	\N	\N	\N
378	34	25	\N	\N	\N
378	35	10	\N	\N	\N
379	14	200	\N	\N	\N
379	47	200	\N	\N	\N
379	61	200	\N	\N	\N
379	57	\N	12	17	\N
379	48	40	\N	\N	\N
379	42	50	\N	\N	\N
380	26	\N	\N	\N	1
380	94	75	\N	\N	\N
380	55	25	\N	\N	\N
380	5	150	\N	\N	\N
381	5	75	\N	\N	\N
381	52	40	\N	\N	\N
381	54	15	\N	\N	\N
381	22	15	\N	\N	\N
382	5	75	\N	\N	\N
382	57	\N	25	35	\N
382	51	5	\N	\N	\N
389	31	35	\N	\N	\N
382	35	15	\N	\N	\N
383	5	300	\N	\N	\N
383	36	-60	\N	\N	\N
383	78	45	\N	\N	\N
383	79	1	\N	\N	\N
383	83	25	\N	\N	\N
383	26	65	\N	\N	\N
384	14	150	\N	\N	\N
384	47	150	\N	\N	\N
384	30	\N	6	45	\N
384	69	30	\N	\N	\N
384	79	1	\N	\N	\N
384	59	70	\N	\N	\N
384	91	35	\N	\N	\N
385	18	120	\N	\N	\N
385	86	30	\N	\N	\N
385	44	15	\N	\N	\N
385	40	35	\N	\N	\N
385	35	15	\N	\N	\N
386	18	175	\N	\N	\N
386	106	40	\N	\N	\N
386	66	55	\N	\N	\N
386	51	5	\N	\N	\N
387	18	50	\N	\N	\N
387	48	20	\N	\N	\N
387	39	100	\N	\N	\N
387	51	3	\N	\N	\N
387	67	15	\N	\N	\N
388	18	75	\N	\N	\N
388	37	5	\N	\N	\N
388	54	10	\N	\N	\N
389	5	\N	1	99	\N
389	77	8	\N	\N	\N
390	14	75	\N	\N	\N
390	47	150	\N	\N	\N
390	69	20	\N	\N	\N
390	59	25	\N	\N	\N
390	42	\N	25	75	\N
391	95	\N	9	11	\N
391	5	\N	20	25	\N
391	26	40	\N	\N	\N
391	48	20	\N	\N	\N
392	52	40	\N	\N	\N
392	39	100	\N	\N	\N
392	34	10	\N	\N	\N
392	35	5	\N	\N	\N
393	79	1	\N	\N	\N
393	5	100	\N	\N	\N
394	14	150	\N	\N	\N
394	61	418	\N	\N	\N
394	42	\N	25	35	\N
394	48	40	\N	\N	\N
394	34	15	\N	\N	\N
394	35	5	\N	\N	\N
395	5	400	\N	\N	\N
395	86	30	\N	\N	\N
395	62	300	\N	\N	\N
395	26	\N	50	75	\N
395	35	25	\N	\N	\N
396	69	20	\N	\N	\N
396	59	77	\N	\N	\N
396	26	57	\N	\N	\N
396	91	10	\N	\N	\N
393	67	\N	15	20	\N
397	37	10	\N	\N	\N
397	33	10	\N	\N	\N
397	83	15	\N	\N	\N
397	5	45	\N	\N	\N
397	59	30	\N	\N	\N
397	26	60	\N	\N	\N
398	5	400	\N	\N	\N
398	36	-60	\N	\N	\N
398	17	15	\N	\N	\N
398	54	40	\N	\N	\N
398	22	40	\N	\N	\N
398	67	40	\N	\N	\N
398	31	88	\N	\N	\N
399	36	-20	\N	\N	\N
399	78	37	\N	\N	\N
399	59	30	\N	\N	\N
399	34	20	\N	\N	\N
399	31	\N	10	15	\N
400	105	2	\N	\N	\N
400	22	33	\N	\N	\N
400	30	\N	3	32	\N
400	59	42	\N	\N	\N
400	26	50	\N	\N	\N
401	86	24	\N	\N	\N
401	45	5	\N	\N	\N
401	5	\N	80	100	\N
401	59	150	\N	\N	\N
401	77	20	\N	\N	\N
402	18	150	\N	\N	\N
402	36	-40	\N	\N	\N
402	52	40	\N	\N	\N
402	55	40	\N	\N	\N
403	67	\N	38	45	\N
403	5	125	\N	\N	\N
403	66	30	\N	\N	\N
403	55	40	\N	\N	\N
403	34	15	\N	\N	\N
403	35	25	\N	\N	\N
404	5	\N	75	100	\N
404	36	-40	\N	\N	\N
404	45	5	\N	\N	\N
404	59	\N	25	50	\N
404	25	30	\N	\N	\N
404	26	66	\N	\N	\N
405	69	20	\N	\N	\N
405	54	30	\N	\N	\N
405	5	30	\N	\N	\N
406	79	2	\N	\N	\N
406	35	5	\N	\N	\N
406	34	5	\N	\N	\N
406	90	5	\N	\N	\N
406	91	5	\N	\N	\N
406	83	25	\N	\N	\N
367	31	\N	25	40	\N
159	29	60	\N	\N	\N
243	61	\N	\N	\N	1.5
347	78	35	\N	\N	\N
182	14	\N	70	80	\N
268	274	\N	\N	\N	3
82	47	50	\N	\N	\N
81	41	50	\N	\N	\N
301	66	15	\N	\N	\N
329	66	20	\N	\N	\N
360	28	\N	\N	\N	1.5
91	79	1	\N	\N	\N
106	79	1	\N	\N	\N
113	79	1	\N	\N	\N
114	79	1	\N	\N	\N
149	79	2	\N	\N	\N
263	79	1	\N	\N	\N
329	79	1	\N	\N	\N
82	143	\N	50	100	\N
359	142	40	\N	\N	\N
359	89	35	\N	\N	\N
36	89	100	\N	\N	\N
78	89	100	\N	\N	\N
247	89	250	\N	\N	\N
402	89	100	\N	\N	\N
74	64	2	\N	\N	\N
204	64	2	\N	\N	\N
225	64	1	\N	\N	\N
264	26	\N	\N	\N	1.25
325	51	2	\N	\N	\N
145	17	\N	10	15	\N
85	25	15	\N	\N	\N
313	107	8	\N	\N	\N
33	43	\N	2	12	\N
115	43	\N	10	20	\N
121	43	\N	4	5	\N
14	76	15	\N	\N	\N
87	76	5	\N	\N	\N
87	102	5	\N	\N	\N
87	71	5	\N	\N	\N
43	83	35	\N	\N	\N
52	83	10	\N	\N	\N
87	87	5	\N	\N	\N
168	87	15	\N	\N	\N
428	49	\N	200	300	\N
439	49	\N	60	120	\N
1	476	5	\N	\N	\N
407	89	\N	100	160	\N
407	55	55	\N	\N	\N
407	78	10	\N	\N	\N
411	61	\N	20	50	\N
408	55	\N	20	30	\N
59	476	4	\N	\N	\N
411	61	\N	20	50	\N
411	47	\N	20	250	\N
409	319	\N	10	20	\N
409	31	\N	10	20	\N
500	47	50	\N	\N	\N
501	47	50	\N	\N	\N
482	44	50	\N	\N	\N
410	56	2	\N	\N	\N
75	477	30	\N	\N	\N
410	324	\N	\N	\N	0.75
410	57	\N	24	48	\N
410	45	10	\N	\N	\N
410	51	4	\N	\N	\N
75	468	60	\N	\N	\N
141	24	50	\N	\N	\N
146	409	33	\N	\N	\N
167	409	50	\N	\N	\N
169	409	35	\N	\N	\N
203	41	64	\N	\N	\N
213	409	50	\N	\N	\N
411	51	2	\N	\N	\N
412	39	\N	400	450	\N
178	24	25	\N	\N	\N
381	24	\N	\N	\N	0.25
412	83	\N	25	55	\N
412	5	\N	300	350	\N
219	409	100	\N	\N	\N
413	333	\N	10	20	\N
413	83	\N	10	20	\N
413	334	\N	5	10	\N
220	409	66	\N	\N	\N
414	336	\N	10	15	\N
414	31	\N	20	40	\N
242	476	10	\N	\N	\N
415	338	3	\N	\N	\N
415	333	\N	10	20	\N
415	51	8	\N	\N	\N
477	24	10	\N	\N	\N
427	48	15	\N	\N	\N
439	37	\N	7	10	\N
473	37	\N	7	10	\N
474	37	\N	4	7	\N
480	37	\N	5	7	\N
491	37	\N	12	18	\N
494	37	\N	6	12	\N
495	37	\N	9	13	\N
496	37	\N	9	15	\N
407	37	\N	6	9	\N
430	33	\N	10	15	\N
408	488	\N	\N	\N	\N
457	33	\N	4	8	\N
474	33	\N	4	7	\N
493	33	\N	10	15	\N
408	478	\N	\N	\N	\N
414	27	\N	80	160	\N
390	33	8	\N	\N	\N
470	19	20	\N	\N	\N
479	19	-20	\N	\N	\N
480	19	10	\N	\N	\N
491	19	25	\N	\N	\N
492	19	-20	\N	\N	\N
499	19	20	\N	\N	\N
411	79	2	\N	\N	\N
413	79	1	\N	\N	\N
458	79	2	\N	\N	\N
459	79	2	\N	\N	\N
460	79	1	\N	\N	\N
463	79	\N	1	2	\N
479	79	1	\N	\N	\N
526	79	2	\N	\N	\N
411	62	\N	150	250	\N
516	62	\N	200	300	\N
424	5	\N	50	120	\N
424	481	\N	\N	\N	\N
424	86	20	\N	\N	\N
424	83	\N	50	70	\N
425	5	\N	100	200	\N
425	359	\N	15	20	\N
425	347	\N	10	15	\N
426	14	\N	230	280	\N
426	15	\N	101	187	\N
426	83	\N	30	50	\N
428	489	\N	\N	\N	\N
427	14	\N	150	200	\N
427	30	\N	1	511	\N
429	483	\N	\N	\N	\N
427	362	-15	\N	\N	\N
411	143	\N	150	250	\N
429	490	\N	\N	\N	\N
446	489	\N	\N	\N	\N
428	14	\N	180	230	\N
452	489	\N	\N	\N	\N
453	482	\N	\N	\N	\N
429	14	\N	170	220	\N
454	491	\N	\N	\N	\N
429	117	2	\N	\N	\N
429	68	\N	10	15	\N
458	485	\N	\N	\N	\N
430	14	\N	190	240	\N
460	483	\N	\N	\N	\N
461	479	\N	\N	\N	\N
430	86	30	\N	\N	\N
464	483	\N	\N	\N	\N
430	83	\N	40	50	\N
431	14	\N	200	270	\N
431	57	\N	236	480	\N
431	48	15	\N	\N	\N
467	481	\N	\N	\N	\N
467	488	\N	\N	\N	\N
467	483	\N	\N	\N	\N
431	67	\N	40	70	\N
432	18	\N	140	180	\N
477	485	\N	\N	\N	\N
483	481	\N	\N	\N	\N
486	483	\N	\N	\N	\N
432	69	30	\N	\N	\N
432	148	10	\N	\N	\N
433	18	\N	120	150	\N
433	52	20	\N	\N	\N
433	100	\N	2	3	\N
433	83	\N	20	30	\N
506	143	\N	250	350	\N
434	18	\N	120	150	\N
486	490	\N	\N	\N	\N
434	379	\N	3	6	\N
434	380	\N	3	6	\N
434	381	\N	3	6	\N
434	35	\N	8	15	\N
434	34	\N	8	15	\N
434	90	\N	8	15	\N
408	73	\N	7	11	\N
435	18	\N	120	160	\N
435	48	10	\N	\N	\N
435	77	\N	55	77	\N
489	480	\N	\N	\N	\N
489	482	\N	\N	\N	\N
492	478	\N	\N	\N	\N
436	18	\N	140	170	\N
436	45	\N	15	23	\N
436	86	20	\N	\N	\N
436	123	2	\N	\N	\N
493	480	\N	\N	\N	\N
493	483	\N	\N	\N	\N
493	490	\N	\N	\N	\N
437	105	\N	1	3	\N
437	69	40	\N	\N	\N
437	387	\N	10	20	\N
437	388	\N	10	20	\N
437	91	\N	20	30	\N
438	105	3	\N	\N	\N
438	69	20	\N	\N	\N
438	389	\N	15	30	\N
438	22	\N	25	40	\N
438	67	\N	25	40	\N
439	18	\N	130	140	\N
494	477	\N	\N	\N	\N
495	477	\N	\N	\N	\N
439	29	33	\N	\N	\N
495	490	\N	\N	\N	\N
496	477	\N	\N	\N	\N
440	18	\N	120	150	\N
504	478	\N	\N	\N	\N
505	480	\N	\N	\N	\N
511	480	\N	\N	\N	\N
513	483	\N	\N	\N	\N
519	483	\N	\N	\N	\N
520	485	\N	\N	\N	\N
522	477	\N	\N	\N	\N
524	478	\N	\N	\N	\N
440	91	\N	20	30	\N
440	342	\N	-10	-20	\N
440	83	\N	15	25	\N
441	18	\N	170	190	\N
441	64	\N	1	2	\N
441	86	20	\N	\N	\N
441	71	10	\N	\N	\N
441	67	\N	30	40	\N
441	21	\N	9	14	\N
441	82	\N	15	25	\N
442	96	\N	1	2	\N
442	66	20	\N	\N	\N
442	106	30	\N	\N	\N
442	14	\N	40	75	\N
2	478	\N	\N	\N	\N
4	479	\N	\N	\N	\N
443	18	\N	170	200	\N
443	57	\N	211	371	\N
443	341	15	\N	\N	\N
443	396	10	\N	\N	\N
443	397	5	\N	\N	\N
443	35	\N	15	25	\N
443	23	\N	10	20	\N
444	14	\N	60	70	\N
444	40	20	\N	\N	\N
444	29	50	\N	\N	\N
444	35	8	\N	\N	\N
5	480	\N	\N	\N	\N
7	409	\N	\N	\N	\N
14	481	\N	\N	\N	\N
21	481	\N	\N	\N	\N
446	14	\N	60	70	\N
23	110	\N	\N	\N	\N
446	34	3	\N	\N	\N
446	35	3	\N	\N	\N
447	14	\N	70	80	\N
447	57	\N	15	50	\N
447	48	10	\N	\N	\N
447	39	\N	50	75	\N
447	56	1	\N	\N	\N
447	67	40	\N	\N	\N
447	34	12	\N	\N	\N
29	481	\N	\N	\N	\N
41	482	\N	\N	\N	\N
49	110	\N	\N	\N	\N
53	478	\N	\N	\N	\N
55	478	\N	\N	\N	\N
55	117	\N	\N	\N	\N
449	18	\N	130	170	\N
63	483	\N	\N	\N	\N
449	400	15	\N	\N	\N
449	76	15	\N	\N	\N
449	42	\N	13	21	\N
449	43	3	\N	\N	\N
64	484	\N	\N	\N	\N
78	110	\N	\N	\N	\N
80	479	\N	\N	\N	\N
82	485	\N	\N	\N	\N
88	117	\N	\N	\N	\N
92	110	\N	\N	\N	\N
442	49	\N	40	75	\N
109	481	\N	\N	\N	\N
446	49	50	\N	\N	\N
113	481	\N	\N	\N	\N
451	14	\N	180	220	\N
119	481	\N	\N	\N	\N
451	49	35	\N	\N	\N
451	48	20	\N	\N	\N
126	485	\N	\N	\N	\N
451	35	8	\N	\N	\N
452	14	\N	150	180	\N
452	409	50	\N	\N	\N
452	57	\N	40	180	\N
129	485	\N	\N	\N	\N
138	485	\N	\N	\N	\N
453	14	\N	150	170	\N
151	481	\N	\N	\N	\N
453	83	40	\N	\N	\N
453	412	2	\N	\N	\N
454	14	123	\N	\N	\N
454	28	66	\N	\N	\N
454	39	632	\N	\N	\N
454	409	66	\N	\N	\N
454	5	321	\N	\N	\N
454	59	36	\N	\N	\N
153	485	\N	\N	\N	\N
154	483	\N	\N	\N	\N
164	482	\N	\N	\N	\N
168	484	\N	\N	\N	\N
171	480	\N	\N	\N	\N
173	479	\N	\N	\N	\N
175	479	\N	\N	\N	\N
195	479	\N	\N	\N	\N
199	478	\N	\N	\N	\N
205	479	\N	\N	\N	\N
210	485	\N	\N	\N	\N
457	18	\N	100	130	\N
457	45	\N	10	18	\N
213	484	\N	\N	\N	\N
457	324	\N	5	11	\N
458	18	\N	90	120	\N
214	482	\N	\N	\N	\N
458	344	\N	8	15	\N
458	34	\N	10	20	\N
458	400	\N	5	9	\N
458	36	-50	\N	\N	\N
459	18	\N	100	150	\N
215	479	\N	\N	\N	\N
459	48	20	\N	\N	\N
216	110	\N	\N	\N	\N
459	35	\N	25	30	\N
459	71	10	\N	\N	\N
459	67	-30	\N	\N	\N
459	55	70	\N	\N	\N
469	144	\N	15	20	\N
467	61	\N	50	100	\N
460	18	50	\N	\N	\N
460	5	\N	100	150	\N
220	484	\N	\N	\N	\N
460	415	\N	10	15	\N
460	83	\N	20	30	\N
460	86	30	\N	\N	\N
460	412	\N	1	2	\N
461	5	\N	250	320	\N
461	40	10	\N	\N	\N
461	35	\N	25	35	\N
461	412	\N	1	2	\N
462	5	\N	250	320	\N
462	69	20	\N	\N	\N
462	344	\N	10	15	\N
462	341	\N	10	15	\N
462	347	\N	10	15	\N
462	416	3	\N	\N	\N
462	46	\N	10	15	\N
463	18	\N	150	180	\N
221	478	\N	\N	\N	\N
463	86	30	\N	\N	\N
221	480	\N	\N	\N	\N
464	18	\N	170	200	\N
464	5	\N	100	150	\N
464	35	\N	40	50	\N
464	415	\N	15	25	\N
465	18	\N	190	220	\N
465	46	\N	10	15	\N
465	86	20	\N	\N	\N
465	54	\N	40	60	\N
222	480	\N	\N	\N	\N
465	418	20	\N	\N	\N
225	478	\N	\N	\N	\N
466	18	\N	170	220	\N
466	89	\N	250	300	\N
466	35	\N	10	15	\N
466	90	\N	10	15	\N
466	86	20	\N	\N	\N
466	25	\N	40	50	\N
226	481	\N	\N	\N	\N
467	18	\N	120	150	\N
229	110	\N	\N	\N	\N
467	52	20	\N	\N	\N
467	35	\N	20	30	\N
467	83	\N	20	30	\N
467	36	-100	\N	\N	\N
229	479	\N	\N	\N	\N
231	483	\N	\N	\N	\N
459	37	\N	8	10	\N
469	18	\N	120	150	\N
469	86	30	\N	\N	\N
235	478	\N	\N	\N	\N
469	412	1	\N	\N	\N
470	18	\N	150	180	\N
237	480	\N	\N	\N	\N
240	480	\N	\N	\N	\N
470	54	\N	40	80	\N
470	37	\N	5	9	\N
240	478	\N	\N	\N	\N
471	5	\N	320	420	\N
471	89	\N	300	350	\N
247	480	\N	\N	\N	\N
250	110	\N	\N	\N	\N
251	480	\N	\N	\N	\N
253	478	\N	\N	\N	\N
269	480	\N	\N	\N	\N
270	479	\N	\N	\N	\N
272	483	\N	\N	\N	\N
471	67	\N	20	30	\N
471	55	\N	30	40	\N
471	426	\N	5	7	\N
471	412	\N	1	3	\N
472	18	\N	130	180	\N
472	106	25	\N	\N	\N
472	66	\N	20	30	\N
472	83	\N	30	40	\N
472	400	\N	6	11	\N
484	31	\N	20	50	\N
473	18	\N	90	120	\N
473	35	\N	10	15	\N
473	426	\N	5	10	\N
473	29	25	\N	\N	\N
273	483	\N	\N	\N	\N
490	49	\N	100	150	\N
474	18	\N	90	120	\N
274	480	\N	\N	\N	\N
275	483	\N	\N	\N	\N
276	483	\N	\N	\N	\N
497	49	\N	150	180	\N
475	18	\N	170	210	\N
475	14	\N	30	60	\N
475	40	10	\N	\N	\N
475	35	\N	15	25	\N
476	18	\N	140	170	\N
476	86	20	\N	\N	\N
476	52	20	\N	\N	\N
476	35	\N	10	15	\N
476	90	\N	10	15	\N
476	55	\N	40	70	\N
476	418	20	\N	\N	\N
477	18	\N	170	200	\N
477	52	20	\N	\N	\N
498	49	200	\N	\N	\N
477	35	\N	10	20	\N
477	34	17	\N	\N	\N
477	46	10	\N	\N	\N
277	483	\N	\N	\N	\N
278	483	\N	\N	\N	\N
303	479	\N	\N	\N	\N
478	18	\N	70	100	\N
307	481	\N	\N	\N	\N
478	52	30	\N	\N	\N
478	86	30	\N	\N	\N
478	34	\N	15	25	\N
478	36	-20	\N	\N	\N
479	18	\N	90	120	\N
317	485	\N	\N	\N	\N
342	483	\N	\N	\N	\N
479	69	20	\N	\N	\N
479	434	5	\N	\N	\N
345	479	\N	\N	\N	\N
347	485	\N	\N	\N	\N
480	68	2	\N	\N	\N
353	485	\N	\N	\N	\N
480	35	15	\N	\N	\N
480	48	10	\N	\N	\N
480	51	-3	\N	\N	\N
481	18	\N	90	140	\N
481	86	10	\N	\N	\N
481	90	\N	30	40	\N
481	45	\N	10	13	\N
481	25	\N	100	120	\N
361	483	\N	\N	\N	\N
482	14	\N	175	225	\N
482	48	40	\N	\N	\N
482	108	-33	\N	\N	\N
364	483	\N	\N	\N	\N
482	29	50	\N	\N	\N
483	14	\N	220	270	\N
483	76	5	\N	\N	\N
483	412	\N	3	5	\N
484	14	\N	240	300	\N
484	48	40	\N	\N	\N
484	108	-25	\N	\N	\N
484	30	\N	1	305	\N
366	478	\N	\N	\N	\N
368	483	\N	\N	\N	\N
485	14	\N	230	280	\N
485	48	40	\N	\N	\N
485	108	-33	\N	\N	\N
485	44	66	\N	\N	\N
485	426	\N	6	9	\N
486	14	\N	150	180	\N
376	485	\N	\N	\N	\N
486	39	\N	270	350	\N
486	48	25	\N	\N	\N
486	324	\N	10	12	\N
379	480	\N	\N	\N	\N
487	14	100	\N	\N	\N
487	57	\N	150	250	\N
487	26	25	\N	\N	\N
386	485	\N	\N	\N	\N
488	14	\N	240	290	\N
488	40	25	\N	\N	\N
488	48	30	\N	\N	\N
488	108	-33	\N	\N	\N
394	483	\N	\N	\N	\N
489	14	\N	150	200	\N
489	44	33	\N	\N	\N
489	442	\N	3	5	\N
490	14	\N	180	230	\N
404	481	\N	\N	\N	\N
490	57	\N	63	324	\N
490	30	\N	63	324	\N
490	42	\N	63	324	\N
490	48	20	\N	\N	\N
524	477	\N	\N	\N	\N
490	412	2	\N	\N	\N
491	14	\N	160	220	\N
491	409	33	\N	\N	\N
491	29	33	\N	\N	\N
492	14	\N	200	300	\N
492	108	-50	\N	\N	\N
492	40	25	\N	\N	\N
492	44	33	\N	\N	\N
492	29	50	\N	\N	\N
493	14	\N	190	240	\N
493	15	108	\N	\N	\N
493	51	2	\N	\N	\N
494	14	\N	160	210	\N
494	57	\N	232	323	\N
494	30	\N	23	333	\N
494	48	30	\N	\N	\N
495	14	\N	150	190	\N
495	68	15	\N	\N	\N
496	14	\N	180	230	\N
496	201	293	\N	\N	\N
481	144	\N	10	15	\N
497	14	\N	270	330	\N
497	42	\N	205	455	\N
497	43	5	\N	\N	\N
497	117	\N	2	4	\N
497	82	\N	5	15	\N
497	48	25	\N	\N	\N
486	61	\N	150	200	\N
498	14	200	\N	\N	\N
498	57	\N	1	200	\N
498	30	\N	1	200	\N
498	42	\N	1	200	\N
498	43	\N	0	7	\N
498	48	50	\N	\N	\N
498	34	15	\N	\N	\N
498	35	15	\N	\N	\N
499	14	\N	230	280	\N
499	48	50	\N	\N	\N
497	47	50	\N	\N	\N
499	36	-20	\N	\N	\N
500	14	\N	240	300	\N
500	30	\N	1	473	\N
500	48	30	\N	\N	\N
500	40	33	\N	\N	\N
498	47	50	\N	\N	\N
499	47	50	\N	\N	\N
500	21	\N	3	9	\N
500	20	30	\N	\N	\N
501	14	\N	280	320	\N
501	32	\N	10	30	\N
501	108	-25	\N	\N	\N
501	40	40	\N	\N	\N
501	35	\N	20	30	\N
502	14	\N	180	230	\N
502	40	50	\N	\N	\N
502	48	60	\N	\N	\N
510	49	\N	150	200	\N
425	486	1	\N	\N	\N
503	14	\N	250	300	\N
516	61	\N	100	150	\N
503	48	10	\N	\N	\N
503	40	33	\N	\N	\N
503	69	10	\N	\N	\N
502	47	50	\N	\N	\N
504	14	\N	270	320	\N
503	47	50	\N	\N	\N
504	48	30	\N	\N	\N
506	47	\N	150	230	\N
504	412	2	\N	\N	\N
505	14	\N	190	240	\N
505	42	\N	4	44	\N
505	44	\N	11	15	\N
508	47	50	\N	\N	\N
505	36	-25	\N	\N	\N
506	14	\N	200	280	\N
506	48	60	\N	\N	\N
506	83	\N	30	50	\N
506	455	10	\N	\N	\N
506	426	\N	10	14	\N
506	31	\N	50	80	\N
506	51	4	\N	\N	\N
506	412	\N	1	3	\N
509	47	\N	200	250	\N
510	47	50	\N	\N	\N
508	14	\N	250	300	\N
508	108	-33	\N	\N	\N
508	48	20	\N	\N	\N
508	40	33	\N	\N	\N
508	96	\N	2	3	\N
508	51	3	\N	\N	\N
508	412	\N	1	2	\N
509	14	\N	250	300	\N
509	32	\N	60	120	\N
509	96	2	\N	\N	\N
509	108	-33	\N	\N	\N
514	47	50	\N	\N	\N
515	47	50	\N	\N	\N
509	51	3	\N	\N	\N
509	36	-60	\N	\N	\N
510	14	\N	240	290	\N
510	32	\N	40	85	\N
510	15	\N	80	240	\N
510	40	33	\N	\N	\N
525	47	50	\N	\N	\N
510	48	10	\N	\N	\N
511	14	\N	180	230	\N
511	44	50	\N	\N	\N
511	201	394	\N	\N	\N
511	48	30	\N	\N	\N
512	14	\N	190	240	\N
512	39	\N	200	250	\N
512	48	50	\N	\N	\N
512	201	325	\N	\N	\N
512	55	\N	30	50	\N
526	47	50	\N	\N	\N
513	14	\N	210	260	\N
513	108	-20	\N	\N	\N
513	48	25	\N	\N	\N
513	18	\N	50	80	\N
514	69	45	\N	\N	\N
514	5	\N	450	550	\N
514	91	\N	40	50	\N
514	334	5	\N	\N	\N
515	69	30	\N	\N	\N
515	348	\N	-7	-15	\N
515	345	\N	-7	-15	\N
515	342	\N	-7	-15	\N
515	46	10	\N	\N	\N
516	14	\N	190	240	\N
516	57	\N	250	500	\N
516	21	\N	3	7	\N
516	412	\N	1	2	\N
517	14	\N	210	260	\N
517	29	50	\N	\N	\N
517	426	\N	7	13	\N
524	41	50	\N	\N	\N
519	14	\N	230	270	\N
519	48	30	\N	\N	\N
519	15	\N	250	500	\N
519	42	\N	250	500	\N
519	43	10	\N	\N	\N
519	333	\N	5	10	\N
519	51	3	\N	\N	\N
520	14	\N	180	230	\N
520	42	\N	237	486	\N
520	43	6	\N	\N	\N
520	464	\N	7	14	\N
520	82	\N	7	15	\N
520	48	25	\N	\N	\N
521	14	\N	170	240	\N
521	57	\N	233	482	\N
521	56	3	\N	\N	\N
521	465	\N	12	18	\N
521	35	\N	10	20	\N
521	90	\N	5	10	\N
505	37	\N	11	15	\N
521	23	\N	20	30	\N
522	14	\N	200	250	\N
522	44	50	\N	\N	\N
522	48	30	\N	\N	\N
522	409	50	\N	\N	\N
517	37	\N	10	15	\N
523	14	\N	160	210	\N
523	57	\N	218	483	\N
523	30	\N	29	501	\N
523	42	\N	176	397	\N
523	43	4	\N	\N	\N
523	48	30	\N	\N	\N
523	468	60	\N	\N	\N
524	14	\N	150	210	\N
524	48	30	\N	\N	\N
524	29	33	\N	\N	\N
516	33	\N	3	6	\N
525	100	2	\N	\N	\N
510	19	25	\N	\N	\N
511	79	\N	2	4	\N
514	79	\N	2	4	\N
515	79	5	\N	\N	\N
525	69	25	\N	\N	\N
526	351	\N	-40	-50	\N
526	68	\N	7	12	\N
526	426	\N	7	12	\N
519	79	1	\N	\N	\N
527	57	\N	17	45	\N
527	341	\N	3	5	\N
527	342	\N	-3	-5	\N
463	73	\N	10	15	\N
528	42	\N	24	38	\N
528	43	12	\N	\N	\N
528	344	\N	3	5	\N
528	345	\N	-3	-5	\N
510	73	\N	4	7	\N
529	30	\N	1	74	\N
529	347	\N	3	5	\N
529	348	\N	-3	-5	\N
465	73	\N	9	14	\N
530	287	37	\N	\N	\N
530	350	\N	3	5	\N
530	351	\N	-3	-5	\N
486	63	\N	5	10	\N
531	57	\N	17	45	\N
531	341	\N	3	5	\N
531	342	\N	-3	-5	\N
508	63	\N	15	20	\N
532	42	\N	24	38	\N
532	43	12	\N	\N	\N
532	344	\N	3	5	\N
532	345	\N	-3	-5	\N
442	17	\N	5	9	\N
533	30	\N	1	74	\N
533	347	\N	3	5	\N
533	355	\N	-3	-5	\N
514	17	\N	5	8	\N
519	487	\N	10	13	\N
534	350	\N	3	5	\N
534	358	\N	-3	-5	\N
474	111	-50	\N	\N	\N
501	111	-100	\N	\N	\N
429	108	-25	\N	\N	\N
530	287	37	\N	\N	\N
534	287	37	\N	\N	\N
\.


--
-- Data for Name: item_itemprop_cache; Type: TABLE DATA; Schema: public; Owner: diablo2
--

COPY item_itemprop_cache (itemid, itempropid, value, value_min, value_max) FROM stdin;
1	3	\N	26	87
2	5	\N	151	275
4	1	\N	37	81
5	3	\N	4	12
6	1	\N	40	116
7	1	\N	8	20
8	5	\N	328	335
9	5	\N	216	255
10	3	\N	10	30
12	3	\N	38	72
13	3	\N	15	35
14	5	\N	102	120
15	1	\N	10	15
16	3	\N	5	34
17	1	\N	16	56
17	3	\N	5	32
18	3	\N	17	61
19	5	\N	52	55
20	5	\N	13	42
22	1	\N	15	174
23	1	\N	50	92
23	3	\N	24	44
24	3	\N	25	60
37	1	\N	15	37
38	5	\N	104	109
39	5	\N	13	16
40	3	\N	19	34
41	1	\N	5	32
42	3	\N	12	28
43	5	\N	330	354
45	5	\N	119	151
48	5	\N	2	3
49	3	\N	6	18
50	5	\N	5	7
51	1	\N	12	20
52	5	\N	21	27
53	1	\N	18	43
54	5	\N	3	3
55	1	\N	14	54
56	1	\N	31	73
57	3	\N	7	18
58	1	\N	5	43
59	1	\N	38	93
60	5	\N	2	3
61	5	\N	15	21
62	1	\N	64	150
62	3	\N	32	74
63	3	\N	29	96
64	1	\N	5	16
65	1	\N	24	56
67	1	\N	105	303
68	5	\N	232	360
69	5	\N	145	210
71	3	\N	52	105
72	5	\N	360	504
73	1	\N	47	123
74	5	\N	182	294
75	3	\N	45	105
76	5	\N	17	19
78	5	\N	25	28
79	5	\N	29	39
80	5	\N	54	63
81	5	\N	34	52
82	5	\N	32	72
83	5	\N	28	31
84	5	\N	39	42
85	5	\N	51	54
86	5	\N	57	60
87	5	\N	76	96
88	5	\N	153	171
89	5	\N	180	214
90	5	\N	202	241
91	5	\N	436	512
92	5	\N	11	15
93	5	\N	18	22
94	5	\N	25	36
95	5	\N	19	40
96	5	\N	60	70
97	5	\N	5	7
98	5	\N	9	11
99	5	\N	10	14
100	5	\N	13	18
101	5	\N	6	7
102	5	\N	10	12
104	5	\N	6	7
105	5	\N	8	9
106	5	\N	90	106
107	5	\N	135	198
108	5	\N	189	244
109	5	\N	77	282
111	5	\N	202	339
112	5	\N	120	250
113	5	\N	255	292
114	5	\N	244	277
115	5	\N	305	394
116	5	\N	207	306
117	5	\N	440	532
118	5	\N	347	447
119	5	\N	488	606
120	5	\N	514	681
121	5	\N	585	729
122	5	\N	540	678
123	5	\N	705	822
124	5	\N	629	825
125	5	\N	620	787
126	5	\N	756	1026
127	5	\N	1042	1260
128	5	\N	131	176
129	5	\N	137	195
130	5	\N	141	201
131	5	\N	115	171
132	5	\N	190	265
133	5	\N	90	347
134	5	\N	208	279
135	5	\N	64	91
136	5	\N	79	109
137	5	\N	92	127
138	5	\N	97	141
139	5	\N	107	159
140	5	\N	61	87
141	5	\N	92	120
142	5	\N	92	127
143	5	\N	97	136
144	5	\N	111	159
145	5	\N	72	95
146	5	\N	68	90
147	5	\N	77	100
148	5	\N	85	113
150	5	\N	182	254
151	5	\N	937	1443
152	5	\N	1230	1551
153	5	\N	280	369
156	3	\N	4	10
157	3	\N	11	22
158	1	\N	10	24
159	1	\N	14	27
160	1	\N	24	64
161	1	\N	13	54
162	1	\N	39	99
163	1	\N	2	8
164	1	\N	2	9
165	1	\N	5	12
166	1	\N	10	26
167	1	\N	13	24
168	1	\N	23	46
169	1	\N	9	24
170	3	\N	2	19
171	3	\N	1	6
173	3	\N	1	10
174	3	\N	10	16
175	3	\N	4	16
176	3	\N	1	38
177	1	\N	90	172
178	1	\N	95	203
179	1	\N	2	54
180	1	\N	9	37
181	1	\N	27	66
182	3	\N	10	19
183	3	\N	18	37
184	1	\N	13	15
185	1	\N	10	28
187	1	\N	25	126
188	1	\N	1	8
189	1	\N	2	11
192	3	\N	4	14
193	3	\N	3	10
194	3	\N	14	34
195	3	\N	12	30
196	3	\N	13	36
197	1	\N	16	34
197	3	\N	4	18
198	1	\N	22	60
198	3	\N	8	24
199	1	\N	30	44
199	3	\N	10	30
200	1	\N	23	52
200	3	\N	16	30
204	3	\N	35	110
205	3	\N	33	91
206	3	\N	40	125
207	1	\N	55	129
208	1	\N	48	154
209	1	\N	50	224
210	1	\N	103	255
211	1	\N	15	57
212	1	\N	22	70
213	1	\N	25	81
214	1	\N	32	81
215	1	\N	29	138
216	1	\N	30	87
217	1	\N	30	175
218	1	\N	50	134
219	1	\N	82	165
220	1	\N	31	71
221	3	\N	18	61
222	3	\N	29	88
223	3	\N	30	76
224	3	\N	47	90
225	3	\N	29	75
226	3	\N	37	64
227	3	\N	44	77
228	3	\N	33	105
229	3	\N	98	162
230	1	\N	148	249
231	1	\N	140	257
232	1	\N	28	127
233	1	\N	45	125
234	1	\N	88	240
235	1	\N	33	255
236	1	\N	72	196
237	3	\N	36	76
238	3	\N	36	104
239	3	\N	23	44
240	1	\N	24	99
241	1	\N	45	103
242	1	\N	75	177
243	1	\N	67	342
245	1	\N	24	104
249	3	\N	20	67
250	3	\N	24	73
251	3	\N	24	62
252	3	\N	25	77
253	3	\N	40	85
254	3	\N	25	105
255	3	\N	54	150
256	1	\N	46	120
256	3	\N	20	78
257	1	\N	47	174
257	3	\N	25	111
258	1	\N	97	180
258	3	\N	35	120
259	1	\N	63	140
259	3	\N	41	91
260	1	\N	126	224
260	3	\N	64	112
267	1	\N	177	282
268	1	\N	98	274
269	1	\N	45	189
270	1	\N	35	238
271	3	\N	129	159
272	1	\N	99	612
273	3	\N	100	140
274	3	\N	77	105
275	1	\N	198	290
275	3	\N	67	189
276	1	\N	145	402
276	3	\N	62	227
277	1	\N	115	444
279	5	\N	62	67
287	5	\N	30	46
288	5	\N	33	33
290	1	\N	9	21
291	5	\N	30	33
295	5	\N	87	90
299	3	\N	8	41
301	5	\N	27	29
304	5	\N	25	27
305	3	\N	10	25
307	5	\N	22	22
312	5	\N	31	31
313	3	\N	13	11
316	5	\N	31	31
318	3	\N	17	14
320	5	\N	105	108
321	5	\N	70	75
324	5	\N	41	43
325	3	\N	15	25
326	5	\N	55	60
327	5	\N	160	168
335	3	\N	12	19
338	5	\N	64	67
341	5	\N	157	171
343	5	\N	746	857
344	3	\N	60	93
345	1	\N	174	345
345	3	\N	75	195
346	3	\N	120	150
347	5	\N	120	128
348	5	\N	51	56
349	5	\N	30	41
351	5	\N	79	87
352	5	\N	666	882
353	5	\N	53	60
354	5	\N	108	115
355	5	\N	917	950
356	5	\N	166	280
357	3	\N	101	118
358	5	\N	290	333
359	5	\N	688	702
361	5	\N	203	220
362	5	\N	164	209
363	5	\N	156	226
365	5	\N	376	390
367	5	\N	160	175
368	1	\N	231	318
369	5	\N	887	1000
370	5	\N	77	88
371	5	\N	108	118
372	5	\N	118	128
373	5	\N	200	210
374	1	\N	40	207
375	5	\N	421	919
376	5	\N	84	97
377	5	\N	81	86
378	5	\N	195	260
379	3	\N	120	153
380	5	\N	540	646
381	5	\N	112	119
382	5	\N	95	105
383	5	\N	721	830
384	1	\N	200	232
385	5	\N	187	215
386	5	\N	129	151
387	5	\N	49	58
388	5	\N	64	73
389	5	\N	4	104
390	3	\N	5	12
391	5	\N	25	31
393	5	\N	175	184
394	3	\N	12	192
395	5	\N	810	917
397	5	\N	99	131
398	5	\N	833	941
401	5	\N	180	257
402	5	\N	787	855
403	5	\N	175	189
404	5	\N	134	166
405	5	\N	67	74
424	5	\N	90	170
425	5	\N	150	260
426	1	\N	214	361
427	3	\N	75	162
428	1	\N	56	155
429	3	\N	97	134
430	3	\N	98	153
431	3	\N	66	196
432	5	\N	247	414
433	5	\N	220	365
434	5	\N	231	375
435	5	\N	244	405
436	5	\N	273	429
439	5	\N	232	348
440	5	\N	226	387
441	5	\N	288	440
443	5	\N	456	579
444	3	\N	4	10
446	1	\N	4	17
447	1	\N	5	32
449	5	\N	85	113
451	1	\N	50	224
452	1	\N	25	81
453	1	\N	32	81
454	1	\N	31	71
457	5	\N	210	342
458	5	\N	216	349
459	5	\N	202	385
460	5	\N	166	247
461	5	\N	350	477
462	5	\N	611	787
463	5	\N	1025	1447
464	5	\N	1125	1569
465	5	\N	1293	1782
466	5	\N	1314	1920
467	5	\N	1071	1500
469	5	\N	323	407
470	5	\N	362	450
471	5	\N	478	593
472	5	\N	363	484
473	5	\N	106	143
474	5	\N	112	147
475	5	\N	167	220
476	5	\N	134	175
477	5	\N	159	201
478	5	\N	105	142
479	5	\N	104	136
481	5	\N	110	156
482	3	\N	90	188
483	3	\N	105	244
484	3	\N	102	192
485	3	\N	79	269
486	1	\N	155	308
487	1	\N	98	274
488	1	\N	204	483
489	1	\N	50	159
490	1	\N	89	300
491	1	\N	67	128
492	3	\N	45	228
493	3	\N	89	159
497	3	\N	129	184
498	3	\N	96	174
499	3	\N	9	304
500	3	\N	10	320
501	3	\N	190	256
502	1	\N	215	349
503	1	\N	115	720
504	1	\N	103	609
505	1	\N	34	479
506	1	\N	99	570
508	3	\N	140	208
509	3	\N	140	208
510	3	\N	125	167
511	1	\N	98	392
512	1	\N	121	312
513	1	\N	102	640
516	3	\N	75	156
517	3	\N	102	162
519	3	\N	102	129
520	3	\N	14	254
521	1	\N	148	401
521	3	\N	40	255
\.


--
-- Data for Name: item_spell; Type: TABLE DATA; Schema: public; Owner: diablo2
--

COPY item_spell (itemid, spellid, "type", level_val, level_min, level_max, pct_val, pct_min, pct_max, num_charges) FROM stdin;
24	3	A	10	\N	\N	10	\N	\N	\N
24	4	W	5	\N	\N	10	\N	\N	\N
28	5	A	2	\N	\N	5	\N	\N	\N
35	6	W	2	\N	\N	10	\N	\N	\N
127	6	W	2	\N	\N	6	\N	\N	\N
45	7	W	7	\N	\N	5	\N	\N	\N
62	8	A	3	\N	\N	5	\N	\N	\N
70	9	W	1	\N	\N	25	\N	\N	\N
109	10	W	3	\N	\N	6	\N	\N	\N
109	34	C	5	\N	\N	\N	\N	\N	30
127	35	C	5	\N	\N	\N	\N	\N	40
129	11	W	5	\N	\N	4	\N	\N	\N
129	12	W	6	\N	\N	4	\N	\N	\N
130	13	W	6	\N	\N	3	\N	\N	\N
130	14	W	7	\N	\N	5	\N	\N	\N
130	4	W	9	\N	\N	5	\N	\N	\N
138	15	O	10	\N	\N	2	\N	\N	\N
140	16	W	8	\N	\N	5	\N	\N	\N
148	12	W	7	\N	\N	5	\N	\N	\N
153	17	W	5	\N	\N	4	\N	\N	\N
205	18	A	8	\N	\N	4	\N	\N	\N
206	19	A	8	\N	\N	5	\N	\N	\N
207	37	C	12	\N	\N	\N	\N	\N	60
207	32	C	20	\N	\N	\N	\N	\N	100
209	32	C	20	\N	\N	\N	\N	\N	200
207	26	C	3	\N	\N	\N	\N	\N	30
207	9	C	1	\N	\N	\N	\N	\N	20
208	20	W	5	\N	\N	15	\N	\N	\N
208	21	O	10	\N	\N	5	\N	\N	\N
211	22	O	6	\N	\N	2	\N	\N	\N
227	22	O	6	\N	\N	5	\N	\N	\N
214	5	A	5	\N	\N	2	\N	\N	\N
218	19	W	6	\N	\N	9	\N	\N	\N
218	23	O	1	\N	\N	4	\N	\N	\N
224	20	W	3	\N	\N	25	\N	\N	\N
226	8	C	9	\N	\N	\N	\N	\N	50
227	22	C	11	\N	\N	\N	\N	\N	60
228	14	A	8	\N	\N	5	\N	\N	\N
228	14	C	15	\N	\N	\N	\N	\N	80
229	24	A	7	\N	\N	5	\N	\N	\N
231	6	W	1	\N	\N	5	\N	\N	\N
231	5	A	1	\N	\N	5	\N	\N	\N
257	5	A	1	\N	\N	6	\N	\N	\N
272	5	A	1	\N	\N	4	\N	\N	\N
231	5	C	8	\N	\N	\N	\N	\N	3
232	17	A	5	\N	\N	5	\N	\N	\N
237	12	A	5	\N	\N	6	\N	\N	\N
238	25	A	1	\N	\N	10	\N	\N	\N
238	26	A	1	\N	\N	5	\N	\N	\N
251	13	C	6	\N	\N	\N	\N	\N	36
254	19	O	4	\N	\N	5	\N	\N	\N
259	38	C	10	\N	\N	\N	\N	\N	20
259	15	C	10	\N	\N	\N	\N	\N	45
265	29	W	2	\N	\N	10	\N	\N	\N
265	30	W	10	\N	\N	5	\N	\N	\N
266	39	C	13	\N	\N	\N	\N	\N	30
273	31	A	10	\N	\N	20	\N	\N	\N
275	17	A	3	\N	\N	8	\N	\N	\N
362	17	A	3	\N	\N	10	\N	\N	\N
277	20	W	31	\N	\N	2	\N	\N	\N
277	21	W	5	\N	\N	5	\N	\N	\N
348	21	W	5	\N	\N	18	\N	\N	\N
382	21	W	5	\N	\N	12	\N	\N	\N
351	32	A	3	\N	\N	10	\N	\N	\N
360	4	A	3	\N	\N	10	\N	\N	\N
364	3	O	3	\N	\N	10	\N	\N	\N
365	31	W	3	\N	\N	10	\N	\N	\N
369	15	W	5	\N	\N	5	\N	\N	\N
371	20	W	4	\N	\N	12	\N	\N	\N
374	14	W	3	\N	\N	10	\N	\N	\N
375	33	W	3	\N	\N	10	\N	\N	\N
239	7	O	4	\N	\N	5	\N	\N	\N
258	7	A	7	\N	\N	6	\N	\N	\N
217	7	A	\N	5	7	5	\N	\N	\N
274	21	A	\N	8	16	5	\N	\N	\N
208	20	O	\N	13	20	10	\N	\N	\N
134	36	C	6	\N	\N	\N	\N	\N	40
134	19	W	5	\N	\N	5	\N	\N	\N
139	37	O	12	\N	\N	4	\N	\N	\N
139	22	O	4	\N	\N	2	\N	\N	\N
259	40	A	6	\N	\N	10	\N	\N	\N
352	14	W	3	\N	\N	25	\N	\N	\N
13	114	S	3	\N	\N	\N	\N	\N	\N
17	115	S	6	\N	\N	\N	\N	\N	\N
22	116	S	3	\N	\N	\N	\N	\N	\N
230	116	S	2	\N	\N	\N	\N	\N	\N
45	117	S	3	\N	\N	\N	\N	\N	\N
52	118	S	2	\N	\N	\N	\N	\N	\N
56	119	S	5	\N	\N	\N	\N	\N	\N
58	120	S	2	\N	\N	\N	\N	\N	\N
65	4	S	3	\N	\N	\N	\N	\N	\N
65	16	S	2	\N	\N	\N	\N	\N	\N
67	121	S	2	\N	\N	\N	\N	\N	\N
75	121	S	2	\N	\N	\N	\N	\N	\N
68	122	S	2	\N	\N	\N	\N	\N	\N
369	122	S	2	\N	\N	\N	\N	\N	\N
71	123	S	1	\N	\N	\N	\N	\N	\N
72	122	S	2	\N	\N	\N	\N	\N	\N
243	122	S	3	\N	\N	\N	\N	\N	\N
73	124	S	2	\N	\N	\N	\N	\N	\N
213	124	S	3	\N	\N	\N	\N	\N	\N
74	125	S	2	\N	\N	\N	\N	\N	\N
225	125	S	2	\N	\N	\N	\N	\N	\N
343	125	S	1	\N	\N	\N	\N	\N	\N
65	14	S	2	\N	\N	\N	\N	\N	\N
82	126	S	3	\N	\N	\N	\N	\N	\N
265	126	S	3	\N	\N	\N	\N	\N	\N
101	127	S	2	\N	\N	\N	\N	\N	\N
148	128	S	2	\N	\N	\N	\N	\N	\N
148	12	S	2	\N	\N	\N	\N	\N	\N
148	33	S	3	\N	\N	\N	\N	\N	\N
183	7	S	1	\N	\N	\N	\N	\N	\N
239	7	S	2	\N	\N	\N	\N	\N	\N
183	129	S	3	\N	\N	\N	\N	\N	\N
237	129	S	2	\N	\N	\N	\N	\N	\N
183	130	S	\N	4	5	\N	\N	\N	\N
188	131	S	5	\N	\N	\N	\N	\N	\N
188	132	S	2	\N	\N	\N	\N	\N	\N
191	132	S	3	\N	\N	\N	\N	\N	\N
190	133	S	2	\N	\N	\N	\N	\N	\N
190	21	S	1	\N	\N	\N	\N	\N	\N
190	31	S	3	\N	\N	\N	\N	\N	\N
191	40	S	2	\N	\N	\N	\N	\N	\N
191	38	S	1	\N	\N	\N	\N	\N	\N
201	6	S	\N	1	3	\N	\N	\N	\N
201	5	S	\N	1	3	\N	\N	\N	\N
201	134	S	\N	1	3	\N	\N	\N	\N
203	134	S	3	\N	\N	\N	\N	\N	\N
265	134	S	2	\N	\N	\N	\N	\N	\N
201	35	S	\N	1	3	\N	\N	\N	\N
203	26	S	2	\N	\N	\N	\N	\N	\N
204	135	S	1	\N	\N	\N	\N	\N	\N
204	136	S	1	\N	\N	\N	\N	\N	\N
213	137	S	3	\N	\N	\N	\N	\N	\N
216	138	S	3	\N	\N	\N	\N	\N	\N
222	39	S	4	\N	\N	\N	\N	\N	\N
222	139	S	4	\N	\N	\N	\N	\N	\N
222	140	S	4	\N	\N	\N	\N	\N	\N
223	19	S	4	\N	\N	\N	\N	\N	\N
223	36	S	4	\N	\N	\N	\N	\N	\N
223	141	S	5	\N	\N	\N	\N	\N	\N
229	142	S	3	\N	\N	\N	\N	\N	\N
343	142	S	1	\N	\N	\N	\N	\N	\N
230	143	S	3	\N	\N	\N	\N	\N	\N
237	144	S	2	\N	\N	\N	\N	\N	\N
239	32	S	4	\N	\N	\N	\N	\N	\N
240	145	S	5	\N	\N	\N	\N	\N	\N
240	146	S	3	\N	\N	\N	\N	\N	\N
246	147	S	1	\N	\N	\N	\N	\N	\N
396	147	S	1	\N	\N	\N	\N	\N	\N
246	148	S	1	\N	\N	\N	\N	\N	\N
396	148	S	1	\N	\N	\N	\N	\N	\N
246	149	S	1	\N	\N	\N	\N	\N	\N
396	149	S	2	\N	\N	\N	\N	\N	\N
247	150	S	3	\N	\N	\N	\N	\N	\N
247	151	S	3	\N	\N	\N	\N	\N	\N
247	9	S	3	\N	\N	\N	\N	\N	\N
249	152	S	\N	1	3	\N	\N	\N	\N
249	153	S	\N	2	4	\N	\N	\N	\N
254	154	S	5	\N	\N	\N	\N	\N	\N
258	155	S	2	\N	\N	\N	\N	\N	\N
355	155	S	2	\N	\N	\N	\N	\N	\N
258	156	S	2	\N	\N	\N	\N	\N	\N
264	157	S	2	\N	\N	\N	\N	\N	\N
265	157	S	2	\N	\N	\N	\N	\N	\N
402	157	S	2	\N	\N	\N	\N	\N	\N
265	158	S	2	\N	\N	\N	\N	\N	\N
265	159	S	3	\N	\N	\N	\N	\N	\N
265	160	S	2	\N	\N	\N	\N	\N	\N
403	160	S	2	\N	\N	\N	\N	\N	\N
266	161	S	1	\N	\N	\N	\N	\N	\N
405	161	S	2	\N	\N	\N	\N	\N	\N
69	161	S	2	\N	\N	\N	\N	\N	\N
367	162	S	2	\N	\N	\N	\N	\N	\N
375	163	S	2	\N	\N	\N	\N	\N	\N
380	164	S	2	\N	\N	\N	\N	\N	\N
268	40	O	\N	13	22	10	\N	\N	\N
407	19	W	10	\N	\N	10	\N	\N	\N
407	165	C	21	\N	\N	\N	\N	\N	15
408	166	C	5	\N	\N	\N	\N	\N	27
409	167	C	7	\N	\N	\N	\N	\N	11
409	168	C	5	\N	\N	\N	\N	\N	13
409	166	C	2	\N	\N	\N	\N	\N	15
412	169	C	22	\N	\N	\N	\N	\N	11
412	6	C	12	\N	\N	\N	\N	\N	20
415	13	C	30	\N	\N	\N	\N	\N	10
433	134	W	3	\N	\N	15	\N	\N	\N
434	170	C	15	\N	\N	\N	\N	\N	18
451	32	C	20	\N	\N	\N	\N	\N	200
453	5	O	5	\N	\N	2	\N	\N	\N
459	171	C	3	\N	\N	\N	\N	\N	20
465	6	W	6	\N	\N	8	\N	\N	\N
472	172	W	8	\N	\N	5	\N	\N	\N
473	173	O	10	\N	\N	5	\N	\N	\N
474	17	O	3	\N	\N	8	\N	\N	\N
496	174	C	11	\N	\N	\N	\N	\N	60
497	12	C	16	\N	\N	\N	\N	\N	16
500	11	O	18	\N	\N	20	\N	\N	\N
500	31	O	10	\N	\N	15	\N	\N	\N
502	175	O	22	\N	\N	33	\N	\N	\N
503	24	O	14	\N	\N	25	\N	\N	\N
503	18	C	14	\N	\N	\N	\N	\N	30
504	35	C	14	\N	\N	\N	\N	\N	30
504	176	O	16	\N	\N	50	\N	\N	\N
505	26	O	1	\N	\N	33	\N	\N	\N
512	36	O	9	\N	\N	15	\N	\N	\N
517	177	C	15	\N	\N	\N	\N	\N	9
521	37	O	16	\N	\N	12	\N	\N	\N
522	14	O	9	\N	\N	25	\N	\N	\N
524	5	O	3	\N	\N	33	\N	\N	\N
407	175	O	13	\N	\N	8	\N	\N	\N
409	133	O	16	\N	\N	10	\N	\N	\N
527	16	L	29	\N	\N	100	\N	\N	\N
528	4	L	43	\N	\N	100	\N	\N	\N
529	14	L	41	\N	\N	100	\N	\N	\N
530	171	L	23	\N	\N	100	\N	\N	\N
531	22	L	31	\N	\N	100	\N	\N	\N
532	12	L	37	\N	\N	100	\N	\N	\N
533	21	L	47	\N	\N	100	\N	\N	\N
534	19	L	51	\N	\N	100	\N	\N	\N
427	133	O	14	\N	\N	20	\N	\N	\N
459	19	W	15	\N	\N	15	\N	\N	\N
470	23	W	7	\N	\N	10	\N	\N	\N
470	14	L	44	\N	\N	100	\N	\N	\N
499	11	O	15	\N	\N	20	\N	\N	\N
411	155	S	\N	1	2	\N	\N	\N	\N
466	178	S	\N	1	2	\N	\N	\N	\N
477	126	S	\N	1	2	\N	\N	\N	\N
509	179	S	\N	2	4	\N	\N	\N	\N
509	32	S	\N	2	4	\N	\N	\N	\N
510	122	S	\N	2	4	\N	\N	\N	\N
525	30	S	\N	1	2	\N	\N	\N	\N
525	176	S	\N	2	3	\N	\N	\N	\N
525	180	S	\N	2	3	\N	\N	\N	\N
525	181	S	\N	4	5	\N	\N	\N	\N
525	182	S	\N	4	5	\N	\N	\N	\N
42	183	S	3	\N	\N	\N	\N	\N	\N
42	184	S	3	\N	\N	\N	\N	\N	\N
45	185	S	3	\N	\N	\N	\N	\N	\N
426	121	S	\N	1	3	\N	\N	\N	\N
427	121	S	\N	2	4	\N	\N	\N	\N
427	186	S	3	\N	\N	\N	\N	\N	\N
428	124	S	\N	2	4	\N	\N	\N	\N
452	124	S	3	\N	\N	\N	\N	\N	\N
430	187	S	\N	1	2	\N	\N	\N	\N
431	187	S	\N	1	3	\N	\N	\N	\N
430	188	S	\N	1	2	\N	\N	\N	\N
478	188	S	\N	1	2	\N	\N	\N	\N
431	189	S	\N	1	2	\N	\N	\N	\N
431	190	S	\N	1	2	\N	\N	\N	\N
432	157	S	\N	1	3	\N	\N	\N	\N
432	191	S	\N	1	3	\N	\N	\N	\N
526	191	S	\N	1	2	\N	\N	\N	\N
432	161	S	\N	1	3	\N	\N	\N	\N
434	192	S	\N	2	3	\N	\N	\N	\N
435	192	S	\N	1	3	\N	\N	\N	\N
435	116	S	\N	1	3	\N	\N	\N	\N
436	116	S	1	\N	\N	\N	\N	\N	\N
435	122	S	\N	1	3	\N	\N	\N	\N
436	193	S	\N	1	2	\N	\N	\N	\N
436	194	S	\N	1	2	\N	\N	\N	\N
439	125	S	\N	2	4	\N	\N	\N	\N
439	195	S	\N	1	2	\N	\N	\N	\N
440	196	S	7	\N	\N	\N	\N	\N	\N
440	142	S	3	\N	\N	\N	\N	\N	\N
503	142	S	7	\N	\N	\N	\N	\N	\N
449	128	S	2	\N	\N	\N	\N	\N	\N
449	12	S	2	\N	\N	\N	\N	\N	\N
449	33	S	3	\N	\N	\N	\N	\N	\N
452	137	S	3	\N	\N	\N	\N	\N	\N
451	32	W	\N	12	28	50	\N	\N	\N
487	197	A	\N	16	20	10	\N	\N	\N
449	197	W	\N	7	20	5	\N	\N	\N
415	37	O	10	\N	\N	25	\N	\N	\N
410	22	W	\N	13	19	2	\N	\N	\N
488	26	K	6	\N	\N	50	\N	\N	\N
429	4	O	8	\N	\N	33	\N	\N	\N
477	173	C	12	\N	\N	\N	\N	\N	10
479	171	C	3	\N	\N	\N	\N	\N	11
477	29	C	33	\N	\N	\N	\N	\N	13
484	196	C	8	\N	\N	\N	\N	\N	15
490	137	C	18	\N	\N	\N	\N	\N	150
\.


--
-- Data for Name: item_type_prop; Type: TABLE DATA; Schema: public; Owner: diablo2
--

COPY item_type_prop (itemtypeid, itempropid, value, value_min, value_max) FROM stdin;
1	1	\N	7	12
2	1	\N	9	19
3	2	28	\N	\N
3	3	\N	18	24
4	2	25	\N	\N
4	1	\N	23	55
5	3	\N	8	14
5	4	80	\N	\N
6	1	\N	16	29
7	1	\N	19	41
8	2	28	\N	\N
8	1	\N	34	51
9	2	25	\N	\N
9	1	\N	42	101
10	3	\N	18	35
10	4	80	\N	\N
11	1	\N	20	47
12	1	\N	14	72
13	2	28	\N	\N
13	1	\N	65	95
14	2	25	\N	\N
14	1	\N	37	153
15	3	\N	30	54
15	4	80	\N	\N
16	5	\N	8	11
16	2	20	\N	\N
17	5	\N	14	17
17	2	24	\N	\N
18	5	\N	21	24
18	2	28	\N	\N
19	5	\N	32	35
19	2	32	\N	\N
20	5	\N	45	48
20	2	36	\N	\N
21	5	\N	57	60
21	2	36	\N	\N
22	5	\N	65	68
22	2	50	\N	\N
23	5	\N	72	75
23	2	45	\N	\N
24	5	\N	90	95
24	2	30	\N	\N
25	5	\N	90	107
25	2	60	\N	\N
26	5	\N	101	105
26	2	48	\N	\N
27	5	\N	108	116
27	2	60	\N	\N
28	5	\N	128	135
28	2	55	\N	\N
29	5	\N	150	161
29	2	70	\N	\N
30	5	\N	218	233
30	2	60	\N	\N
31	5	\N	102	117
31	2	20	\N	\N
32	5	\N	111	126
32	2	24	\N	\N
33	5	\N	122	136
33	2	28	\N	\N
34	5	\N	138	153
34	2	32	\N	\N
35	5	\N	158	172
35	2	26	\N	\N
36	5	\N	176	190
36	2	36	\N	\N
37	5	\N	188	202
37	2	50	\N	\N
38	5	\N	198	213
38	2	45	\N	\N
39	5	\N	225	243
39	2	30	\N	\N
40	5	\N	225	261
40	2	60	\N	\N
41	5	\N	242	258
41	2	48	\N	\N
42	5	\N	252	274
42	2	60	\N	\N
43	5	\N	282	303
43	2	55	\N	\N
44	5	\N	315	342
44	2	70	\N	\N
45	5	\N	417	450
45	2	60	\N	\N
46	5	\N	361	467
46	2	20	\N	\N
47	5	\N	364	470
47	2	24	\N	\N
48	5	\N	369	474
48	2	28	\N	\N
49	5	\N	375	481
49	2	32	\N	\N
50	5	\N	375	489
50	2	26	\N	\N
51	5	\N	390	496
51	2	36	\N	\N
52	5	\N	395	501
52	2	50	\N	\N
53	5	\N	399	505
53	2	45	\N	\N
54	5	\N	410	517
54	2	30	\N	\N
55	5	\N	410	524
55	2	60	\N	\N
56	5	\N	417	523
56	2	48	\N	\N
57	5	\N	421	530
57	2	60	\N	\N
58	5	\N	433	541
58	2	55	\N	\N
59	5	\N	446	557
59	2	70	\N	\N
60	5	\N	487	600
60	2	60	\N	\N
61	2	48	\N	\N
61	3	\N	4	7
62	2	52	\N	\N
62	3	\N	5	9
63	2	56	\N	\N
63	3	\N	2	15
64	2	72	\N	\N
64	3	\N	7	15
65	2	64	\N	\N
65	3	\N	8	15
66	2	69	\N	\N
66	3	\N	10	14
67	2	68	\N	\N
67	3	\N	9	17
68	2	48	\N	\N
68	3	\N	11	24
69	2	56	\N	\N
69	3	\N	13	27
70	2	64	\N	\N
70	3	\N	8	37
71	2	72	\N	\N
71	3	\N	16	37
72	2	52	\N	\N
72	3	\N	21	35
73	2	69	\N	\N
73	3	\N	21	35
74	2	68	\N	\N
74	3	\N	19	40
75	2	48	\N	\N
75	3	\N	39	52
76	2	56	\N	\N
76	3	\N	34	45
77	2	64	\N	\N
77	3	\N	44	53
78	2	72	\N	\N
78	3	\N	36	42
79	2	52	\N	\N
79	3	\N	22	53
80	2	69	\N	\N
80	3	\N	24	44
81	2	68	\N	\N
81	3	\N	40	51
82	2	28	\N	\N
82	6	1	\N	\N
82	3	\N	3	6
83	2	24	\N	\N
83	6	2	\N	\N
83	3	\N	4	11
84	2	24	\N	\N
84	6	2	\N	\N
84	3	\N	5	13
85	2	26	\N	\N
85	6	2	\N	\N
85	3	\N	7	11
86	2	26	\N	\N
86	6	3	\N	\N
86	3	\N	10	18
87	2	30	\N	\N
87	6	2	\N	\N
87	1	\N	6	13
88	2	35	\N	\N
88	6	2	\N	\N
88	1	\N	10	18
89	2	40	\N	\N
89	6	2	\N	\N
89	1	\N	12	32
90	2	50	\N	\N
90	6	3	\N	\N
90	1	\N	9	30
91	2	50	\N	\N
91	6	4	\N	\N
91	1	\N	22	45
92	2	28	\N	\N
92	6	1	\N	\N
92	3	\N	10	21
93	2	24	\N	\N
93	6	2	\N	\N
93	3	\N	10	33
94	2	24	\N	\N
94	6	2	\N	\N
94	3	\N	13	38
95	2	26	\N	\N
95	6	2	\N	\N
95	3	\N	14	34
96	2	26	\N	\N
96	6	3	\N	\N
96	3	\N	16	45
97	2	30	\N	\N
97	6	2	\N	\N
97	1	\N	14	34
98	2	35	\N	\N
98	6	2	\N	\N
98	1	\N	21	49
99	2	40	\N	\N
99	6	2	\N	\N
99	1	\N	24	77
100	2	50	\N	\N
100	6	3	\N	\N
100	1	\N	18	70
101	2	50	\N	\N
101	6	4	\N	\N
101	1	\N	43	85
102	2	28	\N	\N
102	6	1	\N	\N
102	3	\N	33	58
103	2	24	\N	\N
103	6	2	\N	\N
103	3	\N	38	60
104	2	24	\N	\N
104	6	2	\N	\N
104	3	\N	33	66
105	2	26	\N	\N
105	6	2	\N	\N
105	3	\N	30	48
106	2	26	\N	\N
106	6	3	\N	\N
106	3	\N	24	71
107	2	30	\N	\N
107	6	3	\N	\N
107	1	\N	25	123
108	2	35	\N	\N
108	6	3	\N	\N
108	1	\N	62	110
109	2	40	\N	\N
109	6	3	\N	\N
109	1	\N	49	137
110	2	50	\N	\N
110	6	3	\N	\N
110	1	\N	59	94
111	2	50	\N	\N
111	6	4	\N	\N
111	1	\N	60	124
112	5	\N	10	15
112	2	25	\N	\N
113	5	\N	15	20
113	2	35	\N	\N
114	5	\N	25	25
114	2	45	\N	\N
115	5	\N	30	35
115	2	50	\N	\N
116	5	\N	35	50
116	2	55	\N	\N
117	5	\N	55	68
117	2	25	\N	\N
118	5	\N	63	75
118	2	35	\N	\N
119	5	\N	78	90
119	2	45	\N	\N
120	5	\N	85	98
120	2	50	\N	\N
121	5	\N	93	120
121	2	55	\N	\N
122	5	\N	102	147
122	2	25	\N	\N
123	5	\N	105	150
123	2	35	\N	\N
124	5	\N	111	156
124	2	45	\N	\N
125	5	\N	114	159
125	2	50	\N	\N
126	5	\N	117	168
126	2	55	\N	\N
127	5	\N	2	2
127	2	12	\N	\N
128	5	\N	3	3
128	2	14	\N	\N
129	5	\N	5	5
129	2	16	\N	\N
130	5	\N	6	6
130	2	18	\N	\N
131	5	\N	8	11
131	2	24	\N	\N
132	5	\N	29	34
132	2	12	\N	\N
133	5	\N	31	36
133	2	14	\N	\N
134	5	\N	35	40
134	2	16	\N	\N
135	5	\N	37	42
135	2	18	\N	\N
136	5	\N	41	52
136	2	24	\N	\N
137	5	\N	55	62
137	2	12	\N	\N
138	5	\N	56	63
138	2	14	\N	\N
139	5	\N	58	65
139	2	16	\N	\N
140	5	\N	59	66
140	2	18	\N	\N
141	5	\N	61	71
141	2	24	\N	\N
142	5	\N	2	3
142	2	12	\N	\N
142	7	\N	3	8
143	5	\N	5	6
143	2	14	\N	\N
143	7	\N	4	10
144	5	\N	8	9
144	2	16	\N	\N
144	7	\N	6	12
145	5	\N	9	11
145	2	18	\N	\N
145	7	\N	8	16
146	5	\N	12	15
146	2	24	\N	\N
146	7	\N	10	20
147	5	\N	28	35
147	2	12	\N	\N
147	7	\N	26	46
148	5	\N	33	39
148	2	14	\N	\N
148	7	\N	28	50
149	5	\N	37	44
149	2	16	\N	\N
149	7	\N	23	52
150	5	\N	39	47
150	2	18	\N	\N
150	7	\N	37	64
151	5	\N	43	53
151	2	24	\N	\N
151	7	\N	39	80
152	5	\N	54	62
152	2	12	\N	\N
152	7	\N	65	100
153	5	\N	56	65
153	2	14	\N	\N
153	7	\N	60	110
154	5	\N	59	67
154	2	16	\N	\N
154	7	\N	69	118
155	5	\N	59	68
155	2	18	\N	\N
155	7	\N	50	145
156	5	\N	62	71
156	2	24	\N	\N
156	7	\N	83	149
157	1	\N	1	4
158	1	\N	2	6
159	1	\N	3	10
160	1	\N	4	8
161	1	\N	5	11
162	1	\N	3	18
163	1	\N	6	14
164	1	\N	3	23
165	1	\N	6	19
166	1	\N	8	22
167	1	\N	10	29
168	1	\N	11	26
169	1	\N	13	30
170	1	\N	10	42
171	1	\N	14	35
172	1	\N	10	50
173	1	\N	23	50
174	1	\N	21	41
175	1	\N	15	59
176	1	\N	12	52
177	1	\N	33	40
178	1	\N	15	63
179	1	\N	20	53
180	1	\N	10	68
181	5	\N	20	30
181	2	35	\N	\N
182	5	\N	30	40
182	2	30	\N	\N
183	5	\N	40	50
183	2	25	\N	\N
184	5	\N	50	60
184	2	20	\N	\N
185	1	\N	6	9
186	1	\N	9	16
187	1	\N	14	26
188	1	\N	6	12
189	1	\N	14	27
190	1	\N	20	42
191	1	\N	33	55
192	1	\N	14	32
193	1	\N	28	73
194	1	\N	25	87
195	1	\N	32	91
196	1	\N	26	40
197	2	16	\N	\N
197	3	\N	1	4
198	2	20	\N	\N
198	3	\N	3	9
199	2	24	\N	\N
199	3	\N	2	11
200	2	24	\N	\N
200	3	\N	4	15
201	2	16	\N	\N
201	3	\N	6	18
202	2	20	\N	\N
202	3	\N	10	26
203	2	24	\N	\N
203	3	\N	15	31
204	2	24	\N	\N
204	3	\N	19	36
205	2	26	\N	\N
205	3	\N	23	49
206	2	55	\N	\N
206	3	\N	37	53
207	2	36	\N	\N
207	3	\N	15	57
208	2	47	\N	\N
208	3	\N	31	47
209	5	\N	8	11
209	2	20	\N	\N
210	5	\N	4	15
210	2	20	\N	\N
211	5	\N	18	24
211	2	20	\N	\N
212	5	\N	12	28
212	2	20	\N	\N
213	5	\N	22	35
213	2	20	\N	\N
214	5	\N	52	62
214	2	20	\N	\N
215	5	\N	46	68
215	2	20	\N	\N
216	5	\N	67	81
216	2	20	\N	\N
217	5	\N	58	87
217	2	20	\N	\N
218	5	\N	73	98
218	2	20	\N	\N
219	5	\N	101	145
219	2	20	\N	\N
220	5	\N	98	147
220	2	20	\N	\N
221	5	\N	107	152
221	2	20	\N	\N
222	5	\N	103	155
222	2	20	\N	\N
223	5	\N	109	159
223	2	20	\N	\N
224	5	\N	2	3
224	2	12	\N	\N
225	5	\N	5	6
225	2	14	\N	\N
226	5	\N	8	9
226	2	16	\N	\N
227	5	\N	9	11
227	2	18	\N	\N
228	5	\N	12	15
228	2	24	\N	\N
229	5	\N	28	35
229	2	12	\N	\N
230	5	\N	33	39
230	2	14	\N	\N
231	5	\N	37	44
231	2	16	\N	\N
232	5	\N	39	47
232	2	18	\N	\N
233	5	\N	43	53
233	2	24	\N	\N
234	5	\N	54	62
234	2	12	\N	\N
235	5	\N	56	65
235	2	14	\N	\N
236	5	\N	59	67
236	2	16	\N	\N
237	5	\N	59	69
237	2	18	\N	\N
238	5	\N	62	71
238	2	24	\N	\N
239	5	\N	3	5
239	2	12	\N	\N
240	5	\N	8	11
240	2	18	\N	\N
241	5	\N	15	18
241	2	24	\N	\N
242	5	\N	23	26
242	2	30	\N	\N
243	5	\N	30	35
243	2	40	\N	\N
244	5	\N	9	27
244	2	20	\N	\N
245	5	\N	25	45
245	2	50	\N	\N
246	5	\N	33	36
246	2	40	\N	\N
247	5	\N	45	53
247	2	12	\N	\N
248	5	\N	52	62
248	2	18	\N	\N
249	5	\N	63	72
249	2	24	\N	\N
250	5	\N	75	84
250	2	30	\N	\N
251	5	\N	85	98
251	2	40	\N	\N
252	5	\N	54	86
252	2	20	\N	\N
253	5	\N	78	113
253	2	50	\N	\N
254	5	\N	60	125
254	2	40	\N	\N
255	5	\N	98	141
255	2	12	\N	\N
256	5	\N	101	145
256	2	18	\N	\N
257	5	\N	105	149
257	2	24	\N	\N
258	5	\N	110	145
258	2	30	\N	\N
259	5	\N	114	159
259	2	40	\N	\N
260	5	\N	101	154
260	2	20	\N	\N
261	5	\N	111	165
261	2	20	\N	\N
262	5	\N	100	157
262	2	40	\N	\N
263	4	60	\N	\N
264	4	50	\N	\N
265	4	40	\N	\N
266	4	40	\N	\N
267	4	80	\N	\N
268	4	60	\N	\N
269	4	50	\N	\N
270	4	40	\N	\N
271	4	20	\N	\N
272	4	80	\N	\N
273	4	100	\N	\N
274	4	90	\N	\N
275	4	80	\N	\N
276	4	75	\N	\N
277	4	80	\N	\N
280	2	24	\N	\N
280	6	1	\N	\N
280	3	\N	1	6
281	2	36	\N	\N
281	6	2	\N	\N
281	3	\N	5	8
282	2	60	\N	\N
282	6	1	\N	\N
282	3	\N	3	10
283	2	72	\N	\N
283	6	2	\N	\N
283	3	\N	7	16
284	2	30	\N	\N
284	6	3	\N	\N
284	3	\N	1	24
285	2	55	\N	\N
285	6	1	\N	\N
285	3	\N	19	29
286	2	60	\N	\N
286	6	2	\N	\N
286	1	\N	30	43
287	2	60	\N	\N
287	6	2	\N	\N
287	1	\N	38	58
288	2	24	\N	\N
288	6	1	\N	\N
288	3	\N	6	21
289	2	36	\N	\N
289	6	2	\N	\N
289	3	\N	13	25
290	2	60	\N	\N
290	6	1	\N	\N
290	3	\N	15	23
291	2	72	\N	\N
291	6	2	\N	\N
291	3	\N	20	31
292	2	30	\N	\N
292	6	3	\N	\N
292	3	\N	13	35
293	2	55	\N	\N
293	6	1	\N	\N
293	3	\N	35	58
294	2	60	\N	\N
294	6	2	\N	\N
294	1	\N	53	78
295	2	60	\N	\N
295	6	3	\N	\N
295	1	\N	61	99
296	2	29	\N	\N
296	6	1	\N	\N
296	3	\N	35	43
297	2	45	\N	\N
297	6	2	\N	\N
297	3	\N	32	58
298	2	60	\N	\N
298	6	1	\N	\N
298	3	\N	41	49
299	2	72	\N	\N
299	6	2	\N	\N
299	3	\N	43	53
300	2	65	\N	\N
300	6	3	\N	\N
300	3	\N	3	80
301	2	65	\N	\N
301	6	1	\N	\N
301	3	\N	50	61
302	2	60	\N	\N
302	6	2	\N	\N
302	1	\N	77	106
303	2	60	\N	\N
303	6	3	\N	\N
303	1	\N	33	180
304	5	\N	2	4
304	2	20	\N	\N
304	8	23	\N	\N
305	5	\N	4	8
305	2	20	\N	\N
305	8	25	\N	\N
306	5	\N	6	10
306	2	20	\N	\N
306	8	28	\N	\N
307	5	\N	10	16
307	2	20	\N	\N
307	8	30	\N	\N
308	5	\N	15	20
308	2	20	\N	\N
308	8	32	\N	\N
309	5	\N	38	48
309	2	20	\N	\N
309	8	23	\N	\N
310	5	\N	41	52
310	2	20	\N	\N
310	8	25	\N	\N
311	5	\N	44	55
311	2	20	\N	\N
311	8	28	\N	\N
312	5	\N	50	64
312	2	20	\N	\N
312	8	30	\N	\N
313	5	\N	58	70
313	2	20	\N	\N
313	8	32	\N	\N
314	5	\N	95	139
314	2	20	\N	\N
314	8	23	\N	\N
315	5	\N	96	141
315	2	20	\N	\N
315	8	25	\N	\N
316	5	\N	98	142
316	2	20	\N	\N
316	8	28	\N	\N
317	5	\N	100	146
317	2	20	\N	\N
317	8	30	\N	\N
318	5	\N	103	148
318	2	20	\N	\N
318	8	32	\N	\N
319	5	\N	8	12
319	2	20	\N	\N
319	9	40	\N	\N
320	5	\N	10	18
320	2	30	\N	\N
320	9	45	\N	\N
321	5	\N	16	26
321	2	40	\N	\N
321	9	50	\N	\N
322	5	\N	26	36
322	2	50	\N	\N
322	9	52	\N	\N
323	5	\N	30	40
323	2	60	\N	\N
323	9	55	\N	\N
324	5	\N	101	125
324	2	20	\N	\N
324	9	40	\N	\N
325	5	\N	113	137
325	2	30	\N	\N
325	9	45	\N	\N
326	5	\N	129	153
326	2	40	\N	\N
326	9	50	\N	\N
327	5	\N	144	168
327	2	50	\N	\N
327	9	52	\N	\N
328	5	\N	156	181
328	2	60	\N	\N
328	9	55	\N	\N
329	5	\N	126	158
329	2	45	\N	\N
329	9	60	\N	\N
330	5	\N	138	164
330	2	68	\N	\N
330	9	58	\N	\N
331	5	\N	154	172
331	2	55	\N	\N
331	9	55	\N	\N
332	5	\N	169	193
332	2	65	\N	\N
332	9	52	\N	\N
333	5	\N	182	225
333	2	90	\N	\N
333	9	51	\N	\N
334	2	50	\N	\N
334	6	3	\N	\N
334	1	\N	1	27
335	2	50	\N	\N
335	6	3	\N	\N
335	1	\N	6	21
336	2	65	\N	\N
336	6	2	\N	\N
336	1	\N	8	20
337	2	65	\N	\N
337	6	4	\N	\N
337	1	\N	18	39
338	2	55	\N	\N
338	6	5	\N	\N
338	1	\N	12	45
339	2	55	\N	\N
339	6	5	\N	\N
339	1	\N	15	36
340	2	50	\N	\N
340	6	3	\N	\N
340	1	\N	6	58
341	2	50	\N	\N
341	6	3	\N	\N
341	1	\N	14	53
342	2	65	\N	\N
342	6	2	\N	\N
342	1	\N	18	45
343	2	65	\N	\N
343	6	4	\N	\N
343	1	\N	34	75
344	2	55	\N	\N
344	6	5	\N	\N
344	1	\N	13	85
345	2	55	\N	\N
345	6	5	\N	\N
345	1	\N	30	70
346	2	50	\N	\N
346	6	3	\N	\N
346	1	\N	28	145
347	2	50	\N	\N
347	6	3	\N	\N
347	1	\N	17	165
348	2	65	\N	\N
348	6	2	\N	\N
348	1	\N	12	141
349	2	65	\N	\N
349	6	4	\N	\N
349	1	\N	33	150
350	2	55	\N	\N
350	6	5	\N	\N
350	1	\N	46	127
351	2	55	\N	\N
351	6	5	\N	\N
351	1	\N	46	127
352	2	50	\N	\N
352	6	1	\N	\N
352	3	\N	6	11
353	2	60	\N	\N
353	6	2	\N	\N
353	3	\N	8	18
354	2	70	\N	\N
354	6	2	\N	\N
354	3	\N	10	17
355	2	50	\N	\N
355	6	1	\N	\N
355	3	\N	13	24
356	2	60	\N	\N
356	6	2	\N	\N
356	3	\N	14	36
357	2	70	\N	\N
357	6	2	\N	\N
357	3	\N	10	17
358	2	50	\N	\N
358	6	1	\N	\N
358	3	\N	40	52
359	2	60	\N	\N
359	6	2	\N	\N
359	3	\N	45	54
360	2	70	\N	\N
360	6	2	\N	\N
360	3	\N	37	43
361	5	\N	4	6
361	2	12	\N	\N
361	9	30	\N	\N
361	10	20	\N	\N
361	11	25	\N	\N
361	8	20	\N	\N
361	12	25	\N	\N
361	13	25	\N	\N
362	5	\N	8	10
362	2	16	\N	\N
362	9	35	\N	\N
362	10	25	\N	\N
362	11	30	\N	\N
362	8	25	\N	\N
362	12	30	\N	\N
362	13	30	\N	\N
363	5	\N	12	14
363	2	24	\N	\N
363	9	42	\N	\N
363	10	32	\N	\N
363	11	37	\N	\N
363	8	32	\N	\N
363	12	37	\N	\N
363	13	37	\N	\N
364	5	\N	16	18
364	2	30	\N	\N
364	9	38	\N	\N
364	10	28	\N	\N
364	11	33	\N	\N
364	8	28	\N	\N
364	12	33	\N	\N
364	13	33	\N	\N
365	5	\N	15	25
365	2	40	\N	\N
365	9	40	\N	\N
365	10	30	\N	\N
365	11	35	\N	\N
365	8	30	\N	\N
365	12	35	\N	\N
365	13	35	\N	\N
366	5	\N	22	25
366	2	60	\N	\N
366	9	54	\N	\N
366	10	44	\N	\N
366	11	49	\N	\N
366	8	44	\N	\N
366	12	49	\N	\N
366	13	49	\N	\N
367	5	\N	10	30
367	2	40	\N	\N
367	9	50	\N	\N
367	10	40	\N	\N
367	11	45	\N	\N
367	8	40	\N	\N
367	12	45	\N	\N
367	13	45	\N	\N
368	5	\N	30	35
368	2	40	\N	\N
368	9	46	\N	\N
368	10	36	\N	\N
368	11	41	\N	\N
368	8	36	\N	\N
368	12	41	\N	\N
368	13	41	\N	\N
369	5	\N	41	49
369	2	12	\N	\N
369	9	40	\N	\N
369	10	30	\N	\N
369	11	35	\N	\N
369	8	30	\N	\N
369	12	35	\N	\N
369	13	35	\N	\N
370	5	\N	47	55
370	2	16	\N	\N
370	9	42	\N	\N
370	10	32	\N	\N
370	11	37	\N	\N
370	8	32	\N	\N
370	12	37	\N	\N
370	13	37	\N	\N
371	5	\N	53	61
371	2	24	\N	\N
371	9	44	\N	\N
371	10	34	\N	\N
371	11	39	\N	\N
371	8	34	\N	\N
371	12	39	\N	\N
371	13	39	\N	\N
372	5	\N	59	67
372	2	30	\N	\N
372	9	48	\N	\N
372	10	38	\N	\N
372	11	43	\N	\N
372	8	38	\N	\N
372	12	43	\N	\N
372	13	43	\N	\N
373	5	\N	68	78
373	2	40	\N	\N
373	9	47	\N	\N
373	10	37	\N	\N
373	11	42	\N	\N
373	8	37	\N	\N
373	12	42	\N	\N
373	13	42	\N	\N
374	5	\N	68	78
374	2	60	\N	\N
374	9	54	\N	\N
374	10	44	\N	\N
374	11	49	\N	\N
374	8	44	\N	\N
374	12	49	\N	\N
374	13	49	\N	\N
375	5	\N	50	151
375	2	40	\N	\N
375	9	50	\N	\N
375	10	40	\N	\N
375	11	45	\N	\N
375	8	40	\N	\N
375	12	45	\N	\N
375	13	45	\N	\N
376	5	\N	80	93
376	2	40	\N	\N
376	9	46	\N	\N
376	10	36	\N	\N
376	11	41	\N	\N
376	8	36	\N	\N
376	12	41	\N	\N
376	13	41	\N	\N
377	5	\N	95	110
377	2	88	\N	\N
377	9	52	\N	\N
377	10	42	\N	\N
377	11	47	\N	\N
377	8	42	\N	\N
377	12	47	\N	\N
377	13	47	\N	\N
378	5	\N	108	123
378	2	84	\N	\N
378	9	50	\N	\N
378	10	40	\N	\N
378	11	45	\N	\N
378	8	40	\N	\N
378	12	45	\N	\N
378	13	45	\N	\N
379	5	\N	119	135
379	2	82	\N	\N
379	9	54	\N	\N
379	10	44	\N	\N
379	11	49	\N	\N
379	8	44	\N	\N
379	12	49	\N	\N
379	13	49	\N	\N
380	5	\N	133	148
380	2	86	\N	\N
380	9	52	\N	\N
380	10	42	\N	\N
380	11	47	\N	\N
380	8	42	\N	\N
380	12	47	\N	\N
380	13	47	\N	\N
381	5	\N	147	163
381	2	83	\N	\N
381	9	50	\N	\N
381	10	40	\N	\N
381	11	45	\N	\N
381	8	40	\N	\N
381	12	45	\N	\N
381	13	45	\N	\N
382	5	\N	145	161
382	2	92	\N	\N
382	9	54	\N	\N
382	10	44	\N	\N
382	11	49	\N	\N
382	8	44	\N	\N
382	12	49	\N	\N
382	13	49	\N	\N
383	5	\N	158	173
383	2	74	\N	\N
383	9	50	\N	\N
383	10	40	\N	\N
383	11	45	\N	\N
383	8	40	\N	\N
383	12	45	\N	\N
383	13	45	\N	\N
384	5	\N	153	170
384	2	100	\N	\N
384	9	54	\N	\N
384	10	44	\N	\N
384	11	49	\N	\N
384	8	44	\N	\N
384	12	49	\N	\N
384	13	49	\N	\N
385	2	20	\N	\N
385	3	\N	2	5
386	2	30	\N	\N
386	3	\N	3	8
387	2	35	\N	\N
387	3	\N	4	10
388	2	40	\N	\N
388	3	\N	5	12
389	2	50	\N	\N
389	3	\N	8	18
390	2	20	\N	\N
390	3	\N	8	21
391	2	30	\N	\N
391	3	\N	10	26
392	2	35	\N	\N
392	3	\N	11	29
393	2	40	\N	\N
393	3	\N	13	32
394	2	50	\N	\N
394	3	\N	18	42
395	2	20	\N	\N
395	3	\N	21	46
396	2	30	\N	\N
396	3	\N	18	50
397	2	35	\N	\N
397	3	\N	23	55
398	2	40	\N	\N
398	3	\N	12	66
399	2	50	\N	\N
399	3	\N	30	53
400	2	30	\N	\N
400	6	4	\N	\N
400	1	\N	3	15
401	2	35	\N	\N
401	6	4	\N	\N
401	1	\N	9	15
402	2	28	\N	\N
402	6	5	\N	\N
402	1	\N	7	17
403	2	28	\N	\N
403	6	5	\N	\N
403	1	\N	15	23
404	2	25	\N	\N
404	6	5	\N	\N
404	1	\N	14	63
405	2	30	\N	\N
405	6	4	\N	\N
405	1	\N	10	37
406	2	35	\N	\N
406	6	4	\N	\N
406	1	\N	19	37
407	2	28	\N	\N
407	6	5	\N	\N
407	1	\N	16	40
408	2	28	\N	\N
408	6	5	\N	\N
408	1	\N	29	59
409	2	25	\N	\N
409	6	5	\N	\N
409	1	\N	27	114
410	2	30	\N	\N
410	6	4	\N	\N
410	1	\N	35	119
411	2	35	\N	\N
411	6	4	\N	\N
411	1	\N	29	144
412	2	28	\N	\N
412	6	5	\N	\N
412	1	\N	42	92
413	2	28	\N	\N
413	6	5	\N	\N
413	1	\N	18	155
414	2	25	\N	\N
414	6	5	\N	\N
414	1	\N	33	178
415	2	20	\N	\N
415	1	\N	1	5
416	2	30	\N	\N
416	1	\N	2	8
417	2	35	\N	\N
417	1	\N	4	12
418	2	40	\N	\N
418	1	\N	6	13
419	2	50	\N	\N
419	1	\N	12	28
420	2	20	\N	\N
420	1	\N	6	21
421	2	30	\N	\N
421	1	\N	8	26
422	2	35	\N	\N
422	1	\N	11	32
423	2	40	\N	\N
423	1	\N	14	34
424	2	50	\N	\N
424	1	\N	24	58
425	2	20	\N	\N
425	1	\N	69	85
426	2	30	\N	\N
426	1	\N	75	107
427	2	35	\N	\N
427	1	\N	80	93
428	2	40	\N	\N
428	1	\N	65	108
429	2	50	\N	\N
429	1	\N	83	99
430	2	24	\N	\N
430	6	1	\N	\N
430	3	\N	2	7
431	2	22	\N	\N
431	6	1	\N	\N
431	3	\N	2	6
432	2	32	\N	\N
432	6	1	\N	\N
432	3	\N	3	8
433	2	32	\N	\N
433	6	1	\N	\N
433	3	\N	9	17
434	2	20	\N	\N
434	6	2	\N	\N
434	3	\N	5	15
435	2	32	\N	\N
435	6	1	\N	\N
435	3	\N	7	14
436	2	44	\N	\N
436	6	1	\N	\N
436	3	\N	3	19
437	2	44	\N	\N
437	6	1	\N	\N
437	3	\N	8	20
438	2	44	\N	\N
438	6	3	\N	\N
438	3	\N	2	9
438	1	\N	8	17
439	2	50	\N	\N
439	6	3	\N	\N
439	3	\N	5	12
439	1	\N	13	30
440	2	50	\N	\N
440	6	3	\N	\N
440	3	\N	3	16
440	1	\N	9	28
441	2	40	\N	\N
441	6	2	\N	\N
441	3	\N	7	19
441	1	\N	20	28
442	2	50	\N	\N
442	6	3	\N	\N
442	3	\N	9	15
442	1	\N	13	26
443	2	50	\N	\N
443	6	3	\N	\N
443	3	\N	12	20
443	1	\N	25	42
444	2	24	\N	\N
444	6	1	\N	\N
444	3	\N	8	22
445	2	22	\N	\N
445	6	1	\N	\N
445	3	\N	8	21
446	2	32	\N	\N
446	6	1	\N	\N
446	3	\N	10	24
447	2	32	\N	\N
447	6	1	\N	\N
447	3	\N	16	35
448	2	20	\N	\N
448	6	1	\N	\N
448	3	\N	13	35
449	2	32	\N	\N
449	6	1	\N	\N
449	3	\N	16	34
450	2	44	\N	\N
450	6	1	\N	\N
450	3	\N	10	42
451	2	44	\N	\N
451	6	1	\N	\N
451	3	\N	18	43
452	2	44	\N	\N
452	6	3	\N	\N
452	3	\N	8	26
452	1	\N	18	40
453	2	50	\N	\N
453	6	3	\N	\N
453	3	\N	13	30
453	1	\N	26	61
454	2	50	\N	\N
454	6	3	\N	\N
454	3	\N	10	37
454	1	\N	19	58
455	2	40	\N	\N
455	6	2	\N	\N
455	3	\N	14	40
455	1	\N	39	60
456	2	50	\N	\N
456	6	3	\N	\N
456	3	\N	19	35
456	1	\N	29	54
457	2	50	\N	\N
457	6	3	\N	\N
457	3	\N	24	40
457	1	\N	47	80
458	2	24	\N	\N
458	6	1	\N	\N
458	3	\N	31	59
459	2	22	\N	\N
459	6	1	\N	\N
459	3	\N	26	46
460	2	32	\N	\N
460	6	1	\N	\N
460	3	\N	33	45
461	2	32	\N	\N
461	6	1	\N	\N
461	3	\N	28	68
462	6	2	\N	\N
462	3	\N	31	35
463	2	32	\N	\N
463	6	1	\N	\N
463	3	\N	37	53
464	2	44	\N	\N
464	6	2	\N	\N
464	3	\N	5	77
465	2	44	\N	\N
465	6	2	\N	\N
465	3	\N	40	50
466	2	44	\N	\N
466	6	3	\N	\N
466	3	\N	20	56
466	1	\N	50	94
467	2	100	\N	\N
467	6	3	\N	\N
467	3	\N	22	62
467	1	\N	67	96
468	2	50	\N	\N
468	6	3	\N	\N
468	3	\N	15	75
468	1	\N	55	118
469	2	40	\N	\N
469	6	3	\N	\N
469	3	\N	24	54
469	1	\N	71	83
470	2	50	\N	\N
470	6	3	\N	\N
470	3	\N	26	70
470	1	\N	61	121
471	2	50	\N	\N
471	6	3	\N	\N
471	3	\N	25	65
471	1	\N	58	115
472	4	160	\N	\N
473	4	160	\N	\N
474	4	130	\N	\N
475	4	130	\N	\N
476	4	160	\N	\N
477	4	160	\N	\N
478	4	130	\N	\N
479	4	130	\N	\N
480	4	200	\N	\N
481	4	200	\N	\N
482	4	180	\N	\N
483	4	180	\N	\N
484	2	15	\N	\N
484	3	\N	2	4
485	2	15	\N	\N
485	3	\N	2	8
486	2	15	\N	\N
486	3	\N	3	7
487	2	15	\N	\N
487	3	\N	5	11
488	2	15	\N	\N
488	3	\N	8	18
489	2	15	\N	\N
489	3	\N	8	24
490	2	15	\N	\N
490	3	\N	10	22
491	2	15	\N	\N
491	3	\N	13	29
492	2	22	\N	\N
492	3	\N	18	33
493	2	14	\N	\N
493	3	\N	20	42
494	2	17	\N	\N
494	3	\N	10	31
495	2	18	\N	\N
495	3	\N	22	28
\.


--
-- Data for Name: itemcategory; Type: TABLE DATA; Schema: public; Owner: diablo2
--

COPY itemcategory (itemcatid, name) FROM stdin;
1	Amazon
2	Bow
3	Spear
4	Javelin
5	Armor
6	Assassin
7	Axe
8	Helm
9	Belts
10	Boots
11	Crossbow
12	Dagger
13	Gloves
14	Ring
15	Amulet
16	Mace
17	Shield
18	Polearm
19	Scepter
20	Sorceress
21	Staves
22	Sword
23	Throwing
24	Wands
25	Druid
26	Necromancer
27	Charm
28	Jewel
\.


--
-- Data for Name: itemproperty; Type: TABLE DATA; Schema: public; Owner: diablo2
--

COPY itemproperty (itempropid, name) FROM stdin;
1	Two-handed Damage
2	Durability
3	One-handed Damage
4	Stack size
5	Defense
6	Range
7	Kick Damage
8	Blocking% Necromancer
9	Blocking% Paladin
10	Blocking% Druid
11	Blocking% Barbarian
12	Blocking% Assassin
13	Blocking% Amazon
14	% Enhanced Damage
15	Magic Damage
16	% Increased Attack Rate
17	Magic Damage Reduced by
18	% Enhanced Defense
19	% Slows Target by
20	Attacker Takes Lightning Damage of
21	Lightning Absorb
22	% Lightning Resist
23	% Fire Absorb
24	% Heal Stamina Plus
25	Maximum Stamina
26	Life
27	% Extra Gold from Monsters
28	Maximum Damage
29	% Chance of Open Wounds
30	Lightning Damage
31	% Better Chance of Getting Magic Items
32	Damage
33	% Mana Stolen per Hit
34	Dexterity
35	Strength
36	% Requirements
37	% Life Stolen per Hit
38	% Stamina Drain
39	Attack Rating
40	% Chance of Crushing Blow
41	% Hit Causes Monster to Flee
42	Cold Damage
43	Cold Duration
44	% Deadly Strike
45	Replenish Life
46	% Regenerate Mana
47	% Damage to Undead
48	% Increased Attack Speed
49	% Bonus to Attack Rating
51	Light Radius
52	% Faster Run/Walk
54	% Cold Resist
55	% Poison Resist
56	Fire Skills
57	Fire Damage
58	Poison Damage over 6 Seconds
59	Mana
61	% Damage to Demons
62	Attack Rating against Demons
63	Life after each Demon Kill
64	Druid Skill Levels
65	% Defense
66	% Increased Chance of Blocking
67	% Fire Resist
68	Mana after each Kill
69	% Faster Cast Rate
70	Poison Damage over 4 Seconds
71	% Maximum Poison Resist
73	Damage Reduced by
76	% Maximum Cold Resist
77	Attacker Takes Damage of
78	% Damage Taken Goes to Mana
79	All Skill Levels
80	% Increase Maximum Mana
82	% Cold Absorb
83	All Resistances
86	% Faster Hit Recovery
87	Maximum Fire Resist
89	Defense vs. Missile
90	Vitality
91	Energy
94	% Poison Length Reduced by
95	Poison Damage over 3 Seconds
96	Paladin Skill Levels
476	Repairs 1 durability every N seconds
477	Replenishes Quantity
100	Necromancer Skill Levels
102	% Maximum Lightning Resist
487	Level Sanctuary Aura When Equipped
105	Sorceress Skill Levels
106	% Faster Block Rate
107	Minimum Damage
108	% Target Defense
110	Hit Blinds Target
111	Monster Defense per Hit
113	Amazon Skill Levels
117	Freezes Target
121	Poison Damage over 8 Seconds
123	Barbarian Skill Levels
127	Assassin Skill Levels
138	% Slower Stamina Drain
142	Defense vs. Melee
143	Attack Rating against Undead
144	% Damage Reduced by
148	% Maximum Mana
179	All Class Skill Levels
201	Poison Damage over 10 Seconds
210	Holy Bolt When Struck
254	% Chance of Deadly Strike
274	% Enhanced Maximum Damage
280	% Increase Maximum Life
283	Maximum Fire Damage
287	Poison Damage over 2 Seconds
245	% Maximum Life
319	% Lightning Absorb
324	Fire Absorb
478	Prevent Monster Heal
479	Knockback
480	Ignore Target's Defense
481	Cannot Be Frozen
482	Fires Magic Arrows
333	All Attributes
334	% To Experience Gained
483	Indestructible
336	% Reduces All Vendor Prices
484	Fires Explosive Arrows or Bolts
338	To Random Charachter Class Skills
485	Half Freeze Duration
488	Slain Monsters Rest In Peace
341	% To Fire Skill Damage
342	% To Enemy Fire Resistance
489	Fires Explosive Arrows
344	% To Cold Skill Damage
345	% To Enemy Cold Resistance
490	Ethereal
347	% To Lightning Skill Damage
348	% To Enemy Lightning Resistance
491	Fires Explosive Bolts
350	% To Poison Skill Damage
351	% To Enemy Poison Resistance
355	% To Lightning Cold Resistance
357	Poison Damage
358	% To Poison Cold Resistance
359	Faster Cast Rate
362	% Enemy Lightning Resistance
379	Feral Rage
380	Lycanthropy
381	Werewolf
387	% Fire Skill Damage
388	% Lightning Skill Damage
389	% Cold Skill Damage
396	Hydra
397	% Maximum Fire Resist
400	Cold Absorb
409	Piercing Attack
412	Sockets
415	% Damaged Reduced By
416	Random Sorceress Skill
418	Repairs 1 Durability every N Seconds
426	Life After Each Kill
434	% Increased Maximum Mana
486	All Skills
442	Guided Arrow
455	% Reanimate as: Returned
464	Artic Blast
465	Inferno
468	Increased Stack Size
\.


--
-- Data for Name: itemset; Type: TABLE DATA; Schema: public; Owner: diablo2
--

COPY itemset (itemsetid, name) FROM stdin;
1	Angelic Raiment
2	Arcanna's Tricks
3	Arctic Gear
5	Cathan's Traps
6	Civerb's Vestments
7	Cleglaw's Brace
8	Death's Disguise
9	Hsaru's Defense
10	Infernal Tools
11	Iratha's Finery
12	Isenhart's Armory
13	Milabrega's Regalia
14	Sigon's Complete Steel
15	Tancred's Battlegear
16	Vidala's Rig
17	Aldur's Watchtower
18	Bul-Kathos' Children
19	Cow King's Leathers
20	The Disciple
21	Griswold's Legacy
22	Heaven's Brethren
23	Hwanin's Majesty
24	Immortal King
25	M'avina's Battle Hymn
26	Natalya's Odium
27	Naj's Ancient Vestige
28	Orphan's Call
29	Sander's Folly
30	Sazabi's Grand Tribute
31	Tal Rasha's Wrappings
32	Trang-Oul's Avatar
4	Berserker's Arsenal
\.


--
-- Data for Name: itemtype; Type: TABLE DATA; Schema: public; Owner: diablo2
--

COPY itemtype (itemtypeid, name, itemcatid, itemclasscatid, "level", tc, sockets, req_level, req_str, req_dex) FROM stdin;
1	Stag Bow	1	2	0	18	5	14	30	45
2	Reflex Bow	1	2	0	27	5	20	35	60
3	Maiden Spear	1	3	0	18	6	14	54	40
4	Maiden Pike	1	3	0	27	6	20	63	52
5	Maiden Javelin	1	4	0	24	\N	17	33	47
6	Ashwood Bow	1	2	1	39	5	29	56	77
7	Ceremonial Bow	1	2	1	36	5	35	73	110
8	Ceremonial Spear	1	3	1	45	6	32	101	80
9	Ceremonial Pike	1	3	1	51	6	38	115	98
10	Ceremonial Javelin	1	4	1	36	\N	26	25	109
11	Matriarchal Bow	1	2	2	54	5	39	87	187
12	Grand Matron Bow	1	2	2	78	5	58	108	152
13	Matriarchal Spear	1	3	2	63	6	45	114	142
14	Matriarchal Pike	1	3	2	81	6	60	132	149
15	Matriarchal Javelin	1	4	2	66	\N	48	107	151
16	Quilted Armor	5	\N	0	3	2	\N	12	\N
17	Leather Armor	5	\N	0	3	2	\N	15	\N
18	Hard Leather Armor	5	\N	0	6	2	\N	20	\N
19	Studded Leather	5	\N	0	9	2	\N	27	\N
20	Ring Mail	5	\N	0	12	3	\N	44	\N
21	Scale Mail	5	\N	0	15	2	\N	44	\N
22	Breast Plate	5	\N	0	18	3	\N	30	\N
23	Chain Mail	5	\N	0	15	2	\N	48	\N
24	Splint Mail	5	\N	0	21	2	\N	51	\N
25	Light Plate	5	\N	0	36	3	\N	41	\N
26	Field Plate	5	\N	0	30	2	\N	55	\N
27	Plate Mail	5	\N	0	24	2	\N	65	\N
28	Gothic Plate	5	\N	0	33	4	\N	70	\N
29	Full Plate Mail	5	\N	0	39	4	\N	80	\N
30	Ancient Armor	5	\N	0	42	4	\N	100	\N
31	Ghost Armor	5	\N	1	36	2	22	38	\N
32	Serpentskin Armor	5	\N	1	36	2	24	43	\N
33	Demonhide Armor	5	\N	1	39	2	25	50	\N
34	Trellised Armor	5	\N	1	42	2	25	61	\N
35	Linked Mail	5	\N	1	42	3	25	74	\N
36	Tigulated Mail	5	\N	1	45	3	25	86	\N
37	Cuirass	5	\N	1	48	3	25	65	\N
38	Mesh Armor	5	\N	1	45	3	25	92	\N
39	Russet Armor	5	\N	1	51	3	25	97	\N
40	Mage Plate	5	\N	1	60	3	25	55	\N
41	Sharktooth Armor	5	\N	1	57	3	25	103	\N
42	Templar Coat	5	\N	1	54	3	25	118	\N
43	Embossed Plate	5	\N	1	60	4	25	125	\N
44	Chaos Armor	5	\N	1	63	4	25	140	\N
45	Ornate Plate	5	\N	1	66	4	25	170	\N
46	Dusk Shroud	5	\N	2	66	4	49	77	\N
47	Wyrmhide	5	\N	2	69	4	50	84	\N
48	Scarab Husk	5	\N	2	69	4	51	95	\N
49	Wire Fleece	5	\N	2	72	4	53	111	\N
50	Diamond Mail	5	\N	2	72	4	54	131	\N
51	Loricated Mail	5	\N	2	75	4	55	149	\N
52	Great Hauberk	5	\N	2	75	4	56	118	\N
53	Boneweave	5	\N	2	63	4	47	158	\N
54	Balrog Skin	5	\N	2	78	4	57	165	\N
55	Archon Plate	5	\N	2	84	4	63	103	\N
56	Kraken Shell	5	\N	2	81	4	61	174	\N
57	Hellforge Plate	5	\N	2	78	4	59	196	\N
58	Lacquered Plate	5	\N	2	84	4	62	208	\N
59	Shadow Plate	5	\N	2	87	4	64	230	\N
60	Sacred Armor	5	\N	2	90	4	66	232	\N
61	Katar	6	\N	0	3	2	\N	20	20
62	Wrist Blade	6	\N	0	9	2	\N	33	33
63	Hatchet Hands	6	\N	0	12	2	\N	37	37
64	Cestus	6	\N	0	15	2	\N	42	42
65	Claws	6	\N	0	18	3	\N	46	46
66	Blade Talons	6	\N	0	21	3	\N	50	50
67	Scissors Katar	6	\N	0	24	3	\N	55	55
68	Quhab	6	\N	1	30	3	21	57	57
69	Wrist Spike	6	\N	1	33	2	24	66	66
70	Fascia	6	\N	1	36	2	27	69	69
71	Hand Scythe	6	\N	1	42	2	30	73	73
72	Greater Claws	6	\N	1	45	3	33	79	79
73	Greater Talons	6	\N	1	51	3	37	79	79
74	Scissors Quhab	6	\N	1	54	3	40	82	82
75	Suwayyah	6	\N	2	60	3	44	99	99
76	Wrist Sword	6	\N	2	63	2	46	105	105
77	War Fist	6	\N	2	69	2	51	108	108
78	Battle Cestus	6	\N	2	75	2	54	110	110
79	Feral Claws	6	\N	2	78	3	58	113	113
80	Runic Talons	6	\N	2	81	3	60	115	115
81	Scissors Suwayyah	6	\N	2	87	3	64	118	118
82	Hand Axe	7	\N	0	3	2	\N	\N	\N
83	Axe	7	\N	0	9	4	\N	32	\N
84	Double Axe	7	\N	0	15	5	\N	43	\N
85	Military Pick	7	\N	0	21	6	\N	49	33
86	War Axe	7	\N	0	27	6	\N	67	\N
87	Large Axe	7	\N	0	6	4	\N	35	\N
88	Broad Axe	7	\N	0	12	5	\N	48	\N
89	Battle Axe	7	\N	0	18	5	\N	54	\N
90	Great Axe	7	\N	0	24	6	\N	63	39
91	Giant Axe	7	\N	0	27	6	\N	70	\N
92	Hatchet	7	\N	1	33	2	19	25	25
93	Cleaver	7	\N	1	36	4	22	68	\N
94	Twin Axe	7	\N	1	39	5	25	85	\N
95	Crowbill	7	\N	1	45	6	25	94	70
96	Naga	7	\N	1	48	6	25	121	\N
97	Military Axe	7	\N	1	36	4	25	73	\N
98	Bearded Axe	7	\N	1	39	5	25	92	\N
99	Tabar	7	\N	1	42	5	25	101	\N
100	Gothic Axe	7	\N	1	33	6	25	115	79
101	Ancient Axe	7	\N	1	51	6	25	125	\N
102	Tomahawk	7	\N	2	54	2	40	125	67
103	Small Crescent	7	\N	2	63	4	45	115	83
104	Ettin Axe	7	\N	2	72	5	52	145	45
105	War Spike	7	\N	2	81	5	59	133	45
106	Berserker Axe	7	\N	2	87	6	64	138	59
107	Feral Axe	7	\N	2	57	4	42	196	\N
108	Silver-Edged Axe	7	\N	2	66	5	48	166	65
109	Decapitator	7	\N	2	75	5	54	189	33
110	Champion Axe	7	\N	2	84	5	61	167	59
111	Glorious Axe	7	\N	2	90	6	66	164	55
112	Jawbone Cap	8	\N	0	6	3	3	25	\N
113	Fanged Helm	8	\N	0	9	3	6	35	\N
114	Horned Helm	8	\N	0	18	3	12	45	\N
115	Assault Helmet	8	\N	0	21	3	15	55	\N
116	Avenger Guard	8	\N	0	24	3	18	65	\N
117	Jawbone Visor	8	\N	1	33	3	25	58	\N
118	Lion Helm	8	\N	1	39	3	29	73	\N
119	Rage Mask	8	\N	1	45	3	29	88	\N
120	Savage Helmet	8	\N	1	51	3	32	103	\N
121	Slayer Guard	8	\N	1	54	3	40	118	\N
122	Carnage Helm	8	\N	2	60	3	45	106	\N
123	Fury Visor	8	\N	2	66	3	49	129	\N
124	Destroyer Helm	8	\N	2	75	3	54	151	\N
125	Conqueror Crown	8	\N	2	81	3	60	174	\N
126	Guardian Crown	8	\N	2	87	3	65	196	\N
127	Sash	9	\N	0	3	\N	\N	\N	\N
128	Light Belt	9	\N	0	9	\N	\N	\N	\N
129	Belt	9	\N	0	12	\N	\N	25	\N
130	Heavy Belt	9	\N	0	21	\N	\N	45	\N
131	Plated Belt	9	\N	0	27	\N	\N	60	\N
132	Demonhide Sash	9	\N	1	36	\N	24	20	\N
133	Sharkskin Belt	9	\N	1	39	\N	25	20	\N
134	Mesh Belt	9	\N	1	45	\N	25	58	\N
135	Battle Belt	9	\N	1	51	\N	25	88	\N
136	War Belt	9	\N	1	54	\N	25	110	\N
137	Spiderweb Sash	9	\N	2	63	\N	46	50	\N
138	Vampirefang Belt	9	\N	2	69	\N	51	50	\N
139	Mithril Coil	9	\N	2	75	\N	56	106	\N
140	Troll Belt	9	\N	2	84	\N	62	151	\N
141	Colossus Girdle	9	\N	2	90	\N	67	185	\N
142	Boots	10	\N	0	3	\N	\N	\N	\N
143	Heavy Boots	10	\N	0	9	\N	\N	18	\N
144	Chain Boots	10	\N	0	12	\N	\N	30	\N
145	Light Plated Boots	10	\N	0	21	\N	\N	50	\N
146	Greaves	10	\N	0	27	\N	\N	70	\N
147	Demonhide Boots	10	\N	1	36	\N	24	20	\N
148	Sharkskin Boots	10	\N	1	39	\N	25	47	\N
149	Mesh Boots	10	\N	1	45	\N	25	65	\N
150	Battle Boots	10	\N	1	51	\N	25	95	\N
151	War Boots	10	\N	1	54	\N	25	125	\N
152	Wyrmhide Boots	10	\N	2	60	\N	45	50	\N
153	Scarabshell Boots	10	\N	2	66	\N	49	91	\N
154	Boneweave Boots	10	\N	2	72	\N	65	118	\N
155	Mirrored Boots	10	\N	2	81	\N	60	163	\N
156	Myrmidon Greaves	10	\N	2	87	\N	65	208	\N
157	Short Bow	2	\N	0	3	3	\N	\N	15
158	Hunter's Bow	2	\N	0	6	4	\N	\N	28
159	Long Bow	2	\N	0	9	5	\N	22	19
160	Composite Bow	2	\N	0	12	4	\N	22	19
161	Short Battle Bow	2	\N	0	18	5	\N	30	40
162	Long Battle Bow	2	\N	0	24	6	\N	40	50
163	Short War Bow	2	\N	0	27	5	\N	35	55
164	Long War Bow	2	\N	0	33	6	\N	50	65
165	Edge Bow	2	\N	1	30	3	18	25	43
166	Razor Bow	2	\N	1	33	4	21	25	62
167	Cedar Bow	2	\N	1	36	5	23	53	49
168	Double Bow	2	\N	1	39	4	25	58	73
169	Short Siege Bow	2	\N	1	45	5	25	65	80
170	Large Siege Bow	2	\N	1	42	6	25	80	95
171	Rune Bow	2	\N	1	51	5	25	73	103
172	Gothic Bow	2	\N	1	54	6	25	95	118
173	Spider Bow	2	\N	2	57	3	41	64	143
174	Blade Bow	2	\N	2	60	4	45	76	119
175	Shadow Bow	2	\N	2	63	5	47	52	188
176	Great Bow	2	\N	2	69	4	51	121	107
177	Diamond Bow	2	\N	2	72	5	54	89	132
178	Crusader Bow	2	\N	2	78	6	57	97	121
179	Ward Bow	2	\N	2	81	5	60	72	146
180	Hydra Bow	2	\N	2	87	6	63	134	167
181	Circlet	8	\N	0	24	2	16	\N	\N
182	Coronet	8	\N	0	54	2	39	\N	\N
183	Tiara	8	\N	0	72	3	52	\N	\N
184	Diadem	8	\N	0	87	3	64	\N	\N
185	Light Crossbow	11	\N	0	6	3	\N	21	27
186	Crossbow	11	\N	0	15	4	\N	40	33
187	Heavy Crossbow	11	\N	0	24	6	\N	60	40
188	Repeating Crossbow	11	\N	0	33	5	\N	40	50
189	Arbalest	11	\N	1	36	3	22	52	61
190	Siege Crossbow	11	\N	1	42	4	25	80	70
191	Ballista	11	\N	1	48	6	25	110	80
192	Chu-Ko-Nu	11	\N	1	54	5	25	80	95
193	Pellet Bow	11	\N	2	57	3	42	83	155
194	Gorgon Crossbow	11	\N	2	69	4	50	117	105
195	Colossus Crossbow	11	\N	2	75	6	56	163	77
196	Demon Crossbow	11	\N	2	84	5	63	141	98
197	Dagger	12	\N	0	3	1	\N	\N	\N
198	Dirk	12	\N	0	9	1	\N	\N	25
199	Kris	12	\N	0	18	3	\N	\N	45
200	Blade	12	\N	0	24	2	\N	35	51
201	Poignard	12	\N	1	33	1	19	25	\N
202	Rondel	12	\N	1	36	1	24	25	58
203	Cinquedeas	12	\N	1	42	3	25	25	88
204	Stiletto	12	\N	1	48	2	25	73	97
205	Bone Knife	12	\N	2	60	1	43	38	75
206	Mithril Point	12	\N	2	72	1	52	55	98
207	Fanged Knife	12	\N	2	84	3	62	52	86
208	Legend Spike	12	\N	2	90	2	66	65	67
224	Leather Gloves	13	\N	0	3	\N	\N	\N	\N
225	Heavy Gloves	13	\N	0	9	\N	\N	\N	\N
226	Chain Gloves	13	\N	0	12	\N	\N	25	\N
227	Light Gauntlets	13	\N	0	21	\N	\N	45	\N
228	Gauntlets	13	\N	0	27	\N	\N	60	\N
229	Demonhide Gloves	13	\N	1	33	\N	24	20	\N
230	Sharkskin Gloves	13	\N	1	39	\N	25	20	\N
231	Heavy Bracers	13	\N	1	45	\N	25	58	\N
232	Battle Gauntlets	13	\N	1	51	\N	25	88	\N
233	War Gauntlets	13	\N	1	54	\N	25	110	\N
234	Bramble Mitts	13	\N	2	57	\N	42	50	\N
235	Vampirebone Gloves	13	\N	2	63	\N	47	50	\N
236	Vambraces	13	\N	2	69	\N	51	106	\N
237	Crusader Gauntlets	13	\N	2	78	\N	57	151	\N
238	Ogre Gauntlets	13	\N	2	87	\N	64	185	\N
239	Cap	8	\N	0	3	2	\N	\N	\N
240	Skull Cap	8	\N	0	6	2	\N	15	\N
241	Helm	8	\N	0	12	2	\N	26	\N
242	Full Helm	8	\N	0	15	2	\N	41	\N
243	Great Helm	8	\N	0	24	3	\N	63	\N
244	Mask	8	\N	0	21	3	\N	23	\N
245	Crown	8	\N	0	30	3	\N	55	\N
246	Bone Helm	8	\N	0	24	2	\N	25	\N
247	War Hat	8	\N	1	36	2	22	25	\N
248	Sallet	8	\N	1	39	2	25	43	\N
249	Casque	8	\N	1	42	2	25	59	\N
250	Basinet	8	\N	1	45	2	25	82	\N
251	Winged Helm	8	\N	1	51	3	25	115	\N
252	Death Mask	8	\N	1	48	3	25	55	\N
253	Grand Crown	8	\N	1	57	3	25	103	\N
254	Grim Helm	8	\N	1	51	2	25	58	\N
255	Shako	8	\N	2	60	2	43	50	\N
256	Hydraskull	8	\N	2	63	2	47	84	\N
257	Armet	8	\N	2	69	2	51	109	\N
258	Giant Conch	8	\N	2	54	2	40	142	\N
259	Spired Helm	8	\N	2	81	3	59	192	\N
260	Demonhead	8	\N	2	75	3	55	102	\N
261	Corona	8	\N	2	90	3	66	174	\N
262	Bone Visage	8	\N	2	84	3	63	106	\N
263	Javelin	4	\N	0	3	\N	\N	\N	\N
264	Pilum	4	\N	0	12	\N	\N	\N	45
265	Short Spear	4	\N	0	15	\N	\N	40	40
266	Glaive	4	\N	0	24	\N	\N	52	35
267	Throwing Spear	4	\N	0	30	\N	\N	\N	65
268	War Javelin	4	\N	1	30	\N	18	25	25
269	Great Pilum	4	\N	1	39	\N	25	25	88
270	Simbilan	4	\N	1	42	\N	25	80	80
271	Spiculum	4	\N	1	48	\N	25	93	73
272	Harpoon	4	\N	1	51	\N	25	25	118
273	Hyperion Javelin	4	\N	2	54	\N	40	98	123
274	Stygian Pilum	4	\N	2	63	\N	46	118	112
275	Balrog Spear	4	\N	2	72	\N	53	127	95
276	Ghost Glaive	4	\N	2	81	\N	59	89	137
277	Winged Harpoon	4	\N	2	87	\N	65	76	145
278	Ring	14	\N	0	\N	\N	\N	\N	\N
279	Amulet	15	\N	0	\N	\N	\N	\N	\N
280	Club	16	\N	0	3	2	\N	\N	\N
281	Spiked Club	16	\N	0	6	2	\N	\N	\N
282	Mace	16	\N	0	9	2	\N	27	\N
283	Morning Star	16	\N	0	15	3	\N	36	\N
284	Flail	16	\N	0	21	5	\N	41	35
285	War Hammer	16	\N	0	27	4	\N	53	\N
286	Maul	16	\N	0	21	6	\N	69	\N
287	Great Maul	16	\N	0	33	6	\N	99	\N
288	Cudgel	16	\N	1	30	2	18	25	\N
289	Barbed Club	16	\N	1	33	2	20	20	\N
290	Flanged Mace	16	\N	1	36	2	23	61	\N
291	Jagged Star	16	\N	1	39	3	25	74	\N
292	Knout	16	\N	1	45	5	25	82	73
293	Battle Hammer	16	\N	1	48	4	25	100	\N
294	War Club	16	\N	1	45	6	25	124	\N
295	Martel de Fer	16	\N	1	54	6	25	169	\N
296	Truncheon	16	\N	2	54	2	39	88	43
297	Tyrant Club	16	\N	2	57	3	42	133	\N
298	Reinforced Mace	16	\N	2	63	2	47	145	46
299	Devil Star	16	\N	2	72	3	52	153	44
300	Scourge	16	\N	2	78	5	57	125	77
301	Legendary Mallet	16	\N	2	84	4	61	189	\N
302	Ogre Maul	16	\N	2	69	6	51	225	\N
303	Thunder Maul	16	\N	2	87	6	65	253	\N
319	Targe	17	\N	0	6	4	3	16	\N
320	Rondache	17	\N	0	9	4	6	26	\N
321	Heraldic Shield	17	\N	0	18	4	12	40	\N
322	Aerin Shield	17	\N	0	21	4	15	50	\N
323	Crown Shield	17	\N	0	24	4	18	65	\N
324	Akaran Targe	17	\N	1	36	4	26	44	\N
325	Akaran Rondache	17	\N	1	42	4	30	59	\N
326	Protector Shield	17	\N	1	48	4	34	69	\N
327	Gilded Shield	17	\N	1	51	4	38	89	\N
328	Royal Shield	17	\N	1	57	4	41	114	\N
329	Sacred Targe	17	\N	2	63	4	47	86	\N
330	Sacred Rondache	17	\N	2	72	4	52	109	\N
331	Kurast Shield	17	\N	2	75	4	55	124	\N
332	Zakarum Shield	17	\N	2	84	4	61	142	\N
333	Vortex Shield	17	\N	2	90	4	66	148	\N
334	Bardiche	18	\N	0	6	3	\N	40	\N
335	Voulge	18	\N	0	12	4	\N	50	\N
336	Scythe	18	\N	0	15	5	\N	41	41
337	Poleaxe	18	\N	0	21	5	\N	62	\N
338	Halberd	18	\N	0	30	6	\N	75	47
339	War Scythe	18	\N	0	21	6	\N	80	80
340	Lochaber Axe	18	\N	2	33	3	21	80	\N
341	Bill	18	\N	2	39	4	25	95	\N
342	Battle Scythe	18	\N	2	42	5	23	82	82
343	Partizan	18	\N	2	36	5	23	113	67
344	Bec-De-Corbin	18	\N	2	51	6	25	133	91
345	Grim Scythe	18	\N	2	48	6	25	140	140
346	Ogre Axe	18	\N	2	60	3	45	195	75
347	Colossus Voulge	18	\N	2	66	4	48	210	55
348	Thresher	18	\N	2	72	5	53	153	118
349	Cryptic Axe	18	\N	2	81	5	59	165	103
350	Great Poleaxe	18	\N	2	84	6	63	179	99
351	Giant Thresher	18	\N	2	90	6	66	188	140
352	Scepter	19	\N	0	3	2	\N	25	\N
353	Grand Scepter	19	\N	0	15	3	\N	37	\N
354	War Scepter	19	\N	0	21	5	\N	55	\N
355	Rune Scepter	19	\N	1	33	2	19	25	\N
356	Holy Water Sprinkler	19	\N	1	42	3	25	76	\N
357	Divine Scepter	19	\N	1	45	5	25	103	\N
358	Mighty Scepter	19	\N	2	63	2	46	125	65
359	Seraph Rod	19	\N	2	75	3	57	108	69
360	Caduceus	19	\N	2	90	5	66	97	70
361	Buckler	17	\N	0	3	1	\N	12	\N
362	Small Shield	17	\N	0	6	2	\N	22	\N
363	Large Shield	17	\N	0	12	3	\N	34	\N
364	Kite Shield	17	\N	0	15	3	\N	47	\N
365	Spiked Shield	17	\N	0	12	2	\N	30	\N
366	Tower Shield	17	\N	0	24	3	\N	75	\N
367	Bone Shield	17	\N	0	21	2	\N	25	\N
368	Gothic Shield	17	\N	0	30	3	\N	60	\N
369	Defender	17	\N	1	36	1	22	38	\N
370	Round Shield	17	\N	1	39	2	25	53	\N
371	Scutum	17	\N	1	42	3	25	71	\N
372	Dragon Shield	17	\N	1	45	3	25	91	\N
373	Barbed Shield	17	\N	1	42	2	25	65	\N
374	Pavise	17	\N	1	51	3	25	133	\N
375	Grim Shield	17	\N	1	48	2	25	58	\N
376	Ancient Shield	17	\N	1	57	3	25	110	\N
377	Heater	17	\N	2	60	2	43	77	\N
378	Luna	17	\N	2	63	2	45	100	\N
379	Hyperion	17	\N	2	66	3	48	127	\N
380	Monarch	17	\N	2	72	4	54	156	\N
381	Blade Barrier	17	\N	2	69	3	51	118	\N
382	Aegis	17	\N	2	81	4	59	219	\N
383	Troll Nest	17	\N	2	78	3	57	106	\N
384	Ward	17	\N	2	84	4	63	185	\N
385	Eagle Orb	20	\N	0	3	2	\N	\N	\N
386	Scared Globe	20	\N	0	9	2	\N	\N	\N
387	Smoked Sphere	20	\N	0	12	2	8	\N	\N
388	Clasped Orb	20	\N	0	18	2	13	\N	\N
389	Jared's Stone	20	\N	0	24	3	18	\N	\N
390	Glowing Orb	20	\N	1	33	2	24	\N	\N
391	Crystalline Globe	20	\N	1	39	2	27	\N	\N
392	Cloudy Sphere	20	\N	1	42	2	30	\N	\N
393	Sparkling Ball	20	\N	1	48	2	34	\N	\N
394	Swirling Crystal	20	\N	1	51	3	37	\N	\N
395	Heavenly Stone	20	\N	2	60	2	44	\N	\N
396	Eldritch Orb	20	\N	2	69	2	50	\N	\N
397	Demon Heart	20	\N	2	75	2	56	\N	\N
398	Vortex Orb	20	\N	2	84	2	63	\N	\N
399	Dimensional Shard	20	\N	2	90	3	66	\N	\N
400	Spear	3	\N	0	6	3	\N	\N	\N
401	Trident	3	\N	0	9	4	\N	38	24
402	Brandistock	3	\N	0	18	5	\N	40	50
403	Spetum	3	\N	0	21	6	\N	54	35
404	Pike	3	\N	0	6	6	\N	60	45
405	War Spear	3	\N	1	33	3	21	25	25
406	Fuscina	3	\N	1	36	4	24	77	25
407	War Fork	3	\N	1	42	5	25	80	95
408	Yari	3	\N	1	45	6	25	101	\N
409	Lance	3	\N	1	48	6	25	110	68
410	Hyperion Spear	3	\N	2	60	3	43	155	120
411	Stygian Pike	3	\N	2	66	4	49	168	97
412	Mancatcher	3	\N	2	75	5	55	132	134
413	Ghost Spear	3	\N	2	84	6	62	122	163
414	War Pike	3	\N	2	90	6	66	165	106
415	Short Staff	21	\N	0	3	2	\N	\N	\N
416	Long Staff	21	\N	0	9	3	\N	\N	\N
417	Gnarled Staff	21	\N	0	12	4	\N	\N	\N
418	Battle Staff	21	\N	0	18	4	\N	\N	\N
419	War Staff	21	\N	0	24	6	\N	\N	\N
420	Jo Staff	21	\N	1	30	2	18	25	\N
421	Quarterstaff	21	\N	1	36	3	23	25	\N
422	Cedar Staff	21	\N	1	39	4	25	25	\N
423	Gothic Staff	21	\N	1	42	4	25	25	\N
424	Rune Staff	21	\N	1	48	6	25	25	\N
425	Walking Stick	21	\N	2	60	2	43	25	\N
426	Stalagmite	21	\N	2	66	3	49	63	35
427	Elder Staff	21	\N	2	75	4	25	44	37
428	Shillelagh	21	\N	2	84	4	62	52	27
429	Archon Staff	21	\N	2	90	6	66	34	\N
430	Short Sword	22	\N	0	3	2	\N	\N	\N
431	Scimitar	22	\N	0	6	2	\N	\N	21
432	Sabre	22	\N	0	9	2	\N	25	25
433	Falchion	22	\N	0	12	2	\N	33	\N
434	Crystal Sword	22	\N	0	12	6	\N	43	\N
435	Broad Sword	22	\N	0	15	4	\N	48	\N
436	Long Sword	22	\N	0	21	4	\N	55	39
437	War Sword	22	\N	0	27	3	\N	71	45
438	Two-handed Sword	22	\N	0	12	3	\N	33	27
439	Claymore	22	\N	0	18	4	\N	47	\N
440	Giant Sword	22	\N	0	21	4	\N	56	34
441	Bastard Sword	22	\N	0	24	4	\N	62	\N
442	Flamberge	22	\N	0	27	5	\N	70	49
443	Great Sword	22	\N	0	33	6	\N	100	60
444	Gladius	22	\N	1	30	2	18	25	\N
445	Cutlass	22	\N	1	45	2	25	25	52
446	Shamshir	22	\N	1	36	2	23	58	58
447	Tulwar	22	\N	1	39	2	25	70	42
448	Dimensional Blade	22	\N	1	39	6	25	85	60
449	Battle Sword	22	\N	1	42	4	25	92	43
450	Rune Sword	22	\N	1	45	4	25	103	79
451	Ancient Sword	22	\N	1	51	3	25	127	88
452	Espandon	22	\N	1	39	3	25	73	61
453	Dacian Falx	22	\N	1	42	4	25	91	20
454	Tusk Sword	22	\N	1	45	4	25	104	71
455	Gothic Sword	22	\N	1	48	4	25	113	20
456	Zweihander	22	\N	1	51	5	25	125	94
457	Executioner Sword	22	\N	1	54	6	25	170	110
458	Falcata	22	\N	2	57	2	42	150	88
459	Ataghan	22	\N	2	63	2	45	135	95
460	Elegant Blade	22	\N	2	63	2	47	109	122
461	Hydra Edge	22	\N	2	69	2	51	142	105
462	Phase Blade	22	\N	2	75	6	54	25	136
463	Conquest Sword	22	\N	2	78	4	58	142	112
464	Cryptic Sword	22	\N	2	84	4	61	99	109
465	Mythical Sword	22	\N	2	90	3	66	147	124
466	Legend Sword	22	\N	2	60	3	44	175	100
467	Highland Blade	22	\N	2	66	4	49	171	104
468	Balrog Blade	22	\N	2	72	4	53	185	87
469	Champion Sword	22	\N	2	78	4	57	163	103
470	Colossus Sword	22	\N	2	81	5	60	182	95
471	Colossus Blade	22	\N	2	87	6	63	189	110
472	Throwing Knife	23	12	0	3	\N	\N	\N	21
473	Balanced Knife	23	12	0	15	\N	\N	\N	51
474	Throwing Axe	23	7	0	9	\N	\N	\N	40
475	Balanced Axe	23	7	0	18	\N	\N	\N	57
476	Battle Dart	23	12	1	33	\N	19	25	52
477	War Dart	23	12	1	39	\N	22	25	97
478	Francisca	23	7	1	36	\N	25	25	80
479	Hurlbat	23	7	1	42	\N	25	25	106
480	Flying Knife	23	12	2	66	\N	48	48	141
481	Winged Knife	23	12	2	78	\N	57	45	142
482	Flying Axe	23	7	2	57	\N	42	88	108
483	Winged Axe	23	7	2	81	\N	60	96	122
484	Wand	24	\N	0	3	1	\N	\N	\N
485	Yew Wand	24	\N	0	12	1	\N	\N	\N
486	Bone Wand	24	\N	0	18	2	\N	\N	\N
487	Grim Wand	24	\N	0	27	2	\N	\N	\N
488	Burnt Wand	24	\N	1	33	1	19	25	\N
489	Petrified Wand	24	\N	1	39	2	25	25	\N
490	Tomb Wand	24	\N	1	45	2	25	25	\N
491	Grave Wand	24	\N	1	51	2	25	25	\N
492	Polished Wand	24	\N	2	57	2	41	25	\N
493	Ghost Wand	24	\N	2	66	2	48	25	\N
494	Lich Wand	24	\N	2	75	2	56	25	\N
495	Unearthed Wand	24	\N	2	87	2	64	25	\N
209	Wolf Head	25	\N	0	6	3	3	16	\N
210	Hawk Helm	25	\N	0	9	3	6	20	\N
211	Antlers	25	\N	0	18	3	12	24	\N
212	Falcon Mask	25	\N	0	21	3	15	28	\N
213	Spirit Mask	25	\N	0	24	3	18	30	\N
214	Alpha Helm	25	\N	1	36	3	26	44	\N
215	Griffon Headdress	25	\N	1	42	3	30	50	\N
216	Hunter's Guise	25	\N	1	48	3	29	56	\N
217	Sacred Feathers	25	\N	1	51	3	32	62	\N
218	Totemic Mask	25	\N	1	57	3	41	65	\N
219	Blood Spirit	25	\N	2	63	3	46	86	\N
220	Sun Spirit	25	\N	2	69	3	51	95	\N
221	Earth Spirit	25	\N	2	78	3	57	104	\N
222	Sky Spirit	25	\N	2	84	3	62	113	\N
223	Dream Spirit	25	\N	2	90	3	66	118	\N
304	Preserved Head	26	\N	0	6	2	3	12	\N
305	Zombie Head	26	\N	0	9	2	6	14	\N
306	Unraveller Head	26	\N	0	18	2	12	18	\N
307	Gargoyle Head	26	\N	0	21	2	15	20	\N
308	Demon Head	26	\N	0	24	2	18	25	\N
309	Mummified Trophy	26	\N	1	33	2	24	38	\N
310	Fetish Trophy	26	\N	1	39	2	29	41	\N
311	Sexton Trophy	26	\N	1	45	2	33	47	\N
312	Cantor Trophy	26	\N	1	51	2	36	50	\N
313	Hierophant Trophy	26	\N	1	54	2	40	58	\N
314	Minion Skull	26	\N	2	60	2	44	77	\N
315	Hellspawn Skull	26	\N	2	69	2	50	82	\N
316	Overseer Skull	26	\N	2	66	2	49	91	\N
317	Succubus Skull	26	\N	2	81	2	60	95	\N
318	Bloodlord Skull	26	\N	2	87	2	65	106	\N
496	Small Charm	27	\N	0	\N	\N	\N	\N	\N
497	Grand Charm	27	\N	0	\N	\N	\N	\N	\N
498	Large Charm	27	\N	0	\N	\N	\N	\N	\N
499	Jewel	28	\N	0	\N	\N	\N	\N	\N
\.


--
-- Data for Name: spell; Type: TABLE DATA; Schema: public; Owner: diablo2
--

COPY spell (spellid, name, charachter) FROM stdin;
3	Ice Blast	\N
8	Frozen Orb	\N
10	Dim Vision	\N
11	Tornado	\N
13	Hydra	\N
15	Enchant	\N
17	Weaken	\N
18	Volcano	\N
20	Charged Bolt	\N
22	Meteor	\N
23	Lower Resist	\N
24	Fissure	\N
25	Confuse	\N
29	Bone Prison	\N
183	Thorns	pa
34	Cloak of Shadows	\N
37	Firestorm	\N
114	Sacrifice	pa
115	Holy Fire	pa
117	Lightning Fury	am
118	Vigor	pa
119	Strafe	am
120	Exploding Arrow	am
4	Frost Nova	so
16	Blaze	so
123	Martial Arts Skills	as
184	Vengeance	pa
14	Nova	so
185	Lightning Strike	am
127	Leap	ba
7	Fist of the Heavens	pa
129	Holy Shock	pa
130	Resist Lightning	pa
131	Fire Bolt	so
132	Warmth	so
133	Lightning	so
21	Chain Lightning	so
31	Static Field	so
40	Fire Ball	so
38	Fire Wall	so
6	Iron Maiden	ne
5	Amplify Damage	ne
134	Terror	ne
35	Corpse Explosion	ne
26	Decrepify	ne
135	Fury	dr
136	Maul	dr
138	Guided Arrow	am
39	Grim Ward	ba
139	Find Item	ba
140	Find Potion	ba
19	Poison Nova	ne
36	Poison Explosion	ne
141	Poison Dagger	ne
143	Mace Masteries	ba
144	Holy Freeze	pa
121	Javelin and Spear Skills	am
145	Impale	am
146	Power Strike	am
147	Cold Mastery	so
148	Lightning Mastery	so
149	Fire Mastery	so
150	Energy Shield	so
151	Telekinesis	so
9	Teleport	so
152	Whirlwind	ba
153	Sword Mastery	ba
154	Rabies	dr
186	Lightning Bolt	am
156	Offensive Auras	pa
158	Raise Skeletal Mage	ne
159	Raise Skeleton	ne
160	Poison And Bone Skills	ne
162	Warcries Skills	ba
163	Passive and Magic Skills	am
164	Shadow Disciplines Skills	as
165	Poison Creeper	\N
166	Oak Sage	\N
167	Spirit of Barbs	\N
168	Heart of Wolverine	\N
169	Iron Golem	\N
170	Summon Dire Wolf	\N
171	Venom	\N
172	Fade	\N
173	Life Tap	\N
174	Plague Javelin	\N
175	Twister	\N
124	Bow And Crossbow Skills	am
177	Blood Golem	\N
155	Defensive Auras	pa
178	Offensive Aura's	pa
126	Skeleton Mastery	ne
179	Redemption	pa
32	Holy Bolt	pa
30	Bone Spirit	ne
176	Bone Spear	ne
180	Bone Wall	ne
181	Bone Armor	ne
182	Teeth	ne
187	Martial Arts	as
188	Shadow Disciplines	as
189	Wake of Inferno	as
190	Wake of Fire	as
157	Summoning Skills	ne
191	Poison and Bone Skills	ne
161	Curses	ne
192	Warcries	ba
116	Masteries	ba
122	Combat Skills	ba
193	Battle Command	ba
194	Battle Orders	ba
125	Shape Shifting Skills	dr
195	Feral Rage	dr
196	Raven	dr
142	Elemental Skills	dr
128	Chilling Armor	so
12	Blizzard	so
33	Glacial Spike	so
137	Immolation Arrow	am
197	Fireball	\N
\.


--
-- Name: charachter_pkey; Type: CONSTRAINT; Schema: public; Owner: diablo2; Tablespace: 
--

ALTER TABLE ONLY charachter
    ADD CONSTRAINT charachter_pkey PRIMARY KEY (charid);


--
-- Name: item_itemprop_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: diablo2; Tablespace: 
--

ALTER TABLE ONLY item_itemprop_cache
    ADD CONSTRAINT item_itemprop_cache_pkey PRIMARY KEY (itemid, itempropid);


--
-- Name: item_pkey; Type: CONSTRAINT; Schema: public; Owner: diablo2; Tablespace: 
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_pkey PRIMARY KEY (itemid);


--
-- Name: item_type_prop_pkey; Type: CONSTRAINT; Schema: public; Owner: diablo2; Tablespace: 
--

ALTER TABLE ONLY item_type_prop
    ADD CONSTRAINT item_type_prop_pkey PRIMARY KEY (itemtypeid, itempropid);


--
-- Name: itemcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: diablo2; Tablespace: 
--

ALTER TABLE ONLY itemcategory
    ADD CONSTRAINT itemcategory_pkey PRIMARY KEY (itemcatid);


--
-- Name: itemproperty_pkey; Type: CONSTRAINT; Schema: public; Owner: diablo2; Tablespace: 
--

ALTER TABLE ONLY itemproperty
    ADD CONSTRAINT itemproperty_pkey PRIMARY KEY (itempropid);


--
-- Name: itemset_pkey; Type: CONSTRAINT; Schema: public; Owner: diablo2; Tablespace: 
--

ALTER TABLE ONLY itemset
    ADD CONSTRAINT itemset_pkey PRIMARY KEY (itemsetid);


--
-- Name: itemtype_pkey; Type: CONSTRAINT; Schema: public; Owner: diablo2; Tablespace: 
--

ALTER TABLE ONLY itemtype
    ADD CONSTRAINT itemtype_pkey PRIMARY KEY (itemtypeid);


--
-- Name: spell_pkey; Type: CONSTRAINT; Schema: public; Owner: diablo2; Tablespace: 
--

ALTER TABLE ONLY spell
    ADD CONSTRAINT spell_pkey PRIMARY KEY (spellid);


--
-- Name: charitem_charid_idx; Type: INDEX; Schema: public; Owner: diablo2; Tablespace: 
--

CREATE INDEX charitem_charid_idx ON char_item USING btree (charid);


--
-- Name: char_item_charid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: diablo2
--

ALTER TABLE ONLY char_item
    ADD CONSTRAINT char_item_charid_fkey FOREIGN KEY (charid) REFERENCES charachter(charid);


--
-- Name: char_item_itemid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: diablo2
--

ALTER TABLE ONLY char_item
    ADD CONSTRAINT char_item_itemid_fkey FOREIGN KEY (itemid) REFERENCES item(itemid);


--
-- Name: item_item_prop_itemid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: diablo2
--

ALTER TABLE ONLY item_item_prop
    ADD CONSTRAINT item_item_prop_itemid_fkey FOREIGN KEY (itemid) REFERENCES item(itemid);


--
-- Name: item_item_prop_itempropid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: diablo2
--

ALTER TABLE ONLY item_item_prop
    ADD CONSTRAINT item_item_prop_itempropid_fkey FOREIGN KEY (itempropid) REFERENCES itemproperty(itempropid);


--
-- Name: item_itemprop_cache_itemid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: diablo2
--

ALTER TABLE ONLY item_itemprop_cache
    ADD CONSTRAINT item_itemprop_cache_itemid_fkey FOREIGN KEY (itemid) REFERENCES item(itemid);


--
-- Name: item_itemprop_cache_itempropid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: diablo2
--

ALTER TABLE ONLY item_itemprop_cache
    ADD CONSTRAINT item_itemprop_cache_itempropid_fkey FOREIGN KEY (itempropid) REFERENCES itemproperty(itempropid);


--
-- Name: item_itemsetid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: diablo2
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_itemsetid_fkey FOREIGN KEY (itemsetid) REFERENCES itemset(itemsetid);


--
-- Name: item_itemtypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: diablo2
--

ALTER TABLE ONLY item
    ADD CONSTRAINT item_itemtypeid_fkey FOREIGN KEY (itemtypeid) REFERENCES itemtype(itemtypeid);


--
-- Name: item_spell_itemid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: diablo2
--

ALTER TABLE ONLY item_spell
    ADD CONSTRAINT item_spell_itemid_fkey FOREIGN KEY (itemid) REFERENCES item(itemid);


--
-- Name: item_spell_spellid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: diablo2
--

ALTER TABLE ONLY item_spell
    ADD CONSTRAINT item_spell_spellid_fkey FOREIGN KEY (spellid) REFERENCES spell(spellid);


--
-- Name: item_type_prop_itempropid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: diablo2
--

ALTER TABLE ONLY item_type_prop
    ADD CONSTRAINT item_type_prop_itempropid_fkey FOREIGN KEY (itempropid) REFERENCES itemproperty(itempropid);


--
-- Name: item_type_prop_itemtypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: diablo2
--

ALTER TABLE ONLY item_type_prop
    ADD CONSTRAINT item_type_prop_itemtypeid_fkey FOREIGN KEY (itemtypeid) REFERENCES itemtype(itemtypeid);


--
-- Name: itemtype_itemcatid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: diablo2
--

ALTER TABLE ONLY itemtype
    ADD CONSTRAINT itemtype_itemcatid_fkey FOREIGN KEY (itemcatid) REFERENCES itemcategory(itemcatid);


--
-- Name: public; Type: ACL; Schema: -; Owner: pgsql
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM pgsql;
GRANT ALL ON SCHEMA public TO pgsql;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

