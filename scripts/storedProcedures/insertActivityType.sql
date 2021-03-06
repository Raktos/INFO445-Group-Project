USE AtlasTravel_FINAL;
GO

CREATE PROCEDURE uspInsertActivityType
	@ActivityCategory varchar(255),
	@ActivityTypeName varchar(255),
	@ActivityTypeDesc varchar(255)
AS
	BEGIN TRAN t1
		DECLARE @CategoryFind int;
		
		SET @CategoryFind = (SELECT ActivityCategoryID 
			FROM ACTIVITY_CATEGORY 
			WHERE ActivityCategoryName = @ActivityCategory);

		IF @CategoryFind is NULL
		BEGIN
			raiseerror('cannot find cetegory', 18, 1)
			return -1
		END
			
		INSERT INTO ACTIVITY_TYPE(ActivityCategoryID, ActivityTypeName, ActivityTypeDesc)
		VALUES(@CategoryFind, @ActivityTypeName, @ActivityTypeDesc);
	COMMIT TRAN t1
GO