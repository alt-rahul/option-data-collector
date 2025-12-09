DECLARE @Year     INT  = 2010;
DECLARE @fromDate DATE = DATEFROMPARTS(@Year, 1, 1);
DECLARE @toDate   DATE = DATEFROMPARTS(@Year, 12, 31);

SELECT
    br.SecurityID,
    sn.Ticker,
    br.Date,
    br.Days,          -- 10, 30, 60, ... 730
    br.BorrowRate
FROM Std_Borrow_Rate br
JOIN Security_Name sn
  ON sn.SecurityID = br.SecurityID
 AND sn.Date = (
        SELECT MAX(sn2.Date)
        FROM Security_Name sn2
        WHERE sn2.SecurityID = br.SecurityID
          AND sn2.Date <= br.Date
    )
WHERE br.Date BETWEEN @fromDate AND @toDate
ORDER BY sn.Ticker, br.Date, br.Days;
