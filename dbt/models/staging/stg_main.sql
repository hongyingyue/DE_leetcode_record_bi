{{
    config(
        materialized='view'
    )
}}


SELECT
    _dlt_id AS UUID,
    properties__level__select__name AS Level,
    last_edited_time,
    DATETIME(TIMESTAMP(last_edited_time), "America/Los_Angeles") AS last_edited_time_pst,
    DATE(DATETIME(TIMESTAMP(last_edited_time), "America/Los_Angeles")) AS last_edited_date_pst
FROM {{ source('staging','leet_code_tracking') }}
