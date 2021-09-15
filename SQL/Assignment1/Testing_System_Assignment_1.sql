drop database TestingSystem1;

CREATE DATABASE TestingSystem1;
USE TestingSystem1;

CREATE TABLE Department(
	DepartmentID smallint Primary key auto_increment,
    DepartmentName varchar(20)
);

drop table `Position`;

CREATE TABLE `Position`(
	PositionID smallint Primary key auto_increment,
    PositionName ENUM("Dev", "Test", "Scrum Master", "PM")
);

Drop table `Account`;

create table `Account`(
	AccountID smallint Primary key auto_increment,
    Email varchar(30),
    Username varchar(30),
    FullName varchar(30),
    DepartmentID smallint,
    Foreign key(DepartmentID) References Department(DepartmentID),
    PositionID smallint,
    Foreign key(PositionID) References `Position`(PositionID),
    CreateDate datetime
);
drop table `Group`;
create table `Group`(
	GroupID smallint auto_increment,
    GroupName varchar(30),
    CreatorID int ,
    CreateDate datetime,
    Primary key(GroupID, CreatorID)
);

create table GroupAccount(
	GroupID smallint,
    Foreign key(GroupID) References `Group`(GroupID),
    AccountID smallint,
    Foreign key(AccountID) References `Account`(AccountID),
    JoidDate datetime
);

create table TypeQuestion(
	TypeID smallint Primary key auto_increment,
    TypeName Enum ("Essay", "Multiple-Choice")
);

drop table CategoryQuestion;
create table CategoryQuestion(
	CategoryID smallint Primary key auto_increment,
    CategoryName Enum("Java", ".NET", "SQL", "Postman", "Ruby")
);

drop table Question;

create table Question(
	QuestionID smallint auto_increment,
    Content varchar(20),
    CategoryID smallint,
    Foreign key(CategoryID) References CategoryQuestion(CategoryID),
    TypeID smallint,
    Foreign key(TypeID) References TypeQuestion(TypeID),
    CreatorID int,
    CreateDate datetime,
    Primary key (QuestionID, Content)
);

drop table `Answer`;

create table `Answer`(
	AnswerID smallint Primary key auto_increment,
    Content varchar(20),
    QuestionID smallint,
    Foreign key(QuestionID) References Question(QuestioniD),
    isCorrect enum("True", "False")
);

create table `Exam`(
	ExamID smallint auto_increment,
    `Code` int,
	Title varchar(10),
    CategoryID int,
    Duration int,
    CreatorID int,
    CreateDate datetime,
    Primary key(ExamID)
);

create table ExamQuestion(
	ExamID smallint,
    Foreign key(ExamID) References `Exam`(ExamID),
    QuestionID smallint, 
    Foreign key(QuestionID) References `Answer`(QuestionID)
);