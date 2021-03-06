USE [AtlasTravel_FINAL]
GO
/****** Object:  StoredProcedure [dbo].[uspInsertAirline]    Script Date: 3/6/2016 6:32:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[uspInsertAirline]
	@AirlineName varchar(255),
	@AirlineID int output
AS
BEGIN
	BEGIN TRAN T1		
		DECLARE @AirlineFind int;

		SET @AirlineFind = (SELECT AirlineID FROM AIRLINE WHERE AirlineName = @AirlineName)

		IF @AirlineFind IS NULL
		BEGIN
			INSERT INTO AIRLINE(AirlineName)
			VALUES (@AirlineName);
			SET @AirlineID = SCOPE_IDENTITY()
		END
	COMMIT TRAN T1
END