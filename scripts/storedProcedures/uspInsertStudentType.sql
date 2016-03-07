USE [AtlasTravel_FINAL]
GO
/****** Object:  StoredProcedure [dbo].[uspInsertStudentType]    Script Date: 3/6/2016 6:31:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[uspInsertStudentType]
	@StudentTypeName varchar(255),
	@StudentTypeDesc varchar(255)
AS
BEGIN
	BEGIN TRAN T1
		INSERT INTO STUDENT_TYPE(StudentTypeName, StudentTypeDesc)
		VALUES(@StudentTypeName, @StudentTypeDesc)
	COMMIT TRAN T1
END