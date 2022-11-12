--  **************************************************************************************
--  Creation and Population Script for the 'AccountingFirm' database.

--  **************************************************************************************

--  If a database named 'AccountingFirm' already exist, we should drop it.
--  Setting the active database to the built in 'master' database ensures that we are not trying to drop the currently active database.
--  Setting the database to 'single user' mode ensures that any other scripts currently using the database will be disconnectetd.
--  This allows the database to be deleted, instead of giving a 'database in use' error when trying to delete it.

IF DB_ID('AccountingFirm') IS NOT NULL             
	BEGIN
		PRINT 'Database exists - dropping.';
		
		USE master;		
		ALTER DATABASE AccountingFirm SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		
		DROP DATABASE AccountingFirm;
	END

GO

--  Now that we are sure a similar database does not exist, we create go ahead and create.

PRINT 'Creating database...';

CREATE DATABASE AccountingFirm;

GO

--  Make the created database active.

USE AccountingFirm;

GO

--  **************************************************************************************
--  Table creation in the database.
--  **************************************************************************************

-- PayLevel Table --

PRINT 'Creating PayLevel Table...';
CREATE TABLE PayLevel 

( 

PayLevelID INT IDENTITY (3,3) NOT NULL CONSTRAINT PayLevelID_PK PRIMARY KEY,
PayLevelName CHAR(50) NOT NULL,
AnnualPay INT NOT NULL,
MinimumExperiance TINYINT NOT NULL

);

-- JobType Table --

PRINT 'Creating JobType Table...';
CREATE TABLE JobType

(
 
 JobTypeID INT IDENTITY (20,5) NOT NULL CONSTRAINT JobTypeID_PK PRIMARY KEY,
 JobTypeName CHAR(25) NOT NULL,
 CostPerMinute DECIMAL (20) NOT NULL,

 );

 -- Client Table --
 
 PRINT 'Creating Client Table...';
 CREATE TABLE Client 

 (

 ClientID INT IDENTITY (1000,1) CONSTRAINT ClientID_PK PRIMARY KEY NOT NULL,
 TaxFileNo INT NOT NULL,
 ClientFirstName CHAR (20) NOT NULL,
 ClientLastName CHAR(10) NOT NULL,
 ClientContactNumber VARCHAR(20) NOT NULL,
 ClientEmailAddress VARCHAR (50) NOT NULL,
 ClientPostalAddress VARCHAR (100) NOT NULL,

 );

 -- Branch Table --

PRINT 'Creating Branch Table...';
CREATE TABLE Branch

(

BranchID INT IDENTITY (1,1) CONSTRAINT BranchID_PK PRIMARY KEY NOT NULL,
BranchManagerID INT  NULL,
BranchName CHAR (20) NOT NULL,
BranchAddress VARCHAR (60) NOT NULL,
BranchPhoneNo VARCHAR(20) NOT NULL,

);

-- Accountant Table -- 

PRINT 'Creating Accountant Table...';
CREATE TABLE Accountant

(

AccountantID INT IDENTITY (1000,25) CONSTRAINT AccID_PK PRIMARY KEY NOT NULL,
Branch INT  NULL,
PayLevel INT  NULL,
MentorID INT  NULL,
FirstName VARCHAR (20)  NULL,
LastName  VARCHAR (20)  NULL,
ContactNo VARCHAR (20)  NULL,
PostalAddress VARCHAR (100)  NULL,
EmailAddress VARCHAR(50)  NULL,
HireDate DATE NOT NULL,

CONSTRAINT AccBranchID_FK FOREIGN KEY (Branch) REFERENCES Branch(BranchID),
CONSTRAINT PayLevelID_FK FOREIGN KEY (PayLevel) REFERENCES PayLevel(PayLevelID),
CONSTRAINT MentorID_FK FOREIGN KEY (MentorID) REFERENCES Accountant(AccountantID)



);

-- Specialization Table -- 

PRINT 'Creating Specialization Table...';
CREATE TABLE Specialization

(

AccountantID INT NOT NULL,
JobTypeID INT NOT NULL,

CONSTRAINT Specialization_PK PRIMARY KEY (AccountantID, JobTypeID),
CONSTRAINT AccSpecializationID_FK FOREIGN KEY (AccountantID) REFERENCES Accountant(AccountantID),
CONSTRAINT JobTypeID_FK FOREIGN KEY (JobTypeID) REFERENCES JobType(JobTypeID)

);

-- Job Table --

PRINT 'Creating Job Table....';
CREATE TABLE Job

(

JobID INT IDENTITY (500,10) CONSTRAINT JobID_PK PRIMARY KEY NOT NULL,
ClientID INT NOT NULL,
AccountantID INT NOT NULL,
JobTypeID INT NOT NULL,
DateStarted DATE DEFAULT CONVERT(DATE,GETDATE()) NOT NULL,
StartTime TIME NOT NULL,
EndTime TIME NOT NULL,
ExtraNote VARCHAR (200) DEFAULT 'NONE',
Payment CHAR (20) NOT NULL

CONSTRAINT ClientIDJob_FK FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
CONSTRAINT AccountantIDJob_FK FOREIGN KEY (AccountantID) REFERENCES Accountant(AccountantID),
CONSTRAINT JobTypeIDJob_FK FOREIGN KEY (JobTypeID) REFERENCES JobType(JobTypeID)


);


 --***************************************************************************************--
--  Now that the database tables have been created, we can populate them with data
--  **************************************************************************************


--  **************************************************************************************


-- The branch manager relationship constraint is added using ALTER TABLE command because accountant table is created after branch table. --

ALTER TABLE Branch
    ADD CONSTRAINT      Manager_FK      FOREIGN KEY (BranchManagerID)    
            REFERENCES  Accountant(AccountantID); 


PRINT 'Populating PayLevel Table...';

INSERT INTO PayLevel(PayLevelName,AnnualPay,MinimumExperiance)
VALUES('Trainee', 450000,0),
     ('Juniour Accountant',60000, 1),
	 ('Accountant',75000,4),
	 ('Senior Accountant',95000,8);


PRINT 'Populating JobType Table...';

INSERT INTO JobType(JobTypeName,CostPerMinute)
VALUES('TAX Return', 4.00),
     ('Financial Planning', 5.00),
	 ('Retrivement Planning',5.00),
	 ('Litigation Support', 7.50),
	 ('Miscellaneous',6.50);


PRINT 'Populating Client Table...';

INSERT INTO Client (TaxFileNo,ClientFirstName,ClientLastName,ClientContactNumber,ClientEmailAddress,ClientPostalAddress)
VALUES ('55501','Jill','Hope','0772 123 456','JillHo@bmail.com','150, Temple Road, Colombo 6'),
       ('13600','John','Cena','0770 327 567','JohnCe@bmail.com','120, Cross Road, Colombo 12'),
       ('14500','Emma','Watson','0771 456 798','EmmaWa@bmail.com','11, Sun Road, Colombo 7'),
	   ('55505','Seleena','Gomez','0775 525 525','Seleen@bmail.com','180, Flower Road, Colombo 9'),
	   ('16500','Rex','Shurby','0777 729 729','Rexshr@gmail.com','7, Lucky Road, Colombo 7');


PRINT 'Populating Branch Table...';

INSERT INTO branch  (BranchName, BranchAddress,BranchPhoneNo)
VALUES  ('Nugegoda Branch','No. 47/B, David Road, Nugegoda', '0112 567 580'),
        ('Borella Branch','No. 25/C, Borella Road, Borella', '0112 577 588'),
		('Bambalapitiya Branch','No. 455 Sun Rise Road, Bambalapitiya', '0112 566 590'),
		('Kollupitiya Branch','No. 22/A, 5th Lane, Kollupitiya', '0112 555 550'),
		('Wellawatta Branch','No. 50/1, Side Road, Wellawatta', '0112 544 540');


PRINT 'Populating Accountant Table...';

INSERT INTO Accountant (Branch,PayLevel,MentorID,FirstName,LastName,ContactNo,PostalAddress,EmailAddress,HireDate)
VALUES  (1 , 3, NULL , 'Jobs',   'Steve',   '0777 777 777', '58 Baseline Road, Colombo 4', 'Jobs@bmail.com', '2019-05-12'),
        (2 , 6, NULL , 'Simon',  'Calls', '0777 888 888', '101 Parkes Road, Colombo 5', 'Calls@bmail.com', '2012-09-20'),
        (3 , 9, NULL  , 'Nancy',  'Jane',    '0777 999 999', '77 Chruch Road, Bambalapitiya ', 'Nancy5@gmail.com', '2013-03-03'),
        (4 , 3, NULL, 'Dany',     'Carter',   '0778 898 989', '180 Nawala Road, Nawala','Carter25@gmail.com', '2014-04-04'),
        (5 , 6, NULL ,'Ashlynn',  'Smith', '0771 121 212', '999 Nugegoda Road, Nugegoda',   'Ashlynn404@bmail.com','2015-05-05'),
        (3 , 3, NULL, 'Sam', 'Robins',    '0772 211 221', '250, Dickmans Road, Colombo 3 ',    'Robins@bmail.com','2018-08-08'),
        (5 , 9, NULL, 'Cuser',  'Boyle',   '0773 323 233',     '121 Moon Path Road, Colombo 2 ','Boyle@bmail.com',   '2010-10-10'),
        (2 , 12 ,NULL, 'Victoria',  'Justice',   '0755 525 555', '55 Wellawatta Side Road, Wellawatta', 'Justice@bmail.com','2012-12-12');
                                                                           



PRINT 'Populating Specialization Table...';

INSERT INTO Specialization (AccountantID, jobTypeID)
VALUES  (1000, 20),
        (1025, 35),
        (1050, 30),
        (1075, 35),
        (1125, 40),
        (1150, 20),
        (1175, 30),
        (1025, 25),
        (1100, 40);


PRINT 'Populating Job Table...';

INSERT INTO Job (AccountantID,ClientID,JobTypeID , DateStarted, StartTime, EndTime, Payment)
VALUES  (1000, 1000, 20, '2012-12-13', '09:40 AM', '10:30 AM', 'Y'),
        (1025, 1001, 25, '2013-11-25', '10:30 AM', '11:30 PM', 'Y'),
        (1050, 1002, 30, '2014-09-05', '11:30 AM', '12:00 AM', 'N'),
        (1075, 1003, 35, '2015-01-22', '12:30 PM', '01:40 PM', 'N'),
        (1100, 1004, 40, '2013-04-25', '02:30 PM', '03:45 PM', 'N'),
        (1125, 1004, 20, '2018-03-10', '03:20 PM', '04:40 PM', 'Y'),
        (1150, 1000, 35, '2017-05-03', '04:00 AM', '04:30 PM', 'Y'),
        (1000, 1003, 25, '2016-06-10', '05:30 PM', '06:00 PM', 'Y');

PRINT 'Assigning Managers To Branch';
-- Managers are assigned with and update command because accountant table data is INSERTed after branch.

UPDATE Branch
SET BranchManagerID = 1050
WHERE BranchID = 1;

UPDATE Branch
SET BranchManagerID = 1150
WHERE BranchID = 2;

UPDATE Branch
SET BranchManagerID = 1175
WHERE BranchID = 3;

UPDATE Branch
SET BranchManagerID = 1100
WHERE BranchID = 4;

