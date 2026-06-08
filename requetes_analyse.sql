----Mission A:
----1. compter le nombre d'engins par site.
SELECT 
      id_site,
	  COUNT (id_engin) AS total_engins
FROM 
    engins
GROUP BY 
     id_site
ORDER BY 
      total_engins DESC;

----2. les jours où la production a été nulle:
SELECT
     date_prod,
	 id_site,
	 type_minerai,
	 tonnage_brut
FROM 
    production
WHERE
    tonnage_brut = 0
ORDER BY
    date_prod DESC;

-----3. Liste des engins avec le nom de leur site respectif:
SELECT
     e.id_engin,
	 e.type AS type_engin,
	 s.nom AS nom_site,
	 s.province
FROM 
     engins e
INNER JOIN 
     sites s ON e.id_site = s.id_site
ORDER BY 
     id_engin, s.nom, e.type;

----Mission B:
----1. production totale :
SELECT 
     s.province,
	 p.type_minerai,
	 SUM(p.tonnage_brut) AS production_totale_tonnes
FROM 
     production P
INNER JOIN 
     sites s ON p.id_site = s.id_site
GROUP BY 
     s.province,
	 p.type_minerai
ORDER BY 
     s.province,
	 production_totale_tonnes DESC;
----2. le tonnage de métal pur (tonnage brut *teneur%)
SELECT 
     p.id_prod,
	 p.date_prod,
	 s.nom AS nom_site,
	 p.type_minerai,
	 p.tonnage_brut,
	 p.teneur,
     (p.tonnage_brut * (p.teneur / 100)) AS contenu_fin_tonnes
FROM
    production p
INNER JOIN 
    sites s ON p.id_site = s.id_site
ORDER BY 
    p.date_prod DESC;
----3. Chiffre d'affaire total par site 
SELECT 
    s.nom AS nom_site,
	s.province,
	CAST(SUM(e.tonnage_vendu * e.prix_unitaire_usd) AS DECIMAL(15,2)) AS chiffre_affaires_total_usd
FROM 
   exportations e
INNER JOIN 
   sites s ON e.id_site = s.id_site
GROUP BY 
   s.nom,
   s.province
ORDER BY
   chiffre_affaires_total_usd DESC;

   
----4. Alerte Teneur : Lister les sites dont la teneur moyenne est inférieure à 2.5%
SELECT 
    s.nom AS nom_site,
	s.province,
	CAST(AVG(p.teneur) AS DECIMAL(5, 2)) AS teneur_moyenne_pourcent
FROM 
    production p
INNER JOIN
    sites s ON p.id_site = s.id_site
GROUP BY
    s.nom,
	s.province
HAVING 
    AVG(p.teneur) < 2.5
ORDER BY 
     teneur_moyenne_pourcent ASC;
     
