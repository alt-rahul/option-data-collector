DECLARE @Year     INT  = 2010;
DECLARE @fromDate DATE = DATEFROMPARTS(@Year, 1, 1);
DECLARE @toDate   DATE = DATEFROMPARTS(@Year, 12, 31);

SELECT
    hv.SecurityID,
    sn.Ticker,
    hv.Date,
    hv.Days,         
    hv.Volatility
FROM Historical_Volatility hv
JOIN Security_Name sn
  ON sn.SecurityID = hv.SecurityID
 AND sn.Date = (
        SELECT MAX(sn2.Date)
        FROM Security_Name sn2
        WHERE sn2.SecurityID = hv.SecurityID
          AND sn2.Date <= hv.Date
    )
WHERE hv.Date BETWEEN @fromDate AND @toDate
ORDER BY sn.Ticker, hv.Date, hv.Days;
