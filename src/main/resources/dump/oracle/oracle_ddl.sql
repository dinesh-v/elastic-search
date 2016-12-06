CREATE TABLE ipps_summary (
    id                          int NOT NULL,
    provider_id                 int NOT NULL,
    drg_definition              VARCHAR2(100) NOT NULL,
    provider_name               VARCHAR2(100) NOT NULL,
    provider_street_address     VARCHAR2(100) NOT NULL,
    provider_city               VARCHAR2(50) NOT NULL,
    provider_state              VARCHAR2(5) NOT NULL,
    provider_zip_code           int NOT NULL,
    hrrd                        VARCHAR2(100) NOT NULL,
    total_discharges            int NOT NULL,
    average_covered_charges     VARCHAR2(30) NOT NULL,
    average_total_payments      VARCHAR2(30) NOT NULL,
    average_medicare_payments   VARCHAR2(30) NOT NULL,
    CONSTRAINT ipps_summary_pk PRIMARY KEY ( id ) ENABLE
);
CREATE SEQUENCE ipps_seq
  START WITH 1
  INCREMENT BY 1
  CACHE 100;