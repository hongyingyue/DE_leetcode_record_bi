{{
    config(
        materialized='table'
    )
}}


with main as (
    select * 
    from {{ ref('stg_main') }}
),
qno as (
    select * 
    from {{ ref('stg_qno') }}
),
qtitle as (
    select * 
    from {{ ref('stg_qtitle') }}
)

select
    qno.QNo,
    qtitle.Question,
    main.Level,
    main.last_edited_date_pst
from main
join qno
    on main.UUID = qno.UUID
join qtitle
    on main.UUID = qtitle.UUID

