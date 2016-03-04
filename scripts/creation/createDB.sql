CREATE DATABASE AtlasTravel;

USE AtlasTravel;

--------------------
--   Locations    --
-- requires: none --
--------------------

CREATE TABLE COUNTRY (
	CountryID int IDENTITY(1,1) NOT NULL,
	CountryName varchar(255) NOT NULL,
	CONSTRAINT PK_COUNTRY PRIMARY KEY NONCLUSTERED (CountryID)
);

CREATE TABLE REGION (
	RegionID int IDENTITY(1,1) NOT NULL,
	CountryID int NOT NULL,
	RegionName varchar(255) NOT NULL,
	CONSTRAINT PK_REGION PRIMARY KEY NONCLUSTERED (RegionID), 
	CONSTRAINT FK_REGION_COUNTRY FOREIGN KEY (CountryID) 
    	REFERENCES COUNTRY (CountryID) 
);

CREATE TABLE CITY (
	CityID int IDENTITY(1,1) NOT NULL,
	RegionID int NOT NULL,
	CityName varchar(255),
	CONSTRAINT PK_CITY PRIMARY KEY NONCLUSTERED (CityID), 
	CONSTRAINT FK_CITY_REGION FOREIGN KEY (RegionID) 
    	REFERENCES REGION (RegionID) 
);

--------------------
--    Airlines    --
-- requires: CITY --
--------------------

CREATE TABLE AIRLINE (
	AirlineID int IDENTITY(1,1) NOT NULL,
	AirlineName varchar(255) NOT NULL,
	CONSTRAINT PK_AIRLINE PRIMARY KEY NONCLUSTERED (AirlineID)
);

CREATE TABLE FLIGHT (
	FlightID int IDENTITY(1,1) NOT NULL,
	AirlineID int NOT NULL,
	FlightDepartureCityID int NOT NULL,
	FlightArrivalCityID int NOT NULL,
	FligthDepartureDate date NOT NULL,
	FlightArrivalDate date NOT NULL,
	FlightNumber varchar(255) NOT NULL,
	CONSTRAINT PK_FLIGHT PRIMARY KEY NONCLUSTERED (FlightID),
	CONSTRAINT FK_FLIGHT_AIRLINE FOREIGN KEY (AirlineID)
		REFERENCES AIRLINE (AirlineID),
	CONSTRAINT FK_FLIGHT_DEPARTURECITY FOREIGN KEY (FlightDepartureCityID)
		REFERENCES CITY (CityID),
	CONSTRAINT FK_FLIGHT_ARRIVALCITY FOREIGN KEY (FlightArrivalCityID)
		REFERENCES CITY (CityID)
);

--------------------
--     Hotels     --
-- requires: CITY --
--------------------

CREATE TABLE HOTEL_TYPE (
	HotelTypeID int IDENTITY(1,1) NOT NULL,
	HotelTypeName varchar(255) NOT NULL,
	HotelTypeDesc varchar(255) NOT NULL,
	CONSTRAINT PK_HOTELTYPE PRIMARY KEY NONCLUSTERED (HotelTypeID)
);

CREATE TABLE HOTEL (
	HotelID int IDENTITY(1,1) NOT NULL,
	HotelTypeID int NOT NULL,
	CityID int NOT NULL,
	HotelName varchar(255) NOT NULL,
	HotelDesc varchar(255) NOT NULL,
	HotelStreetAddress varchar(255) NOT NULL,
	CONSTRAINT PK_HOTEL PRIMARY KEY NONCLUSTERED (HotelID),
	CONSTRAINT FK_HOTEL_HOTELTYPE FOREIGN KEY (HotelTypeID)
		REFERENCES HOTEL_TYPE (HotelTypeID),
	CONSTRAINT FK_HOTEL_CITY FOREIGN KEY (CityID)
		REFERENCES CITY (CityID)
);

--------------------
--    Transit     --
-- requires: none --
--------------------

CREATE TABLE TRANSIT_TYPE (
	TransitTypeID int IDENTITY(1,1) NOT NULL,
	TransitTypeName varchar(255) NOT NULL,
	TransitTypeDesc varchar(255) NOT NULL,
	CONSTRAINT PK_TRANSITTYPE PRIMARY KEY NONCLUSTERED (TransitTypeID)
);

CREATE TABLE TRANSIT_COMPANY (
	TransitCompanyID int IDENTITY(1,1) NOT NULL,
	TransitCompanyName varchar(255) NOT NULL,
	TransitCompanyDesc varchar(255) NOT NULL,
	CONSTRAINT PK_TRANSITCOMPANY PRIMARY KEY NONCLUSTERED (TransitCompanyID)
);

CREATE TABLE TRANSIT (
	TransitID int IDENTITY(1,1) NOT NULL,
	TransitTypeID int NOT NULL,
	TransitCompanyID int NOT NULL,
	TransitDesc varchar(255) NOT NULL,
	CONSTRAINT PK_TRANSIT PRIMARY KEY NONCLUSTERED (TransitID),
	CONSTRAINT FK_TRANSIT_TRANSITTYPE FOREIGN KEY (TransitTypeID)
		REFERENCES TRANSIT_TYPE (TransitTypeID),
	CONSTRAINT FK_TRANSIT_TRANSITCOMPANY FOREIGN KEY (TransitCompanyID)
		REFERENCES TRANSIT_COMPANY (TransitCompanyID)
);

--------------------
--   Activities   --
-- requires: none --
--------------------

CREATE TABLE ACTIVITY_CATEGORY (
	ActivityCategoryID int NOT NULL,
	ActivityCategoryName varchar(255) NOT NULL,
	ActivityCategoryDesc varchar(255) NOT NULL,
	CONSTRAINT PK_ACTIVITYCATEGORY PRIMARY KEY NONCLUSTERED (ActivityCategoryID)
);

CREATE TABLE ACTIVITY_TYPE (
	ActivityTypeID int NOT NULL,
	ActivityCategoryID int NOT NULL,
	ActivityTypeName varchar(255) NOT NULL,
	ActivityTypeDesc varchar(255) NOT NULL,
	CONSTRAINT PK_ACTIVITYTYPE PRIMARY KEY NONCLUSTERED (ActivityTypeID),
	CONSTRAINT FK_ACTIVITYTYPE_ACTIVITYCATEGORY FOREIGN KEY (ActivityCategoryID)
		REFERENCES ACTIVITY_CATEGORY (ActivityCategoryID)
);

--------------------
--    Sponsors    --
-- requires: CITY --
--------------------

CREATE TABLE SPONSOR_TYPE (
	SponsorTypeID int NOT NULL,
	SponsorTypeName varchar(255) NOT NULL,
	SponsorTypeDesc varchar(255) NOT NULL,
	CONSTRAINT PK_SPONSORTYPE PRIMARY KEY NONCLUSTERED (SponsorTypeID)
);

CREATE TABLE SPONSOR (
	SponsorID int NOT NULL,
	SponsorTypeID int NOT NULL,
	CityID int NOT NULL,
	SponsorName varchar(255) NOT NULL,
	SponsorDesc varchar(255) NOT NULL,
	SponsorStreetAddress varchar(255) NOT NULL,
	CONSTRAINT PK_SPONSOR PRIMARY KEY NONCLUSTERED (SponsorID),
	CONSTRAINT FK_SPONSOR_SPONSORTYPE FOREIGN KEY (SponsorTypeID)
		REFERENCES SPONSOR_TYPE (SponsorTypeID),
	CONSTRAINT FK_SPONSOR_CITY FOREIGN KEY (CityID)
		REFERENCES CITY (CityID)
);

CREATE TABLE SPONSOR_CONTACT (
	SponsorContactID int NOT NULL,
	SponsorID int NOT NULL,
	SponsorContactFName varchar(255) NOT NULL,
	SponsorContactLName varchar(255) NOT NULL,
	SponsorContactPhoneNumber varchar(255) NOT NULL,
	SponsorContactEmail varchar(255) NOT NULL,
	CONSTRAINT PK_SPONSORCONTACT PRIMARY KEY NONCLUSTERED (SponsorContactID),
	CONSTRAINT FK_SPONSORCONTACT_SPONSOR FOREIGN KEY (SponsorID)
		REFERENCES SPONSOR (SponsorID)
);

--------------------------------
--    Students and Leaders    --
--       requires: none       --
--------------------------------

CREATE TABLE STUDENT_TYPE (
	StudentTypeID int NOT NULL,
	StudentTypeName varchar(255) NOT NULL,
	StudentTypeDesc varchar(255) NOT NULL,
	CONSTRAINT PK_STUDENTTYPE PRIMARY KEY NONCLUSTERED (StudentTypeID)
);

CREATE TABLE STUDENT (
	StudentID int NOT NULL,
	StudentTypeID int NOT NULL,
	StudentFName varchar(255) NOT NULL,
	StudentLName varchar(255) NOT NULL,
	StudentDOB date NOT NULL,
	StudentGraduationDate date NOT NULL,
	StudentPhoneNumber varchar(255) NOT NULL,
	StudentEmal varchar(255) NOT NULL,
	CONSTRAINT PK_STUDENT PRIMARY KEY NONCLUSTERED (StudentID),
	CONSTRAINT FK_STUDENT_STUDENTTYPE FOREIGN KEY (StudentTypeID)
		REFERENCES STUDENT_TYPE (StudentTypeID)
);

CREATE TABLE LEADER (
	LeaderID int NOT NULL,
	LeaderFName varchar(255) NOT NULL,
	LeaderLName varchar(255) NOT NULL,
	LeaderDOB date NOT NULL,
	LeaderPhoneNumber varchar(255) NOT NULL,
	LeaderEmail varchar(255) NOT NULL,
	CONSTRAINT PK_LEADER PRIMARY KEY NONCLUSTERED (LeaderID)
);

---------------------------------------
--              Groups               --
-- requires: STUDENT, LEADER, FLIGHT --
---------------------------------------

CREATE TABLE TRIPGROUP (
	GroupID int NOT NULL,
	GroupMainLeaderID int NOT NULL,
	GroupCoLeaderID int NOT NULL,
	GroupName varchar(255) NOT NULL,
	GroupDesc varchar(255) NOT NULL,
	CONSTRAINT PK_GROUP PRIMARY KEY NONCLUSTERED (GroupID),
	CONSTRAINT FK_GROUP_MAINLEADER FOREIGN KEY (GroupMainLeaderID)
		REFERENCES LEADER (LeaderID),
	CONSTRAINT FK_GROUP_COLEADER FOREIGN KEY (GroupCoLeaderID)
		REFERENCES LEADER (LeaderID)
);

CREATE TABLE GROUP_STUDENT (
	GroupStudentID int NOT NULL,
	StudentID int NOT NULL,
	GroupID int NOT NULL,
	CONSTRAINT PK_GROUPSTUDENT PRIMARY KEY NONCLUSTERED (GroupStudentID),
	CONSTRAINT FK_GROUPSTUDENT_STUDENT FOREIGN KEY (StudentID)
		REFERENCES STUDENT (StudentID),
	CONSTRAINT FK_GROUPSTUDENT_GROUP FOREIGN KEY (GroupID)
		REFERENCES TRIPGROUP (GroupID)
);

CREATE TABLE FLIGHT_GROUP_STUDENT (
	FlightGroupStudentID int NOT NULL,
	FlightID int NOT NULL,
	GroupStudentID int NOT NULL,
	CONSTRAINT PK_FLIGHTGROUPSTUDENT PRIMARY KEY NONCLUSTERED (FlightGroupStudentID),
	CONSTRAINT FK_FLIGHTGROUPSTUDENT_FLIGHT FOREIGN KEY (FlightID)
		REFERENCES FLIGHT (FlightID),
	CONSTRAINT FK_FLIGHTGROUPSTUDENT_GROUPSTUDENT FOREIGN KEY (GroupStudentID)
		REFERENCES GROUP_STUDENT (GroupStudentID)
);

---------------------------------------------------------------------------
--                                Trips                                  --
-- requires: GROUP, SPONSOR_CONTACT, CITY, ACTIVITY_TYPE, TRANSIT, HOTEL --
---------------------------------------------------------------------------

CREATE TABLE TRIP (
	TripID int NOT NULL,
	GroupID int NOT NULL,
	SponsorContactID int NOT NULL,
	CONSTRAINT PK_TRIP PRIMARY KEY NONCLUSTERED (TripID),
	CONSTRAINT FK_TRIP_GROUP FOREIGN KEY (GroupID)
		REFERENCES TRIPGROUP (GroupID),
	CONSTRAINT FK_TRIP_SPONSORCONTACT FOREIGN KEY (SponsorContactID)
		REFERENCES SPONSOR_CONTACT (SponsorContactID)
);

CREATE TABLE TRIP_CITY (
	TripCityID int NOT NULL,
	TripID int NOT NULL,
	CityID int NOT NULL,
	TripCityArrivalDate date NOT NULL,
	TripCityDepartureDate date NOT NULL,
	CONSTRAINT PK_TRIPCITY PRIMARY KEY NONCLUSTERED (TripCityID),
	CONSTRAINT FK_TRIPCITY_TRIP FOREIGN KEY (TripID)
		REFERENCES TRIP (TripID),
	CONSTRAINT FK_TRIPCITY_CITY FOREIGN KEY (CityID)
		REFERENCES CITY (CityID)
);

CREATE TABLE TRIP_ACTIVITY (
	TripActivityID int NOT NULL,
	TripID int NOT NULL,
	ActivityTypeID int NOT NULL,
	CityID int NOT NULL,
	ActivityName varchar(255) NOT NULL,
	ActivityDesc varchar(255) NOT NULL,
	ActivityStartDate date NOT NULL,
	ActivityEndDate date NOT NULL,
	ActivityStreetAddress varchar(255) NOT NULL,
	ActivityCost money NOT NULL,
	CONSTRAINT PK_TRIPACTIVITY PRIMARY KEY NONCLUSTERED (TripActivityID),
	CONSTRAINT FK_TRIPACTIVITY_TRIP FOREIGN KEY (TripID)
		REFERENCES TRIP (TripID),
	CONSTRAINT FK_TRIPACTIVITY_ACTIVITYTYPE FOREIGN KEY (ActivityTypeID)
		REFERENCES ACTIVITY_TYPE (ActivityTypeID),
	CONSTRAINT FK_TRIPACTIVITY_CITY FOREIGN KEY (CityID)
		REFERENCES CITY (CityID)
);

CREATE TABLE TRIP_HOTEL (
	TripHotelID int NOT NULL,
	TripID int NOT NULL,
	HotelID int NOT NULL,
	HotelRoomsReserved int NOT NULL,
	HotelCheckInDate date NOT NULL,
	HotelCheckOutDate date NOT NULL,
	HotelCost money NOT NULL,
	CONSTRAINT PK_TRIPHOTEL PRIMARY KEY NONCLUSTERED (TripHotelID),
	CONSTRAINT FK_TRIPHOTEL_TRIP FOREIGN KEY (TripID)
		REFERENCES TRIP (TripID),
	CONSTRAINT FK_TRIPHOTEL_HOTEL FOREIGN KEY (HotelID)
		REFERENCES HOTEL (HotelID)
);

CREATE TABLE TRIP_TRANSIT (
	TripTransitID int NOT NULL,
	TripID int NOT NULL,
	TransitID int NOT NULL,
	TripTransitPickupCityID int NOT NULL,
	TripTransitDropoffCityID int NOT NULL,
	TripTransitPickupDate date NOT NULL,
	TripTransitDropoffDate date NOT NULL,
	TripTransitPickupStreetAddress varchar(255) NOT NULL,
	TripTransitDropoffStreetAddress varchar(255) NOT NULL,
	TripTransitCost money NOT NULL,
	CONSTRAINT PK_TRIPTRANSIT PRIMARY KEY NONCLUSTERED (TripTransitID),
	CONSTRAINT FK_TRIPTRANSIT_TRIP FOREIGN KEY (TripID)
		REFERENCES TRIP (TripID),
	CONSTRAINT FK_TRIPTRANSIT_TRANSIT FOREIGN KEY (TransitID)
		REFERENCES TRANSIT (TransitID),
	CONSTRAINT FK_TRIPTRANSITPICKUP_CITY FOREIGN KEY (TripTransitPickupCityID)
		REFERENCES CITY (CityID),
	CONSTRAINT FK_TRIPTRANSITDROPOFF_CITY FOREIGN KEY (TripTransitDropoffCityID)
		REFERENCES CITY (CityID)
);

