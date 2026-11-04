WITH utilisateurs_par_etape AS (
  SELECT
    COUNT(DISTINCT IF(event_name = 'view_item', user_pseudo_id, NULL)) AS vue_produit,
    COUNT(DISTINCT IF(event_name = 'add_to_cart', user_pseudo_id, NULL)) AS ajout_panier,
    COUNT(DISTINCT IF(event_name = 'begin_checkout', user_pseudo_id, NULL)) AS debut_paiement,
    COUNT(DISTINCT IF(event_name = 'purchase', user_pseudo_id, NULL)) AS achat
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
)
SELECT
  vue_produit,
  ajout_panier,
  debut_paiement,
  achat,
  ROUND(ajout_panier / vue_produit * 100, 1) AS taux_vue_vers_panier,
  ROUND(debut_paiement / ajout_panier * 100, 1) AS taux_panier_vers_paiement,
  ROUND(achat / debut_paiement * 100, 1) AS taux_paiement_vers_achat,
  ROUND(achat / vue_produit * 100, 1) AS taux_global
FROM utilisateurs_par_etape
