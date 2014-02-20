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

insert into productcategory ( type, url, name, description )
values ('ACTIVE', 'Cycle Support', 'cycle-support', 'Maintain healthy hormone balances, boost immunity, and helps organs fight off some of the toxic effects from using Prohormone’s or any other synthetic muscle building compounds.');
insert into productcategory ( type, url, name, description )
values ('ACTIVE','prohormones','Prohormones','Prohormones are hormone precursors, synthetically produced compounds that are converted to anabolic hormones via liver enzymes once they are introduced to the body that raise the levels of the male hormones testosterone and 19-nortestosterone. They contain metabolic precursors that your body transforms into the active hormones.');

insert into productsku ( type, url, productcategoryid, brandid, name, description )
values ('ACTIVE','competitive-edge-labs-cycle-assist',1,1,'Cycle Assist','Cycle Assist is designed to be an all-in-one support solution for basic on cycle and post cycle therapy needs. Cycle Assist contains a combination of specifically dosed ingredients designed to help provide liver, blood pressure, cholesterol, prostate, and acne support.');
insert into productsku ( type, url, productcategoryid, brandid, name, description )
values ('ACTIVE','competitive-edge-labs-pct-assist',1,1,'PCT Assist','PCT Assist is designed to help increase natural testosterone levels during the period of Post Cycle Therapy (PCT) or as part of a natural testosterone enhancement regimen.');
insert into productsku ( type, url, productcategoryid, brandid, name, description )
values ('ACTIVE','recomp-performance-nutrition-havoc',2,2,'Havoc','Being completely non-estrogenic, Havoc offers an ideal composition to maximize strength and lean mass gains, with minimal side effects such as lethargy or gyno. RPN Havoc supplement embodies the most recent in a long, distinguished line of hormonal products designed to optimize the bodys ability to maximize muscular hypertrophy.');

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
