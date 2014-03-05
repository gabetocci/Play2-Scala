insert into category ( type, url, name, description, parentcategory)
values ('ACTIVE',
        'build-muscle',
        'Build Muscle',
        'Add Bulk',
        2);
insert into category ( type, url, name, description, parentcategory)
values ('ACTIVE',
        'burn-fat',
        'Burn Fat',
        'Burn Fat',
        2);
insert into category ( type, url, name, description, parentcategory)
values ('ACTIVE',
        'increase-energy',
        'Increase Energy',
        'Increase Energy',
        2);
insert into category ( type, url, name, description, parentcategory)
values ('ACTIVE',
        'sexual-health',
        'Sexual Health',
        'Get your swag on in the Bedroom',
        2);
insert into category ( type, url, name, description, parentcategory)
values ('ACTIVE',
        'mental-health',
        'Improve Mental Focus',
        'Improve Mental Focus',
        2);
insert into category ( type, url, name, description, parentcategory)
values ('ACTIVE',
        'protein',
        'Protein',
        'Protein Supplements',
        3);
insert into category ( type, url, name, description, parentcategory)
values ('ACTIVE',
        'creatine',
        'Creatine',
        'Creatine Supplements',
        3);
insert into category ( type, url, name, description, parentcategory)
values ('ACTIVE',
        'nitrous-oxide',
        'Nitrous Oxide (NO2)',
        'Nitrous Oxide (NO2) Supplements',
        3);
insert into category ( type, url, name, description, parentcategory)
values ('ACTIVE',
        'caffeine',
        'Caffeine',
        'Caffeine Supplements',
        3);
insert into category ( type, url, name, description, parentcategory)
values ('ACTIVE',
        'daspartic-acid',
        'D-Aspartic Acid (DAA)',
        'D-Aspartic Acid (DAA) Supplements',
        3);
update brand set name = 'BPI Sports' where id = 4;
update category set url = 'popular-products' where id = 4;

alter table brand add column url varchar(100);
update brand set url = 'competitive-edge-labs' where id = 1;
update brand set url = 'recomp-performance-nutrition' where id = 2;
update brand set url = 'cellucor' where id = 3;
update brand set url = 'bpi-sports' where id = 4;
update brand set url = 'elite-formulations' where id = 5;
update brand set url = 'serious-nutrition-solutions' where id = 6;
update brand set url = 'blackstone-labs' where id = 7;
update brand set url = 'platinum-labs' where id = 8;
alter table brand alter column url set not null;

