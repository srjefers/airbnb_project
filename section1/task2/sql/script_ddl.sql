-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://github.com/pgadmin-org/pgadmin4/issues/new/choose if you find any bugs, including reproduction steps.
BEGIN;


ALTER TABLE IF EXISTS sch_airbnb.fct_home DROP CONSTRAINT IF EXISTS fk_dim_neighborhood;

ALTER TABLE IF EXISTS sch_airbnb.fct_home DROP CONSTRAINT IF EXISTS fk_dim_host;

ALTER TABLE IF EXISTS sch_airbnb.fct_home DROP CONSTRAINT IF EXISTS fk_dim_review;

ALTER TABLE IF EXISTS sch_airbnb.fct_home DROP CONSTRAINT IF EXISTS fk_dim_room_type;



DROP TABLE IF EXISTS sch_airbnb.dim_host;

CREATE TABLE IF NOT EXISTS sch_airbnb.dim_host
(
    host_id bigint NOT NULL,
    host_name character varying(256) NOT NULL,
    host_calculated_listings_count integer NOT NULL,
    CONSTRAINT pk_dim_host PRIMARY KEY (host_id)
);

COMMENT ON TABLE sch_airbnb.dim_host
    IS 'Table Host, created at sch_airbnb schema at postgres database.';

DROP TABLE IF EXISTS sch_airbnb.dim_review;

CREATE TABLE IF NOT EXISTS sch_airbnb.dim_review
(
    review_id bigserial NOT NULL,
    number_of_reviews bigint NOT NULL,
    last_review date NOT NULL,
    reviews_per_month bigint NOT NULL,
    CONSTRAINT pk_dim_review PRIMARY KEY (review_id)
);

COMMENT ON TABLE sch_airbnb.dim_review
    IS 'Table Reviews, created at sch_airbnb schema at postgres database.';

DROP TABLE IF EXISTS sch_airbnb.dim_neighborhood;

CREATE TABLE IF NOT EXISTS sch_airbnb.dim_neighborhood
(
    neighborhood_id bigserial NOT NULL,
    neighbourhood_group character varying(120) NOT NULL,
    neighbourhood_name character varying(120) NOT NULL,
    CONSTRAINT pk_dim_neighborhood PRIMARY KEY (neighborhood_id)
);

COMMENT ON TABLE sch_airbnb.dim_neighborhood
    IS 'Table Neighborhoods, created at sch_airbnb schema at postgres database.';

DROP TABLE IF EXISTS sch_airbnb.fct_home;

CREATE TABLE IF NOT EXISTS sch_airbnb.fct_home
(
    home_id bigint NOT NULL,
    home_name character varying(512) NOT NULL,
    home_latitude numeric(10, 8) NOT NULL,
    home_longitude numeric(10, 8) NOT NULL,
    home_price numeric(10, 2) NOT NULL,
    home_minimum_nights integer NOT NULL,
    home_availability_365 integer NOT NULL,
    fk_neighborhood_id bigint,
    fk_host_id bigint,
    fk_review_id bigint,
    fk_room_type_id bigint,
    CONSTRAINT pk_fct_home PRIMARY KEY (id)
);

COMMENT ON TABLE sch_airbnb.fct_home
    IS 'Table home, created at sch_airbnb schema at postgres database.';

DROP TABLE IF EXISTS sch_airbnb.dim_room_type;

CREATE TABLE IF NOT EXISTS sch_airbnb.dim_room_type
(
    room_type_id bigserial NOT NULL,
    room_type_name character varying(128) NOT NULL,
    PRIMARY KEY (room_type_id)
);

COMMENT ON TABLE sch_airbnb.dim_room_type
    IS 'Table Room_type, created at sch_airbnb schema at postgres database.';

ALTER TABLE IF EXISTS sch_airbnb.fct_home
    ADD CONSTRAINT fk_dim_neighborhood FOREIGN KEY (fk_neighborhood_id)
    REFERENCES sch_airbnb.dim_neighborhood (neighborhood_id) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS sch_airbnb.fct_home
    ADD CONSTRAINT fk_dim_host FOREIGN KEY (fk_host_id)
    REFERENCES sch_airbnb.dim_host (host_id) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS sch_airbnb.fct_home
    ADD CONSTRAINT fk_dim_review FOREIGN KEY (fk_review_id)
    REFERENCES sch_airbnb.dim_review (review_id) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE CASCADE
    NOT VALID;


ALTER TABLE IF EXISTS sch_airbnb.fct_home
    ADD CONSTRAINT fk_dim_room_type FOREIGN KEY (fk_room_type_id)
    REFERENCES sch_airbnb.dim_room_type (room_type_id) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE CASCADE
    NOT VALID;

END;