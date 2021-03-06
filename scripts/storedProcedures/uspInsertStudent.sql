USE [AtlasTravel_FINAL]
GO
/****** Object:  StoredProcedure [dbo].[uspInsertStudent]    Script Date: 3/6/2016 6:31:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[uspInsertStudent]
	@StudentTypeName varchar(255),
	@StudentFName varchar(255),
	@StudentLName varchar(255),
	@StudentDOB DATE,
	@StudentPhoneNumber varchar(10),
	@StudentEmail varchar(255)
AS
BEGIN
	BEGIN TRAN T1	
		DECLARE @StudentTypeID int;
		DECLARE @StudentFind int;

		SET @StudentTypeID = (SELECT StudentTypeID FROM STUDENT_TYPE WHERE StudentTypeName = @StudentTypeName)
		
		IF @StudentTypeID IS NULL
			BEGIN
				RETURN -1
			END	

		INSERT INTO STUDENT(StudentTypeID, StudentFName, StudentLName, StudentDOB, StudentPhoneNumber, StudentEmail)
		VALUES(@StudentTypeID, @StudentFName, @StudentLName, @StudentDOB, @StudentPhoneNumber, @StudentEmail)

	COMMIT TRAN T1
END