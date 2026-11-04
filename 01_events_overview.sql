SELECT
  event_name,
  COUNT(*) AS nb_evenements,
  COUNT(DISTINCT user_pseudo_id) AS nb_utilisateurs
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY event_name
ORDER BY nb_evenements DESC
