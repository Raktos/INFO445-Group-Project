-- calculate the number of STUDENTS on a given flight
CREATE FUNCTION fnCalcStudentsOnFlight (@FlightID INT)
RETURNS INT
AS
BEGIN
	DECLARE @RET INT =
		(SELECT COUNT(StudentID) FROM GROUP_STUDENT gs 
			JOIN FLIGHT_GROUP_STUDENT fgs ON gs.GroupStudentID = fgs.GroupStudentID
			WHERE fgs.FlightID = @FlightID)
	RETURN @RET
END
GO