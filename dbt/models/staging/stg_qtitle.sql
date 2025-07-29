{{
    config(
        materialized='view'
    )
}}


select
    _dlt_parent_id UUID,
    plain_text Question
from {{ source('staging','leet_code_tracking__properties__question_title__rich_text') }}