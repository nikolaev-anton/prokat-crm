truncate table STATUS;
insert into STATUS(ID,NAME) values(0,'�������');
insert into STATUS(ID,NAME) values(1,'�������');
insert into STATUS(ID,NAME) values(2,'�������');
insert into STATUS(ID,NAME) values(3,'��������');
insert into STATUS(ID,NAME) values(4,'����������');
insert into STATUS(ID,NAME) values(5,'�����������');
insert into STATUS(ID,NAME) values(6,'��������');
insert into STATUS(ID,NAME) values(7,'������');
insert into STATUS(ID,NAME) values(8,'�����');

insert into MODELS (ID, COMMENT, NAME, `TYPE`, PHOTO1, PHOTO2, PHOTO3, VIDEO1, VIDEO2, VIDEO3, DESCRIPTION1, DESCRIPTION2, DESCRIPTION3, CREATED)
select 4,'fresh&black','Arpenaz 3XL', `TYPE`, PHOTO1, PHOTO2, PHOTO3, VIDEO1, VIDEO2, VIDEO3, DESCRIPTION1, DESCRIPTION2, DESCRIPTION3, CURRENT_TIMESTAMP() 
FROM prokatparu_crm.MODELS where ID =3;

ALTER TABLE ORDERS MODIFY COLUMN GIVER_ID INT NULL, MODIFY COLUMN TAKER_ID INT NULL, MODIFY COLUMN GIVE_STOCK_ID INT NULL, MODIFY COLUMN TAKE_STOCK_ID INT NULL;

INSERT INTO STOCKS values(0,'�����������','�� ������',now(),'����������� ����� - ��� �������, ��� �� ������ �����')
-- ��-�� autoincrement 0 �� ���������
UPDATE STOCKS set id=0 WHEre id=5;

ALTER TABLE EMPLOYEES MODIFY COLUMN PHONE1 varchar(255) NULL, MODIFY COLUMN PHONE2 varchar(255) NULL, MODIFY COLUMN PHONE3 varchar(255) NULL;
INSERT INTO EMPLOYEES(ID,COMMENT, NAME, PHONE1 ,PHONE2, PHONE3 , CREATED, LOGIN , PASSWORD , STATUS)  values(0,'����������� ��������� - ��� �������, ��� �� ������ ���������','�� ������',null,null,null,now(),'�� ������','�������������� hash ������, ����� ���������� ���� ��� ��� ����������', '��������')

ALTER TABLE ORDERS MODIFY COLUMN GIVER_ID int NOT NULL, MODIFY COLUMN TAKER_ID int NOT NULL, MODIFY COLUMN GIVE_STOCK_ID int NOT NULL, MODIFY COLUMN TAKE_STOCK_ID int NOT NULL;
