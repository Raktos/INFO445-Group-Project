ALTER PROCEDURE uspPopulateStudent
  @NumInserts int
AS
WHILE @NumInserts > 0
BEGIN
  DECLARE @StudentType VARCHAR(255)
  DECLARE @FName VARCHAR(255)
  DECLARE @LName VARCHAR(255)
  DECLARE @DOB DATE
  DECLARE @Phone VARCHAR(10)
  DECLARE @Email VARCHAR(255)
  DECLARE @School VARCHAR(255)
  
  SET @StudentType = (SELECT TOP 1 StudentTypeName FROM STUDENT_TYPE ORDER BY NEWID())
  SET @FName = (SELECT TOP 1 fName FROM FIRST_NAME ORDER BY NEWID())
  SET @LName = (SELECT TOP 1 lName FROM LAST_NAME ORDER BY NEWID())
  SET @School = (SELECT TOP 1 SponsorName FROM SPONSOR ORDER BY NEWID())
  SET @Phone = CAST(CAST(ROUND((RAND() * 8999999999) + 1000000000, 0) AS NUMERIC(10,0)) AS VARCHAR(10))
  SET @DOB = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 14600), '1960-01-01') -- date from 1960-1-1 to + 2000-1-1, +40 years
  SET @Email = @FName + '.' + @LName + '@' + REPLACE(@School, ' ', '') + '.edu'
  
  EXEC dbo.uspInsertStudent
  	@StudentTypeName = @StudentType,
    @StudentFName = @FName,
    @StudentLName = @LName,
    @StudentDOB = @DOB,
    @StudentPhoneNumber = @Phone,
    @StudentEmail = @Email;
  
  SET @NumInserts = @NumInserts - 1
END
GO