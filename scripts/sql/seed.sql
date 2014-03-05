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

-- top level categories
insert into category ( type, url, name, description )
values ('ACTIVE',
        'product-categories',
        'Product Categories',
        'See All Of Our Product Categories');
insert into category ( type, url, name, description )
values ('ACTIVE',
        'fitness-goals',
        'Fitness Goals',
        'What Are Your Fitness Goals?');
insert into category ( type, url, name, description )
values ('ACTIVE',
        'product-ingredients',
        'Product Ingredients',
        'Find Supplements With A Specific Ingredient');
insert into category ( type, url, name, description )
values ('ACTIVE',
        'popular-products',
        'Most Popular',
        'See What Everyone Else Is Using');
insert into category ( type, url, name, description)
values ('ACTIVE',
        'product-brands',
        'Brands',
        'Find Your Favorite Brand');
insert into category ( type, url, name, description )
values ('ACTIVE',
        'sale-products',
        'Sales and Promotions',
        'Check Out Our Current Promotions');

-- subcategories
insert into category ( type, url, name, description, parentcategory)
values ('ACTIVE',
        'prohormones',
        'ProHormones',
        'Hard To Find Hardcore Prohomones',
        1);
insert into category ( type, url, name, description, parentcategory)
values ('ACTIVE',
        'cycle-support',
        'Cycle Support',
        'Pre-On-Post Cycle Support Products',
        1);
insert into category ( type, url, name, description, parentcategory)
values ('ACTIVE',
        'preworkout',
        'Pre Workout',
        'Get Amped For Your Workout',
        1);
insert into category ( type, url, name, description, parentcategory)
values ('ACTIVE',
        'fat-burners',
        'Fat Burning',
        'Industry Leading Thermogenics Will Get You Cut',
        1);
insert into category ( type, url, name, description, parentcategory)
values ('ACTIVE',
        'male-enhancement',
        'Male Enhancement',
        'Get Your Swag On In The Bedroom',
        1);
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


insert into brand ( type, name, url )
values ('ACTIVE', 'Competitive Edge Labs (CEL)','competitive-edge-labs');
insert into brand ( type, name, url )
values ('ACTIVE', 'Recomp Performance Nutrition (RPN)','recomp-performance-nutrition');
insert into brand ( type, name, url )
values ('ACTIVE', 'Cellucor','cellucor');
insert into brand ( type, name, url )
values ('ACTIVE', 'BPI Sports','bpi-sports');
insert into brand ( type, name, url )
values ('ACTIVE', 'Elite Formulations','elite-formulations');
insert into brand ( type, name, url )
values ('ACTIVE', 'Serious Nutrition Solutions (SNS)','serious-nutrition-solutions');
insert into brand ( type, name, url )
values ('ACTIVE', 'Blackstone Labs','blackstone-labs');
insert into brand ( type, name, url )
values ('ACTIVE', 'Platinum Labs','platinum-labs');

insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','competitive-edge-labs-cycle-assist',1,'Cycle Assist','Cycle Assist is designed to be an all-in-one support solution for basic on cycle and post cycle therapy needs. Cycle Assist contains a combination of specifically dosed ingredients designed to help provide liver, blood pressure, cholesterol, prostate, and acne support.');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','competitive-edge-labs-pct-assist',1,'PCT Assist','PCT Assist is designed to help increase natural testosterone levels during the period of Post Cycle Therapy (PCT) or as part of a natural testosterone enhancement regimen.');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','recomp-performance-nutrition-havoc',2,'Havoc','Being completely non-estrogenic, Havoc offers an ideal composition to maximize strength and lean mass gains, with minimal side effects such as lethargy or gyno. RPN Havoc supplement embodies the most recent in a long, distinguished line of hormonal products designed to optimize the bodys ability to maximize muscular hypertrophy.');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','cellucor-p6-180',3,'P6 180',
        'THE DAYS OF BUYING 3+ PRODUCTS THAT CONTAIN ALL THE INGREDIENTS YOU NEED TO SUPPORT YOUR NATURAL TESTOSTERONE PRODUCTION ARE OVER. <br />Cellucor’s P6 Extreme is a revolutionary "test booster" that harnesses an advanced 3-in-1 formula, combining ingredients that support natural testosterone production, inhibit the formation of estrogen reducing the likelihood of negative feedback on the HPTA, and minimize DHT conversion, all in a single product. P6 Extreme is formulated with a goal of optimizing the conditions for natural testosterone production. As we know, high Testosterone levels are correlated with strength, lean muscle mass, libido, and energy levels.*<br />P6 Extreme’s exclusive, comprehensive formula eliminates complicated dosing schedules and the need to ‘cycle’ on/off. In fact, because of the 3:1 exclusive formula, P6 Extreme is the ultimate, legal route to supporting natural testosterone production.');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','elite-formulations-ultradrol',5,'Ultradrol',
        'Ultradrol is Discontinued and sold out. There are no more Authentic Ultradrol Bottles! Antaeus Labs will not make more! Check out Msten Extreme Assault Labs. Same Ingredient/Compound & Same Mgs, however with Msten Extreme, you get 120 CAPSULES vs. Ultradrol''s 90 caps. Ultradrol by Antaeus Labs. 90 Capsules Now that Superdrol is banned, everyone is turning to Methylstenbolone as a replacement, specifcally Ultradrol by Antaeus Labs. Methylstenbolone as a compound is very similar to SD and when dosed correctly you can achieve the same results as taking suprdrol. We recommend dosing 3 CAPSULES a day for 30 days. Add On Cycle Support and following your 30 day cycle make sure to use proper Post Cycle Therapy. Ultradrol provides: Bulking Muscle Mass Gains Size Gains Strength Gains No conversion to Estrogen Ultradrol is the world''s best legal bulking and repartitioning agent. .');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','competitive-edge-labs-hdrol',1,'H-Drol',
        'H-Drol is one of the most popular & proven compounds on the market and is considered a good beginners cycle due to it’s reputation for minimal side effects and dry gains that are relatively easy to maintain after the cycle is completed.  H-Drol is known for having a very long half life which makes the dosing protocol simple for those on a busy schedule, the half life of H-Drol can vary based on the user however it’s typically reported of having a half life in the realm of 12 hours.');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','competitive-edge-labs-mdrol',1,'M-Drol','IN STOCK, and ready to ship!<br /><br />Product has been discontinued, low stock.<br /><br />Buy C.E.L M-Drol today, while you still can!<br /><br />What to expect:<br />M-Drol is diverse in its uses. It can be used when bulking or when wanting to gain lean muscle tissue and hold on to strength while trying to get leaner. Muscle gains from M-Drol are very dry and lean, so there is little to no water retention with this item. Users typically notice rapid gains in strength, muscle fullness, and size from M-Drol.<br /><br />Common dosage protocol:<br />M-Drol is usually used for periods of 3 to 4 weeks. Average dosing is starting off at one capsule per day for the first one to two weeks, then possibly going up to 2 capsules per day for the remaining one to 2 weeks. Others stay at one capsule per day throughout.<br /><br /><br /><br />Supplement Facts:<br />Serving Size: 1 capsule<br />Servings per Container: 90<br /><br />Amount Per Serving:<br />2a,17a di methyl etiocholan 3-one, 17b-ol – 10 mg<br /><br />');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','serious-nutrition-solutions-piracetam',6,'Piracetam',
        'Memory & Concentration* Stress & Fatigue Reduction* Mental Alertness<br /><br />Piracetam powder contains 1000 mg (1 gram) per scoop.<br />Piracetam is one of the best known nootropic supplements available. It is a natural derivative of GABA (Gama Amino Butyric Acid), and is chemically related to Pyroglutamic Acid, which plays an important role in cognitive function. Piracetam is commonly used to help support mental alertness, creative thinking, memory and concentration, cardiovascular health, overall sense of well-being, and to help reduce stress and fatigue.<br />Piracetam is Commonly Used for:<br />Memory & Concentration<br />Mental Alertness<br />Improved Sense of Well-Being<br />Stress & Fatigue Reduction<br />Creative Thought Enhancement<br />Cardiovascular Support<br />');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','cellucor-m5',3,'M5 Extreme 2-in-1',
        'Ignite + Build<br />2 Products in 1<br />2 in 1 Custom Pre-Workout<br /><br />THE MASS MACHINE<br /><br />Explosive Energy Ignited by C4<br />Contains Creatine Magnapower<br />Promotes Intensity<br />');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','blackstone-labs-super-dmz-2',7,'Super DMZ 2.0',
        'Super-DMZ Rx 2.0™ is a newly formulated anabolic "Hardening Stack" engineered and designed to increase, sustain, and strengthen muscularity via multiple pathways. Super-DMZ Rx™ incorporates a combination of two synergistic compounds (Dymethazine & Methylsten) that target multiple receptor sites resulting in dry gains, harder/leaner muscle, and increased vascularity from one workout to the next. Super-DMZ Rx™ will increase lean muscle mass and strength at a level that is comparable to popular anabolic steroids such as Dianabol and Anadrol, the only difference is it''s 100% legal!.');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','blackstone-labs-alpha-1-max',7,'Alpha-1 Max',
        'ALPHA-1 MAX™ by BLACKSTONE LABS is a very powerful designer steroid that will illicit significant strength and lean body mass gains in just four short weeks.<br /><br />This methylated version of 1-AD also has a significant conversion to the exceedingly strong but banned Methyl 1-Testosterone (M1T). M1T was arguably one of the most powerful designer steroids to ever hit the OTC market. Therefore, ALPHA-1 MAX possesses two distinct and powerful anabolic pathways that will produce rapid and profound gains in muscle mass and power if proper weight training and nutrition are in place. Users of ALPHA-1 MAX routinely have reported gains of 12-15 lbs. in just one cycle.<br /><br />ALPHA-1 MAX™ by BLACKSTONE LABS has been designed for experienced users of anabolic steroids and cycle duration should NOT exceed four weeks. ALPHA-1 MAX does not aromatize which means conversion to estrogen is not a concern. Proper hydration and cycle support is recommended. ALPHA-1 MAX has been purity tested and is the gold standard in Alpha-1 products.<br /><br />Nomenclature: Methyl-1-Etiocholenolol-Epietiocholanolone (20 mg per capsule) Consume 1 capsule twice daily in divided doses.');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','blackstone-labs-growth',7,'Growth',
        'Old School...Blue Tops, Red Tops, and Riptropins<br /><br />New School...Time after time Blackstone Labs has released products that make an impact on bodybuilders from across the globe. If you thought our pro-hormones and pre-workout products were intense we have outdone ourselves with our latest creation. Introducing GROWTH – the first clinically proven formula to naturally increase growth hormone production within minutes after swallowing your first pill.<br /><br />Normally we would tell you to run and hide from OTC products claiming to increase natural GH production. That’s because the industry has never produced one that actually works. That was until now. At Blackstone Labs we deliver products that back up our claims and this one is no different. You want to stop calling or emailing “your guy” to get a few kits of underground HGH? Now is your chance to get the same great product you had to be sneaky to acquire, but with the safety and guarantee that nothing is under dosed or requires a safe email to stay under the radar.<br /><br />');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','blackstone-labs-gear-support',7,'Gear Support',
        'Complete ‘On Cycle and Post Cycle’ Pro Hormone and Designer Steroid Support<br /><br />Protects the Liver & Major Organs<br /><br />Improves Cholesterol and Lipid Profiles<br />Decreases Blood Pressure & Increases Blood Circulation<br />Prostate Support<br /><br />Introducing Red Clover Extract, this highly potent plant extract will not only help improve liver health, but has an array of other clinically proven health benefits. Everyone: bodybuilders, athletes, and even your average Joe’s need to be taking Red Clover Extract. It obviously helps bodybuilder’s and guys who train hard, but who wouldn’t want to have an extra insurance policy on your health? Find this key ingredient and several others in our new product, Gear Support.<br />Pick up a bottle of Gear Support and like every other Blackstone Labs product, try and find something you don’t love about it.');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','platinum-labs-defcon-1',8,'Defcon-1',
        'TACTICAL FOCUS<br />DEFCON1 is the highest state of Alert and that is exactly where you will be when training after a dose of DEFCON1. While other preworkouts just seem to load more and more stimulants into their products and promise focus, while instead delivering a jittery workout and horrible crash afterwards. DEFCON1 uses brain boosting nootropics to dramatically increase cognitive ability and mind to muscle connection. Nootropics have been proven in numerous human studies to increase brain function, communication between left and right hemispheres of the brain, help with study and concentration and even increase IQ scores. Platinum Labs is the first company to ever combine these amazing substances into a pre-workout to get you focused and driven like never before! We weren’t done there though as not only did we want to give laser like focus but also people to be loving every single extra rep! So we also included mood enhancing compounds to put you in a positive and focused state of mind!<br /><br />NUCLEAR PUMPS<br />As all the Pro’s say “chase the pump!” the reason the muscle “pump” is so sought after is because it means the blood is rushing into the muscles you are training and carrying with them all the nutrients required for them to grow! When we formulated DEFCON1 it was priority number 1 to provide massive muscle pumps and vasodilation to ensure our customers got the most insane, shirt splitting pumps of their life! With a combination of multiple nitrates and vasodilators we promise you will never feel this pumped on any other product.<br /><br />ARTILLERY STRENGTH<br />Probably the one thing that most pre-workouts these days lack is that extra surge of strength required to give a truly supreme workout, DEFCON1 is combining creatine hcl (rather than the standard and cheaper creatine monohydrate) with other muscle boosting and strength increasing compounds to ensure your pushing your muscles to the absolute limit and maximising your growth! We have also included anti-catabolic compounds to ensure no muscle is lost during your heavy workout session!');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','platinum-labs-optiburn',8,'Optiburn',
        'Thermogenesis<br />Thermogenesis is the process of boosting the body’s MR (Metabolic Rate) and proof that a thermogenic fat burner is working is because you begin to feel warmer than usual as your body literally begins to burns fat! The complete list of thermogenic ingredients in OptiBurn are second to none and you will feel their effects within minutes of taking it.<br /><br />Appetite Suppressant<br />What are considered the most dreaded aspect of dieting? Food cravings! OptiBurn has advanced appetite suppressants that control hunger cravings throughout the day, making sure you’re only eating the food you want without craving all the naughty snacks between meals!<br /><br />Advanced Energy<br />At Platinum Labs we know you need to power through your day and also your workout, which is often particularly challenging when dieting. The energy that OptiBurn provides is a strong, sustained energy that will last 6-8 hours without jitters or crash like other stimulant fat burners.<br /><br />Shed stubborn water<br />There is nothing worse than water bloating that may come about through diet, stress, medications or the hormonal cycle. OptiBurn contains natural diuretics to emphasize how lean you are without being cheated by the bloat!<br /><br />Mood Enhancer<br />OptiBurn is the first ever fat burner to contain Nelumba Nucifera or “Indian Lotus” concentrated extract. This herb has been used for thousands of years to treat many ailments throughout the East, and brewed in a tea promote general well-being and euphoria. This is the secret to the unmistakable “OptiBurn feel” that all our customers have been raving about!');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','blackstone-labs-angel-dust-watermelon',7,'Angel Dust (Watermelon)',
        'THE strongest pre-workout on the market, period.<br />.<br />Shredded Muscle Pumps.<br />Explosive Strength & Power.<br />Extreme Energy Release.<br />Enhance Athletic Performance.<br />Rapid Nutrient Absorption.<br />');
insert into sku ( type, url, brandid, name, description )
values ('ACTIVE','blackstone-labs-angel-dust-lemonade',7,'Angel Dust (Lemonade)',
        'THE strongest pre-workout on the market, period.<br />.<br />Shredded Muscle Pumps.<br />Explosive Strength & Power.<br />Extreme Energy Release.<br />Enhance Athletic Performance.<br />Rapid Nutrient Absorption.<br />');

insert into skuprice ( type, skuid, price )
values ('ACTIVE',1,24.95);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',2,34.95);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',3,27.45);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',4,104.98);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',5,33.29);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',6,33.79);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',7,59.49);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',8,93.49);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',9,59.98);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',10,52.20);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',11,42.99);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',12,39.98);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',13,33.99);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',14,38.98);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',15,38.98);
values ('ACTIVE',16,36.79);
insert into skuprice ( type, skuid, price )
values ('ACTIVE',17,36.79);

insert into skuprice ( type, skuid, price )
values ('MSRP',1,41.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',2,49.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',3,69.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',4,119.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',5,59.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',6,49.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',7,79.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',8,99.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',9,89.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',10,59.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',11,64.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',12,44.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',13,39.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',14,39.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',15,39.99);
insert into skuprice ( type, skuid, price )
insert into skuprice ( type, skuid, price )
values ('MSRP',16,54.99);
insert into skuprice ( type, skuid, price )
values ('MSRP',17,54.99);

insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',1,8);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',2,8);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',3,6);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',1,4);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',2,4);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',3,4);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',1,6);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',2,6);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',4,7);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',5,7);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',6,7);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',7,7);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',8,4);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',9,4);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',9,9);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',10,4);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',10,7);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',11,7);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',12,7);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',13,8);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',13,4);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',14,9);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',15,10);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',16,4);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',16,9);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',17,4);
insert into skucategory (type, skuid, categoryid)
values ('ACTIVE',17,9);


commit;

select * from sku;
select * from brand;
select * from category;
select * from SkuPrice;
select * from skucategory;

/*
select * from ProductCategory;
select * from ProductSku;
select * from SkuAttribute;
select * from SkuCost;
select * from SkuImage;

8/
