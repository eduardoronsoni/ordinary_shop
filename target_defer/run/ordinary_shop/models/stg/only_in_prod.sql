
  
    

    create or replace table `dbt-studies-462323`.`ordinary_shop_dbt_prod`.`only_in_prod`
      
    
    

    OPTIONS()
    as (
      select *
from `dbt-studies-462323`.`source_data`.`customers`
    );
  