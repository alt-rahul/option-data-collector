--forward prices table
DECLARE @Year     INT  = 2010; --year chage
DECLARE @fromDate DATE = DATEFROMPARTS(@Year, 1, 1);
DECLARE @toDate   DATE = DATEFROMPARTS(@Year, 12, 31);

SELECT
    f.SecurityID,
    sn.Ticker,
    f.Date,
    f.Expiration,
    f.AMSettlement,
    f.ForwardPrice
FROM Forward_Price f
JOIN Security_Name sn
  ON sn.SecurityID = f.SecurityID
 AND sn.Date = (
        SELECT MAX(sn2.Date)
        FROM Security_Name sn2
        WHERE sn2.SecurityID = f.SecurityID
          AND sn2.Date <= f.Date
    )
WHERE f.Date BETWEEN @fromDate AND @toDate
ORDER BY sn.Ticker, f.Date, f.Expiration, f.AMSettlement;
