-- index dividend table here
DECLARE @Year     INT  = 2010; -- change the year
DECLARE @fromDate DATE = DATEFROMPARTS(@Year, 1, 1);
DECLARE @toDate   DATE = DATEFROMPARTS(@Year, 12, 31);

SELECT
    idiv.SecurityID,
    sn.Ticker,
    idiv.Date,
    idiv.Expiration,
    idiv.Rate        -- dividend yield
FROM Index_Dividend idiv
JOIN Security_Name sn
  ON sn.SecurityID = idiv.SecurityID
 AND sn.Date = (
        SELECT MAX(sn2.Date)
        FROM Security_Name sn2
        WHERE sn2.SecurityID = idiv.SecurityID
          AND sn2.Date <= idiv.Date
    )
WHERE idiv.Date BETWEEN @fromDate AND @toDate
ORDER BY sn.Ticker, idiv.Date, idiv.Expiration;
