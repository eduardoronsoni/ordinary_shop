select 'EUUU' as id
from {{ source('ordinary_shop', 'customers')}}