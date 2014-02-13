
-- Record Types

DROP TABLE IF EXISTS RecordType CASCADE;
CREATE TABLE RecordType (
  Id               serial           PRIMARY KEY,
  Type             varchar(10)      NOT NULL UNIQUE,
  Name             varchar(50),
  IsActive         boolean          NOT NULL DEFAULT 't',
  Comment          text,
  TimeStamp        timestamp        DEFAULT CURRENT_TIMESTAMP
);

-- Entities

DROP TABLE IF EXISTS Entity CASCADE;
CREATE TABLE Entity (
  Id               serial          PRIMARY KEY,
  Type             varchar(10)     NOT NULL REFERENCES RecordType(Type),
  CompanyName      varchar(200),
  Title            varchar(10),
  FirstName        varchar(50),
  MiddleName       varchar(50),
  LastName         varchar(50),
  Suffix           varchar(10),
  Comment          text,
  TimeStamp        timestamp       DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS UserAccount CASCADE;
CREATE TABLE UserAccount (
  Id               serial          PRIMARY KEY,
  EntityId         int             NOT NULL REFERENCES Entity(Id),
  Username         varchar(20),
  Password         varchar(256),
  isActive         boolean         NOT NULL DEFAULT 't',
  Comment          text,
  TimeStamp        timestamp       DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION count_primary_email(EntityId integer)
  RETURNS BIGINT AS
  $$
  SELECT count(*) FROM email
   WHERE email.EntityId = $1
     AND email.isPrimary = 't'
  $$
  LANGUAGE SQL IMMUTABLE;

DROP TABLE IF EXISTS Email CASCADE;
CREATE TABLE Email (
  Id               serial          PRIMARY KEY,
  Type             varchar(10)     NOT NULL REFERENCES RecordType(Type),
  EntityId         int             NOT NULL REFERENCES Entity(Id),
  EmailAddress     varchar(100)    NOT NULL,
  isActive         boolean         NOT NULL DEFAULT 't',
  isPrimary        boolean         NOT NULL DEFAULT 't',
  Comment          text,
  TimeStamp        timestamp       DEFAULT CURRENT_TIMESTAMP,
  CHECK( count_primary_email(EntityId) <= 1 )
);



DROP TABLE IF EXISTS Address CASCADE;
CREATE TABLE Address (
  Id serial PRIMARY KEY,
  Type varchar(10) NOT NULL REFERENCES RecordType(Type),
  EntityId int NOT NULL,
  Line1 varchar(60) ,
  Line2 varchar(60) ,
  City varchar(60) ,
  State varchar(30),
  PostalCode varchar(15) ,
  Country varchar(60) ,
  Comment text,
  TimeStamp timestamp DEFAULT CURRENT_TIMESTAMP
  PRIMARY KEY (Id),
  CONSTRAINT fk_Address_Entity FOREIGN KEY (EntityId) REFERENCES Entity (Id) ON DELETE NO ACTION
);

DROP TABLE IF EXISTS Phone CASCADE;
CREATE TABLE Phone (
  Id serial PRIMARY KEY,
  Type varchar(10) NOT NULL REFERENCES RecordType(Type),
  EntityId int NOT NULL,
  PhoneNumber varchar(25),
  Extension varchar(10),
  Comment text,
  TimeStamp timestamp DEFAULT CURRENT_TIMESTAMP
  PRIMARY KEY (Id),
  CONSTRAINT fk_Phone_Entity FOREIGN KEY (EntityId) REFERENCES Entity (Id) ON DELETE NO ACTION
);

DROP TABLE IF EXISTS Demographic CASCADE;
CREATE TABLE Demographic (
  Id serial PRIMARY KEY,
  Type varchar(10) NOT NULL REFERENCES RecordType(Type),
  EntityId int NOT NULL,
  Dob timestamp,
  Gender varchar(1),
  Comment text,
  TimeStamp timestamp DEFAULT CURRENT_TIMESTAMP
  PRIMARY KEY (Id),
  CONSTRAINT fk_Demographic_Entity FOREIGN KEY (EntityId) REFERENCES Entity (Id) ON DELETE NO ACTION
);

DROP TABLE IF EXISTS CreditCard CASCADE;
CREATE TABLE CreditCard (
  Id serial PRIMARY KEY,
  Type varchar(10) NOT NULL REFERENCES RecordType(Type),
  EntityId int NOT NULL,
  AddressId int NOT NULL,
  CardNumber varchar(20) NOT NULL,
  ExpDate varchar(8) NOT NULL,
  Cvv char(4) NOT NULL,
  Comment text,
  TimeStamp timestamp DEFAULT CURRENT_TIMESTAMP
  PRIMARY KEY (Id),
  CONSTRAINT fk_CreditCard_Entity FOREIGN KEY (EntityId) REFERENCES Entity (Id) ON DELETE NO ACTION,
  CONSTRAINT fk_CreditCard_Address FOREIGN KEY (AddressId) REFERENCES Address (Id) ON DELETE NO ACTION
);


-- Accounting

DROP TABLE IF EXISTS Account CASCADE;
CREATE TABLE Account (
  Id serial PRIMARY KEY,
  Type varchar(4) NOT NULL,
  Name varchar(50) NOT NULL,
  Comment text,
  TimeStamp timestamp DEFAULT CURRENT_TIMESTAMP
  PRIMARY KEY (Id)
);

DROP TABLE IF EXISTS Currency CASCADE;
CREATE TABLE Currency (
  Id serial PRIMARY KEY,
  Type varchar(10) NOT NULL REFERENCES RecordType(Type),
  Code varchar(3),
  Rate numeric,
  Comment text,
  TimeStamp timestamp DEFAULT CURRENT_TIMESTAMP
  PRIMARY KEY (Id)
);

DROP TABLE IF EXISTS Document CASCADE;
CREATE TABLE Document (
  Id serial PRIMARY KEY,
  Type varchar(10) NOT NULL REFERENCES RecordType(Type),
  AccountId int,
  ExternalDocumentId varchar(50),
  ExternalEntityId int,
  ExternalAddressId int,
  Description varchar(50),
  DocumentDate timestamp,
  DueDate timestamp,
  Status char(4) ,
  SubTotal numeric,
  TaxAmt numeric,
  ShippingAmt numeric,
  TotalAmt numeric,
  CurrencyCode char(4),
  ShipmentId int,
  Comment text,
  TimeStamp timestamp DEFAULT CURRENT_TIMESTAMP
  PRIMARY KEY (Id)
);

DROP TABLE IF EXISTS DocumentItem CASCADE;
CREATE TABLE DocumentItem (
  Id serial PRIMARY KEY,
  Type varchar(10) NOT NULL REFERENCES RecordType(Type),
  DocumentId int NOT NULL,
  ProductId int,
  SkuId int,
  SkuQty int,
  SkuPriceEach numeric,
  LineTotal numeric,
  Comment text,
  TimeStamp timestamp DEFAULT CURRENT_TIMESTAMP
  PRIMARY KEY (Id),
  CONSTRAINT fk_DocumentItem_Document FOREIGN KEY (Id) REFERENCES Document (Id) ON DELETE NO ACTION
);

DROP TABLE IF EXISTS TaxRate CASCADE;
CREATE TABLE TaxRate (
  Id serial PRIMARY KEY,
  Type varchar(10) NOT NULL REFERENCES RecordType(Type),
  State varchar(10),
  Rate numeric,
  Comment text,
  TimeStamp timestamp DEFAULT CURRENT_TIMESTAMP
  PRIMARY KEY (Id)
);

DROP TABLE IF EXISTS Transaction CASCADE;
CREATE TABLE Transaction (
  Id serial PRIMARY KEY,
  Type varchar(10) NOT NULL REFERENCES RecordType(Type),
  DocumentId int,
  Date timestamp,
  Amount numeric,
  Comments text,
  TimeStamp timestamp DEFAULT CURRENT_TIMESTAMP
  PRIMARY KEY (Id),
  CONSTRAINT fk_Transaction_Document FOREIGN KEY (DocumentId) REFERENCES Document (Id) ON DELETE NO ACTION
);

--
-- Inventory
--

DROP TABLE IF EXISTS ProductCategory CASCADE;
CREATE TABLE ProductCategory (
  Id               serial          PRIMARY KEY,
  Type             varchar(10)     NOT NULL REFERENCES RecordType(Type),
  Name             varchar(50),
  Description      text,
  Comment          text,
  TimeStamp        timestamp       DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS Brand CASCADE;
CREATE TABLE Brand (
  Id               serial          PRIMARY KEY,
  Type             varchar(10)     NOT NULL REFERENCES RecordType(Type),
  Name        varchar(50),
  EntityId         int             REFERENCES Entity(Id),
  Comment          text,
  TimeStamp        timestamp       DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS ProductSku CASCADE;
CREATE TABLE ProductSku (
  Id               serial          PRIMARY KEY,
  Type             varchar(10)     NOT NULL REFERENCES RecordType(Type),
  ProductCategoryId int            REFERENCES ProductCategory(Id),
  BrandId          int             REFERENCES Brand(Id),
  Name             varchar(50),
  Description      text,
  ReorderQty       int,
  InStockQty       int,
  Weight           numeric,
  Comment          text,
  TimeStamp        timestamp       DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SkuAttribute CASCADE;
CREATE TABLE SkuAttribute (
  Id               serial          PRIMARY KEY,
  Type             varchar(10)     NOT NULL REFERENCES RecordType(Type),
  SkuId            int             NOT NULL REFERENCES ProductSku(Id),
  AttributeKey     varchar(20),
  AttributeValue   varchar(40),
  Comment          text,
  TimeStamp        timestamp       DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SkuCost CASCADE;
CREATE TABLE SkuCost (
  Id               serial          PRIMARY KEY,
  Type             varchar(10)     NOT NULL REFERENCES RecordType(Type),
  SkuId            int             NOT NULL REFERENCES ProductSku(Id),
  Cost             numeric,
  StartDate        timestamp,
  EndDate          timestamp,
  Comment          text,
  TimeStamp        timestamp       DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SkuImage CASCADE;
CREATE TABLE SkuImage (
  Id               serial          PRIMARY KEY,
  Type             varchar(10)     NOT NULL REFERENCES RecordType(Type),
  SkuId            int             NOT NULL REFERENCES ProductSku(Id),
  Filename         varchar(50),
  Comment          text,
  TimeStamp        timestamp       DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SkuLocation CASCADE;
CREATE TABLE SkuLocation (
  Id               serial          PRIMARY KEY,
  Type             varchar(10)     NOT NULL REFERENCES RecordType(Type),
  SkuId            int             NOT NULL REFERENCES ProductSku(Id),
  FacilityId       int,
  LocationId       int,
  Shelf            varchar(50),
  Bin              varchar(50),
  Comment          text,
  TimeStamp        timestamp       DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SkuPrice CASCADE;
CREATE TABLE SkuPrice (
  Id               serial          PRIMARY KEY,
  Type             varchar(10)     NOT NULL REFERENCES RecordType(Type),
  SkuId            int             NOT NULL REFERENCES ProductSku(Id),
  Price            numeric,
  StartDate        timestamp,
  EndDate          timestamp,
  Comment          text,
  TimeStamp        timestamp       DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS SkuReview CASCADE;
CREATE TABLE SkuReview (
  Id               serial          PRIMARY KEY,
  Type             varchar(10)     NOT NULL REFERENCES RecordType(Type),
  SkuId            int             NOT NULL REFERENCES ProductSku(Id),
  EntityId         int             NOT NULL REFERENCES Entity(Id),
  ReviewDate       timestamp,
  Rating           int,
  Comment          text,
  TimeStamp        timestamp       DEFAULT CURRENT_TIMESTAMP
);

--
-- Sales
--

DROP TABLE IF EXISTS ProductOrder CASCADE;
CREATE TABLE ProductOrder (
  Id               serial PRIMARY KEY,
  Type             varchar(10) NOT NULL REFERENCES RecordType(Type),
  EntityId         int NOT NULL,
  OrderDate        timestamp NOT NULL,
  BillToAddressId  int NOT NULL,
  CurrencyId       int,
  SubTotal         numeric NOT NULL,
  TaxAmt           numeric NOT NULL,
  ShippingAmt      numeric NOT NULL,
  TotalDue         numeric,
  PaymentId        int,
  Comment          text,
  TimeStamp        timestamp DEFAULT CURRENT_TIMESTAMP
  CONSTRAINT fk_Order_Entity FOREIGN KEY (EntityId) REFERENCES Entity (Id) ON DELETE NO ACTION,
  CONSTRAINT fk_Order_BillToAddress FOREIGN KEY (BillToAddressId) REFERENCES Address (Id) ON DELETE NO ACTION
);

DROP TABLE IF EXISTS OrderLineItem CASCADE;
CREATE TABLE OrderLineItem (
  Id serial PRIMARY KEY,
  Type varchar(10) NOT NULL REFERENCES RecordType(Type),
  OrderId int NOT NULL,
  SkuId int,
  SkuQty int,
  PriceEach numeric,
  LineTotal numeric,
  Comment text,
  TimeStamp timestamp DEFAULT CURRENT_TIMESTAMP
  PRIMARY KEY (Id),
  CONSTRAINT fk_OrderLineItem_CustomerOrder FOREIGN KEY (OrderId) REFERENCES CustomerOrder (Id) ON DELETE NO ACTION,
  CONSTRAINT fk_OrderLineItem_Sku FOREIGN KEY (SkuId) REFERENCES ProductSku (Id) ON DELETE NO ACTION
);

--
-- Logging
--

DROP TABLE IF EXISTS Log CASCADE;
CREATE TABLE Log (
  Id serial PRIMARY KEY,
  Type varchar(10) NOT NULL REFERENCES RecordType(Type),
  EntityId int,
  Comment text,
  TimeStamp timestamp DEFAULT CURRENT_TIMESTAMP

);

DROP TABLE IF EXISTS PageTracking CASCADE;
CREATE TABLE PageTracking (
  Id serial PRIMARY KEY,
  Type varchar(10) NOT NULL REFERENCES RecordType(Type),
  EntityId int,
  IPAddress varchar(50),
  URL varchar(200),
  FromURL varchar(200),
  Cookie varchar(200),
  Comment text,
  TimeStamp timestamp DEFAULT CURRENT_TIMESTAMP

);


/***

DROP TABLE IF EXISTS Shipment;
CREATE TABLE Shipment (
  Id serial PRIMARY KEY,
   Type varchar(10) NOT NULL REFERENCES RecordType(Type),
  DocumentId int,
  OrderId int,
  ShipToAddressId int NOT NULL,
  Service varchar(50),
  TrackingNumber varchar(50),
  ShippingAmt numeric NOT NULL,
  ShipDate timestamp,
  DueDate timestamp,
  DeliveryDate timestamp,
  LastScanLocation varchar(50),
  LastScanDate timestamp,
  ModifiedDate timestamp NOT NULL,
  PRIMARY KEY (Id),
  CONSTRAINT fk_Shipment_Order FOREIGN KEY (OrderId) REFERENCES Sales.Order (Id) ON DELETE NO ACTION,
  CONSTRAINT fk_Shipment_Document FOREIGN KEY (DocumentId) REFERENCES Accounting.DocumentId (Id) ON DELETE NO ACTION,
  CONSTRAINT fk_Shipment_Address FOREIGN KEY (ShipToAddressId) REFERENCES Entity.Address (Id) ON DELETE NO ACTION
);

DROP TABLE IF EXISTS SpecialOffer;
CREATE TABLE SpecialOffer (
  Id serial PRIMARY KEY,
   Type varchar(10) NOT NULL REFERENCES RecordType(Type),
  SkuId int,
  Title varchar(50),
  Discount numeric,
  Start timestamp,
  End timestamp,
  MinQty int,
  MaxQty int,
  ModifiedDate timestamp NOT NULL
  PRIMARY KEY (Id),
  CONSTRAINT fk_SpecialOffer_Sku FOREIGN KEY (SkuId) REFERENCES Inventory.ProductSku (Id) ON DELETE NO ACTION
);

 COMMENT=Record type validation table
 COMMENT Person being tracked.,
 COMMENT IP adress of the person.,
 COMMENT URL requested by person.,
 COMMENT URL the person is coming from (last page visited).,
 COMMENT Coockie associated with this person.,
 COMMENT Date and time this activity was tracked.,

ModifiedDate timestamp NULL DEFAULT CURRENT_TIMESTAMP,

***/

insert into RecordType (Type, Name)
values ('ACTIVE','Active');
insert into RecordType (Type, Name)
values ('INACTIVE','Inactive');
insert into RecordType (Type, Name)
values ('EMPLOYEE','Employee');
insert into RecordType (Type, Name)
values ('CUSTOMER','Customer');
insert into RecordType (Type, Name)
values ('VENDOR','Vendor');
insert into RecordType (Type, Name)
values ('PERSONAL','Personal');
insert into RecordType (Type, Name)
values ('BUSINESS','Business');
commit;

select * from RecordType;

insert into Entity (Type, FirstName, LastName)
values ('EMPLOYEE', 'Gabriel', 'Tocci');
insert into Entity (Type, FirstName, LastName)
values ('EMPLOYEE', 'Rachael', 'Tocci');
insert into Entity (Type, FirstName, LastName)
values ('CUSTOMER', 'Mickey', 'Mouse');
insert into Entity (Type, FirstName, LastName)
values ('CUSTOMER', 'Donald', 'Duck');
insert into Entity (Type, CompanyName, FirstName, LastName)
values ('VENDOR', 'Get Fit Fast Supplements LLC.', 'Adam', 'Harper');
insert into Entity (Type, CompanyName, FirstName, LastName)
values ('VENDOR', 'New Tech Wholesalers', 'David', 'New');
insert into RecordType (Type, Name, isactive)
values ('ACTIVE','Active', 't');
insert into RecordType (Type, Name, isactive)
values ('INACTIVE','Inactive', 't');
insert into RecordType (Type, Name, isactive)
values ('MSRP','Suggested Retail Price', 't');
insert into RecordType (Type, Name, isactive)
values ('Sale','Sale', 't');

insert into UserAccount (EntityId, Username, Password)
values (1, 'gabrieltocci', 'password');
insert into UserAccount (EntityId, Username, Password)
values (2, 'rachaeltocci', 'password');

insert into Email ( Type, EntityID, EmailAddress, isPrimary)
values ('PERSONAL',1,'gabetoccig@gmail.com','f');
insert into Email ( Type, EntityID, EmailAddress, isPrimary)
values ('PERSONAL',2,'rachaele.griffin@gmail.com','t');
insert into Email ( Type, EntityID, EmailAddress, isPrimary)
values ('BUSINESS',1,'gabe@gabrieltocci.com','t');
insert into Email ( Type, EntityID, EmailAddress, isPrimary)
values ('BUSINESS',5,'bigharpa4heezy@hotmail.com','t');
commit;

select * from Entity;
select * from UserAccount;
select * from Email;

insert into brand ( type, name )
values ('ACTIVE', 'Competitive Edge Labs (CEL)');
insert into brand ( type, name )
values ('ACTIVE', 'Recomp Performance Nutrition (RPN)');

insert into productcategory ( type, name, description )
values ('ACTIVE', 'Cycle Support','Maintain healthy hormone balances, boost immunity, and helps organs fight off some of the toxic effects from using Prohormone’s or any other synthetic muscle building compounds.');
insert into productcategory ( type, name, description )
values ('ACTIVE', 'Prohormones','Prohormones are hormone precursors, synthetically produced compounds that are converted to anabolic hormones via liver enzymes once they are introduced to the body that raise the levels of the male hormones testosterone and 19-nortestosterone. They contain metabolic precursors that your body transforms into the active hormones.');

insert into productsku ( type, productcategoryid, brandid, name, description )
values ('ACTIVE',1,1,'Cycle Assist','Cycle Assist is designed to be an all-in-one support solution for basic on cycle and post cycle therapy needs. Cycle Assist contains a combination of specifically dosed ingredients designed to help provide liver, blood pressure, cholesterol, prostate, and acne support.');
insert into productsku ( type, productcategoryid, brandid, name, description )
values ('ACTIVE',1,1,'PCT Assist','PCT Assist is designed to help increase natural testosterone levels during the period of Post Cycle Therapy (PCT) or as part of a natural testosterone enhancement regimen.');
insert into productsku ( type, productcategoryid, brandid, name, description )
values ('ACTIVE',2,2,'Havoc','Being completely non-estrogenic, Havoc offers an ideal composition to maximize strength and lean mass gains, with minimal side effects such as lethargy or gyno. RPN Havoc supplement embodies the most recent in a long, distinguished line of hormonal products designed to optimize the bodys ability to maximize muscular hypertrophy.');

insert into skuprice ( type, skuid, price )
values ('ACTIVE',1,24.95);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',2,34.95);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',3,27.45);
insert into skuprice ( type, skuid, price )
values ('MSRP',1,41.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',2,49.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',3,69.99);
commit;

select * from brand;
select * from ProductCategory;
select * from ProductSku;
select * from SkuPrice;


/*
select * from ProductCategory;
select * from ProductSku;
select * from SkuAttribute;
select * from SkuCost;
select * from SkuImage;

8/