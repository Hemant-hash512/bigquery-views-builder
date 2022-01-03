CREATE OR REPLACE VIEW `root-micron-336614.dataset_example.view_cart_latest`
OPTIONS(
description="the latest representation of each cart-new"
)
AS
SELECT * EXCEPT(row_number)
  FROM (
   SELECT
     *,
     ROW_NUMBER() OVER(PARTITION BY Id ORDER BY PartitionTimestamp DESC) row_number
   FROM(
    SELECT * FROM `root-micron-336614.dataset_example.cart_timeseries`
      UNION ALL
    SELECT * FROM `root-micron-336614.dataset_example.cart_staging` WHERE _PARTITIONDATE >= DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY)
   )
  ) 
  WHERE row_number = 1
