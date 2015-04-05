CREATE TABLE `FAQ` (
  `faqid` INTEGER NOT NULL AUTO_INCREMENT,
  `userid` INTEGER NOT NULL,
  `faqcategory` INTEGER NOT NULL,
  `question` LONGTEXT DEFAULT NULL,
  `answer` LONGTEXT DEFAULT NULL,
  `createdate` varchar(255) DEFAULT NULL,
  `createby` bigint(20) DEFAULT NULL,
  `updatedate` varchar(255)  DEFAULT NULL,
  `updateby` bigint(20) DEFAULT NULL,
  `deleted` INTEGER DEFAULT 0,
  PRIMARY KEY (`faqid`)
) 

CREATE TABLE `FAQCATEGORY` (
  `faqcategoryid` INTEGER NOT NULL AUTO_INCREMENT,
  `faqcategoryname` varchar(255) DEFAULT NULL,
  `createdate` varchar(255) DEFAULT NULL,
  `createby` bigint(20) DEFAULT NULL,
  `updatedate` varchar(255)  DEFAULT NULL,
  `updateby` bigint(20) DEFAULT NULL,
  `deleted` INTEGER DEFAULT 0,
  PRIMARY KEY (`faqcategoryid`)
)

CREATE TABLE `USER` (
  `userid` INTEGER NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` LONGTEXT DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `createdate` varchar(255) DEFAULT NULL,
  `createby` bigint(20) DEFAULT NULL,
  `updatedate` varchar(255)  DEFAULT NULL,
  `updateby` bigint(20) DEFAULT NULL,
  `deleted` INTEGER DEFAULT 0,
  PRIMARY KEY (`userid`)
) 

CREATE TABLE `MESSAGE` (
  `messageid` INTEGER NOT NULL AUTO_INCREMENT,
  `senderid` INTEGER NOT NULL,
  `sentdate` DATE NOT NULL,
  `subject` LONGTEXT DEFAULT NULL,
  `content` LONGTEXT DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL, -- may be draft, sent or something else
  `important` INTEGER NOT NULL,
  `createdate` varchar(255) DEFAULT NULL,
  `createby` bigint(20) DEFAULT NULL,
  `updatedate` varchar(255)  DEFAULT NULL,
  `updateby` bigint(20) DEFAULT NULL,
  `deleted` INTEGER DEFAULT 0,
  PRIMARY KEY (`messageid`)
); 

CREATE TABLE `MESSAGERECIPIENT` (
  `messagerecipientid` INTEGER NOT NULL AUTO_INCREMENT,
  `recipientid` INTEGER NOT NULL,
  `messageid` INTEGER NOT NULL,
  `viewed` INTEGER NOT NULL,
  `createdate` varchar(255) DEFAULT NULL,
  `createby` bigint(20) DEFAULT NULL,
  `updatedate` varchar(255)  DEFAULT NULL,
  `updateby` bigint(20) DEFAULT NULL,
  `deleted` INTEGER DEFAULT 0,
  PRIMARY KEY (`messagerecipientid`)
);

alter table user add column ENABLED INTEGER;
alter table user drop column ENABLED

alter table user add column ENABLED TINYINT(1) NOT NULL;

INSERT INTO user (USERID, USERNAME,PASSWORD, ENABLED)
VALUES (100, 'mahesh', '24251', TRUE);

INSERT INTO user_roles (USER_ROLE_ID, USERID,AUTHORITY)
VALUES (2, 100, 'ROLE_USER');

INSERT INTO user(username,password,enabled)
VALUES ('mkyong','123456', TRUE);
INSERT INTO user(username,password,enabled)
VALUES ('alex','123456', TRUE);

CREATE TABLE `user_roles` (
  `USER_ROLE_ID` INTEGER NOT NULL AUTO_INCREMENT,
  `USERID` INTEGER NOT NULL,
  `AUTHORITY` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`USER_ROLE_ID`)
);

INSERT INTO user_roles (USER_ROLE_ID, USERID,AUTHORITY)
VALUES (1, 1, 'ROLE_USER');

drop table user_roles;

CREATE TABLE user_roles (
  user_role_id INT(11) NOT NULL AUTO_INCREMENT,
  username VARCHAR(45) NOT NULL,
  ROLE VARCHAR(45) NOT NULL,
  PRIMARY KEY (user_role_id),
  UNIQUE KEY uni_username_role (ROLE,username));

  INSERT INTO user_roles (username, ROLE)
VALUES ('mkyong', 'ROLE_USER');
INSERT INTO user_roles (username, ROLE)
VALUES ('mkyong', 'ROLE_ADMIN');
INSERT INTO user_roles (username, ROLE)
VALUES ('alex', 'ROLE_USER');
  
INSERT INTO `dost`.`user` (`userid`, `username`, `password`, `role`, `userrole`) VALUES ('1', 'satya', '123', 'USER', 'USER');
INSERT INTO `dost`.`user` (`userid`, `username`, `password`, `role`, `userrole`) VALUES ('2', 'richa', '123', 'COUNSELOR', 'COUNSELOR');

ALTER TABLE faq modify userid BIGINT NOT NULL DEFAULT 100;

insert into faqcategory (faqcategoryid, faqcategoryname, deleted) values(2,'family',0);

--message 1
--alex sending to mkyong
INSERT INTO `dost`.`message` (`messageid`, `senderid`, `sentdate`, `subject`, `content`, `important`, `deleted`) VALUES ('1', '102', NOW(), 'Test message', 'Full test message', '0', '0');
INSERT INTO `dost`.`messagerecipient` (`messagerecipientid`, `recipientid`, `messageid`, `viewed`, `deleted`) VALUES ('1', '101', '1', '0', '0');


--message 2
--mkyong sending to alex
INSERT INTO `dost`.`message` (`messageid`, `senderid`, `sentdate`, `subject`, `content`, `important`, `deleted`) VALUES ('2', '101', NOW(), 'Test message reply', 'Full test message reply', '0', '0');
INSERT INTO `dost`.`messagerecipient` (`messagerecipientid`, `recipientid`, `messageid`, `viewed`, `deleted`) VALUES ('2', '102', '2', '0', '0');

alter table message add column msgid INTEGER;

UPDATE `dost`.`message` SET `msgid`='1' WHERE `messageid`='1';
UPDATE `dost`.`message` SET `msgid`='1' WHERE `messageid`='2';

alter table user_roles add column userid INTEGER;
UPDATE `dost`.`user_roles` SET `userid`='102' WHERE `user_role_id`='3';
UPDATE `dost`.`user_roles` SET `userid`='101' WHERE `user_role_id`='2';

alter table user_roles drop column dbUser;

ALTER TABLE message MODIFY sentdate DATETIME NULL DEFAULT NOW();

CREATE TRIGGER message_OnInsert BEFORE INSERT ON `message`
    FOR EACH ROW SET NEW.sentdate = NOW();
    
INSERT INTO `dost`.`user` (`userid`, `username`, `password`, `deleted`, `ENABLED`) VALUES ('103', 'sohil', '123456', '0', '1');
insert into user_roles values(4,'sohil', 'ROLE_USER', 103);
    
INSERT INTO `dost`.`user` (`userid`, `username`, `password`, `deleted`, `ENABLED`) VALUES ('104', 'prashant', '123', '0', '1');
insert into user_roles values(5,'prashant', 'ROLE_ADMIN', 104);

alter table user add column avatar varchar(100);
--DDL to add discussion topics with huge text
ALTER TABLE jforum_topics MODIFY topic_title TEXT(65536)

--Creating DDL for security questions
CREATE TABLE `security_question` (
  `question_id` INTEGER NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL,
  `createdate` varchar(255) DEFAULT NULL,
  `createby` bigint(20) DEFAULT NULL,
  `updatedate` varchar(255)  DEFAULT NULL,
  `updateby` bigint(20) DEFAULT NULL,
  `deleted` INTEGER DEFAULT 0,
  PRIMARY KEY (`question_id`)
);

insert into security_question values(1, 'What is your nick name', '', 0, '', 0, 0)
insert into security_question values(2, 'What is you first school’s name', '', 0, '', 0, 0)
insert into security_question values(3, 'Which city are you born in', '', 0, '', 0, 0)
insert into security_question values(4, 'What was your maternal grandfather’s first name', '', 0, '', 0, 0)
insert into security_question values(5, 'In what city or town does your nearest sibling live', '', 0, '', 0, 0)
insert into security_question values(6, 'What was the name of your elementary / primary school', '', 0, '', 0, 0)
insert into security_question values(7, 'In what city or town does your nearest sibling live', '', 0, '', 0, 0)

--DDL to store user security questions and answers
CREATE TABLE `user_question` (
  `USER_QUESTION_ID` INTEGER NOT NULL AUTO_INCREMENT,
  `USERID` INTEGER NOT NULL,
  `QUESTIONID` INTEGER NOT NULL,
  `ANSWER` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`USER_QUESTION_ID`)
);

CREATE TABLE `conversationnote` (
  `noteid` INTEGER NOT NULL AUTO_INCREMENT,
  `userid` INTEGER NOT NULL,
  `messageId` INTEGER NOT NULL,
  `note` VARCHAR(4500) DEFAULT NULL,
  `notedate` varchar(255) DEFAULT NULL,
  `createdate` varchar(255) DEFAULT NULL,
  `createby` bigint(20) DEFAULT NULL,
  `updatedate` varchar(255)  DEFAULT NULL,
  `updateby` bigint(20) DEFAULT NULL,
  `deleted` INTEGER DEFAULT 0,
  PRIMARY KEY (`noteid`)
);

--Trigger to insert note date 
CREATE TRIGGER conversationnote_OnInsert BEFORE INSERT ON `conversationnote`
    FOR EACH ROW SET NEW.notedate = NOW();

select * from fpSessionMetadata m,fpSession s
where m.sessionid = s.sessionid and metadataValue = 'alex'

ALTER TABLE user
ADD COLUMN `fname` VARCHAR(100) DEFAULT NULL AFTER `avatar`,
ADD COLUMN `lname` VARCHAR(100) DEFAULT NULL AFTER `fname`,
ADD COLUMN `hostel` VARCHAR(100) DEFAULT NULL AFTER `lname`,
ADD COLUMN `year` INT(10) UNSIGNED DEFAULT NULL AFTER `hostel`;

ALTER TABLE user
ADD COLUMN `branch` VARCHAR(100) DEFAULT NULL AFTER `year`;

ALTER TABLE user MODIFY year VARCHAR(100) DEFAULT NULL;

CREATE TRIGGER user_OnInsert BEFORE INSERT ON `user`
    FOR EACH ROW SET NEW.createdate = NOW();
    
ALTER TABLE user
ADD COLUMN `email` VARCHAR(100) DEFAULT NULL AFTER `branch`;

--Table for storing emails after conversation with Shweta

CREATE TABLE `dost_email` (
    `emailid` INTEGER NOT NULL AUTO_INCREMENT,
    `conversationid` INTEGER NOT NULL,
    `email_type` VARCHAR(4500) DEFAULT NULL,
    `sender` varchar(255) DEFAULT NULL,
	`agent` varchar(255) DEFAULT NULL,
    `recipient` varchar(255) DEFAULT NULL,
    `recipient_email` VARCHAR(10000) DEFAULT NULL,
    `status` varchar(255) DEFAULT NULL,
    `error_message` varchar(4500) DEFAULT NULL,
    `createdate` varchar(255) DEFAULT NULL,
    `createby` bigint(20) DEFAULT NULL,
    `updatedate` varchar(255) DEFAULT NULL,
    `updateby` bigint(20) DEFAULT NULL,
    `deleted` INTEGER DEFAULT 0,
    PRIMARY KEY (`emailid`)
);

--Trigger to add data in chat_update table from ofConversation when chat ends
delimiter |
CREATE TRIGGER chat_update
AFTER UPDATE ON ofConParticipant
FOR EACH ROW
BEGIN
SET @countOfMessage = (select messageCount from ofConversation where conversationID = OLD.conversationID);
SET @countOfemail = (select count(*) from dost_email where conversationid = OLD.conversationID);
IF @countOfemail = 0 THEN
insert into dost_email (conversationid, email_type, sender, agent, messagecount, recipient, recipient_email, status, createdate) 
values(OLD.conversationID, 'CHAT_FEEDBACK', 'customersupport@yourdost.com', 
(select nickname from ofConParticipant where conversationID = OLD.conversationID and jidResource in ('Spark 2.6.3')),
@countOfMessage,
(select nickname from ofConParticipant where conversationID = OLD.conversationID and jidResource not in ('Spark 2.6.3', 'demo')),
(select email from user where username in( select nickname from ofConParticipant where conversationID = OLD.conversationID and jidResource not in ('Spark 2.6.3', 'demo'))), 
'NOT_SENT', NOW());
END IF;
-- if message count is 2 or less
SET @countOfMessage = (select messageCount from ofConversation where conversationID = OLD.conversationID);
IF @countOfMessage < 5 and @countOfemail = 1 THEN -- there can be only one entry in dost_email table
insert into dost_email (conversationid, email_type, sender, agent, messagecount, recipient, recipient_email, status, createdate) 
values(OLD.conversationID, 'MESSAGE_COUNT', 'customersupport@yourdost.com', 
(select nickname from ofConParticipant where conversationID = OLD.conversationID and jidResource in ('Spark 2.6.3')),
@countOfMessage,
(select nickname from ofConParticipant where conversationID = OLD.conversationID and jidResource not in ('Spark 2.6.3', 'demo')),
(select email from user where username in( select nickname from ofConParticipant where conversationID = OLD.conversationID and jidResource not in ('Spark 2.6.3', 'demo'))), 
'NOT_SENT', NOW());
END IF;
END |
delimiter ;

ALTER TABLE dost_email
ADD COLUMN `messagecount` INTEGER DEFAULT 0 AFTER `agent`;


--Adding new forums 

insert into jforum_categories values (2, 'Category Relation', 2, 0)
insert into jforum_categories values (3, 'Category Career', 3, 0)
insert into jforum_categories values (4, 'Category Education', 4, 0)
insert into jforum_categories values (5, 'Category Personality', 5, 0)

insert into jforum_forums values (2, 2, 'Relationship', 'Relationship', 1, 0, 0, 0)
insert into jforum_forums values (3, 3, 'Career', 'Career', 1, 0, 0, 0)
insert into jforum_forums values (4, 4, 'Education', 'Education', 1, 0, 0, 0)
insert into jforum_forums values (5, 5, 'Personality', 'Personality', 1, 0, 0, 0)


CREATE TABLE `dost_userlog` (
    `logid` INTEGER NOT NULL AUTO_INCREMENT,
    `userid` INTEGER NOT NULL,
    `username` VARCHAR(255) NOT NULL,
    `ip` varchar(255) DEFAULT NULL,
	`logintime` varchar(255) DEFAULT NULL,
    `createdate` varchar(255) DEFAULT NULL,
    `createby` bigint(20) DEFAULT NULL,
    `updatedate` varchar(255) DEFAULT NULL,
    `updateby` bigint(20) DEFAULT NULL,
    `deleted` INTEGER DEFAULT 0,
    PRIMARY KEY (`logid`)
);

CREATE TRIGGER dost_userlog_OnInsert BEFORE INSERT ON `dost_userlog`
    FOR EACH ROW SET NEW.logintime = NOW();
    
    
CREATE TABLE `dost_codes` (
    `codeid` INTEGER NOT NULL AUTO_INCREMENT,
    `type` varchar(255) NOT NULL,
	`value` varchar(1000) NOT NULL,
    `createdate` varchar(255) DEFAULT NULL,
    `createby` bigint(20) DEFAULT NULL,
    `updatedate` varchar(255) DEFAULT NULL,
    `updateby` bigint(20) DEFAULT NULL,
    `deleted` INTEGER DEFAULT 0,
    PRIMARY KEY (`codeid`)
);

INSERT INTO `dost`.`dost_codes` (`codeid`, `type`, `value`, `deleted`) VALUES ('1', 'TAG', 'Relationship', '0');
INSERT INTO `dost`.`dost_codes` (`codeid`, `type`, `value`, `deleted`) VALUES ('2', 'TAG', 'Career', '0');
INSERT INTO `dost`.`dost_codes` (`codeid`, `type`, `value`, `deleted`) VALUES ('3', 'TAG', 'Education', '0');
INSERT INTO `dost`.`dost_codes` (`codeid`, `type`, `value`, `deleted`) VALUES ('8', 'TAG', 'Others', '0');

CREATE TABLE `dost_counselors` (
    `counselorid` INTEGER NOT NULL AUTO_INCREMENT,
	`username` varchar(1000) NOT NULL,
    `password` varchar(1000) NOT NULL,
	`name` varchar(1000) NOT NULL,
    `description` varchar(10000) NOT NULL,
	`profilename` varchar(1000) NOT NULL,
    `timing` varchar(255) DEFAULT NULL,
    `gender` varchar(255) DEFAULT NULL,
    `location` varchar(255) DEFAULT NULL,
    `createdate` varchar(255) DEFAULT NULL,
    `createby` bigint(20) DEFAULT NULL,
    `updatedate` varchar(255) DEFAULT NULL,
    `updateby` bigint(20) DEFAULT NULL,
    `deleted` INTEGER DEFAULT 0,
    PRIMARY KEY (`counselorid`)
);

CREATE TABLE `dost_counselortags` (
    `tagid` INTEGER NOT NULL AUTO_INCREMENT,
    `counselorid` INTEGER NOT NULL,
	`tagname` varchar(255) DEFAULT NULL,
    `createdate` varchar(255) DEFAULT NULL,
    `createby` bigint(20) DEFAULT NULL,
    `updatedate` varchar(255) DEFAULT NULL,
    `updateby` bigint(20) DEFAULT NULL,
    `deleted` INTEGER DEFAULT 0,
    PRIMARY KEY (`tagid`)
);
-- Add data in dost_counselortags
-- Going forward we need to add data in dost_counselors also apart from users table

ALTER TABLE user
ADD COLUMN `blocked` VARCHAR(10) DEFAULT false AFTER `email`;

ALTER TABLE user
ADD COLUMN `identifier` VARCHAR(100) AFTER `blocked`;

ALTER TABLE message
ADD COLUMN `category` INTEGER AFTER `msgid`;