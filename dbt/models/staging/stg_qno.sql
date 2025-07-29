{{
    config(
        materialized='view'
    )
}}


select
    _dlt_parent_id UUID,
    plain_text QNo
from {{ source('staging','leet_code_tracking__properties__qno__title') }}