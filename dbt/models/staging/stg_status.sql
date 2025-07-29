{{
    config(
        materialized='view'
    )
}}


select
    _dlt_parent_id UUID,
    name Status
from {{ source('staging','leet_code_tracking__properties__x__multi_select') }}