SELECT
  device.category AS appareil,
  COUNT(DISTINCT user_pseudo_id) AS visiteurs,
  COUNT(DISTINCT IF(event_name = 'purchase', user_pseudo_id, NULL)) AS acheteurs,
  ROUND(SAFE_DIVIDE(
    COUNT(DISTINCT IF(event_name = 'purchase', user_pseudo_id, NULL)),
    COUNT(DISTINCT user_pseudo_id)) * 100, 2) AS taux_conversion,
  ROUND(SUM(IF(event_name = 'purchase', ecommerce.purchase_revenue, 0)), 0) AS revenu,
  ROUND(SAFE_DIVIDE(
    SUM(IF(event_name = 'purchase', ecommerce.purchase_revenue, 0)),
    COUNT(DISTINCT IF(event_name = 'purchase', user_pseudo_id, NULL))), 1) AS panier_moyen
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY appareil
ORDER BY revenu DESC
