-- SQL Manager for PostgreSQL 6.3.0.54659
-- ---------------------------------------
-- Хост         : eci-db1-dev.eci.local
-- База данных  : cscd
-- Версия       : PostgreSQL 14.7 on x86_64-pc-linux-gnu, compiled by gcc (AstraLinuxSE 8.3.0-6) 8.3.0, 64-bit



SET search_path = pls, pg_catalog;
ALTER TABLE ONLY pls.ref_route DROP CONSTRAINT IF EXISTS ref_route_fk;
DROP TABLE IF EXISTS pls.entity_attr_log;
DROP TABLE IF EXISTS pls.ref_attr_group_actor;
DROP TABLE IF EXISTS pls.ref_stage_action_stage;
DROP TABLE IF EXISTS pls.ref_stage_action_actor;
DROP VIEW IF EXISTS pls.entity_group;
DROP TABLE IF EXISTS pls.entity_entity;
DROP VIEW IF EXISTS pls.candidate_view_list;
DROP VIEW IF EXISTS pls.request_view_list;
DROP VIEW IF EXISTS pls.entity_view_list;
DROP SERVER IF EXISTS test4_tsup_ecp;
DROP FOREIGN DATA WRAPPER IF EXISTS postgres_fdw;
DROP TABLE IF EXISTS pls.ref_attr_actor;
DROP SEQUENCE IF EXISTS pls.ref_action_raction_id_seq;
DROP TABLE IF EXISTS pls.ref_action;
DROP TABLE IF EXISTS pls.ref_attr_outer;
DROP TABLE IF EXISTS pls.ref_attr_dict;
DROP TABLE IF EXISTS pls.ref_stage_action;
DROP TABLE IF EXISTS pls.ref_actor;
DROP TABLE IF EXISTS pls.ref_stage;
DROP TABLE IF EXISTS pls.ref_route;
DROP TABLE IF EXISTS pls.entity_stage;
DROP TABLE IF EXISTS pls.entity_attr;
DROP TABLE IF EXISTS pls.ref_attr;
DROP TABLE IF EXISTS pls.ref_attr_group;
DROP TYPE IF EXISTS pls.attr_type;
DROP TABLE IF EXISTS pls.entity;
DROP TABLE IF EXISTS pls.ref_entity_type;
DROP SCHEMA IF EXISTS pls;
CREATE SCHEMA pls AUTHORIZATION d79276;
SET check_function_bodies = false;
--
-- Structure for table entity (OID = 1059624) : 
--
CREATE TABLE pls.entity (
    entity_id integer DEFAULT nextval('entity_ent_id_seq'::regclass) NOT NULL,
    rentity_type_id integer,
    ts_deleted timestamp without time zone,
    user_deleted varchar(50),
    chatroom_uuid uuid
)
WITH (oids = false);
--
-- Structure for table ref_entity_type (OID = 1059634) : 
--
CREATE TABLE pls.ref_entity_type (
    rentity_type_id integer DEFAULT nextval('entity_types_ent_type_id_seq'::regclass) NOT NULL,
    rentity_type_name varchar(255),
    rentity_type_label varchar(255),
    rroute_id integer
)
WITH (oids = false);
--
-- Definition for type attr_type (OID = 1059667) : 
--
CREATE TYPE pls.attr_type AS ENUM (
  'string', 'date', 'number', 'dict', 'outer', 'longstring', 'bool', 'file'
);
--
-- Structure for table ref_attr (OID = 1059642) : 
--
CREATE TABLE pls.ref_attr (
    rattr_id serial NOT NULL,
    rattr_name varchar(255),
    rattr_type attr_type,
    rattr_label varchar(255),
    rattr_required boolean,
    rattr_system boolean,
    rattr_group_id integer,
    rattr_no smallint,
    rattr_view boolean,
    rattr_multilple boolean
)
WITH (oids = false);
--
-- Structure for table entity_attr (OID = 1059653) : 
--
CREATE TABLE pls.entity_attr (
    entity_attr_id integer DEFAULT nextval('entity_attr_ent_attr_id_seq'::regclass) NOT NULL,
    rattr_id integer,
    entity_id integer,
    entity_attr_value varchar
)
WITH (oids = false);
--
-- Structure for table ref_attr_group (OID = 1059676) : 
--
CREATE TABLE pls.ref_attr_group (
    rattr_group_id integer DEFAULT nextval('ref_attr_group_rag_id_seq'::regclass) NOT NULL,
    rattr_group_name varchar(255),
    rattr_group_label varchar(255),
    rattr_group_no smallint,
    rentity_type_id integer
)
WITH (oids = false);
--
-- Structure for table entity_stage (OID = 1059999) : 
--
CREATE TABLE pls.entity_stage (
    entity_stage_id serial NOT NULL,
    rstage_id integer,
    entity_id integer
)
WITH (oids = false);
--
-- Structure for table ref_stage (OID = 1060006) : 
--
CREATE TABLE pls.ref_stage (
    rstage_id serial NOT NULL,
    rstage_name varchar(255),
    rstage_label varchar(255),
    rentity_type_id integer,
    rstage_wait_others boolean,
    rroute_id integer NOT NULL
)
WITH (oids = false);
--
-- Structure for table ref_actor (OID = 1060015) : 
--
CREATE TABLE pls.ref_actor (
    ractor_id serial NOT NULL,
    ractor_auth_group_name varchar(255),
    ractor_label varchar(255)
)
WITH (oids = false);
--
-- Structure for table ref_stage_action (OID = 1060024) : 
--
CREATE TABLE pls.ref_stage_action (
    rstage_action_id integer DEFAULT nextval('ref_stage_actor_ref_stage_actor_id_seq'::regclass) NOT NULL,
    rstage_id integer,
    raction_id integer
)
WITH (oids = false);
--
-- Structure for table ref_attr_dict (OID = 1060261) : 
--
CREATE TABLE pls.ref_attr_dict (
    rattr_dict_id serial NOT NULL,
    rattr_id integer,
    rattr_dict_no smallint,
    rattr_dict_name varchar(255),
    rattr_dict_label varchar(255)
)
WITH (oids = false);
--
-- Structure for table ref_attr_outer (OID = 1060271) : 
--
CREATE TABLE pls.ref_attr_outer (
    rattr_outer_id serial NOT NULL,
    rattr_id integer,
    rattr_outer_name varchar(255),
    rattr_outer_label varchar(255),
    rattr_outer_fields varchar(255),
    rattr_outer_path varchar(255),
    rattr_outer_key varchar(255),
    rattr_outer_sort varchar(255)
)
WITH (oids = false);
--
-- Structure for table ref_action (OID = 1075661) : 
--
CREATE TABLE pls.ref_action (
    raction_id integer DEFAULT nextval(('pls.ref_action_raction_id_seq'::text)::regclass) NOT NULL,
    raction_name varchar(255),
    raction_label varchar(255)
)
WITH (oids = false);
--
-- Definition for sequence ref_action_raction_id_seq (OID = 1075670) : 
--
CREATE SEQUENCE pls.ref_action_raction_id_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 2147483647
    NO MINVALUE
    CACHE 1;
--
-- Structure for table ref_attr_actor (OID = 1085456) : 
--
CREATE TABLE pls.ref_attr_actor (
    rattr_actor_id serial NOT NULL,
    rattr_id integer,
    ractor_id integer,
    rstage_id integer
)
WITH (oids = false);
--
-- Definition for foreign data wrapper postgres_fdw (OID = 1088041) : 
--
CREATE FOREIGN DATA WRAPPER postgres_fdw
  HANDLER public.postgres_fdw_handler
  VALIDATOR public.postgres_fdw_validator;
--
-- Definition for foreign server test4_tsup_ecp (OID = 1090591) : 
--
CREATE SERVER test4_tsup_ecp
  FOREIGN DATA WRAPPER postgres_fdw
  OPTIONS (
    host 'test4.tsup.ecp',
    dbname 'tsup',
    port '5432',
    use_remote_estimate 'true',
    updatable 'false',
    truncatable 'false');
--
-- Definition for view entity_view_list (OID = 1151765) : 
--
CREATE VIEW pls.entity_view_list
AS
SELECT s.entity_id,
    string_agg((s.rattr_label)::text, ';'::text) AS attr_list,
    string_agg((s.entity_attr_value)::text, ';'::text) AS label_list
FROM (
    SELECT ent.entity_id,
            ea.entity_attr_value,
            ra.rattr_label
    FROM (((entity ent
             LEFT JOIN ref_entity_type ret ON ((ret.rentity_type_id =
                 ent.rentity_type_id)))
             LEFT JOIN entity_attr ea ON ((ea.entity_id = ent.entity_id)))
             LEFT JOIN ref_attr ra ON ((ra.rattr_id = ea.rattr_id)))
    WHERE (ra.rattr_view = true)
    ORDER BY ent.entity_id, ra.rattr_no
    ) s
GROUP BY s.entity_id;

--
-- Definition for view request_view_list (OID = 1151773) : 
--
CREATE VIEW pls.request_view_list
AS
SELECT s.entity_id,
    string_agg((s.rattr_label)::text, ';'::text) AS label_list,
    string_agg((s.entity_attr_value)::text, ';'::text) AS attr_list
FROM (
    SELECT ent.entity_id,
            ea.entity_attr_value,
            ra.rattr_label
    FROM (((entity ent
             LEFT JOIN ref_entity_type ret ON ((ret.rentity_type_id =
                 ent.rentity_type_id)))
             LEFT JOIN entity_attr ea ON ((ea.entity_id = ent.entity_id)))
             LEFT JOIN ref_attr ra ON ((ra.rattr_id = ea.rattr_id)))
    WHERE (((ret.rentity_type_name)::text = 'request'::text) AND
        (ra.rattr_view = true))
    ORDER BY ent.entity_id, ra.rattr_no
    ) s
GROUP BY s.entity_id;

--
-- Definition for view candidate_view_list (OID = 1164261) : 
--
CREATE VIEW pls.candidate_view_list
AS
SELECT s.entity_id,
    string_agg((s.rattr_label)::text, ';'::text) AS label_list,
    string_agg((s.entity_attr_value)::text, ';'::text) AS attr_list
FROM (
    SELECT ent.entity_id,
            ea.entity_attr_value,
            ra.rattr_label
    FROM (((entity ent
             LEFT JOIN ref_entity_type ret ON ((ret.rentity_type_id =
                 ent.rentity_type_id)))
             LEFT JOIN entity_attr ea ON ((ea.entity_id = ent.entity_id)))
             LEFT JOIN ref_attr ra ON ((ra.rattr_id = ea.rattr_id)))
    WHERE (((ret.rentity_type_name)::text = 'candidate'::text) AND
        (ra.rattr_view = true))
    ORDER BY ent.entity_id, ra.rattr_no
    ) s
GROUP BY s.entity_id;

--
-- Structure for table entity_entity (OID = 1223127) : 
--
CREATE TABLE pls.entity_entity (
    ent_ent_id serial NOT NULL,
    entity_id integer,
    entity_id_link integer,
    ts_created timestamp without time zone,
    ts_deleted timestamp without time zone
)
WITH (oids = false);
--
-- Definition for view entity_group (OID = 1223411) : 
--
CREATE VIEW pls.entity_group
AS
SELECT ea.entity_attr_value AS entity_id,
    count(*) AS vacancy,
    1 AS vacancy_move,
    1 AS vacancy_out
FROM ((ref_entity_type ret
     LEFT JOIN entity e ON ((e.rentity_type_id = ret.rentity_type_id)))
     LEFT JOIN entity_attr ea ON (((ea.entity_id = e.entity_id) AND
         (ea.rattr_id = 11))))
GROUP BY ea.entity_attr_value;

--
-- Structure for table ref_stage_action_actor (OID = 1260925) : 
--
CREATE TABLE pls.ref_stage_action_actor (
    rstage_action_actor_id integer DEFAULT nextval('ref_stage_action_actor_ref_stage_action_actor_id_seq'::regclass) NOT NULL,
    rstage_action_id integer,
    ractor_id integer
)
WITH (oids = false);
--
-- Structure for table ref_stage_action_stage (OID = 1261493) : 
--
CREATE TABLE pls.ref_stage_action_stage (
    rstage_action_stage_id integer DEFAULT nextval('ref_stage_actor_stage_rstage_action_stage_id_seq'::regclass) NOT NULL,
    rstage_action_id integer,
    rstage_id integer
)
WITH (oids = false);
--
-- Structure for table ref_route (OID = 1275415) : 
--
CREATE TABLE pls.ref_route (
    rroute_id serial NOT NULL,
    rroute_name varchar(255),
    rroute_label varchar(255),
    rstage_id_start integer
)
WITH (oids = false);
ALTER TABLE ONLY pls.ref_route ALTER COLUMN rroute_id SET STATISTICS 0;
--
-- Structure for table ref_attr_group_actor (OID = 1275513) : 
--
CREATE TABLE pls.ref_attr_group_actor (
    rattr_group_actor_id serial NOT NULL,
    rattr_group_id integer,
    ractor_id integer,
    can_edit boolean DEFAULT false,
    can_read boolean DEFAULT true
)
WITH (oids = false);
--
-- Structure for table entity_attr_log (OID = 1282855) : 
--
CREATE TABLE pls.entity_attr_log (
    entity_attr_log_id serial NOT NULL,
    rattr_id integer,
    entity_id integer,
    entity_attr_value varchar,
    ts_change timestamp without time zone,
    user_change varchar(50)
)
WITH (oids = false);
--
-- Data for table pls.entity (OID = 1059624) (LIMIT 0,19)
--
INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (40, 4, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (41, 2, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (42, 2, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (43, 2, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (44, 2, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (45, 4, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (46, 4, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (47, 4, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (48, 2, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (49, 4, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (50, 2, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (51, 2, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (52, 4, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (53, 4, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (54, 2, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (55, 2, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (56, 2, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (57, 2, NULL, NULL, NULL);

INSERT INTO entity (entity_id, rentity_type_id, ts_deleted, user_deleted, chatroom_uuid)
VALUES (58, 2, NULL, NULL, NULL);

--
-- Data for table pls.ref_entity_type (OID = 1059634) (LIMIT 0,3)
--
INSERT INTO ref_entity_type (rentity_type_id, rentity_type_name, rentity_type_label, rroute_id)
VALUES (2, 'candidate', 'Кандидат', NULL);

INSERT INTO ref_entity_type (rentity_type_id, rentity_type_name, rentity_type_label, rroute_id)
VALUES (4, 'request', 'Заявка на подбор персонала', NULL);

INSERT INTO ref_entity_type (rentity_type_id, rentity_type_name, rentity_type_label, rroute_id)
VALUES (5, 'stage', 'Этап заявки', NULL);

--
-- Data for table pls.ref_attr (OID = 1059642) (LIMIT 0,77)
--
INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (49, 'material_responsibility', 'dict', 'Материальная ответственность', NULL, NULL, 4, 23, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (30, 'resume', 'date', 'Дата поступления резюме', NULL, NULL, 2, 1, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (32, 'come_from', 'dict', 'Откуда пришел', NULL, NULL, 2, 3, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (1, 'surname', 'string', 'Фамилия', true, false, 2, 4, true, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (5, 'name', 'string', 'Имя', NULL, NULL, 2, 5, true, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (9, 'patronymic', 'string', 'Отчество', NULL, NULL, 2, 6, true, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (10, 'request_no', 'string', 'Номер заявки', NULL, NULL, 4, 1, true, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (6, 'birth_date', 'date', 'Дата рождения', NULL, NULL, 2, 8, true, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (15, 'source', 'dict', 'Источник вакансии', NULL, NULL, 4, 46, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (14, 'approve_date', 'date', 'Дата утверждения', NULL, NULL, 4, 2, true, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (33, 'gender', 'dict', 'Пол', NULL, NULL, 2, 7, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (50, 'shifts', 'dict', 'Рабочее время', NULL, NULL, 4, 24, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (51, 'shifts_code', 'string', 'Код графика', NULL, NULL, 4, 25, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (52, 'shift_descr', 'longstring', 'Описание графика для внесения в ТД', NULL, NULL, 4, 26, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (34, 'phone', 'string', 'Телефон', NULL, NULL, 2, 9, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (35, 'email', 'string', 'Электронная почта', NULL, NULL, 2, 9, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (63, 'vacation_not_28', 'string', 'Продолжительности основного отпуска, если не равен 28 к. дней', NULL, NULL, 4, 36, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (36, 'education', 'dict', 'Образование', NULL, NULL, 2, 10, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (37, 'speciality', 'string', 'Специальность', NULL, NULL, 2, 11, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (38, 'additional_education', 'string', 'Дополнительные профессии, навыки, компетенции', NULL, NULL, 2, 12, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (39, 'docs', 'longstring', 'Документы', NULL, NULL, 2, 13, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (40, 'target', 'string', 'Цель резюме', NULL, NULL, 2, 14, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (53, 'card_spec', 'string', 'Карта спецоценки условий труда', NULL, NULL, 4, 27, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (16, 'type', 'dict', 'Тип заявки', NULL, NULL, 4, 3, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (11, 'division', 'string', 'Подразделение', NULL, NULL, 4, 7, true, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (18, 'difficulty', 'dict', 'Сложность подбора', NULL, NULL, 4, 4, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (13, 'div_group', 'string', 'Структурное подразделение', NULL, NULL, 4, 8, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (19, 'close_date', 'date', 'Целевой срок закрытия заявки', NULL, NULL, 4, 5, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (20, 'recrouter', 'dict', 'Рекрутер', NULL, NULL, 4, 6, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (12, 'position_name', 'string', 'Наименование вакантной должности', NULL, NULL, 4, 9, true, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (57, 'salary_oper', 'dict', 'Оперативная премия,%', NULL, NULL, 4, 30, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (17, 'category', 'dict', 'Категория', NULL, NULL, 4, 10, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (43, 'comment', 'longstring', 'Комментарии', NULL, NULL, 2, 17, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (72, 'class', 'dict', 'Класс условий труда', NULL, NULL, 4, 45, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (58, 'salary_region', 'string', 'Районный коэффициент, %', NULL, NULL, 4, 31, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (21, 'address', 'string', 'Фактический адрес рабочего места', NULL, NULL, 4, 11, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (42, 'mark', 'dict', 'Признак резюме', NULL, NULL, 2, 16, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (41, 'ready_education', 'dict', 'Готовность к обучению', NULL, NULL, 2, 15, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (44, 'secondment_length', 'string', 'Продолжительность командировок (% рабочего времени)', NULL, NULL, 4, 19, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (45, 'salary', 'string', 'Средний уровень зарплаты, руб', NULL, NULL, 4, 20, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (59, 'salary_1011', 'string', 'ш. 1011', NULL, NULL, 4, 32, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (54, 'lpp', 'dict', 'Лечебно-профилактическое питание', NULL, NULL, 4, 28, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (24, 'manager', 'longstring', 'Непосредственный руководитель', NULL, NULL, 4, 14, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (22, 'f1', 'longstring', 'О преимуществах работы', NULL, NULL, 4, 12, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (23, 'f2', 'string', 'Количество подчиненных', NULL, NULL, 4, 13, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (60, 'salary_1018', 'dict', 'За вредные условия труда (ш. 1018)', NULL, NULL, 4, 33, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (25, 'f3', 'longstring', 'Функциональные задачи и зона ответственности', NULL, NULL, 4, 15, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (26, 'f3', 'dict', 'Вид трудового договора', NULL, NULL, 4, 16, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (27, 'f4', 'dict', 'Режим работы', NULL, NULL, 4, 17, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (56, 'milk', 'dict', 'Молоко', NULL, NULL, 4, 29, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (28, 'secondment', 'dict', 'Командировки', NULL, NULL, 4, 18, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (46, 'stud_education', 'dict', 'При заключении ученического договора обучение', NULL, NULL, 4, 21, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (47, 'stud_education_hours', 'string', 'Количество часов обучения (если требуется)', NULL, NULL, 4, 22, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (64, 'vacation_not_28_descr', 'longstring', 'Причина продолжительности основного отпуска не равного 28 к. дней', NULL, NULL, 4, 37, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (65, 'pens', 'dict', 'Право на льготное пенсионное обеспечение', NULL, NULL, 4, 38, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (66, 'acc_form', 'dict', 'Форма допуска', NULL, NULL, 4, 39, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (67, 'position', 'string', 'Позиция профессии', NULL, NULL, 4, 40, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (61, 'add_vacation', 'dict', 'Дополнительный отпуск предоставляется', NULL, NULL, 4, 34, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (62, 'add_vacation_days', 'dict', 'Дополнительный отпуск, дней', NULL, NULL, 4, 35, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (73, 'replace_fio', 'string', 'ФИО работника который увольняется/переводится/временно отсутствует', NULL, NULL, 4, 47, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (69, 'expances_source', 'string', 'Место возникновения затрат', NULL, NULL, 4, 42, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (68, 'expances_code', 'string', 'Код производственных щатрат', NULL, NULL, 4, 41, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (70, 'harms', 'dict', 'Опасные и вредные производственные факторы', NULL, NULL, 4, 43, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (71, 'psyco', 'dict', 'Виды деятельности, при осуществлении которых проводится психиатрическое освидетельствование', NULL, NULL, 4, 44, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (74, 'replace_descr', 'string', 'Причина отсутствия', NULL, NULL, 4, 48, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (75, 'replace_date', 'date', 'Последний день работы', NULL, NULL, 4, 49, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (76, 'comment', 'longstring', 'Дополнительные комментарии к вакансии', NULL, NULL, 4, 50, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (78, 'req_spec', 'string', 'Специальность', NULL, NULL, 4, 52, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (7, 'source', 'dict', 'Источник кандидата', NULL, NULL, 2, 2, true, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (81, 'req_exp', 'string', 'Требования к опыту работы', NULL, NULL, 4, 55, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (80, 'req_spec_progr', 'longstring', 'Знание специального программного обеспечения', NULL, NULL, 4, 54, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (79, 'req_dop_education', 'longstring', 'Дополнительное профессиональное образование, специальная подготовка, профессиональные сертификаты', NULL, NULL, 4, 53, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (77, 'req_education', 'dict', 'Образование', NULL, NULL, 4, 51, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (82, 'req_test', 'dict', 'Потребность в дополнительном тестировании кандидата', NULL, NULL, 4, 56, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (83, 'req_characteristics', 'longstring', 'Компетенции, личностные характеристики, которые требуется оценить', NULL, NULL, 4, 57, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (84, 'req_comment', 'longstring', 'Дополнительные требования к кандидату', NULL, NULL, 4, 58, NULL, NULL);

INSERT INTO ref_attr (rattr_id, rattr_name, rattr_type, rattr_label, rattr_required, rattr_system, rattr_group_id, rattr_no, rattr_view, rattr_multilple)
VALUES (85, 'status', 'dict', 'Статус', NULL, NULL, 4, 0, NULL, NULL);

--
-- Data for table pls.entity_attr (OID = 1059653) (LIMIT 0,500)
--
INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (262, 30, 44, '2024-03-17');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (263, 7, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (264, 32, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (265, 1, 44, 'Захаров');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (171, 47, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (172, 49, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (151, 10, 40, '001-24-0001');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (226, 30, 42, '2024-03-14');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (227, 7, 42, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (228, 32, 42, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (229, 1, 42, 'Сидоров');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (230, 5, 42, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (231, 9, 42, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (232, 33, 42, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (233, 6, 42, '2024-03-22');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (234, 35, 42, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (235, 34, 42, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (236, 36, 42, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (237, 37, 42, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (238, 38, 42, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (239, 39, 42, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (240, 40, 42, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (241, 41, 42, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (242, 42, 42, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (243, 43, 42, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (244, 30, 43, '2024-03-01');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (245, 7, 43, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (246, 32, 43, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (247, 1, 43, 'Иванов');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (248, 5, 43, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (249, 9, 43, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (250, 33, 43, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (251, 6, 43, '2024-03-01');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (252, 35, 43, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (253, 34, 43, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (254, 36, 43, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (255, 37, 43, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (256, 38, 43, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (257, 39, 43, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (258, 40, 43, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (259, 41, 43, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (260, 42, 43, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (261, 43, 43, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (280, 85, 45, 'Создана');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (281, 10, 45, '2024213123');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (282, 14, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (283, 16, 45, 'В рамках предельной численности');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (284, 18, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (285, 19, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (286, 20, 45, 'Иванова И.И.');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (287, 11, 45, '213');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (288, 13, 45, '21312');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (289, 12, 45, '213123');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (290, 17, 45, 'основной рабочий');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (291, 21, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (292, 22, 45, '123123');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (293, 23, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (294, 24, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (266, 5, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (267, 9, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (268, 33, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (269, 6, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (270, 35, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (271, 34, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (272, 36, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (273, 37, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (274, 38, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (275, 39, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (276, 40, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (277, 41, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (278, 42, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (279, 43, 44, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (164, 24, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (165, 26, 40, 'На неопределенный срок');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (166, 27, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (167, 28, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (168, 44, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (169, 45, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (170, 46, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (173, 50, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (174, 51, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (175, 52, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (179, 57, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (180, 58, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (181, 59, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (210, 32, 41, 'из армии');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (211, 1, 41, 'Петров');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (182, 60, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (183, 61, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (184, 62, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (185, 63, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (186, 64, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (187, 65, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (188, 66, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (189, 67, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (190, 68, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (191, 69, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (192, 70, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (193, 71, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (194, 72, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (195, 15, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (196, 73, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (197, 74, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (198, 75, 40, '2024-01-10');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (199, 76, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (200, 77, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (201, 78, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (202, 79, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (203, 80, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (204, 81, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (205, 82, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (206, 83, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (207, 84, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (208, 30, 41, '2024-03-01');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (209, 7, 41, 'трудоустройство');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (212, 5, 41, 'Петр');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (213, 9, 41, 'Петрович');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (214, 33, 41, 'муж');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (215, 6, 41, '2002-12-03');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (150, 85, 40, 'Создана');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (152, 14, 40, '2023-01-01');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (153, 16, 40, 'В рамках предельной численности');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (154, 18, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (155, 19, 40, '2024-11-30');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (156, 20, 40, 'Соколова С.И.');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (157, 11, 40, '112');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (158, 13, 40, 'участок 2');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (159, 12, 40, 'Токарь');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (160, 17, 40, 'основной рабочий');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (161, 21, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (162, 22, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (163, 23, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (176, 53, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (177, 54, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (178, 56, 40, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (295, 26, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (296, 27, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (297, 28, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (298, 44, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (299, 45, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (300, 46, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (301, 47, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (302, 49, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (303, 50, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (304, 51, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (305, 52, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (306, 53, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (307, 54, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (308, 56, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (309, 57, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (310, 58, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (311, 59, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (312, 60, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (313, 61, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (314, 62, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (315, 63, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (316, 64, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (317, 65, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (318, 66, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (319, 67, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (320, 68, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (321, 69, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (322, 70, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (323, 71, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (324, 72, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (325, 15, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (326, 73, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (327, 74, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (328, 75, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (329, 76, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (330, 77, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (331, 78, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (332, 79, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (333, 80, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (334, 81, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (335, 82, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (336, 83, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (337, 84, 45, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (338, 85, 46, 'Создана');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (339, 10, 46, '213123-2131231');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (340, 14, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (341, 16, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (342, 18, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (343, 19, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (344, 20, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (345, 11, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (346, 13, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (347, 12, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (348, 17, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (349, 21, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (350, 22, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (351, 23, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (352, 24, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (353, 26, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (354, 27, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (355, 28, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (356, 44, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (357, 45, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (358, 46, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (359, 47, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (360, 49, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (361, 50, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (362, 51, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (363, 52, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (364, 53, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (365, 54, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (366, 56, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (367, 57, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (368, 58, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (369, 59, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (370, 60, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (371, 61, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (372, 62, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (373, 63, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (374, 64, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (375, 65, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (376, 66, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (377, 67, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (378, 68, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (379, 69, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (380, 70, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (381, 71, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (382, 72, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (383, 15, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (384, 73, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (385, 74, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (386, 75, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (387, 76, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (388, 77, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (389, 78, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (390, 79, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (391, 80, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (392, 81, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (393, 82, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (394, 83, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (395, 84, 46, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (396, 85, 47, 'Создана');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (397, 10, 47, '1231232132');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (398, 14, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (399, 16, 47, 'В рамках предельной численности');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (400, 18, 47, 'Средняя');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (401, 19, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (402, 20, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (403, 11, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (404, 13, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (405, 12, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (406, 17, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (407, 21, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (408, 22, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (409, 23, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (410, 24, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (411, 26, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (412, 27, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (413, 28, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (414, 44, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (415, 45, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (416, 46, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (417, 47, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (418, 49, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (419, 50, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (420, 51, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (421, 52, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (422, 53, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (423, 54, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (424, 56, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (425, 57, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (426, 58, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (427, 59, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (428, 60, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (429, 61, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (430, 62, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (431, 63, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (432, 64, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (433, 65, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (434, 66, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (435, 67, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (436, 68, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (437, 69, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (438, 70, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (439, 71, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (440, 72, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (441, 15, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (442, 73, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (443, 74, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (444, 75, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (445, 76, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (446, 77, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (447, 78, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (448, 79, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (449, 80, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (450, 81, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (451, 82, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (452, 83, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (453, 84, 47, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (454, 30, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (455, 7, 48, 'сотрудник предприятия');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (456, 32, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (457, 1, 48, 'Смирнов');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (458, 5, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (459, 9, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (460, 33, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (461, 6, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (462, 35, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (463, 34, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (464, 36, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (465, 37, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (220, 38, 41, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (221, 39, 41, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (222, 40, 41, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (223, 41, 41, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (224, 42, 41, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (225, 43, 41, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (218, 36, 41, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (219, 37, 41, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (466, 38, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (467, 39, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (468, 40, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (469, 41, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (470, 42, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (471, 43, 48, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (472, 85, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (473, 10, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (474, 14, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (475, 16, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (476, 18, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (477, 19, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (478, 20, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (479, 11, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (480, 13, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (481, 12, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (482, 17, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (483, 21, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (484, 22, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (485, 23, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (486, 24, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (487, 26, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (488, 27, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (489, 28, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (490, 44, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (491, 45, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (492, 46, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (493, 47, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (494, 49, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (495, 50, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (496, 51, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (497, 52, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (498, 53, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (499, 54, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (500, 56, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (501, 57, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (502, 58, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (503, 59, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (504, 60, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (505, 61, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (506, 62, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (507, 63, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (508, 64, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (509, 65, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (510, 66, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (511, 67, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (512, 68, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (513, 69, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (514, 70, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (515, 71, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (516, 72, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (517, 15, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (518, 73, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (519, 74, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (520, 75, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (521, 76, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (522, 77, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (523, 78, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (524, 79, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (525, 80, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (526, 81, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (527, 82, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (528, 83, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (529, 84, 49, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (530, 30, 50, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (531, 7, 50, 'трудоустройство');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (532, 32, 50, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (533, 1, 50, 'Попова');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (534, 5, 50, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (535, 9, 50, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (536, 33, 50, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (537, 6, 50, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (538, 35, 50, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (539, 34, 50, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (540, 36, 50, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (541, 37, 50, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (542, 38, 50, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (543, 39, 50, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (544, 40, 50, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (545, 41, 50, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (546, 42, 50, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (547, 43, 50, 'ВФЫА');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (548, 30, 51, '2024-03-14');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (549, 7, 51, 'трудоустройство');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (550, 32, 51, 'дни карьеры');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (551, 1, 51, 'Тест');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (552, 5, 51, 'Тест');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (553, 9, 51, 'Тест');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (554, 33, 51, 'муж');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (555, 6, 51, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (556, 35, 51, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (557, 34, 51, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (558, 36, 51, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (559, 37, 51, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (560, 38, 51, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (561, 39, 51, '213123');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (562, 40, 51, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (563, 41, 51, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (564, 42, 51, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (565, 43, 51, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (566, 85, 52, 'Создана');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (567, 10, 52, '13231231');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (568, 14, 52, '2024-03-16');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (569, 16, 52, 'В рамках предельной численности');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (570, 18, 52, 'Высокая');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (571, 19, 52, '2024-03-02');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (572, 20, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (573, 11, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (574, 13, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (575, 12, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (576, 17, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (577, 21, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (578, 22, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (579, 23, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (580, 24, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (581, 26, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (582, 27, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (583, 28, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (584, 44, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (585, 45, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (586, 46, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (587, 47, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (588, 49, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (589, 50, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (590, 51, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (591, 52, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (592, 53, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (593, 54, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (594, 56, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (595, 57, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (596, 58, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (597, 59, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (598, 60, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (599, 61, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (600, 62, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (601, 63, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (602, 64, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (603, 65, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (604, 66, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (605, 67, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (606, 68, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (607, 69, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (608, 70, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (609, 71, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (610, 72, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (611, 15, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (612, 73, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (613, 74, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (614, 75, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (615, 76, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (616, 77, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (617, 78, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (618, 79, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (619, 80, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (620, 81, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (216, 35, 41, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (217, 34, 41, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (621, 82, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (622, 83, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (623, 84, 52, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (624, 85, 53, 'Создана');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (625, 10, 53, '21312312');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (626, 14, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (627, 16, 53, 'В рамках предельной численности');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (628, 18, 53, 'Высокая');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (629, 19, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (630, 20, 53, 'Соколова С.И.');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (631, 11, 53, '213123');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (632, 13, 53, '12312');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (633, 12, 53, '213');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (634, 17, 53, 'основной рабочий');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (635, 21, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (636, 22, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (637, 23, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (638, 24, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (639, 26, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (640, 27, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (641, 28, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (642, 44, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (643, 45, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (644, 46, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (645, 47, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (646, 49, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (647, 50, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (648, 51, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (649, 52, 53, '');

--
-- Data for table pls.entity_attr (OID = 1059653) (LIMIT 500,122)
--
INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (650, 53, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (651, 54, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (652, 56, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (653, 57, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (654, 58, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (655, 59, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (656, 60, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (657, 61, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (658, 62, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (659, 63, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (660, 64, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (661, 65, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (662, 66, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (663, 67, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (664, 68, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (665, 69, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (666, 70, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (667, 71, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (668, 72, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (669, 15, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (670, 73, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (671, 74, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (672, 75, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (673, 76, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (674, 77, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (675, 78, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (676, 79, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (677, 80, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (678, 81, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (679, 82, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (680, 83, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (681, 84, 53, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (682, 30, 54, '2024-03-17');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (683, 7, 54, 'трудоустройство');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (684, 32, 54, 'дни карьеры');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (685, 1, 54, '213');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (686, 5, 54, '3213123');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (687, 9, 54, '21321312');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (688, 33, 54, 'муж');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (689, 6, 54, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (690, 35, 54, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (691, 34, 54, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (692, 36, 54, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (693, 37, 54, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (694, 38, 54, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (695, 39, 54, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (696, 40, 54, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (697, 41, 54, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (698, 42, 54, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (699, 43, 54, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (700, 30, 55, '2024-03-14');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (701, 7, 55, 'сотрудник предприятия');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (702, 32, 55, 'дни карьеры');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (703, 1, 55, '213');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (704, 5, 55, '213');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (705, 9, 55, '123');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (706, 33, 55, 'жен');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (707, 6, 55, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (708, 35, 55, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (709, 34, 55, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (710, 36, 55, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (711, 37, 55, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (712, 38, 55, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (713, 39, 55, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (714, 40, 55, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (715, 41, 55, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (716, 42, 55, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (717, 43, 55, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (718, 30, 56, '2024-03-17');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (719, 7, 56, 'трудоустройство');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (720, 32, 56, 'дни карьеры');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (721, 1, 56, '213');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (722, 5, 56, '213');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (723, 9, 56, '213');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (724, 33, 56, 'муж');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (725, 6, 56, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (726, 35, 56, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (727, 34, 56, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (728, 36, 56, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (729, 37, 56, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (730, 38, 56, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (731, 39, 56, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (732, 40, 56, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (733, 41, 56, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (734, 42, 56, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (735, 43, 56, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (736, 30, 57, '2024-03-14');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (737, 7, 57, 'трудоустройство');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (738, 32, 57, 'из армии');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (739, 1, 57, '2112312312312');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (740, 5, 57, '213213123');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (741, 9, 57, '213123');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (742, 33, 57, 'муж');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (743, 6, 57, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (744, 35, 57, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (745, 34, 57, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (746, 36, 57, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (747, 37, 57, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (748, 38, 57, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (749, 39, 57, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (750, 40, 57, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (751, 41, 57, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (752, 42, 57, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (753, 43, 57, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (754, 30, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (755, 7, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (756, 32, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (757, 1, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (758, 5, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (759, 9, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (760, 33, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (761, 6, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (762, 35, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (763, 34, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (764, 36, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (765, 37, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (766, 38, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (767, 39, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (768, 40, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (769, 41, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (770, 42, 58, '');

INSERT INTO entity_attr (entity_attr_id, rattr_id, entity_id, entity_attr_value)
VALUES (771, 43, 58, '');

--
-- Data for table pls.ref_attr_group (OID = 1059676) (LIMIT 0,2)
--
INSERT INTO ref_attr_group (rattr_group_id, rattr_group_name, rattr_group_label, rattr_group_no, rentity_type_id)
VALUES (4, 'request_attributes', 'Атрибуты заявки', 1, 4);

INSERT INTO ref_attr_group (rattr_group_id, rattr_group_name, rattr_group_label, rattr_group_no, rentity_type_id)
VALUES (2, 'candidate_attributes', 'Атрибуты кандидата', 1, 2);

--
-- Data for table pls.ref_attr_dict (OID = 1060261) (LIMIT 0,113)
--
INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (29, 32, 8, 'student', 'студент/выпускник МИФИ, ППТ');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (30, 32, 9, 'social_network', 'соцсети');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (31, 32, 10, 'your_vacancy', 'твоя вакансия');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (32, 32, 11, 'bazaar', 'ярмарки вакансий');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (33, 32, 12, 'other', 'другое');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (34, 33, 1, 'male', 'муж');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (3, 17, 1, 'main', 'основной рабочий');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (4, 17, 2, 'all', 'прочий персонал');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (5, 16, 1, 'normal', 'В рамках предельной численности');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (6, 16, 2, 'loss', 'Под перспективную убыль');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (35, 33, 2, 'female', 'жен');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (7, 16, 3, 'over', 'Сверх предельной численности');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (8, 18, 1, 'high', 'Высокая');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (10, 18, 2, 'average', 'Средняя');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (11, 18, 3, 'low', 'Низкая');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (12, 20, 1, 'sokolova', 'Соколова С.И.');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (13, 20, 2, 'ivanova', 'Иванова И.И.');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (75, 61, 3, 'other', 'другое');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (14, 26, 1, 'uncertain', 'На неопределенный срок');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (15, 26, 2, 'period', 'Срочный трудовой договор');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (16, 26, 3, 'part-time', 'По совместительству');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (17, 27, 1, 'shifts', 'Сменный');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (18, 27, 2, 'weekend', 'С предоставлением выходных дней');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (81, 65, 1, 'no', 'отсутствует');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (19, 28, 1, 'yes', 'Предполагаются');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (20, 28, 2, 'no', 'Не предполагаются');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (21, 32, 1, 'career_day', 'дни карьеры');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (1, 7, 1, 'outer', 'трудоустройство');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (82, 65, 2, 'list_1', 'Список №1');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (22, 32, 2, 'army', 'из армии');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (83, 65, 3, 'list_2', 'Список №2');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (23, 32, 3, 'division', 'кандидат подразделения');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (2, 7, 2, 'inner', 'сотрудник предприятия');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (56, 50, 1, '5_2', 'Пятидневная рабочая неделя с выходными днями СБ,ВС');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (57, 50, 2, '5_0', 'Пятидневная рабочая неделя с предоставлением выходных по индивидуальному графику');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (84, 66, 1, 'no', 'Без анкеты');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (58, 50, 3, '7_0', 'Рабочая неделя с предоставлением выходных дней по скользящему графику');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (36, 36, 1, 'vpo', 'Высшее профессиональное');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (37, 36, 2, 'spo', 'Среднее профессиональное');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (39, 36, 4, 'so', 'Среднее общее');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (40, 36, 5, 'nv', 'Неоконченое высшее');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (41, 41, 1, 'yes', 'Да');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (85, 66, 2, '1', '1');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (24, 32, 4, 'site', 'работные сайты');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (26, 32, 5, 'referal', 'реферал (привел сотрудник комбината)');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (28, 32, 7, 'saraphan', 'сарафанное радио');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (27, 32, 6, 'himself', 'сам пришел');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (42, 41, 2, 'no', 'Нет');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (86, 66, 3, '2', '2');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (87, 66, 4, '3', '3');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (38, 36, 3, 'npo', 'Начальное профессиональное');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (90, 70, 1, 'no', 'без вредных и опасных производственных факторов');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (67, 60, 2, '6', '6');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (68, 60, 3, '8', '8');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (69, 60, 4, '10', '10');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (64, 56, 1, 'yes', 'Да');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (65, 56, 2, 'no', 'Нет');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (59, 54, 1, 'lpp_no', 'ЛПП нет');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (60, 54, 2, 'lpp_1', 'ЛПП №1');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (61, 54, 3, 'lpp_2', 'ЛПП №2');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (62, 54, 4, 'lpp_3', 'ЛПП №3');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (43, 42, 1, 'pp1', 'ПП1');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (44, 42, 1, 'pp2', 'ПП2');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (63, 54, 5, 'lpp_4', 'ЛПП №4');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (45, 42, 2, 'pp3', 'ПП3');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (46, 42, 3, 'pp4', 'ПП4');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (47, 42, 4, 'pp5', 'ПП5');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (48, 42, 5, 'pp6', 'ПП6');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (49, 42, 6, 'pp7', 'ПП7');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (50, 42, 7, 'pp8', 'П8-инвалиды');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (51, 42, 8, 'pp9', 'П9-МС');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (52, 46, 1, 'no', 'не требуется');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (53, 46, 2, 'yes', 'требуется');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (54, 49, 1, 'yes', 'Да');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (55, 49, 2, 'no', 'Нет');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (66, 60, 1, '4', '4');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (70, 60, 5, '12', '12');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (71, 60, 6, '16', '16');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (72, 60, 7, '24', '24');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (88, 70, 2, '184', '1.8.4 Фтор');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (89, 70, 3, '44', '4.4 Шум');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (91, 71, 1, 'no', 'отсутствуют');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (92, 71, 2, '10', 'Деятельность, связанная с работами с использованием сведений, составляющими государственную тайну');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (96, 72, 3, '2', '2.0 - допустимые');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (93, 71, 3, '11', 'Деятельность в сфере электроэнергетики, связанная с организацией и осуществлением монтажа, наладки, технического обслуживания, ремонта, управления режимом работы электроустановок');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (94, 72, 1, 'no', 'рабочее место не аттестовано');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (95, 72, 2, '1', '1.0 - оптимальные');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (77, 62, 1, '3', '3');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (78, 62, 2, '7', '7');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (79, 62, 3, '14', '14');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (80, 62, 4, '21', '21');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (73, 61, 1, 'harmful', 'за вредные условия труда');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (74, 61, 2, 'not_norm', 'за ненормированный рабочий день');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (98, 72, 5, '32', '3.2 - вредные');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (97, 72, 4, '31', '3.1 - вредные');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (99, 72, 6, '33', '3.3 - вредные');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (100, 72, 7, '34', '3.4 - вредные');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (101, 72, 8, '40', '4.0 - опасные');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (103, 15, 2, 'new', 'создание нового подразделения/ввод новой должности в штатное расписание');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (102, 15, 1, 'fill', 'незаполненная вакансия по штатному расписанию');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (104, 15, 3, 'replacment', 'замещение должности увольняющегося работника');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (106, 15, 5, 'replacement_temporary', 'замещение временно отсутствующего работника');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (105, 15, 4, 'transfer', 'перевод работника (внутри организации)');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (110, 77, 4, 'no', 'без требований к образованию');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (109, 77, 3, 'np', 'начальное профессиональное');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (108, 77, 2, 'sp', 'среднее профессиональное');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (107, 77, 1, 'vp', 'высшее профессиональное');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (111, 82, 1, 'yes', 'Да');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (112, 82, 2, 'no', 'Нет');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (113, 85, 1, 'created', 'Создана');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (115, 85, 3, 'approved', 'Утверждена');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (114, 85, 2, 'on_approvement', 'На согласовании');

INSERT INTO ref_attr_dict (rattr_dict_id, rattr_id, rattr_dict_no, rattr_dict_name, rattr_dict_label)
VALUES (116, 85, 4, 'planned', 'Включена в план подбора');

--
-- Data for table pls.ref_action (OID = 1075661) (LIMIT 0,4)
--
INSERT INTO ref_action (raction_id, raction_name, raction_label)
VALUES (4, 'rollback', 'Отправить на предыдущий этап');

INSERT INTO ref_action (raction_id, raction_name, raction_label)
VALUES (3, 'reject', 'Отклонить');

INSERT INTO ref_action (raction_id, raction_name, raction_label)
VALUES (2, 'approve', 'Утвердить');

INSERT INTO ref_action (raction_id, raction_name, raction_label)
VALUES (1, 'move', 'Отправить на следующий этап');

--
-- Data for table pls.entity_entity (OID = 1223127) (LIMIT 0,4)
--
INSERT INTO entity_entity (ent_ent_id, entity_id, entity_id_link, ts_created, ts_deleted)
VALUES (9, 40, 42, NULL, NULL);

INSERT INTO entity_entity (ent_ent_id, entity_id, entity_id_link, ts_created, ts_deleted)
VALUES (10, 40, 41, NULL, NULL);

INSERT INTO entity_entity (ent_ent_id, entity_id, entity_id_link, ts_created, ts_deleted)
VALUES (11, 40, 44, NULL, NULL);

INSERT INTO entity_entity (ent_ent_id, entity_id, entity_id_link, ts_created, ts_deleted)
VALUES (12, 45, 48, NULL, NULL);

--
-- Data for table pls.ref_route (OID = 1275415) (LIMIT 0,1)
--
INSERT INTO ref_route (rroute_id, rroute_name, rroute_label, rstage_id_start)
VALUES (1, 'default_request', 'Заявка по-умолчанию', NULL);

--
-- Definition for index entity_pkey (OID = 1059628) : 
--
ALTER TABLE ONLY entity
    ADD CONSTRAINT entity_pkey
    PRIMARY KEY (entity_id);
--
-- Definition for index entity_types_pkey (OID = 1059638) : 
--
ALTER TABLE ONLY ref_entity_type
    ADD CONSTRAINT entity_types_pkey
    PRIMARY KEY (rentity_type_id);
--
-- Definition for index ref_attr_pkey (OID = 1059646) : 
--
ALTER TABLE ONLY ref_attr
    ADD CONSTRAINT ref_attr_pkey
    PRIMARY KEY (rattr_id);
--
-- Definition for index entity_attr_pkey (OID = 1059657) : 
--
ALTER TABLE ONLY entity_attr
    ADD CONSTRAINT entity_attr_pkey
    PRIMARY KEY (entity_attr_id);
--
-- Definition for index ref_attr_group_pkey (OID = 1059680) : 
--
ALTER TABLE ONLY ref_attr_group
    ADD CONSTRAINT ref_attr_group_pkey
    PRIMARY KEY (rattr_group_id);
--
-- Definition for index entity_stage_pkey (OID = 1060003) : 
--
ALTER TABLE ONLY entity_stage
    ADD CONSTRAINT entity_stage_pkey
    PRIMARY KEY (entity_stage_id);
--
-- Definition for index ref_stage_pkey (OID = 1060012) : 
--
ALTER TABLE ONLY ref_stage
    ADD CONSTRAINT ref_stage_pkey
    PRIMARY KEY (rstage_id);
--
-- Definition for index ref_actor_pkey (OID = 1060021) : 
--
ALTER TABLE ONLY ref_actor
    ADD CONSTRAINT ref_actor_pkey
    PRIMARY KEY (ractor_id);
--
-- Definition for index ref_stage_actor_pkey (OID = 1060028) : 
--
ALTER TABLE ONLY ref_stage_action
    ADD CONSTRAINT ref_stage_actor_pkey
    PRIMARY KEY (rstage_action_id);
--
-- Definition for index ref_attr_dict_pkey (OID = 1060265) : 
--
ALTER TABLE ONLY ref_attr_dict
    ADD CONSTRAINT ref_attr_dict_pkey
    PRIMARY KEY (rattr_dict_id);
--
-- Definition for index ref_attr_outer_pkey (OID = 1060277) : 
--
ALTER TABLE ONLY ref_attr_outer
    ADD CONSTRAINT ref_attr_outer_pkey
    PRIMARY KEY (rattr_outer_id);
--
-- Definition for index ref_action_pkey (OID = 1075671) : 
--
ALTER TABLE ONLY ref_action
    ADD CONSTRAINT ref_action_pkey
    PRIMARY KEY (raction_id);
--
-- Definition for index ref_attr_actor_pkey (OID = 1085460) : 
--
ALTER TABLE ONLY ref_attr_actor
    ADD CONSTRAINT ref_attr_actor_pkey
    PRIMARY KEY (rattr_actor_id);
--
-- Definition for index entity_attr_fk (OID = 1212232) : 
--
ALTER TABLE ONLY entity_attr
    ADD CONSTRAINT entity_attr_fk
    FOREIGN KEY (entity_id) REFERENCES entity(entity_id);
--
-- Definition for index entity_attr_fk1 (OID = 1212246) : 
--
ALTER TABLE ONLY entity_attr
    ADD CONSTRAINT entity_attr_fk1
    FOREIGN KEY (rattr_id) REFERENCES ref_attr(rattr_id);
--
-- Definition for index entity_fk (OID = 1221772) : 
--
ALTER TABLE ONLY entity
    ADD CONSTRAINT entity_fk
    FOREIGN KEY (rentity_type_id) REFERENCES ref_entity_type(rentity_type_id);
--
-- Definition for index ref_attr_fk (OID = 1221813) : 
--
ALTER TABLE ONLY ref_attr
    ADD CONSTRAINT ref_attr_fk
    FOREIGN KEY (rattr_group_id) REFERENCES ref_attr_group(rattr_group_id);
--
-- Definition for index entity_entity_pkey (OID = 1223131) : 
--
ALTER TABLE ONLY entity_entity
    ADD CONSTRAINT entity_entity_pkey
    PRIMARY KEY (ent_ent_id);
--
-- Definition for index entity_entity_idx (OID = 1223134) : 
--
ALTER TABLE ONLY entity_entity
    ADD CONSTRAINT entity_entity_idx
    UNIQUE (entity_id, entity_id_link);
--
-- Definition for index entity_entity_fk (OID = 1223143) : 
--
ALTER TABLE ONLY entity_entity
    ADD CONSTRAINT entity_entity_fk
    FOREIGN KEY (entity_id) REFERENCES entity(entity_id);
--
-- Definition for index entity_entity_fk1 (OID = 1223153) : 
--
ALTER TABLE ONLY entity_entity
    ADD CONSTRAINT entity_entity_fk1
    FOREIGN KEY (entity_id_link) REFERENCES entity(entity_id);
--
-- Definition for index ref_stage_action_actor_pkey (OID = 1260929) : 
--
ALTER TABLE ONLY ref_stage_action_actor
    ADD CONSTRAINT ref_stage_action_actor_pkey
    PRIMARY KEY (rstage_action_actor_id);
--
-- Definition for index ref_stage_actor_stage_pkey (OID = 1261497) : 
--
ALTER TABLE ONLY ref_stage_action_stage
    ADD CONSTRAINT ref_stage_actor_stage_pkey
    PRIMARY KEY (rstage_action_stage_id);
--
-- Definition for index ref_route_pkey (OID = 1275421) : 
--
ALTER TABLE ONLY ref_route
    ADD CONSTRAINT ref_route_pkey
    PRIMARY KEY (rroute_id);
--
-- Definition for index ref_route_fk (OID = 1275423) : 
--
ALTER TABLE ONLY ref_route
    ADD CONSTRAINT ref_route_fk
    FOREIGN KEY (rstage_id_start) REFERENCES ref_stage(rstage_id) DEFERRABLE;
--
-- Definition for index ref_stage_fk (OID = 1275434) : 
--
ALTER TABLE ONLY ref_stage
    ADD CONSTRAINT ref_stage_fk
    FOREIGN KEY (rroute_id) REFERENCES ref_route(rroute_id) DEFERRABLE;
--
-- Definition for index ref_attr_group_actor_pkey (OID = 1275519) : 
--
ALTER TABLE ONLY ref_attr_group_actor
    ADD CONSTRAINT ref_attr_group_actor_pkey
    PRIMARY KEY (rattr_group_actor_id);
--
-- Definition for index ref_attr_group_actor_fk (OID = 1275600) : 
--
ALTER TABLE ONLY ref_attr_group_actor
    ADD CONSTRAINT ref_attr_group_actor_fk
    FOREIGN KEY (ractor_id) REFERENCES ref_actor(ractor_id) DEFERRABLE;
--
-- Definition for index ref_attr_group_actor_fk1 (OID = 1275605) : 
--
ALTER TABLE ONLY ref_attr_group_actor
    ADD CONSTRAINT ref_attr_group_actor_fk1
    FOREIGN KEY (rattr_group_id) REFERENCES ref_attr_group(rattr_group_id) DEFERRABLE;
--
-- Definition for index entity_attr_log_pkey (OID = 1282861) : 
--
ALTER TABLE ONLY entity_attr_log
    ADD CONSTRAINT entity_attr_log_pkey
    PRIMARY KEY (entity_attr_log_id);
--
-- Definition for index entity_attr_log_fk (OID = 1282863) : 
--
ALTER TABLE ONLY entity_attr_log
    ADD CONSTRAINT entity_attr_log_fk
    FOREIGN KEY (entity_id) REFERENCES entity(entity_id);
--
-- Definition for index entity_attr_log_fk1 (OID = 1282868) : 
--
ALTER TABLE ONLY entity_attr_log
    ADD CONSTRAINT entity_attr_log_fk1
    FOREIGN KEY (rattr_id) REFERENCES ref_attr(rattr_id);
--
-- Data for sequence pls.entity_ent_id_seq (OID = 1059623)
--
SELECT pg_catalog.setval('entity_ent_id_seq', 58, true);
--
-- Data for sequence pls.entity_types_ent_type_id_seq (OID = 1059633)
--
SELECT pg_catalog.setval('entity_types_ent_type_id_seq', 5, true);
--
-- Data for sequence pls.ref_attr_rattr_id_seq (OID = 1059641)
--
SELECT pg_catalog.setval('ref_attr_rattr_id_seq', 85, true);
--
-- Data for sequence pls.entity_attr_ent_attr_id_seq (OID = 1059652)
--
SELECT pg_catalog.setval('entity_attr_ent_attr_id_seq', 771, true);
--
-- Data for sequence pls.ref_attr_group_rag_id_seq (OID = 1059675)
--
SELECT pg_catalog.setval('ref_attr_group_rag_id_seq', 3, true);
--
-- Data for sequence pls.entity_stage_entity_stage_id_seq (OID = 1059998)
--
SELECT pg_catalog.setval('entity_stage_entity_stage_id_seq', 1, false);
--
-- Data for sequence pls.ref_stage_rstage_id_seq (OID = 1060005)
--
SELECT pg_catalog.setval('ref_stage_rstage_id_seq', 1, false);
--
-- Data for sequence pls.ref_actor_ractor_id_seq (OID = 1060014)
--
SELECT pg_catalog.setval('ref_actor_ractor_id_seq', 1, false);
--
-- Data for sequence pls.ref_stage_actor_ref_stage_actor_id_seq (OID = 1060023)
--
SELECT pg_catalog.setval('ref_stage_actor_ref_stage_actor_id_seq', 1, false);
--
-- Data for sequence pls.ref_attr_dict_rattr_dict_id_seq (OID = 1060260)
--
SELECT pg_catalog.setval('ref_attr_dict_rattr_dict_id_seq', 116, true);
--
-- Data for sequence pls.ref_attr_outer_rattr_outer_id_seq (OID = 1060270)
--
SELECT pg_catalog.setval('ref_attr_outer_rattr_outer_id_seq', 1, false);
--
-- Data for sequence pls.ref_action_raction_id_seq (OID = 1075670)
--
SELECT pg_catalog.setval('ref_action_raction_id_seq', 4, true);
--
-- Data for sequence pls.ref_attr_actor_rattr_actor_id_seq (OID = 1085455)
--
SELECT pg_catalog.setval('ref_attr_actor_rattr_actor_id_seq', 1, false);
--
-- Data for sequence pls.entity_entity_ent_ent_id_seq (OID = 1223126)
--
SELECT pg_catalog.setval('entity_entity_ent_ent_id_seq', 12, true);
--
-- Data for sequence pls.ref_stage_action_actor_ref_stage_action_actor_id_seq (OID = 1260924)
--
SELECT pg_catalog.setval('ref_stage_action_actor_ref_stage_action_actor_id_seq', 1, false);
--
-- Data for sequence pls.ref_stage_actor_stage_rstage_action_stage_id_seq (OID = 1261492)
--
SELECT pg_catalog.setval('ref_stage_actor_stage_rstage_action_stage_id_seq', 1, false);
--
-- Data for sequence pls.ref_route_rroute_id_seq (OID = 1275414)
--
SELECT pg_catalog.setval('ref_route_rroute_id_seq', 2, true);
--
-- Data for sequence pls.ref_attr_group_actor_rattr_group_actor_id_seq (OID = 1275512)
--
SELECT pg_catalog.setval('ref_attr_group_actor_rattr_group_actor_id_seq', 1, false);
--
-- Data for sequence pls.entity_attr_log_entity_attr_log_id_seq (OID = 1282854)
--
SELECT pg_catalog.setval('entity_attr_log_entity_attr_log_id_seq', 1, false);
--
-- Comments
--
COMMENT ON COLUMN pls.entity.rentity_type_id IS 'ref_entity_type';
COMMENT ON COLUMN pls.entity.ts_deleted IS 'пометка, что сущность удалена в корзину';
COMMENT ON COLUMN pls.entity.chatroom_uuid IS 'ссылка на чат в мессенджере';
COMMENT ON COLUMN pls.ref_entity_type.rroute_id IS 'указатель маршрута, там будет с какого этапа начинается';
COMMENT ON COLUMN pls.ref_attr.rattr_label IS 'отображаемое имя';
COMMENT ON COLUMN pls.ref_attr.rattr_required IS 'обязательный';
COMMENT ON COLUMN pls.ref_attr.rattr_system IS 'служебный';
COMMENT ON COLUMN pls.ref_attr.rattr_group_id IS 'группа атрибутов';
COMMENT ON COLUMN pls.ref_attr.rattr_no IS 'порядковый номер';
COMMENT ON COLUMN pls.ref_attr.rattr_view IS 'это атрибут используется для отображения и идентификации сущности';
COMMENT ON COLUMN pls.ref_attr.rattr_multilple IS 'сущность может иметь несколько значений (копий) этого атрибута. Например, у укандидата несколько образований.';
COMMENT ON COLUMN pls.ref_attr_group.rattr_group_no IS 'порядковый номер для отображения';
COMMENT ON COLUMN pls.ref_attr_group.rentity_type_id IS 'указатель какой тип сущности обладает этой группа атрибутов';
COMMENT ON COLUMN pls.entity_stage.rstage_id IS 'из справочника этапов';
COMMENT ON COLUMN pls.entity_stage.entity_id IS 'какая сущность соединена с этим этапом';
COMMENT ON COLUMN pls.ref_stage.rentity_type_id IS 'какой тип сущности создавать при создании этого этапа';
COMMENT ON COLUMN pls.ref_stage.rstage_wait_others IS 'когда этап переходит на этот, если True, то всегда проверяет, есть ли потенциальные другие этапы, которые в этот переходят. Если такие есть - ждет. Если таких нет (или они закончились и перешли в этот), то включает этот этап.';
COMMENT ON COLUMN pls.ref_stage.rroute_id IS 'маршрут, который объединяет все этапы';
COMMENT ON COLUMN pls.ref_actor.ractor_auth_group_name IS 'соответствие auth.auth_groups.name';
COMMENT ON TABLE pls.ref_stage_action IS 'на этапе можно совершить разные действия разным акторам';
COMMENT ON COLUMN pls.ref_stage_action.rstage_id IS 'на каком этапе';
COMMENT ON COLUMN pls.ref_stage_action.raction_id IS 'какое действие может выполнить';
COMMENT ON COLUMN pls.ref_attr_dict.rattr_dict_no IS 'порядковый номер при отображении';
COMMENT ON COLUMN pls.ref_attr_dict.rattr_dict_name IS '!! После использования нельзя редактировать. Именно это поле записывается в значения атрибутов';
COMMENT ON COLUMN pls.ref_attr_dict.rattr_dict_label IS 'Отображаемый текст варианта выбора';
COMMENT ON COLUMN pls.ref_attr_outer.rattr_outer_fields IS 'какие поля показывать при выборе из справочника';
COMMENT ON COLUMN pls.ref_attr_outer.rattr_outer_path IS 'где находится этот справочник';
COMMENT ON COLUMN pls.ref_attr_outer.rattr_outer_key IS 'какое поле записывается в значение атрибута';
COMMENT ON COLUMN pls.ref_attr_outer.rattr_outer_sort IS 'по каким полям сортируется при отображении справочника';
COMMENT ON TABLE pls.ref_attr_actor IS 'Какой атрибут на каком этапе может редактирвоать';
COMMENT ON COLUMN pls.ref_attr_actor.rattr_id IS 'какой атрибут';
COMMENT ON COLUMN pls.ref_attr_actor.ractor_id IS 'какой актор';
COMMENT ON COLUMN pls.ref_attr_actor.rstage_id IS 'на каком конкретном этапе (NULL=на всех)';
COMMENT ON SERVER test4_tsup_ecp IS 'Используется для внешних таблиц в схеме egt';
COMMENT ON TABLE pls.entity_entity IS 'Связь двух сущностей';
COMMENT ON COLUMN pls.entity_entity.ent_ent_id IS 'уникальный ключ связки';
COMMENT ON COLUMN pls.entity_entity.entity_id IS 'сущность_родитель';
COMMENT ON COLUMN pls.entity_entity.entity_id_link IS 'сущность_дитя';
COMMENT ON TABLE pls.ref_stage_action_actor IS 'какое действие на каком этапе может выполнить какой актор';
COMMENT ON COLUMN pls.ref_stage_action_actor.rstage_action_id IS 'указатель на этап и действие';
COMMENT ON COLUMN pls.ref_stage_action_actor.ractor_id IS 'указатель на актора';
COMMENT ON COLUMN pls.ref_stage_action_stage.rstage_action_id IS 'после какого действия другого этапа';
COMMENT ON COLUMN pls.ref_stage_action_stage.rstage_id IS 'какие новые этапы начинаются (возможна развилка и распаллеливание)';
COMMENT ON TABLE pls.ref_route IS 'Маршрут, который объединяет несколько этапов';
COMMENT ON COLUMN pls.ref_route.rstage_id_start IS 'Этап, с которого начинается этот маршрут';
COMMENT ON COLUMN pls.ref_attr_group_actor.rattr_group_id IS 'в какой группе атрибутов';
COMMENT ON COLUMN pls.ref_attr_group_actor.ractor_id IS 'какой актор (роль)';
COMMENT ON COLUMN pls.ref_attr_group_actor.can_edit IS 'может редактировать все атрибуты в этой группе (по умолчанию нет)';
COMMENT ON COLUMN pls.ref_attr_group_actor.can_read IS 'может видеть атрибуты в этой группе (по умолчанию да)';
