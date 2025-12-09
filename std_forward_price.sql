DECLARE @Year     INT  = 2010;
DECLARE @fromDate DATE = DATEFROMPARTS(@Year, 1, 1);
DECLARE @toDate   DATE = DATEFROMPARTS(@Year, 12, 31);

SELECT
    sop.SecurityID,
    sn.Ticker,
    sop.Date,
    sop.Days,             -- 10, 30, 60, ... 730
    sop.CallPut,
    sop.ForwardPrice,
    sop.Strike,
    sop.OptionPrice,
    sop.ImpliedVolatility,
    sop.Delta,
    sop.Gamma,
    sop.Vega,
    sop.Theta
FROM Std_Option_Price sop
JOIN Security_Name sn
  ON sn.SecurityID = sop.SecurityID
 AND sn.Date = (
        SELECT MAX(sn2.Date)
        FROM Security_Name sn2
        WHERE sn2.SecurityID = sop.SecurityID
          AND sn2.Date <= sop.Date
    )
WHERE sop.Date BETWEEN @fromDate AND @toDate
ORDER BY sn.Ticker, sop.Date, sop.Days, sop.CallPut;
