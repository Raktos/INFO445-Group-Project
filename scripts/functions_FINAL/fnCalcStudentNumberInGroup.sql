ALTER FUNCTION fnCalcStudentNumberInGroup (@GroupID INT)
RETURNS int
AS
BEGIN
DECLARE @RET INT =
	(SELECT COUNT(GroupStudentID) FROM GROUP_STUDENT gs WHERE gs.GroupID = @GroupID)
RETURN @RET
END
GO