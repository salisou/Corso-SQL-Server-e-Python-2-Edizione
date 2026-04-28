SELECT * FROM Aule; -- 30
SELECT * FROM Corsi; --30
SELECT * FROM Docenti; --30
SELECT * FROM DocentiCorso; --30 Corso
SELECT * FROM Lezioni; --26 Corsi e Aule
SELECT * FROM Studenti; --37
SELECT * FROM Iscrizioni; --28 Studenti e corsi

SELECT * FROM Aule WHERE AulaId = 10;
SELECT NomeAula FROM Aule WHERE Capacita > 30;
SELECT * FROM Studenti;
SELECT TOP 10 * FROM Studenti;
SELECT * FROM Corsi WHERE Crediti < 7 AND Durata > 30 ;
SELECT DISTINCT * FROM Studenti WHERE DataNascita IS NULL;
SELECT 
	StudenteId,
	Nome + ' - ' + Cognome AS 'Nome Completo',
	ISNULL(CONVERT(NVARCHAR, DataNascita, 107), 'DD/MM/YYYY') AS DataNascita,
	ISNULL(CONVERT(NVARCHAR, YEAR(DataNascita), 105), 'N/D') AS Anno,
	ISNULL(CONVERT(NVARCHAR, Month(DataNascita), 107), '--') AS Mese
FROM Studenti;

-- studenti scritti ad un corso
SELECT * FROM Corsi;
SELECT * FROM Studenti;
SELECT * FROM Iscrizioni;


SELECT 
	s.Nome + ' - ' + s.Cognome AS 'Nome Completo',
    ISNULL(c.NomeCorso, 'Non presente') AS 'Nome corso',
	ISNULL(c.Durata, 0) AS Durata,
	COUNT(s.StudenteId) AS 'Totale Studenti'
FROM Studenti AS s
LEFT JOIN Iscrizioni AS i
	ON i.StudenteId = s.StudenteId
LEFT JOIN Corsi AS c
	ON c.CorsoId = i.CorsoId
GROUP BY s.StudenteId, s.Nome , s.Cognome , c.NomeCorso, c.Durata 
ORDER BY s.Nome ASC

UPDATE Iscrizioni
SET CorsoId = 1
WHERE StudenteId < 10


-- 0. Uso ScuolaDb per capire il funzionamento tra tabelle
-- 1. TUTTI I JOIN {Left join, Right join, inner join, join}
-- 2. CONDIZIONI IF/ELSE (CASE THEN ) == SE / ALTRIMENTI
IF EXISTS(SELECT 1 FROM Studenti WHERE StudenteId = 15)
BEGIN
	SELECT * FROM Studenti 
	WHERE StudenteId = 15
END
ELSE
BEGIN
	PRINT 'Studente non trovato'
END;


IF EXISTS(
	SELECT 1 
	FROM Studenti 
	WHERE DataNascita IS NULL
)
BEGIN
	SELECT 
		Nome,
		Cognome,
		ISNULL(CONVERT(NVARCHAR, DataNascita, 107), 'DD/MM/YYYY') AS DataNascita,
		CASE -- CONDIZIONE VERIFICA SE CI SONO DATA DI NASCITA
			WHEN DataNascita IS NULL THEN 'Manca la data di nascita'
			ELSE 'Data presente'
		END AS Stato 
	FROM Studenti ;
END
ELSE
BEGIN
	PRINT 'Tutti gli studenti hanno la data di nascita'
END;

-- 3. STORE PROCEDURE 
-- 4. VIEW = VISTE
-- 5. BACK-UP STANDARD E AUTOMATIZZATA DEL DB