-- zero curve table
DECLARE @Year     INT  = 2010; -- chage year here
DECLARE @fromDate DATE = DATEFROMPARTS(@Year, 1, 1);
DECLARE @toDate   DATE = DATEFROMPARTS(@Year, 12, 31);

SELECT
    zc.Date,
    zc.Days,
    zc.Rate
FROM Zero_Curve zc
WHERE zc.Date BETWEEN @fromDate AND @toDate
ORDER BY zc.Date, zc.Days;
