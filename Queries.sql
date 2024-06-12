-- TASK D.1
SELECT vc1.Month AS OM1,
       c.location AS CN,
       vc1.total_vaccinations AS VOM1,
       vc2.Month AS OM2,
       vc2.total_vaccinations AS VOM2,
       vc1.total_vaccinations - vc2.total_vaccinations AS "VOM1 - VOM2"
  FROM (
           SELECT iso_code,
                  strftime('%Y-%m', date) AS Month,
                  SUM(total_vaccinations) AS total_vaccinations
             FROM vaccination
            WHERE date LIKE '%2022-04%'
            GROUP BY iso_code
       )
       vc1
       JOIN
       (
           SELECT iso_code,
                  strftime('%Y-%m', date) AS Month,
                  SUM(total_vaccinations) AS total_vaccinations
             FROM vaccination
            WHERE date LIKE '%2022-05%'
            GROUP BY iso_code
       )
       vc2 ON vc1.iso_code = vc2.iso_code
       JOIN
       country c ON vc2.iso_code = c.iso_code
 ORDER BY vc1.iso_code;

-- TASK D.2
SELECT c.location AS Country, avg.months AS Month, dose AS "Cumulative Doses" FROM (SELECT tot1.months,
       AVG(dose) AS avgDose
FROM (SELECT iso_code,
              strftime('%Y-%m', date) AS months,
              SUM(total_vaccinations) AS dose
         FROM vaccination
         GROUP BY iso_code,strftime('%Y-%m', date) 
       ) AS tot1
GROUP BY tot1.months) AS avg
JOIN (SELECT iso_code,
              strftime('%Y-%m', date) AS months,
              SUM(total_vaccinations) AS dose
         FROM vaccination
         GROUP BY iso_code,strftime('%Y-%m', date) 
       ) AS tot ON avg.months = tot.months
JOIN country c ON c.iso_code = tot.iso_code 
WHERE avgDose < dose;

-- TASK D.3
SELECT cv.vaccine AS "Vaccine Type",c.location AS Country  
FROM country_vaccine cv 
     JOIN country c ON c.iso_code = cv.iso_code;
     
-- TASK D.4
SELECT location, s.source_name || ' - ' || s.source_website AS "Source Name(URL)" ,tot_vaccine AS "Total Administered Vaccines" 
FROM country c
    JOIN source s ON s.source_id=c.source_id
    JOIN (SELECT iso_code, SUM(total_vaccinations) AS tot_vaccine 
            FROM vaccination
            GROUP BY iso_code) AS v ON v.iso_code=c.iso_code
WHERE s.source_website IS NOT NULL AND s.source_website <> ''
ORDER BY tot_vaccine;

-- TASK D.5
SELECT usaDate AS "Date Range", usaVac AS "United States",wlsVac AS Wales,canVac AS Canada, dnkVac AS Denmark
FROM (SELECT strftime('%Y-%m', date) AS usaDate, SUM(people_fully_vaccinated) AS usaVac
        FROM vaccination
        WHERE date LIKE "2022-%" AND iso_code = "USA"
        GROUP BY strftime('%Y-%m', date))
      JOIN (SELECT strftime('%Y-%m', date) AS canDate, SUM(people_fully_vaccinated) AS canVac
            FROM vaccination
            WHERE date LIKE "2022-%" AND iso_code = "CAN"
            GROUP BY strftime('%Y-%m', date)) ON canDate = usaDate
      JOIN (SELECT strftime('%Y-%m', date) AS wlsDate, SUM(people_fully_vaccinated) AS wlsVac
            FROM vaccination
            WHERE date LIKE "2022-%" AND iso_code = "OWID_WLS"
            GROUP BY strftime('%Y-%m', date)) ON wlsDate = usaDate
      JOIN (SELECT strftime('%Y-%m', date) AS dnkDate, SUM(people_fully_vaccinated) AS dnkVac
            FROM vaccination
            WHERE date LIKE "2022-%" AND iso_code = "DNK"
            GROUP BY strftime('%Y-%m', date)) ON dnkDate = usaDate;