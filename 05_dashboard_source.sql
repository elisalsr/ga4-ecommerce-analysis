SELECT
  PARSE_DATE('%Y%m%d', event_date) AS date,
  traffic_source.medium AS canal,
  device.category AS appareil,
  COUNT(DISTINCT user_pseudo_id) AS visiteurs,
  COUNT(DISTINCT IF(event_name = 'view_item', user_pseudo_id, NULL)) AS vue_produit,
  COUNT(DISTINCT IF(event_name = 'add_to_cart', user_pseudo_id, NULL)) AS ajout_panier,
  COUNT(DISTINCT IF(event_name = 'begin_checkout', user_pseudo_id, NULL)) AS debut_paiement,
  COUNT(DISTINCT IF(event_name = 'purchase', user_pseudo_id, NULL)) AS acheteurs,
  SUM(IF(event_name = 'purchase', ecommerce.purchase_revenue, 0)) AS revenu
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY date, canal, appareil
