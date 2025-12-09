DECLARE @Year     INT  = 2010;
DECLARE @fromDate DATE = DATEFROMPARTS(@Year, 1, 1);
DECLARE @toDate   DATE = DATEFROMPARTS(@Year, 12, 31);

SELECT
    b.SecurityID,
    sn.Ticker,
    b.Date,
    b.ExpirationDate,
    b.Days,
    b.BorrowRate
FROM Borrow_Rate b
JOIN Security_Name sn
  ON sn.SecurityID = b.SecurityID
 AND sn.Date = (
        SELECT MAX(sn2.Date)
        FROM Security_Name sn2
        WHERE sn2.SecurityID = b.SecurityID
          AND sn2.Date <= b.Date
    )
WHERE b.Date BETWEEN @fromDate AND @toDate
ORDER BY sn.Ticker, b.Date, b.ExpirationDate;
