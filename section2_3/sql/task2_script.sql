-- Add a new column last_review_date to the Listings table.
alter table sch_bronze_airbnb.dim_host add column last_review_date date;
-- Create a new table Amenities with fields amenity_id, listing_id, and
-- amenity_name.
create table if not exists sch_bronze_airbnb.dim_amenities (
	amenity_id bigint NOT NULL,
	host_id bigint,
	amenity_name character varying(512) NOT NULL,
	CONSTRAINT pk_dim_amenities PRIMARY KEY (amenity_id)
);

ALTER TABLE IF EXISTS sch_bronze_airbnb.dim_amenities
    ADD CONSTRAINT fk_dim_host FOREIGN KEY (host_id)
    REFERENCES sch_bronze_airbnb.dim_host (host_id) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE CASCADE
    NOT VALID;