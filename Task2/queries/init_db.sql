-- SQLite
CREATE TABLE persons (
    ID VARCHAR(20) PRIMARY KEY,
    Status VARCHAR(10),
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Email_Address VARCHAR(100),
    Locatie VARCHAR(50)
);

CREATE TABLE Votes (
    ID INT PRIMARY KEY,
    voting_date DATETIME,
    chosen_person VARCHAR(20),
    voter INT,
    message VARCHAR(100),
    valid BIT,
    quality VARCHAR(20)
);

INSERT INTO persons (ID, Status, First_Name, Last_Name, Email_Address, Locatie)
VALUES ('00108901', 'Active', 'Person', 'One', 'person.one@gfk.com', 'Germany');

INSERT INTO persons (ID, Status, First_Name, Last_Name, Email_Address, Locatie)
VALUES ('00108941', 'Active', 'Person', 'Two', 'person.two@gfk.com', 'France');

INSERT INTO persons (ID, Status, First_Name, Last_Name, Email_Address, Locatie)
VALUES ('00199990', 'Inactive', 'Person', 'Three', 'person.three@gfk.com', 'Brazil');

INSERT INTO persons (ID, Status, First_Name, Last_Name, Email_Address, Locatie)
VALUES ('01100003', 'Active', 'Person', 'Four', 'person.four@gfk.com', 'Hong Kong');

INSERT INTO persons (ID, Status, First_Name, Last_Name, Email_Address, Locatie)
VALUES ('03400110', 'Active', 'Person', 'Five', 'person.five@gfk.com', 'Germany');

INSERT INTO persons (ID, Status, First_Name, Last_Name, Email_Address, Locatie)
VALUES ('03400360', 'Active', 'Person', 'Six', 'person.six@gfk.com', 'France');

INSERT INTO persons (ID, Status, First_Name, Last_Name, Email_Address, Locatie)
VALUES ('03402059', 'Inactive', 'Person', 'Seven', 'person.seven@gfk.com', 'Brazil');

INSERT INTO persons (ID, Status, First_Name, Last_Name, Email_Address, Locatie)
VALUES ('03400565', 'Active', 'Person', 'Eight', 'person.eight@gfk.com', 'Hong Kong');

INSERT INTO persons (ID, Status, First_Name, Last_Name, Email_Address, Locatie)
VALUES ('03400436', 'Active', 'Person', 'Nine', 'person.nine@gfk.com', 'Hong Kong');

INSERT INTO Votes (ID, Voting_date, chosen_person, voter, message, valid, quality)
VALUES (253, '2022-10-29 11:54:15', '03400110', 1, 'Vote 1', 1, 'entrepreneur');

INSERT INTO Votes (ID, Voting_date, chosen_person, voter, message, valid, quality)
VALUES (254, '2022-10-29 11:55:22', '03400360', 1, 'Vote 2', 0, 'entrepreneur');

INSERT INTO Votes (ID, Voting_date, chosen_person, voter, message, valid, quality)
VALUES (255, '2022-10-29 11:56:53', '03402059', 1, 'Vote 3', 1, 'partner');

INSERT INTO Votes (ID, Voting_date, chosen_person, voter, message, valid, quality)
VALUES (256, '2022-10-29 11:58:23', '03400565', 1, 'Vote 4', 1, 'developer');

INSERT INTO Votes (ID, Voting_date, chosen_person, voter, message, valid, quality)
VALUES (257, '2022-10-29 12:13:00', '03400436', 1, 'Vote 5', 1, 'developer');