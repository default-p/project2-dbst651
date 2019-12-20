SET ECHO ON;
SET SERVEROUTPUT ON;
SET LINESIZE 150;
SET PAGESIZE 30;

DROP TABLE LIBRARY CASCADE CONSTRAINTS PURGE;
DROP TABLE CUSTOMER CASCADE CONSTRAINTS PURGE;
DROP TABLE LIBRARY_CARD CASCADE CONSTRAINTS PURGE;
DROP TABLE BRANCH CASCADE CONSTRAINTS PURGE;
DROP TABLE CATALOG_ITEM CASCADE CONSTRAINTS PURGE;
DROP TABLE BRANCH_ITEM CASCADE CONSTRAINTS PURGE;
DROP TABLE TRANSACTION CASCADE CONSTRAINTS PURGE;
DROP TABLE DVD CASCADE CONSTRAINTS PURGE;
DROP TABLE BOOK CASCADE CONSTRAINTS PURGE;


CREATE TABLE LIBRARY (
  LIBRARY_ID NUMBER(10),
  LIBRARY_NAME VARCHAR2(50),
  LIBRARY_PHONE VARCHAR2(150),
  LIBRARY_ADDRESS VARCHAR2(150),
  CONSTRAINT LIBRARY_PK PRIMARY KEY (LIBRARY_ID)  
);

CREATE TABLE CUSTOMER (
  CUSTOMER_ID NUMBER(10),
  CUSTOMER_FIRST_NAME VARCHAR2(100),
  CUSTOMER_LAST_NAME VARCHAR2(100),  
  CUSTOMER_STREET VARCHAR2(150),
  CUSTOMER_CITY VARCHAR2(150),
  CUSTOMER_STATE VARCHAR2(150),
  CUSTOMER_ZIP VARCHAR2(150),
  CONSTRAINT CUSTOMER_PK PRIMARY KEY (CUSTOMER_ID)
);

CREATE TABLE LIBRARY_CARD (
  LIBRARY_CARD_ID NUMBER(10),
  LIBRARY_ID NUMBER(10),
  CUSTOMER_ID NUMBER(10),
  LIBRARY_CARD_NUMBER NUMBER(10),
  LIBRARY_CARD_PIN NUMBER(10), 
  ISSUE_DATE DATE,
  EXPIRATION_DATE DATE,
  CONSTRAINT LIBRARY_CARD_PK PRIMARY KEY (LIBRARY_CARD_ID),
  CONSTRAINT LIBRARY_CARD_LIBRARY_FK FOREIGN KEY (LIBRARY_ID) REFERENCES LIBRARY (LIBRARY_ID),
  CONSTRAINT LIBRARY_CARD_CUSTOMER_FK FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID)
);

CREATE TABLE BRANCH (
  BRANCH_ID NUMBER(10),
  BRANCH_NAME VARCHAR2(50),
  BRANCH_PHONE VARCHAR2(150),
  BRANCH_ADDRESS VARCHAR2(150),
  LIBRARY_ID NUMBER(10),
  CONSTRAINT BRANCH_PK PRIMARY KEY (BRANCH_ID),
  CONSTRAINT BRANCH_LIBRARY_FK FOREIGN KEY (LIBRARY_ID) REFERENCES LIBRARY (LIBRARY_ID)
);

CREATE TABLE CATALOG_ITEM (
  CATALOG_ITEM_ID NUMBER(10),
  TITLE VARCHAR2(150),
  DESCRIPTION VARCHAR2(300),
  RELEASE_DATE DATE,
  PUBLISHER VARCHAR2(150),  
  TYPE VARCHAR2(150)
);

CREATE TABLE BRANCH_ITEM (
  BRANCH_ITEM_ID NUMBER(10),
  CATALOG_ITEM_ID NUMBER(10),
  BRANCH_ID NUMBER(10),
  COPY_NUMBER NUMBER(10),  
  TITLE VARCHAR2(150),
  PURCHASE_DATE DATE,
  CONSTRAINT BRANCH_ITEM_PK PRIMARY KEY (BRANCH_ITEM_ID),
  CONSTRAINT BRANCH_ITEM_BRANCH_FK FOREIGN KEY (BRANCH_ID) REFERENCES BRANCH (BRANCH_ID)
);

CREATE TABLE TRANSACTION (
  TRANSACTION_ID NUMBER(10),
  LIBRARY_CARD_ID NUMBER(10),
  BRANCH_ITEM_ID NUMBER(10),
  CHECKOUT_DATE DATE,
  DUE_DATE DATE,
  RETURN_DATE DATE,
  CONSTRAINT TRANSACTION_LIBRARY_CARD_FK FOREIGN KEY (LIBRARY_CARD_ID) REFERENCES LIBRARY_CARD (LIBRARY_CARD_ID),
  CONSTRAINT TRANSACTION_BRANCH_ITEM_FK FOREIGN KEY (BRANCH_ITEM_ID) REFERENCES BRANCH_ITEM (BRANCH_ITEM_ID)
);

CREATE TABLE DVD (
  CATALOG_ITEM_ID NUMBER(10),
  DVD_LENGTH VARCHAR(50)
);

CREATE TABLE BOOK (
  CATALOG_ITEM_ID NUMBER(10),
  ISBN VARCHAR2(150),
  PAGE_LENGTH NUMBER(10)
);



CREATE INDEX LIBRARY_CARD_LIBRARY_FK_I ON LIBRARY_CARD (LIBRARY_ID);

CREATE INDEX LIBRARY_CARD_CUSTOMER_FK_I ON LIBRARY_CARD (CUSTOMER_ID);

CREATE INDEX BRANCH_LIBRARY_FK_I ON BRANCH (LIBRARY_ID);

CREATE INDEX BRANCH_ITEM_BRANCH_FK_I ON BRANCH_ITEM (BRANCH_ID);

CREATE INDEX BRANCH_ITEM_CATALOG_ITEM_FK_I ON BRANCH_ITEM (CATALOG_ITEM_ID);

CREATE INDEX TRANSACTION_LIBRARY_CARD_FK_I ON TRANSACTION (LIBRARY_CARD_ID);

CREATE INDEX TRANSACTION_BRANCH_ITEM_FK_I ON TRANSACTION (BRANCH_ITEM_ID);

CREATE INDEX BOOK_CATALOG_ITEM_FK_I ON BOOK (CATALOG_ITEM_ID);

CREATE INDEX DVD_CATALOG_ITEM_FK_I ON DVD (CATALOG_ITEM_ID);


/*
DROP SEQUENCE DVD_ID_SEQ;

CREATE SEQUENCE DVD_ID_SEQ
 INCREMENT BY 1
 START WITH 0
/

CREATE OR REPLACE TRIGGER DVD_BIUS_TRG
BEFORE INSERT OR UPDATE ON DVD
FOR EACH ROW
WHEN (NEW.DVD_ID IS NULL)
BEGIN
  SELECT DVD_ID_SEQ.NEXTVAL
  INTO   :NEW.DVD_ID
  FROM   DUAL;
END;
/
*/