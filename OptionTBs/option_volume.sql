-- this is the option volume table
DECLARE @Year     INT  = 2010; -- change the year here
DECLARE @fromDate DATE = DATEFROMPARTS(@Year, 1, 1);
DECLARE @toDate   DATE = DATEFROMPARTS(@Year, 12, 31);

SELECT
    ov.SecurityID,
    sn.Ticker,
    ov.Date,
    ov.CallPut,          -- 'C', 'P', or blank for total
    ov.Volume,
    ov.OpenInterest
FROM Option_Volume ov
JOIN Security_Name sn
  ON sn.SecurityID = ov.SecurityID
 AND sn.Date = (
        SELECT MAX(sn2.Date)
        FROM Security_Name sn2
        WHERE sn2.SecurityID = ov.SecurityID
          AND sn2.Date <= ov.Date
    )
WHERE ov.Date BETWEEN @fromDate AND @toDate
ORDER BY sn.Ticker, ov.Date, ov.CallPut;
