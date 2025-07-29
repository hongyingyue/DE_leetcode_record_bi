{{
    config(
        materialized='view'
    )
}}


select
    _dlt_parent_id UUID,
    name List
from {{ source('staging','leet_code_tracking__properties__list__multi_select') }}