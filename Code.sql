/* Drop the tables if they already exist. */

DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE category CASCADE CONSTRAINTS;
DROP TABLE review CASCADE CONSTRAINTS;
DROP TABLE account CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE shipment CASCADE CONSTRAINTS;
DROP TABLE credit_card CASCADE CONSTRAINTS;
DROP TABLE product_categorized_as CASCADE CONSTRAINTS;
DROP TABLE order_includes CASCADE CONSTRAINTS;
DROP TABLE shipment_contains CASCADE CONSTRAINTS;
DROP TABLE account_credit_cards CASCADE CONSTRAINTS;
DROP TABLE order_paid_with CASCADE CONSTRAINTS;
DROP TABLE order_gift_cards CASCADE CONSTRAINTS;
DROP TABLE account_gift_cards CASCADE CONSTRAINTS;
DROP TABLE account_addresses CASCADE CONSTRAINTS;

/* Create the tables. */

CREATE TABLE product
(
	ASIN CHAR (10) CONSTRAINT product_asin_pk PRIMARY KEY,
	Name VARCHAR2 (128) CONSTRAINT product_name_nn NOT NULL,
	Description VARCHAR2 (2048),
	Price NUMBER (9, 2) CONSTRAINT product_price_nn NOT NULL
);

CREATE TABLE category
(
	Category_ID NUMBER (10) CONSTRAINT category_category_id_pk PRIMARY KEY,
	Name VARCHAR2 (128) CONSTRAINT category_name_nn NOT NULL,
	Subcategory_Of NUMBER (10)
);

CREATE TABLE review
(
	Review_ID CHAR (14) CONSTRAINT review_review_id_pk PRIMARY KEY,
	Title VARCHAR2 (128),
	Text VARCHAR2 (2048),
	Star_Rating NUMBER (1) CONSTRAINT review_star_rating_nn NOT NULL,
	Written_By VARCHAR2 (64) CONSTRAINT review_written_by_nn NOT NULL,
	Written_About CHAR (10) CONSTRAINT review_written_about_nn NOT NULL
);

CREATE TABLE account
(
	Email VARCHAR2 (64) CONSTRAINT account_email_pk PRIMARY KEY,
	Name VARCHAR2 (128) CONSTRAINT account_name_nn NOT NULL,
	Password_Hash CHAR (40) CONSTRAINT account_password_hash_nn NOT NULL
);

CREATE TABLE orders
(
	Order_Number NUMBER (17) CONSTRAINT orders_order_number_pk PRIMARY KEY,
	Date_Placed DATE CONSTRAINT orders_date_placed_nn NOT NULL,
	Status VARCHAR2 (64) CONSTRAINT orders_status_nn NOT NULL,
	Placed_By VARCHAR2 (64) CONSTRAINT orders_placed_by_nn NOT NULL
);

CREATE TABLE shipment
(
	Order_Number NUMBER (17),
	Tracking_Number VARCHAR2 (32),
	Company VARCHAR2 (32) CONSTRAINT shipment_company_nn NOT NULL,
	Date_Shipped DATE,
	Street VARCHAR2 (32) CONSTRAINT shipment_street_nn NOT NULL,
	City VARCHAR2 (32) CONSTRAINT shipment_city_nn NOT NULL,
	State CHAR (2) CONSTRAINT shipment_state_nn NOT NULL,
	Zip NUMBER (5) CONSTRAINT shipment_zip_nn NOT NULL,
	CONSTRAINT shipment_ordno_trackno_pk PRIMARY KEY (Order_Number, Tracking_Number)
);

CREATE TABLE credit_card
(
	Card_Number NUMBER (16) CONSTRAINT credit_card_card_number_pk PRIMARY KEY,
	Type VARCHAR2 (16) CONSTRAINT credit_card_type_nn NOT NULL,
	Security_Code NUMBER (4) CONSTRAINT credit_card_security_code_nn NOT NULL,
	Exp_Month NUMBER (2) CONSTRAINT credit_card_exp_month_nn NOT NULL,
	Exp_Year NUMBER (2) CONSTRAINT credit_card_exp_year_nn NOT NULL
);

CREATE TABLE product_categorized_as
(
	Product_ASIN CHAR (10),
	Category_ID NUMBER (10),
	CONSTRAINT product_cat_as_asin_catid_pk PRIMARY KEY (Product_ASIN, Category_ID)
);

CREATE TABLE order_includes
(
	Order_Number NUMBER (17),
	Product_ASIN CHAR (10),
	CONSTRAINT order_includes_ordno_asin_pk PRIMARY KEY (Order_Number, Product_ASIN)
);

CREATE TABLE shipment_contains
(
	Order_Number NUMBER (17),
	Tracking_Number VARCHAR2 (32),
	Product_ASIN CHAR (10),
	CONSTRAINT shipment_cont_ono_tno_asin_pk PRIMARY KEY (Order_Number, Tracking_Number, Product_ASIN)
);

CREATE TABLE account_credit_cards
(
	Account_Email VARCHAR2 (64),
	Credit_Card_Number NUMBER (16),
	CONSTRAINT account_ccs_email_cardno_pk PRIMARY KEY (Account_Email, Credit_Card_Number)
);

CREATE TABLE order_paid_with
(
	Order_Number NUMBER (17),
	Credit_Card_Number NUMBER (16),
	CONSTRAINT order_paid_w_ordno_cardno_pk PRIMARY KEY (Order_Number, Credit_Card_Number)
);

CREATE TABLE order_gift_cards
(
	Order_Number NUMBER (17),
	Gift_Card_Number CHAR (15),
	CONSTRAINT order_gcs_ordno_gcno_pk PRIMARY KEY (Order_Number, Gift_Card_Number)
);

CREATE TABLE account_gift_cards
(
	Account_Email VARCHAR2 (64),
	Gift_Card_Number CHAR (15),
	CONSTRAINT account_gcs_email_gcno_pk PRIMARY KEY (Account_Email, Gift_Card_Number)
);

CREATE TABLE account_addresses
(
	Account_Email VARCHAR2 (64),
	Street VARCHAR2 (32),
	City VARCHAR2 (32),
	State CHAR (2),
	Zip NUMBER (5),
	CONSTRAINT account_addrs_em_s_c_s_z_pk PRIMARY KEY (Account_Email, Street, City, State, Zip)
);

/* Insert the tuples. */

INSERT INTO product VALUES ('0133970779', 'Fundamentals of Database Systems (7th Edition)', 'This book introduces the fundamental concepts necessary for designing, using, and implementing database systems and database applications. Our presentation stresses the fundamentals of database modeling and design, the languages and models provided by the database management systems, and database system implementation', 162.47);
INSERT INTO product VALUES ('B00TSUGXKE', 'Fire Tablet, 7" Display, Wi-Fi, 8 GB - Includes Special Offers, Black', 'Beautiful 7" IPS display and 1.3 GHz quad-core processor. Available in four colors. Coming soon: the Alexa cloud-based voice service – just press and ask. Amazon Underground, where thousands of apps, games and even in-app items are 100% free. Enjoy millions of movies, TV shows, songs, Kindle e-books, apps and games. 8 or 16 GB of internal storage and a microSD slot for up to 200 GB of expandable storage. Prime members get unlimited access to a huge selection of songs, books, videos and more. Up to 7 hours of battery life', 49.99);
INSERT INTO product VALUES ('B014KP70F8', 'MoKo Case for Fire 7 2015 - Slim Folding Cover for Amazon Fire Tablet (7 inch Display - 5th Generation, 2015 Release Onl', 'Notes: 1. Fits Amazon Fire (7" 5th Gen-2015 release) ONLY. Will NOT fit 2014( 4th Gen) or Previous Fire HD/HDX 7 inch or 1st Gen Fire 7 (2011 release) or Fire HD 6/ HD 8 /HD 10 Tablets. 2. Unlike other Fire Tablets, Fire Tablet (7" display 5th Gen-2015 release) does NOT support auto wake/sleep feature.', 10.99);
INSERT INTO product VALUES ('B00IEYHMIM', 'Sony ICFC1 Alarm Clock Radio, Black', 'Rise and shine with a Sony alarm clock radio. While a large, easy-to-read, backlit LCD display with jumbo LEDs make reading the time from across the room a snap, a battery back-up is also there to ensure that you never miss an important appointment or meeting again!', 6.35);
INSERT INTO product VALUES ('B00KWFCSB2', 'Super Mario Maker - Nintendo Wii U', 'The ultimate evolution of Super Mario Bros. is here!Mario experience of your dreams has arrived and is bursting with creativity…including yours! Play a near-limitless number of intensely creative Super Mario levels from players around the world. It’s easy enough to create your own levels with the Wii U GamePad controller that it may feel like you’re simply sketching out your ideas on paper, but you can now bring enemies and objects into a playable course in ways you could only dream of before. What was impossible in  traditional Mario games is now impossibly fun, so let your imagination run wild!FEATURES:    Play a near-limitless number of Mario levels created by Nintendo and players around the world. Create your own Mario levels by using the Wii U GamePad controller touch screen to add enemies, blocks, pipes and more. Break the conventions of traditional Super Mario gameplay by blending enemies, traps and items into unexpected twists, like Piranha Plant-shooting cannons, power-up-tossing Lakitus, or even Hammer Bros. riding on Bowser while bouncing on trampolines.. Touch control, instant editing and a robust online ranking and search system makes creating, playing and sharing a seamless process. Switch between four distinct themes, each with different art styles and features: Super Mario Bros., Super Mario Bros. 3, Super Mario World, and New Super Mario Bros. U. Transform into different characters at random with the new Mystery Mushroom item. Expand the roster of possible characters by completing 100 Mario Challenge mode or tapping compatible amiibo. Tap a 30th Anniversary Mario amiibo figure to the Wii U GamePad controller to add a Big Mushroom power-up to your course! Each retail copy of the game will come with a special booklet that offers fun ideas for designing co', 297.99);
INSERT INTO product VALUES ('B00IRVQ0F8', 'Sabrent USB External Stereo Sound Adapter for Windows and Mac. Plug and play No drivers Needed. (AU-MMSA)', 'Description: This Sabrent AU-MMSA 2.1 Audio Sound Card Adapter is a highly flexible audio interface, which can be used with either laptop or desktop system. No driver required, plug-and-play for instant audio playing and compliant with all mainstream operation systems. Simply Plug the Sound Adapter into your USB port, and then plug your headphones into the Adapter.   Features 3D stereo USB audio adapter. USB 2.0 Hi-Speed specification. Backward compatible with USB 1.1 Connectors: USB type A, stereo output jack, microphone input jack. No external power required. Plug &' || ' Play, no drivers needed.   System requirements Windows XP/Vista/7/8/8.1/10 Mac OS 8.6 or above   What''s in the box? USB audio sound adapter   Warranty information: 1 year limited warranty. When you register your new Sabrent product online within 90 days of purchase, your standard 1-year warranty coverage is extended to 2-years.', 6.99);
INSERT INTO product VALUES ('B004RMK57U', '3-Month Playstation Plus Membership  - PS3/ PS4/ PS Vita [Digital Code]', 'Enables access to Online Multiplayer on PS4. Get Free PS4 Games to Play. Exclusive PlayStation Store Sales and Discounts. Store Game Saves Online: Now PS Plus Members Get 10x the Online Game Save Storage for PS4. Enables Shareplay Feature: Invite Friends to Join You in Your Favorite PS4 Games – Even If They Don’t Own the Game. New Games every month with Instant Game Collection. Next-generation online multiplayer on the PS4 system. One membership will extend to your PS4, PS3, and PS Vita systems.', 19.99);
INSERT INTO product VALUES ('B00ZB7QB1O', 'Meliora', 'Sweden''s Ghost is back with their highly anticipated 3rd album, Meliora. Steeped in subversive themes of humanism, counterculture and anti-establishmentarianism, the album was produced by Klas Ahlund, mixed by Andy Wallace, and is their heaviest and most melodic project to date. Lead singer Papa Emeritus II has been ''let go'' and will be replaced by the younger, more powerful Papa Emeritus III, who expertly leads his Ghouls through 10 scorching tracks, including ''Cirice'', which means church in Old English and is an ode to institutions inventing the problem so that they can offer the solution.', 9.49);
INSERT INTO product VALUES ('B01GUVOXIW', 'Warcraft (Blu-ray + DVD + Digital HD)', 'The peaceful realm of Azeroth stands on the brink of war as its civilization faces a fearsome race of invaders: orc warriors fleeing their dying home to colonize another. As a portal opens to connect the two worlds, one army faces destruction and the other faces extinction. From opposing sides, an unlikely set of heroes are set on a collision course that will decide the fate of their families, their people and their home. So begins a spectacular saga of power and sacrifice in which war has many faces, and everyone fights for something.', 19.96);
INSERT INTO product VALUES ('B00BKBCF38', 'Infestissumam [Explicit]', '4-Panel 1 Pocket Softpak', 9.49);
INSERT INTO product VALUES ('B00XUZBCVI', 'NHL 16 - PlayStation 4', 'Built with more input from our fans than ever before, NHL 16 steps onto the ice to deliver ways to compete as a team, new features across the most played single-player modes, gameplay innovation at every position and an unrivalled game day atmosphere.', 23.97);
INSERT INTO product VALUES ('B01I5AI96S', 'Dig Your Roots', 'Known for their record-breaking tracks, undeniable energy and all around good vibes, FLORIDA GEORGIA LINE will release DIG YOUR ROOTS August 26 on Big Machine Label Group. The award-winning duo s highly anticipated third studio album uncovers pieces of their lineage along with an evolved creativity. Our album cover says it all, shares Brian Kelley. "Tyler and I are continuing to grow musically and personally. We really wanted this album to reflect who we are and our lives in this moment, but also where we came from. Tyler Hubbard adds, we both started out playing guitar, singing in church and writing songs so we wanted to let fans see our foundation a deeper side to us. We couldn t have picked a more fitting title or image for DIG YOUR ROOTS. Award-winning producer Joey Moi, who has been at the helm for FGL s entire discography to date, once again joined the pair for DIG YOUR ROOTS. The duo penned over half of the new music, further depicting an evolution in both of their life journeys. FGL''s soaring single H.O.L.Y. sets the tone for the new project and is the right balance of change and continuity, and the mix of love and spirituality (Billboard). Written by hit makers busbee, Nate Cyphert and William Larsen, the song has commanded the #1 spot on the Billboard Hot Country Songs Chart for the last six weeks and marks their 11th consecutive Top 10 hit as artists at Country radio.Selling an impressive 1.5 million tickets and landing in the upper reaches of Billboard s Hot Tours ranking (all genre) in 2015 alone, FGL are taking it to the next level with their headline DIG YOUR ROOTS Tour through the end of 2016.With each of their BMLG releases 2X PLATINUM debut HERE S TO THE GOOD TIMES and PLATINUM ANYTHING GOES, the proven superstar duo has celebrated numerous bucket-list', 12.49);
INSERT INTO product VALUES ('B00N1G35MU', 'S4 case, JETech® Super Protective Samsung Galaxy S4 Case Slim Ultra Fit for Galaxy S IV Galaxy SIV i9500 (Silver)', 'S4 case, JETech Super Protective Samsung Galaxy S4 Case Slim Ultra Fit for Galaxy S IV Galaxy SIV i9500 (Silver)', 9.99);
INSERT INTO product VALUES ('B00N0YYGIU', 'Galaxy S4 Screen Protector, JETech Premium Tempered Glass Screen Protector for Samsung Galaxy S4 - 0820', 'Made with high quality 0.33mm thick premium tempered glass with rounded edges exclusively for Samsung Galaxy S4. Extremely high hardness: resists scratches up to 9H (harder than a knife). High-response, high-transparency, and high transparency. Dust-free, fingerprint-free, one-push super easiy installation, bubble free. Retail package includes: 1-Pack tempered glass screen protector, cleaning cloth, instruction, 6-month replacement warranty', 5.99);
INSERT INTO product VALUES ('B01837LGGI', 'Top Plaza Jewelry - Mens Womens Cool Black Matte Agate Gems 8MM Beads Stretch Bracelet with Dragon Vein Agate Tiger Eye ', 'Orders (without battery) below $100: USPS (7-14 working days,mostly); Over $100: DHL/EMS (3-5 working days.)', 8.48);
INSERT INTO product VALUES ('B018231PW8', 'Top Plaza Healing Power Lava Rock Bead Elastic Beaded Bracelet, Unisex, 8MM', 'Orders (without battery) below $100: USPS (7-14 working days,mostly); Over $100: DHL/EMS (3-5 working days.)', 7.89);
INSERT INTO product VALUES ('B01BFJ8JNO', 'Kenneth Cole Reaction Women''s Saffiano Tri Me A River Wallet', 'Carry the necessities around in style with this Saffiano Tri Me A River Wallet by Kenneth Cole Reaction. The interior features 2 large slip pockets, a divided bill compartment, 8 credit card slots, 2 ID windows and a small kiss-lock coin purse within a slip pocket, while the exterior features a spacious zip pocket. The wallet is fully lined and designed with a hidden magnetic closure. Great as a everyday wallet or as a clutch when you hit the town, get the most out of your wallet! Measures 8.75" x 4.15" x 1"', 19.92);
INSERT INTO product VALUES ('B016E448AS', 'Kenneth Cole Reaction Women''s Saffiano Tri Me A River Wallet', 'Carry the necessities around in style with this Saffiano Tri Me A River Wallet by Kenneth Cole Reaction. The interior features 2 large slip pockets, a divided bill compartment, 8 credit card slots, 2 ID windows and a small kiss-lock coin purse within a slip pocket, while the exterior features a spacious zip pocket. The wallet is fully lined and designed with a hidden magnetic closure. Great as a everyday wallet or as a clutch when you hit the town, get the most out of your wallet! Measures 8.75" x 4.15" x 1"', 19.92);
INSERT INTO product VALUES ('B00WL40SZ0', 'Kenneth Cole Reaction Women''s Saffiano Tri Me A River Wallet', 'Carry the necessities around in style with this Saffiano Tri Me A River Wallet by Kenneth Cole Reaction. The interior features 2 large slip pockets, a divided bill compartment, 8 credit card slots, 2 ID windows and a small kiss-lock coin purse within a slip pocket, while the exterior features a spacious zip pocket. The wallet is fully lined and designed with a hidden magnetic closure. Great as a everyday wallet or as a clutch when you hit the town, get the most out of your wallet! Measures 8.75" x 4.15" x 1"', 19.92);
INSERT INTO product VALUES ('B00B6T0EBY', 'Mesoestetic Cosmelan 2 Maintenance Depigmentation Cream 1.06 fl oz.', 'Cosmelan 2 is an extremely effective lightening cream designed to reduce hyperpigmentation. Cosmelan 2 helps to restore radiance and clarity by softly removing uneven pigmentation. It is created to be used as a maintenance cream following the professional application of Cosmelan 1. Its smooth texture melts comfortably into the skin, providing moisture as it renews the skin, leaving it brighter and evenly toned.', 159.88);
INSERT INTO product VALUES ('B002RLW5VW', 'Mesoestetic Hydra-Vital Factor K facial 1.69 fl oz.', 'This comforting cream uses hidroviton, bio mineral salts and vitamin E to protect against water loss, thereby boosting the skin''s moisture levels. Vitamin E also conditions the skin''s texture and supplies exceptional antioxidant protection, helping to prevent free radical damage and premature skin aging. Hydra-Vital Factor K promotes a soft, creamy skin texture while plumping dehydration lines, resulting in a more youthful complexion. Due to a manufacturer packaging change, item received may vary from photograph.', 59.97);
INSERT INTO product VALUES ('B00GP21EOS', 'Jjf Compose-01 Bootie Boots, Camel Suede, 5.5', 'Work Hiking Desert Stiletto High Heel Platform Ankle Boots', 39.95);

INSERT INTO category VALUES (283155, 'Books', NULL);
INSERT INTO category VALUES (5, 'Computers &' || ' Technology', 283155);
INSERT INTO category VALUES (3652, 'Networking &' || ' Cloud Computing', 5);
INSERT INTO category VALUES (172282, 'Electronics', NULL);
INSERT INTO category VALUES (541966, 'Computers &' || ' Accessories', 172282);
INSERT INTO category VALUES (2348628011, 'Tablet Accessories', 541966);
INSERT INTO category VALUES (2348629011, 'Bags, Cases &' || ' Sleeves', 2348628011);
INSERT INTO category VALUES (3012929011, 'Cases', 2348629011);
INSERT INTO category VALUES (1055398, 'Home &' || ' Kitchen', NULL);
INSERT INTO category VALUES (1063278, 'Home Décor', 1055398);
INSERT INTO category VALUES (542938, 'Clocks', 1063278);
INSERT INTO category VALUES (3734911, 'Alarm Clocks', 542938);
INSERT INTO category VALUES (509324, 'Electronic Alarm Clocks', 3734911);
INSERT INTO category VALUES (468642, 'Video Games', NULL);
INSERT INTO category VALUES (8400376011, 'Kids &' || ' Family', 468642);
INSERT INTO category VALUES (8400382011, 'Wii U', 8400376011);
INSERT INTO category VALUES (8400392011, 'Games', 8400382011);
INSERT INTO category VALUES (3012292011, 'External Components', 541966);
INSERT INTO category VALUES (3015427011, 'External Sound Cards', 3012292011);
INSERT INTO category VALUES (14210751, 'PlayStation 3', 468642);
INSERT INTO category VALUES (7326756011, 'Subscription Cards', 14210751);
INSERT INTO category VALUES (5174, 'CDs &' || ' Vinyl', NULL);
INSERT INTO category VALUES (37, 'Pop', 5174);
INSERT INTO category VALUES (2625373011, 'Movies &' || ' TV', NULL);
INSERT INTO category VALUES (468374, 'Studio Specials', 2625373011);
INSERT INTO category VALUES (14279371, 'Universal Studios Home Entertainment', 468374);
INSERT INTO category VALUES (14279381, 'All Universal Studios Titles', 14279371);
INSERT INTO category VALUES (67207, 'Metal', 5174);
INSERT INTO category VALUES (67215, 'Pop Metal', 67207);
INSERT INTO category VALUES (8400377011, 'PlayStation 4', 8400376011);
INSERT INTO category VALUES (8400387011, 'Games', 8400377011);
INSERT INTO category VALUES (16, 'Country', 5174);
INSERT INTO category VALUES (2335752011, 'Cell Phones &' || ' Accessories', NULL);
INSERT INTO category VALUES (2407760011, 'Cases, Holsters &' || ' Clips', 2335752011);
INSERT INTO category VALUES (3081461011, 'Cases', 2407760011);
INSERT INTO category VALUES (2407755011, 'Accessories', 2335752011);
INSERT INTO category VALUES (2407781011, 'Screen Protectors', 2407755011);
INSERT INTO category VALUES (7141123011, 'Clothing, Shoes &' || ' Jewelry', NULL);
INSERT INTO category VALUES (7147445011, 'Novelty &' || ' More', 7141123011);
INSERT INTO category VALUES (2516784011, 'Jewelry', 7147445011);
INSERT INTO category VALUES (2516513011, 'Bracelets', 2516784011);
INSERT INTO category VALUES (7147441011, 'Men', 7141123011);
INSERT INTO category VALUES (3887881, 'Jewelry', 7147441011);
INSERT INTO category VALUES (3888081, 'Bracelets', 3887881);
INSERT INTO category VALUES (7147440011, 'Women', 7141123011);
INSERT INTO category VALUES (2474936011, 'Accessories', 7147440011);
INSERT INTO category VALUES (7072327011, 'Handbag Accessories', 2474936011);
INSERT INTO category VALUES (3420366011, 'Handbag Organizers', 7072327011);
INSERT INTO category VALUES (3760911, 'Beauty &' || ' Personal Care', NULL);
INSERT INTO category VALUES (11060451, 'Skin Care', 3760911);
INSERT INTO category VALUES (11060711, 'Face', 11060451);
INSERT INTO category VALUES (11062031, 'Treatments &' || ' Masks', 11060711);
INSERT INTO category VALUES (11061301, 'Creams &' || ' Moisturizers', 11060711);
INSERT INTO category VALUES (7792272011, 'Fluids &' || ' Lotions', 11061301);
INSERT INTO category VALUES (7792274011, 'Lotions', 7792272011);
INSERT INTO category VALUES (679337011, 'Shoes', 7147440011);
INSERT INTO category VALUES (679380011, 'Boots', 679337011);

INSERT INTO review VALUES ('R2Q5B5R3WDZS5X', 'Great book for grad students, but not for Beginners.', 'I simply love this book. I agree however that it is VERY theoretical, VERY abstract at times, and VERY mathematical.If you want a great book on general database theory, This is for you. I would have loved to see some more diagrams on the relational algebra chapters though.For the following section, please bear in mind that i am not expert in the DBA field. I''m a AP graduate, who loves database technology.Who would i suggest this book to?* Grad students wanting a reference on general database theory.* Developers looking to develop DBMSs.* Autodidacts who already know how to access Databases from Java or C#, wanting to learn more.* Professionals wanting to delve into what is under the hood of Database systems.* DBAs and would be DBAs.Who would i not suggest this book to?* First semester CS and AP in commuter science students.* Autodidacts who are looking for their first book on databases.* People looking for an in depth book on a specific DBMS. For instance if you are learning MS SQL then inside MS SQL server 20xx would be a better choice.', 4, 'lars42041@yahoo.com', '0133970779');
INSERT INTO review VALUES ('R3E26ES3KIFR85', 'I wouldn''t buy it unless I had to.', 'The title of this book suggests that it is merely the basics; don''t be fooled.  This book goes far beyond the fundamentals.  It is over 1,000 pages of "stuff".  It is used for graduate school classes in database design.  I won''t bore the reader with complex theories and jargon.  In short, don''t buy this book unless it is required for a school course.  This book will only be of use if you are attending graduate school or in search of a PhD.If you are looking to understand how to build tables, define the relationship between tables, how to load data into a database, how to query the database of information, and simply desire a good foundation is the true "fundamentals" of database design then I recommend "The Practical SQL Handbook" by Judith Bowman and it''s companion "Practical SQL the Sequel".  These books will provide a better and more thorough understanding of the application of database design in terms you can understand and it leaves out the theoretical, discrete math, set theory "stuff".', 3, 'bluechip51814@hotmail.com', '0133970779');
INSERT INTO review VALUES ('R1XP5KQRI13IW6', 'Worst text that I have had thus far!', 'I had to have this textbook for a Database Design course and I found the book to be horrible.  Not in the sense of incorrect grammar but as a source of educating and being able to refer to as a learning tool.  I found the text to be very hard to read taking me about as twice as long to read each chapter as compared to most technical textbooks that I have had in the past.  Chapters seem to just start talking about one thing, then moves onto another thing, and then returns back to the original topic.  But to sum it all up, I would only recommend this textbook towards enemy''s as a punishment because it made my life pretty much hell throughout this course.  I would expect a little better quality for $150.00.', 1, 'dustinjmeckley18115@hotmail.com', '0133970779');
INSERT INTO review VALUES ('R1KVUEEHYAKGTK', 'A Virtual Doorstop', 'Using it for a graduate course at the author''s author school. The author frequntly references diagrams from previous chapters and occasionally future chapters. Really obvious in the Kindle version. Some text is a reading of a mathematical formula not shown, not an explanation for added understanding. Still has errors after the 7th edition. Too expensive, even the ebook, for a book that will soon atempt to obsolesce itself.  There are too many editions and theory does not change that quickly. It''s attempting to be a timeless comprehensive reference like CLRS or Russel &' || ' Norvig but it''s got a ways to go.', 2, 'amazoncustomer24899@yahoo.com', '0133970779');
INSERT INTO review VALUES ('R2L4EI0XOIQ2PD', 'Five Stars', 'Good job', 5, 'patrickagenonga46545@yahoo.com', '0133970779');
INSERT INTO review VALUES ('R2XKRQVCYCJY01', 'Three Stars', 'The book came with blue spots on the cover, although it was published this year.', 3, 'amazoncustomer27821@gmail.com', '0133970779');
INSERT INTO review VALUES ('R2F2PM0QMSBLUM', 'Five Stars', 'I can''t understand the topic, but the book is well written', 5, 'patriciahale2339@yahoo.com', '0133970779');
INSERT INTO review VALUES ('R1VDHBK9ZB99K2', 'Good book to study database', 'Good book to study database and MySQL', 5, 'edwardk30243@hotmail.com', '0133970779');
INSERT INTO review VALUES ('R1VKN59YMEK5PC', 'This is a steal for $50 as long as you aren;t expecting a "Premium" experience.', 'I pre-ordered this for my wife mostly to use as a Kindle E-reader as I figured the tablet would be slow and the display would be less than impressive.  I was wrong.  What a bargain this little beauty is!  This model cost $49.00 but it comes with ad''s displayed on the lock screen when your tablet is dormant.  Once your screen times out, they disappear.  You can pay $15.00 up front to get an ad free version so I assumed to unlock the tablet I''d have to spend 15 to 30 seconds looking at an ad for Amazon Prime, or a product from the daily specials section of Amazon.com  I abstained from paying for Ad removal and was pleasantly surprised to find that the ads are only on the lock screen and that as soon as I unlock the tablet they disappear immediately.Here are my pros and cons thus far.PRO:Perfect size for Ebooks, and web surfing to alleviate strain on the eyes from my 5" phone displaynice sturdy casing that gives it a nice heft but still weighs in as one of the lighter tablets on the marketChild Accounts- Amazon allows you to set up this tablet with age restricted access for kids making this a low cost piece of tech that is perfect for school kids and allows mom and dad to ration the amount of time lil Johnny can play Clash of Clans and how much he can hit the ol'' Visa card for.Battery life thus far; wife was on it for about 5 hours last night and battery was at about 46%Kindle Integration -this goes without saying but having my ebooks and audible books synced to the tablet is awesome and my Kindle books look greatPrice - it''s a $50.00 tablet that looks and performs as well as ipad mini gen1CON:Screen resolution - if you''re looking for a premium screen res on par with your latest smart phone or HD tablet look elsewhere.  I''d say the resolution is on par with an Iphone 3G or', 5, 'ghulse40521@hotmail.com', 'B00TSUGXKE');
INSERT INTO review VALUES ('R2MKH6IJ66WR5C', 'UPDATED: Incredible Value for Under $50!', 'See video on Amazon.com UPDATED - After spending quite a bit more time with the device, I would give it a 4.5 due to a few specific gaps that are a bit annoying.  However, you are still getting an amazing 7” tablet, with front and rear facing cameras, a gorgeous interface, fairly snappy performance and durability, all for under 50 bucks!  I can’t imagine not buying these for myself and my whole family, but not a primary tablet for a techie adult by any means.  For background, I have every Kindle, a couple Fires, and multiple tablets from Apple, Microsoft and Samsung. Note that my review with 5 stars considers the value equation, not just performance and how that may or may not compare to other tablets - if you are expecting this to compare to a tablet costing several times more, don''t bother.  But if you are looking for a great entry level tablet that does most of the things people want, this little tablet definitely delivers the value!PRICING/CONFIG:  I prefer this tablet with ads and no accessories to keep the costs down.  You have the option to spend more money, but I recommend against it.  You can easily see the specs online, so I won’t do you the discourtesy of simply cutting and pasting those here.  Here is the price breakdown:• 49.99 base price – what an incredible price point!  Or buy 5 and get a sixth one free!  This puts it into reach of schools and non-profits.• No sponsored screensaver ($15) – big deal that each time you turn it on it shows you something interesting you might want.• MicroSD card ($19.99 for 32GB) – you probably already have one laying around somewhere.  Beyond that, there is memory in the device, and you are using the cloud for storage mostly anyway.  If you end up needing this, just buy one off Amazon, it certainly won’t be more expensive. ', 5, 'tmmassage35551@yahoo.com', 'B00TSUGXKE');
INSERT INTO review VALUES ('R3VT170UM9DFEJ', 'Best Value, Especially with Prime, but beware: mine has 2 dead pixels, Works with GH4 + Antutu Bench', 'See video on Amazon.com $50? Despite the dirt cheap price, i find it to be great for casual use. Videos play nice, games even play nice, text is just not as sexy looking as higher resolution screens. Watch the video for full demo!The short/summed up version: it''s the new budget king in the 6-8" size. It''s screen is a little lower in resolution but still pleasant to look at, it has enough power for most of the typical tablet tasks, and it shares many of the same features as its higher priced brothers such as front and back cameras, b/g/n wifi, and good overall battery life (minus an hour) My favorite size tablet is 8", so if you''re looking at the amazon fire lineup, i would take this over the 6" for sure, and would have a hard time picking the 8" fire at 3x the price. If you''re not a prime member, it''s still a good tablet, if you are a prime member: it''s a great tablet. Possible quality control issue: Mine had two dead pixels (not very noticeable, but still will exchange) You can load APKs(enable unknown sources), i loaded antutu and panasonic image app, both work properly.Just some background, i currently own 5 tablets not including this new one, ranging from a nook color, a samsung tab pro 8.4, LG g pad x8.3, an old acer a500 and an off brand 10.1". Suffice it to say: i know my tablets!Main Cons:-2 dead pixels-Front and rear cameras are low resolution, mostly good for video calls only-1 speaker, sounds tinny like a small laptop, Gets decently loud, use headphones!-Text not very crisp (but still decent to read)The rest are overall Positives:-7-8" is my favorite tablet size, 6" is just a bit too tiny, and 9+ can be cumbersome-Uses a slightly slower quad core 1.3ghz processor, for most tasks you won''t notice a difference-Screen resolution is OK at 171 pixels per inch, at ', 4, 'darrenlevine53893@gmail.com', 'B00TSUGXKE');
INSERT INTO review VALUES ('R18K7NCGHPBY0N', 'Well-made, stylish, all holes appear in the right places', 'Appears well-made and stylish.  I like that the Kindle Fire 7 fit in it very snugly and there was even a flap with velcro to secure after the Fire was slid into the case.  All of the holes (for camera, speakers, etc.) were in the proper place.  There is even a strap on the outside to secure it shut.', 5, 'amazoncustomer22180@hotmail.com', 'B014KP70F8');
INSERT INTO review VALUES ('R34PR61NJUD07F', 'Well made and comfortable to use', 'Well made, easy to use and more importantly, comfortable to use. The elastic that is built into the cover slides over your hand and allows you to barely hold the Fire. I used the Fire for a couple of days before I received the cover and my hand and wrist ached from holding it. This cover has taken away all of my pain and makes using the Fire easy.', 5, 'adiscerningbuyer78588@gmail.com', 'B014KP70F8');
INSERT INTO review VALUES ('R2ICA6JQFAB4T5', 'Great quality', 'I really like this Moko slim case for my new Fire 7 kindle.  It fits perfectly and my camera, charging cord and speaker all have a hole so I have access without taking it out of the case. My daughter loves that it folds to prop the kindle up so she can read while eating. I love the handle so I can read while laying in bed and not drop it.  It has a magnetic closure and a strap to keep the lid closed and screen protected when not using it.  The stylus holder is elastic so it will not fall out or get lost.  I did receive this product at a discount for my honest review.', 5, 'ashleemckim22738@hotmail.com', 'B014KP70F8');
INSERT INTO review VALUES ('R3BUH110LTSN6H', 'Nicely Designed Case', 'I looked at the cases available for the new 2015 Fire 7, and this looked the best. I like the nice stitching on the black material, but many other colors are available. Other designs looked less strong, and their corner clips looked weak. It took a while to get in stock, but the wait was worth it. This case is well made and well designed. Easy to slip the Kindle in a sleeve, and it stays snug.  When closed, the cover keeps the screen protected, and when opened, has a nice opening along the fold that helps the sound from the rear speaker be reflected to the sides and front. All case openings, for buttons, earphones, the speaker etc, are perfectly placed.', 5, 'digster63723@yahoo.com', 'B014KP70F8');
INSERT INTO review VALUES ('R1UBCFJKEVH4Z6', 'Very nice case', 'Great case, fast shipping. Fits the new 5th generation kindle fire 7in perfectly. This is my second case (kindle paper white) made by them and love them both.', 5, 'amandasmith42373@hotmail.com', 'B014KP70F8');
INSERT INTO review VALUES ('R13DKTQUZMOLNI', 'Love it', 'Love the color and the fit of this case for my Kindle Fire.  The indigo color is perfect and looks professional without going with the old standby "safe" color of black.  It is well constructed, holds my kindle securely and I especially love there is place to hold my stylus. Not many cases offer a stylus holder and I appreciate that this one does.  The magnetic closure is far superior to than traditional velcro closures.  Again, this leads to it''s look of professional which I appreciate because I use my kindle as a planner and it is always at my side, even at work.At home, when reading on my kindle, I really like the handle that allows secure one handed holding ability while reading.  That is a feature I have not seen on other cases. I do write reviews for items I have received at deeply discounted rates.  However, I purchased this item at full price without promise of a review.  I write reviews to help others make informed decisions.  It is my sincere hope that my review was helpful. If it was not, then please let me know what I left out that you''d want to know. I always aim to improve.', 5, 'positiveserendipity39814@yahoo.com', 'B014KP70F8');
INSERT INTO review VALUES ('R1SH9TPVDANNZG', 'Not as Advertised and Then it Is', 'The case I received is nothing like the case that was described and shown. There is no stylus holder. There is no hand strap. The unit is bonded vinyl, not stitched leather. It is very flimsy. This is a bait and switch, at worst, or a bad mistake, at best. The only good thing is that it does fit. Recommend? NO!UPDATE: MoKo responded to this issue by sending the correct cover at no charge. The new cover is exactly as advertised. This cover fits perfectly and will provide the conveniences and protection needed. Based on this response, I will not hesitate to order products from this vendor.', 4, 'steve7036@yahoo.com', 'B014KP70F8');
INSERT INTO review VALUES ('R1032TOKYJJZAM', 'Elegantly simple, supremely functional, best in class at $20.', 'Clean, simple, aesthetically pleasing design.  Not too big, not too small.  Adjustable brightness.  Solid snooze bar.  Radio gets clear signal (at least inside a large NYC building).  Speaker is loud and clear.  No frills, just another solid entry into Sony''s decades-long run of producing excellent digital alarm clocks.  The price is right at $20 - this can''t be beat.', 5, 'ewillyard77078@hotmail.com', 'B00IEYHMIM');
INSERT INTO review VALUES ('R22KQPW0XQXYWT', 'Nice clock and helpful hint for those who find the display on the white version too bright...', 'Nice, simple alarm clock.  I bought the single alarm version and wake up to the radio (which, by the way, has decent reception and tonal quality). Simply press the alarm reset button to stop it and it''s already set for the next morning!  As I have it set up, if it''s left set by mistake (say you''re not home), the radio simply plays for an hour.  I purchased the white version because it is easier to see the markings on the controls (especially in dim light).  The problem with the white version (as noted by others) is the plastic overlay covering the display allows the LEDs to emit too much light (even on dim setting) and there is also a bright yellow aura or halo around each LED.Solution... I made a 3 7/8" (10cm) square screen cover from translucent vinyl (actually, using the purple color from a loose leaf divider set, I had sitting around) and taped it over the front.  Seems to help considerably. You can experiment for yourself.  See before and after photos.', 5, 'charles39638@hotmail.com', 'B00IEYHMIM');
INSERT INTO review VALUES ('R36ITYQL1AR08H', 'Contemporary, clean, elegant reasonably priced alarm clock', 'To be gin clear here, we did not buy this for sound quality and audio performance.  We bought this because we needed a nice, clean lined, clearly readable, CHEAP digital clock for our daughter''s room.  This serves its intended purpose perfectly.  See my submitted customer image for size perspective.  I fully realize specs are provided, but I prefer to see a visual representation.  I''d highly recommend this for a simple, cheap alarm clock.  It has a nice orange glow through the translucent white face but the digits are still clean and clear.', 4, 'btcruzr95300@gmail.com', 'B00IEYHMIM');
INSERT INTO review VALUES ('R2H8VHAQ1EA5N7', 'Very nice Alarm Clock!', 'I have been searching and searching for a nice alarm clock for my bedroom.  For me, form is equally important to function.  This alarm clock delivers!  Let me clarify my criteria.  I needed an alarm clock that presented a pleasing light that didn''t blind me at night.  I also need to be able to see it during the day.  Because of this fact, most blue light LED clocks are out because that light annoys me at night.  The red lights are also out so I went searching for something soothing.  Well Amber is it!  This alarm clock display has three levels of brightness.  I prefer the medium but low would be good as well.Next I moved on to form.  This product delivers!  It has a beautiful design and looks quite elegant.  It is the iPod of clocks!  It also has a radio which does work but I don''t buy clocks for their sound quality.  I have a nice stereo for that.Overall, I receive compliments on this clock from guests and family and would absolutely buy it again.  Before purchasing this clock I purchased and returned four other clocks.  It''s fair to say I''m picky.  This clock did not disappoint and I would absolutely buy it again!  Great job Sony!', 5, 'rj32402@hotmail.com', 'B00IEYHMIM');
INSERT INTO review VALUES ('R2SS0O2X4D4IP2', 'White Noise', 'When the radio is switched off, the amplifier is not. This leaves the speaker outputting white noise, or any other interference that it picks-up. The amplitude is the same, regardless of the volume position. In the still of the night, this makes it very hard for me to fall asleep. It''s difficult to imagine why you would design it this way. Reading the [l]users'' manual didn''t show any way of preventing this.Overall, I like the aesthetics. The display has three brightness settings, with the lowest being a little bright for nighttime IMO. Unfortunately, I will have to buy another alarm clock, as the white noise is a show-stopper for me.', 1, 'mrrogernixon17914@hotmail.com', 'B00IEYHMIM');
INSERT INTO review VALUES ('R2FFTJCCFTFW7V', 'Well designed and functional alarm clock.', 'This is a perfect no thrills alarm clock radio. You can select the alarm time and either the beeper or radio as your wake up sound. It''s not digital tuning, so if you''re constantly changing radio stations, this might not be for. But the radio reception is great, and the power cord is the antenna so there are now weird wires dangling around. The face of the alarm is smooth and glossy and the led display is a soothing amber color that is not too bring for small rooms but perfectly readable. The important buttons to set the alarm time and to turn on the radio is easily accessible and memorizable on top of the radio, while the buttons to set the time are well hidden in the back. Got this from target to save on shipping so that the radio will keep my dog company while I''m away. Does a good job of waking me up too', 5, 'irvinquick59423@gmail.com', 'B00IEYHMIM');
INSERT INTO review VALUES ('R33L4XH2Y9YSJ3', 'Serves its purpose well', 'When they said this was a 4" cube, I guess I didn''t realize how serious they were. Its was a little taller and deeper than I expected it to be, but it still works well for its intended purpose. Haven''t noticed any noises like others have claimed. I do feel that given the size, the display should be larger.  Other than the that, no complaints thus far.', 5, 'joshuanapier7853@gmail.com', 'B00IEYHMIM');
INSERT INTO review VALUES ('R2KCSPL811CHPY', 'Nice, small alarm clock radio', 'I bought this to replace a SONY alarm clock radio that I had for years. Easy to use. Good radio reception for the size. Doesn''t take up much room on the nightstand.', 5, 'lynnmukavitz87556@yahoo.com', 'B00IEYHMIM');
INSERT INTO review VALUES ('R3P8Q2HBSTLRTJ', 'The Best Idea Nintendo Ever Had!', 'Simply the best idea Nintendo has ever had! Super Mario Maker is a masterpiece that can be played and created for years to come! If you still don''t own a Wii U and consider yourself a gamer, now is the time to switch over to pure gaming bliss! I can''t give a higher recommendation - a must own! Well done Nintendo! 10/10', 5, 'efyevan60698@hotmail.com', 'B00KWFCSB2');
INSERT INTO review VALUES ('R1L94HUYTD50IA', 'Hello great game, goodbye relationship', 'I ordered this for my boyfriend because I''m the one with Amazon prime. There was much hand wringing whether the lower price was worth waiting the few hours until the mail came on release day vs. getting it at midnight. Frankly I''m surprised he was able to contain himself. Since the arrival of the mail I''ve effectively lost him to Mario.This is a very cool game. It comes with high quality levels made by Nintendo itself in the styles of all the previous Mario games (NES, SNES, GameCube, Wii, etc, with the exception of paper and Galaxy Mario). The Nintendo levels would make it worth it alone, but obviously the main feature of this game is making your own levels and playing other people''s levels. I don''t know why I underestimated how cool this would be when I know how awesomely the gaming community has responded to minecraft. Amongst all the "Sorry this is my first level" attempts out there, there are already some truly amazing levels created in only the last few days. They range from impossible to funny to beautiful to impressive.Creating your own levels is seamless and easy. The stylus function on the Wii U is finally getting the game it was designed for. While creating a level (tap an item you want to place in the menu then tap it on the screen, drag to create big swaths of landscape or enemies) you can toggle back and forth between playing the level and creating, so that if you make a big jump and realize the next platform is too far you can switch back and move the platform in seconds. Everything is smooth and polished. Your mom could be making an awesome Mario level in ten minutes and uploading it the world before she figures out how to set up her email on an iPhone.As usual with Nintendo there is tons of polish...unlockable features, Easter eggs in level creation, cu', 5, 'amorybrown51045@hotmail.com', 'B00KWFCSB2');
INSERT INTO review VALUES ('R2E2W7X2TH5EAN', 'Now my microphone works', 'I had a damaged microphone port on my computer, so unfortunately, Neewer® 2X 3.5mm Hands Free Computer Clip on Mini Lapel Microphone (2X Lapel Microphone) that I had bought wasn''t working. I had bought that cheapo mic because I had so many complaints about my built-in mic being grainy and unpleasant to listen to. So I got the new mic, and it didn''t work on my computer. I even tested the mic on other computers, which it worked perfectly. Eventually I came to the conclusion that the microphone jack must of been damaged and the the signal wasn''t going through. I bought this guy for like $6, plugged it in, and now it works flawlessly. For those who are curious, yes, you can set your speakers to still use your built in sound system, and not use the USB. Just go into Windows Sound settings and change it. In the Playback tab, make your built in speakers the default, and then go to the Recording tab and then make the USB the default for the microphone. I attached pictures so you know what it looks like. USB audio is the Sabrent. Now I did test the audio capacity too, just to see how it was, and it sounds find. You can plug your headphones into the green port. I attached some pictures to give an idea of size, and how I use it. Here is my recommendation. The thing is bulky compared to most USB devices, which given the fact that it is doing it''s own processing makes sense. Try to make sure you have the set-up to where it doesn''t get yanked. I can see that being bad. I received it October 17, 2015. If it breaks or anything like that, I''ll try to remember to update this review of when it happened, how rough I was being on it, etc. As of right now, this is a stationary computer with a mic that I never take off the desk, so I can''t imagine it getting damaged anytime soon. Green = head', 5, 'sf44855@yahoo.com', 'B00IRVQ0F8');
INSERT INTO review VALUES ('R3SPSRE8L80RI3', 'Use for DJing', 'Initially I was skeptical about this product working for my intended use, but for $6 I figured it was worth a shot.  I was looking for a way to output my cue mix through my headphones without disrupting my playback from the computer to the PA speakers.  Most of the reviews I read on here were using this product to replace their existing sound card, not add to it.  Nonetheless it did work and now I have 2 available output deices to put my sound through.FYI:  It is tricky to output 2 sounds to 2 different places.  Some software allows you to choose which device to output to (for me I am using Virtual DJ, but for other programs I know VLC can too).  For other programs without that feature there is a "trick" to get by and I have been somewhat successful with it but not consistently.  If you set your default output to one device, open up your program and play whatever audio you choose, then sometimes you can successfully reset the default output to the other device without changing your initial audio output.  This enables any other program you then open to output it''s sound to that new default output you set, thus achieving dual sound outputs simultaneously.  However, this doesn''t always work so you will need to play around with it, and even if it does work the original audio may randomly stop or switch over to your new default output device.There are also other programs (eg. virtual audio cable) and methods of achieving this but I briefly looked into it and they were not very intuitive and looked to be more trouble than it was worth.This product works well and seems versatile enough to accomplish your needs, whatever they may be.  Product arrived quickly and you''ll need a good pair of scissors to open the packaging.  Highly recommend.', 5, 'zroberts9121@gmail.com', 'B00IRVQ0F8');
INSERT INTO review VALUES ('R14CM5ZCUE261T', 'Great Customer Service', 'Update: After I posted the old review (see below), Andrew from Sabrent promptly contacted me and fixed the problem.The new adapter works wonderfully and I am so happy! Now I can listen to music from my iMac again. The customer service from this company is awesome. If you have a broken iMac or headphone jack, this should fix the problem. Make sure to go into System Preferences/Sound/Output/Select C-Media USB Headphone set for your device sound output.---Old review:Static every ten seconds. Loud static. It does work on my iMac, kind of. When I plug it in, sometimes there will be this loud metallic static noise. It will go away, and then return. I guess I can''t return it due to some return policy. I am glad it was only seven dollars and not twenty.', 5, 'rm4980@yahoo.com', 'B00IRVQ0F8');
INSERT INTO review VALUES ('R3KPGDLKISRM6E', 'Great deal', 'I had recently bought a ps3 and thought it would be interesting to buy playstation plus. I was very impressed by the games that came out in my first 3 months of use. I got uncharted 3, infamous, demon souls, saints row the third, little big planet 2, xcom enemy unknown, BF3. If your subscription expires you can''t play the games anymore, but if you renew you get access to the games again.  The games can be played offline and the longer you are a member the more you benefit from it since they remove and add games each month. As of 7/25/2013 you can get hit man absolution,  and bit trip runner as well some other games mentioned above. I have been a xbox live member for 5 years and have never gotten any free games from MS for being a gold member until recently.', 5, 'amazoncustomer66508@yahoo.com', 'B004RMK57U');
INSERT INTO review VALUES ('R3JDC5KFIL3EEY', 'It''s a big plus', 'As someone who has not purchased many digital "things," I was skeptic of the Playstation Network that came with my brand new Playstation 3. Hence, I went for the 3-month card instead of the 12-month card.  The first day after I put in the code, I got a copy of Sam and Max season 3, a 35 dollar value, for free, because it was the Playstation Plus game of the month.  Wowzers.The bad: Buying free games with the Playstation Plus cards are actually rentals of said games.  If I got a free game on the same day that I got my 3-month Playstation Plus card, it''s actually a 3-month rental of the game, that could be extended from a 3 months rental to a 15 months rental if I buy a 12 month Playstation Plus card (50 bucks) in the next three months.  If I bought another 12 months, say, 12 months from now, the "due dates" for these rentals would extend another 12 months, turning rentals into pretty much the same as a purchase. Games bought with a 1 to 99 percent discount in the Playstation Plus store don''t expire when your Playstation Plus card expires, so that''s good.  The discount applies to a handful of games every month, all of them popular and worth a look.The good:  You get several games picked out of a hat for you per month.  What you get:-one playstation 3 game per month, in the 15-35 dollar range, for free.  For me, the games are always at least decent, at best highly addictive.- one playstation 1 game per month, worth 6 bucks in the playstation store, for free.  These are usually popular, such as Spyro, Tomb Raider, Crash Bandicoot, etc.  In the last 6 months, only one has been lame (Crash Team Racing).- two Playstation "minis", which are video games worth 2-3 bucks in the playstation store, for free. You get about 1-10 hours of fun from these, depending on how addicted you a', 4, 'michael11657@yahoo.com', 'B004RMK57U');
INSERT INTO review VALUES ('R2F5UTXUHUACLA', 'Plus is a Nice Deal and this Card is Convenient', 'Well, PS+ is a very neat deal.  See the website for details, but it''s fairly simple in concept: it''s essentially Netflix for Playstation games.  But there are additional perks like discounted purchases (you can buy full games, movies, music, etc.)Also, one subscription works across several devices.  I own a PS3 and a Vita and use the service for both.  I can also buy and add to my download list from either the PS3, the Vita, or a PC.Another great feature: when you add a free game to your download list, it stays in that list and stays available to you even after that game has been removed from the service.Also, say you let your subscription expire, then wait a few months and then decide to start it up again.  Those games will still be in your download list, read to download and play.The card itself is a great way to try out the plan without giving Sony your credit card information.  When you buy, you are given a code that you can then enter online to start your subscription.  I couldn''t find a link on a PC to do this.  I actually talked to a service rep who told me the easiest way was on a PS3.  I tried that and found where to enter the code pretty easily.Please keep in my my analogy about Netflix.  If you stop paying for the subscription, you will not be able to play any of the "free" games.  Just like Netflix.  If you cancel Netflix, you don''t get to watch those movies anymore.', 5, 'lkfsdg36993@gmail.com', 'B004RMK57U');
INSERT INTO review VALUES ('R2VQDM9SGCMUGY', 'Their Best Work to Date', 'I think this is Ghost''s best work to date. Seems like they took the best elements of the first two albums and combined them on this one. Fantastic riffs combined with great melodies, choruses and guitar solos. This is a landmark album from one of the few metal bands around who still value the importance of melody and good songwriting vs. trying to be "over the top" all the time. My only complaint would be that the drums are somewhat buried in the mix. I was going to mention that it''s a bit short, but then I looked at their other albums. Opus Eponymous is only 34 minutes long, and Infestissumam is only 47 minutes long. This one clocks in at 41 minutes, so it''s par for the course. Ghost just keep you wanting more. Nothing wrong with that. If you are a fan of classic sounding metal/hard rock, I''d highly recommend this album. You won''t be disappointed. I''ve noticed a lot of Metallica fans are also Ghost fans. That''s not a coincidence (I''m one of them).', 5, 'tim75423@hotmail.com', 'B00ZB7QB1O');
INSERT INTO review VALUES ('R3G23SOH3T5L0O', 'UNBELIEVABLY GREAT IN WAYS THAT DEFY WORDS.', 'This is one EXCELLENT album.  If my assumptions are correct, the impact of this album''s popularity will have on GHOST will be much the same as what ''Moving Pictures'' did for RUSH and what ''Close To The Edge'' did for YES, and ''Into The Pandemonium'' did for CELTIC FROST.  First and foremost, the music is incredibly well written and performed.  There isn''t any guitar shredding here, or ostentatious, overblown soloing going on.  Just great riffs, and memorable guitar work that you''ll want to listen to over and over again.  They keyboards add the right texture, without making the songs sound ''sappy.''  The drums and bass form the perfect rhythm section--the beautiful skeleton that holds the music together.  Perhaps the most important quality about this album is that the songs are able to breathe.  You can hear traces from rock''s elders such as DEEP PURPLE, BLUE OYSTER CULT, IRON MAIDEN, and even SPINAL TAP in this stuff!!  Another great quality is the duration of the songs.  The song lengths vary anywhere from just under a minute to just over six minutes (I personally like longer songs). The writing is fantastic, imaginative, and thought provoking.  The group has made themselves ingeniously mysterious--everyone is disguised; thus, your focus remains on the music, instead of the appearances of the individual members.  One thing that I have noticed about their live performances, is that no-one hogs the stage.  Papa Emeritus'' limits his physical activity, enabling the viewer to focus on the music and the other band members.  Whether by design, or by accident, this brilliant approach to performing keeps the egos (that tend to cause other bands to implode) in check.  Last (but not least) the production is outstanding.  Each song is mixed PERFECTLY!  If there are any flubs, I''ll be', 5, 'jonpgoodwin30233@hotmail.com', 'B00ZB7QB1O');
INSERT INTO review VALUES ('R297QI4VU3LMY6', 'Not A Review For Everyone', 'So here''s the thing—I liked Infestissumam better than Opus Eponymous. Don’t head down to that not helpful button yet. I know that I’m wrong about this. That the consensus is that Opus Eponymous was the far better album. I’m cool with being wrong. But it doesn’t change my opinion.So I’m chiming in a review that’s a bit unique. Otherwise, I’d stay quiet because there are plenty of other reviews on here for Meliora already. However, for those few of you like me who liked Infestisumam better, here’s a quick opinion on Meliora.Meliora backs off the Satanic message considerably. While not wholly ditching it—Meliora contains no choruses of “Hail, Satan!” or “Come together for Lucifer’s son.” While the lyrics still stay within the realm of Satanic proselytizing, they could easily be confused for anything else if being listened to at a party or in a car with only half-attention.This lyrical return to being more just generally spooky than directly Satanic isn’t necessarily a bad thing. Ghost risks being overly one-note if every song is an overt ode to Satan. However, that lack of lyrical conviction dulls Meliora for me in comparison to Infestissumam.Without that lyrical bluntness, Ghost’s delivery doesn’t grab me quite as strongly. I like Meliora overall. There are some really catchy tunes. "He Is" and "Deus in Absentia" are the two that caught my attention on first listen. They both push Ghost much further into prog rock than metal. And I love prog rock! But there''s nothing on Meliora to compare with the bluntly majestic power of “Year Zero,” “Monstrance Clock,” or “Ghuleh/Zombie Queen” for me.', 4, 'captpostmod33021@yahoo.com', 'B00ZB7QB1O');
INSERT INTO review VALUES ('R2127V3ZT4XVQH', 'Third Full Length From My Favourite Newer Band', 'Let me just say that Ghost are my favorite band, despite all of the 60s, 70s, 80s and 90s metal that I love to death.Whether you''ve been a Ghost fan since their initial 3 song demo tape(or a fan of their  even earlier bands.. hush hush!), or are just getting into them, prepare yourself as the chills run down your spine.The five elemental Nameless Ghouls along with Papa Emeritus the third take you on an incredible journey of satanic pop hymns and catchy 70s metal riffs that further en-trains your soul into their energy field with every listen.Expect an atmosphere that only Ghost can deliver; Power, passion, despair and admiration for the spirit that makes our race what it is all rolled into one.Favourite moments from side one: The UFO/Dr. Who-like synth opening of ''Spirit'', the softly intriguing ''spoksonat'' leading into ''He Is''(which is a masterpiece in song-writing, and seems to be one of the favorite tracks). I''ve listened to ''From the Pinnacle to the Pit'' and ''Cirice'' about 50 times each pre-album release, so I''m not going to even say anything about those two tracks.Favourite moments from side two: That peak of energy found in ''Mummy Dust'' is insane. That is something to mosh to, friends! Majesty is an incredible single, fairly guitar heavy and the Organ truly shines! ''Devil Church'' and ''Absolution'' together are an experience; The guitar solo section in Absolution is very reminiscent of THE WHO and is a joyous free-for-all of instruments that is surging with talent. ''Absolution'' is one of my ''absolute''(tehe)favorites, too. Lastly, ''Deus In Absentia'' is a fitting closing tango-like piece that ends with some beautifully haunting choir work. Seriously spiritual stuff here.One thing bothers me.. ''Zenith'', the bonus track, wasn''t included with the regular LP, but as a 10" ', 5, 'deadhead15185@hotmail.com', 'B00ZB7QB1O');
INSERT INTO review VALUES ('R28CAUO97YN31J', 'Sit back, relax and Enjoy don''t criticize', 'Despite what the critics say and some of the non-critic professionals say, this is an amazing movie.  I am not a gamer, and I thoroughly enjoyed this movie.  This movie made me become a WarCraft fan.  The cast of characters, the acting, the CGI, the story line, everything I so enjoyed.  No spoiler alert no fairy tale ending, but can we please have a part 2 picking up where this one ended, I am ready to go see this.i am not sure why people who are not into a particular genre, become critics of it in general, for they would never appreciate it, so why criticize because that is all they do.Anyway, my view point is sit back relax and enjoy this well done cinematic viewing of this movie.  I actually went back and saw it twice.  If you did not see it due to listening to the critics, that''s your bad.  But don''t listen to me I generally don''t listen to critics at all and go see things for myself, and I''m rarely disappointed.  I''m a movie buff and pretty old school, where we went to the movies to be entertained, not judgemental.  So do enjoy :)', 5, 'starrr95963@yahoo.com', 'B01GUVOXIW');
INSERT INTO review VALUES ('R3M4M74XNNAICN', 'By the fans, for the fans, and maybe a few newcomers', 'If you don''t know anything about Warcraft and are not picky about films, I would say this may be a 3/5 stars for you with great action. For any fan, I would say it is a 5/5. It was everything I wanted from the Warcraft movie. The special effects and sound are top notch. The orcs and world are believable and fans will see their favorite locations. The action is thirst-quenching. The acting isn''t great and feels like some scenes may have been cut but this is video game movie based on a fantasy strategy game... With that said, there are some touching moments. If you are a Warcraft fan looking for a fun movie, this is it. If you are looking for a serious, brooding film, this is not your flick. There are some silly moments and easter eggs, like somebody leveling up in the movie (not blatantly obvious) or a Murloc thrown in for laughs. I saw it twice in IMAX 3D and will be buying a 4K home theater just for the 4K Blu Ray of this movie. Just FYI, I am not an avid World of Warcraft player, I rarely play but I loved Warcraft 1 to Frozen Throne.', 5, 'thecrash92488@gmail.com', 'B01GUVOXIW');
INSERT INTO review VALUES ('R3MUF0Z2UZWYKL', 'A worthy follow-up....', 'I''m not going to spend time beating a dead horse about how great their first album was. Instead I''m going to write about how great THIS album is! It appears (so far) that people either love it, hate it or think it falls short compared to their first album. I think it surpasses their first album. The new album is Ghost becoming Ghost. The first album had a bunch of great, catchy songs. But Infestissumam is the direction I was hoping Ghost would take. If I were to describe this album to someone unfamiliar with the band I would tell them to imagine if Rosemary''s Baby was a play performed inside a circus where everyone was tripping on LSD and then you might have an idea what to expect. Everything has been improved upon. The sound, the multi-layered and complexity of the songs creates the ideal atmosphere for the listener. Some songs do take a little longer to grow on you than others but the entire album is good. Definitely not a filler track to be found. And while the obvious choices for the first singles: Secular Haze &' || ' Year Zero are excellent I feel the real gems are Ghuleh/Zombie Queen &' || ' Monstrance Clock.I noticed many people refer to the opening track as comparable to the opening track from their first album. I disgree. Yes, it''s the intro and yes it''s an instrumental but I feel it picks up where Genesis left off...and I see a concept even bigger than ONE album which I''ll get to in a minute.Other highlights for me are Per Aspera Ad Inferi and Depth of Satan''s Eyes. Both are very gothic, sinister and charming. This is where Black Metal/Death Metal whatever the hell it''s called these days fails. When you start off screaming your @$$ off and playing as fast as humanly possible right out of the gate with no direction you lose your appeal. Where do you go from there? There''s', 5, 'js41944@gmail.com', 'B00BKBCF38');
INSERT INTO review VALUES ('R2OR27X1C58K8F', 'A good record', 'As a youth minister, I''m always looking for new, exciting music to play for the kids. We had a road trip coming up last month so I ordered this a few days in advance. The kids enjoyed singing the tunes. Johnathan particularly enjoyed the campy, yet moody sounds of "Monstrous Clock." Little Ashley had a ball singing along to the oh-so-melodic "Body and Blood." But for me, my favorite song, hands down, was "Depth of Satan''s Eyes." I love this band and appreciate all that they are doing. If we don''t warn kids about satan, who will? Looking to book them for Easter next year!!!God bless, y''all!', 5, 'chrisevans74993@yahoo.com', 'B00BKBCF38');
INSERT INTO review VALUES ('R257UIN0KELCDF', 'Sheer brilliance', 'After months of speculation, controversy and sheer hype, we finally have the new album from Swedish band Ghost - or Ghost B.C. as they''re calling themselves in the US. Ghost, of course, made a huge splash with their 2011 debut Opus Eponymous, and since its release their buzz has only increased, leading to a reported seven-figure deal on a major label. Naturally, expectations were very high going into their sophomore album, which is titled Infestissumam. Fans of the debut weren''t exactly put at ease when the first single - "Secular Haze" was released. It''s heavy use of circus-like organ seemed like a huge departure from the simple, catchy retro metal of the debut. Well, if "Secular Haze" threw fans for a loop, the rest of Infestissumam will definitely have some jaws dropping.The formula for Opus Eponymous was simple - retro sounding heavy metal that sounded more or less like King Diamond writing lyrics for a Blue Oyster Cult album (with a bit of Angel Witch-y NWOBHM for good measure). The easiest thing for Ghost to do here is serve up another 8-9 catchy Satanic rockers to satisfy their fans. Instead, the band reached even further back into `70s prog and even `60s rock for an album that is both catchy and complex, and for all its Satanic trappings is a layered, progressive and perhaps even artistically brilliant work.Opus Eponymous was effective for a reason, and Ghost hasn''t forgotten that here. Infestissumam still has a handful of catchy heavy metal songs like "Jigolo Har Megiddo," "Depth of Satan''s Eyes" and especially "Year Zero" that should satisfy the way "Satan Prayer" and "Death Knell" did. It''s songs like the gloriously morbid King Diamond does King Crimson "Ghuleh/Zombie Queen" and the epic "The Monstrance Clock," with its Summer of Love turned Summer of Satan v', 5, 'justing70885@gmail.com', 'B00BKBCF38');
INSERT INTO review VALUES ('R29J6501UMOEWL', 'Ideal introduction', 'When I first heard of Ghost (Ghost B.C. in certain markets), I wasn''t quite sure what to think. The concept of a faux Seventies pop-rock band emerging from the twenty-first century and performing Satanic songs seemed too far out to really latch onto. However, after giving Infestissumam a listen, Ghost quickly became one of my new favorite bands. The music is equal parts psychedelic, guitar-driven, and melodic, but descriptions fail to provide what the music itself can. Some personal favorites from this record are the eerie, chorale-tinged "Year Zero," the poppy and fun "Body and Blood" and "Idolatrine," the unpredictable and dynamic "Ghuleh/Zombie Queen," and the lengthy, meandering "Monstrance Clock," but there isn''t a bad or unbecoming song, or any filler, anywhere on the album.', 5, 'docsteele95862@hotmail.com', 'B00BKBCF38');
INSERT INTO review VALUES ('R1BERAXGD4MGBU', 'Step forward in features and presentation, but two steps back in gameplay', 'I''ve been playing NHL games since the earliest SNES/Genesis days, and I am definitely a sucker that buys in every year, mostly out of habit now.Personally I found NHL 15 enjoyable, despite the lack of modes, and the on-ice play and graphics were improved from the previous generation.  Of course the game was stripped of so many features it was barely a "full retail" title.  EA did provide updates that definitely improved the life of the title (how they left Playoff Mode off at launch, I will never know), but the game was fairly thin in terms of long term replay value.NHL 16 brings back the game modes that were left off 15, but I want to focus more on the presentation and gameplay itself because for me, that''s the biggest disappointment in this year''s version.On the positive side, the visuals feel even crisper than before, and the on ice action looks great.  Replays look like broadcasts, the players are less zombie like (though still a little waxy looking), and the crowd is represented better than in just about any other game not named NBA2K.There is also a new coaching mode that provides with you quick on-screen suggestions for stick movements to make the correct move, and then you receive instant feedback as to how well you executed the move.  At first I thought it was kind of cool.  I have been playing a long time, but there are always some stick movements you forget about in the course of the game, and this gave me a refresher.  After one period I was looking for anyway to shut this off.  It''s incredibly distracting, and the suggested move changes so fast that you spend more time looking at the suggestion than your player and often end up taking a body check into the boards.  The "suggestion" for face-offs doesn''t change until you successfully execute the current mane', 2, 'christopherkboyle24347@yahoo.com', 'B00XUZBCVI');
INSERT INTO review VALUES ('R29HGVLNBZ09A6', 'I wanted to like this....', 'Is it just me....or do these games seem to introduce less each year than CoD but for some reason they don''t get as much hate. Its crazy how EA gets away with this...Okay..lets break the game down with some pros and cons.Pro: Lots of new features and modes were added since NHL 15Con: By added I mean reintroduced from NHL 14Pro: Be a Pro finally awards stats for doing, instead of arbitrarily spending pointsCon: Be a Pro is still a pointless grind with no story or anything to make it feel immersive. It hasn''t changed that much.Pro: You can now play couch co-op in Online VersusCon: But you still can''t play EASHL without everybody being on their own consolePro: The gameplay builds nicely on NHL 15, which was a fairly large step up for the new generationCon: The AI is still awful. The penalties are really inconsistent and teammates constantly skate offside and take dumb penalties for no reason.Pro: The passing feels more realistic...Con: ..But its so hard to grab the puck when you receive a pass. Players still skate a few inches from the puck without even trying to put their stick out for it.Pro: The A.I. goalies don''t have as many gaping exploits. They changed the skating physics. He doesn''t feel like he''s skating in quick sand anymore.Con: Besides the skating..Playing as the goalie feels so awkward...He''s either too slow or crazy fast in the net. He seems to have a hard time getting off the post and swapping back and forth between them.Pro: The new On Ice Trainer is a great addition for beginner players.Con: They assume you have no idea what you''re doing and don''t ask if you want the game to essentially let you cheat by highlighting shot options, passing lanes, etc.Pro: There are playoff beardsCon: Really? Shouldn''t they have used that time to fix something useful..Pro: Pok', 1, 'colinishere42063@yahoo.com', 'B00XUZBCVI');
INSERT INTO review VALUES ('R25JLK986C5A4F', 'Much better than 15!', 'The game flows better and there are many more modes. The look and feel of the players on ice are great. It handles well and feels more like real hockey. I had to take stars off because it still seems to be a 6-4 games. It''s hard to tweek the goalie setting to find a realistic sweet spot. 3-2. I want to score but not all the time and I don''t want it to be too hard to score either. Much better game than last year and I''ve already had more fun playing this one in the first night than the entire time with 15. I can hold gem to ten shots and they will still score three times. Much improved but the goalie is still weak. Fix it. Make it realistic ea. Fix the goalie!!!!!!', 2, 'dharmaking61448@hotmail.com', 'B00XUZBCVI');
INSERT INTO review VALUES ('R2J7DACD87XELP', 'CHL, and controls', 'I haven''t played a hockey game in a while so I kinda went into this a little blind. The graphics are beautiful, the little things the crowd dose when you score or win a game is pretty awesome too. But my problems with this game are the player creation. There is almost no freedom, you basically just make a face with limited selection an throw some hair on it. Meh. Another issue i have is the controls, its a huge learning curve. The skill stick kinda sucks, theres been Times when I have gone to take a slap shot an the player just freezes and basically dose a fake, letting the puck fly away causing a turn over. Pretty annoying. Another issue is whe chl. When you create a character you have the choice to be drafted to a team of your choice, or play in the chl an stimulate becoming a pro, pretty cool. No, not at all. You NEED to play around 50 games to get drafted, they offer a simulation setting to speed it up. But if you use it your basically told you suck and get penalized, draft round gets dropped an the coach keeps telling you that you need to play more. Don''t include a feature if it dose something like that. I honestly enjoy the game, but the whole chl deal is super annoying.', 3, 'nathanlabelle16832@gmail.com', 'B00XUZBCVI');
INSERT INTO review VALUES ('R2U4G1Z1P072YH', 'Diggin'' this FGL CD', 'This FGL cd is a long ways from the sound of their previous albums. While the other albums had a ton of songs about drinking and partying, this cd has songs about family and love. It is quite refreshing. Some great collaborations as well with the Backstreet Boys and Tim McGraw. However, this album has more of a pop vibe to it whereas the other ones were more country-rock. Once you get past the shock of that then you will enjoy the well thought out lyrics.', 4, 'milliemarkie90297@gmail.com', 'B01I5AI96S');
INSERT INTO review VALUES ('R3A0N4GZQM4EX5', 'FGL is awesome', 'I am a long time FGL fan.  This music is not their typical party music which I loved.  This is deeper and has value.  I love FGL no matter what they sing, but this is different for them.  Love the old and love the new, always a fan!!', 5, 'hollydukowitz60595@hotmail.com', 'B01I5AI96S');
INSERT INTO review VALUES ('R3ERVWYNS4IDHI', 'A little different... But that is what made them popular.', 'I anxiously awaited the release of this album after the last two were some of my favorite fun &' || ' feel good type albums I own. I have listened to it about a dozen times already and some of the tracks at first I was a bit perplexed by have grown on me. I will say if you expect this to be a FGL drinking moonshine and driving lifted chevys down a dirt road with a chrome pieces in the console album it is not. A few tracks I feel like I am listening to an Usher cd, like Island. Another one I felt I was listening to a boy band track... Looking at the track listing I''ll be damned.. I was... God, Your Mama, And Me Featuring Backstreet Boys.As others have mentioned FGL is not country like Jamey Johnson or George Jones but that is what is special about them. I do not like this album as much as the last two. Just a little bit too much autotune, T-pain Justin timberlake type feel to it. But there are still some very good redeeming tracks. I can see Smooth being their next radio single after May We All dies down. Another favorite is Good Girl, Bad Boy. And of course there are more serious and heartfelt tracks like Grow Old and While He''s Still Around.Overall an enjoyable listen all the way through. However not quite as good as previous Albums.', 4, 'odcaveman82446@hotmail.com', 'B01I5AI96S');
INSERT INTO review VALUES ('R3GBJAXCTOYGTP', 'These guys are great musicians and songwriters and it''s about time they did ...', 'Don''t listen to the nattering nabobs of negativity. Genuine artists change and grow. These guys are great musicians and songwriters and it''s about time they did something with more maturity and depth. After all, "Baby you a song, you make me want to roll my windows down" will only take you so far.  They''ve done their share of party anthems, but there''s more to life than partying. The stripped down approach on songs like "Music Is Healing" gives them an opportunity to showcase their talent, not bury it in a bunch of sonic pyrotechnics. This is good stuff and it''s Florida Georgia Line, so enjoy.', 5, 'rexwilgus12822@gmail.com', 'B01I5AI96S');
INSERT INTO review VALUES ('R1QTD29T53TFC5', 'Joy to my soul', 'Such joy.  Their voices just fill my heart. My first experience of these guys and having the two voices, together and solo and together again, just brings harmony to my ears. I learned of them from tv show and heard them on satellite radio, so I had to get this cd album. Love love. And yes, the upbeat heartful songs are very welcomed in my life. Thank you FGL for being you.', 5, 'layneroach89169@hotmail.com', 'B01I5AI96S');
INSERT INTO review VALUES ('R1W5CKAQPZOROY', 'Its thoughtful, heartfelt, unique and beautiful!', 'I have been a FGL fan for a few years now. As soon as I heard they''re new album was out I purchased it (without even sampling it first). I just knew that it would be great. They did not disappoint. If they were not my favorite country group before they sure are now! I love that their music while country incorporates different genres of music to blend a specific sound unique to them. The other thing I love about their music is that you can just feel the passion (LIKE REALLY FEEL IT!). This is what they love and it shows. They put so much into their music and it makes it truly special. I can listen to the entire album without skipping a track. Its thoughtful, heartfelt, unique and beautiful!', 5, 'janellehunter87562@gmail.com', 'B01I5AI96S');
INSERT INTO review VALUES ('R1E9PJQ4A41200', 'Another great album!', 'I loved their first album and didn''t think it was possible to do any better. But as I have listened to this one a few times now,It is every bit as good! It is a different then the first one, but different in a great way!', 5, 'craiglthompson8926@yahoo.com', 'B01I5AI96S');
INSERT INTO review VALUES ('R294WKAFAJJEP9', 'Accidentally tested, Confidently approved!!', 'Saved my Galaxy S4 already, so it more than paid for itself. While pulling the phone out of my back pocket I basically tossed my phone by the corner into a Frisbee spiral that traveled five feet up and three feet out I watched Dumbfounded as the phone landed on the corner onto the rough asphalt parking lot bounced then landed flat, screen down...SOB!! Without a case I have no doubt that the phone would have spread into a pile of thin plastic Samsung shards.The case took 3 gouges on the initial hit on the edge above the power button but the phone was fine!! I Love This Case!!', 5, 'robw27485@hotmail.com', 'B00N1G35MU');
INSERT INTO review VALUES ('R3O0549897LSPV', 'best case NA', 'Awesome case ! Feels just like the spigen slim armor but better because it has the nice mat finish on the back plate for a better grip ! Super slick and sleek and matches my s4 black must really well I highly recommend', 5, 'samitani56949@gmail.com', 'B00N1G35MU');
INSERT INTO review VALUES ('R2ZILJCRHOKFIE', 'fantastic case! perfect fit', 'excellent product! the case is a bit hard to put in because you need to break down the case into two pieces. put in the rubber part. then put on the plastic part. however the fit is perfect! and feels amazing in the hands. soft yet smooth and looks great!', 5, 'gerard62314@hotmail.com', 'B00N1G35MU');
INSERT INTO review VALUES ('R3617XIIN0Q83V', 'This is a very good case', '***Update***After about nine months of use (daily and sometimes very hard use) this case is falling apart!  The plastic pieces on the front are breaking off,  the back is scratched is badly that there are areas of a different color (white) plastic showing through, the black silicone part has ripped in several spots around the screen and also has come unglued from the hard plastic part.  Also I have noted that some headphone connecters will not fit into the headphone jack on the phone because of the size of the opening in the case.  However, based on the way this case looks, works and the price, I intend to order another one for my phone.This is a very nice looking case that does what it is designed to do, and more.  The case has two parts that are permanently connected together.  The inner sort of soft material that is in contact with your phone on all sides and the bottom and the outer hard shell (in the version I got this is gray colored with a very subtle metallic shine).  The case I ordered fits my S4 nice and tight with no wiggle room.  The case does cover the volume and power buttons but these are still usable.  This case has cut-outs for the camera, flash and speaker on the back; the headphone jack, the noise canceling microphone, and IR blaster on the top; the charging/USB port and primary microphone on the bottom.I have gotten many a TON of compliments on how this case looks on my phone.  It does add a bit of bulk to the phone but this is a good thing for security of grip!Now a quick story about this case.  Just after I put this case on my phone, I dropped it into a puddle of muddy water.  I quickly grabbed the phone  and removed the case, back and battery.  Only then did I note that NOT ONE DROP of water had reached the phone outside of the areas cut-out for I', 4, 'amazoncustomer76516@hotmail.com', 'B00N1G35MU');
INSERT INTO review VALUES ('R23RKM5Z4ATRYD', 'Excellent case, nice styling, solid protection, feels secure on the phone and in your hand', 'This is a great case. Nice styling, effective protection, not too bulky, and a great price. One pleasant surprise is the case has a matte finish that is good looking and has a nice feel to it, smooth but not slippery, i.e. the phone doesn''t feel like it''s going to squirt out of your hands or your pockets.', 5, 'cduenas58763@hotmail.com', 'B00N1G35MU');
INSERT INTO review VALUES ('R1B5ZJBYSS462T', 'AWESOME  phone case!', 'This case is awesome. It fit my S4 perfectly. I can''t believe  the quality of this case considering how cheap the price was. It''s strong and I love the smooth texture on the back. I highly recommend  this case. Honestly, it''s the best case I have ever bought for a phone....my in-laws bought $30 cases from best buy and mine is literally just as good looking and as durable for so much less. Love it!', 5, 'am25439@hotmail.com', 'B00N1G35MU');
INSERT INTO review VALUES ('R1SIG5ORODW4G7', 'Much better than its price suggests.', 'Perfect for the price. Fits VERY snug--was afraid it was too small at first. Feels like it will protect the device well, and the buttons are very clickable without problem through the protector, and the ports are all open and the headphone and charger ports are sufficiently recessed to allow charger cords and headphone plugs through so that they don''t get stopped short on the case itself. Nice.', 5, 'kyleb18302@yahoo.com', 'B00N1G35MU');
INSERT INTO review VALUES ('R38CF4Z9NJC0M5', 'Highly recommend!', 'Make sure you have it lined up well before you place it on the phone. Also, don''t freak out if there''s a bubble. Gently press the bubble toward the closest edge of the protector and it will disappear after a few seconds. Excellent clarity and protection; far superior to plastic protectors. Custom designed for your cell brand (make sure you order the right one). Totally worth the money. Would not have wasted my time with this review if it weren''t. So far it has survived a screwdriver drop, jangling around in my bag with my car keys and my cat (who does have claws) playing with virtual mice. Not a mark on it. Cannot believe it; it''s amazing.', 5, 'amazoncustomer48195@hotmail.com', 'B00N0YYGIU');
INSERT INTO review VALUES ('R30BMAA9BN76RA', 'Decent Price, Would Buy Again', 'I have had this screen protector for a little over a month. No scratches, but a little chip on the side of the glass. Not sure how it got there when I have a bumper case. I prefer the glass over a plastic screen protector because it is very soft, hard to scratch, and shows less fingerprints. Easy installation  with helpful tabs enabled me to place it perfectly on my screen.', 5, 'amazoncustomer6365@yahoo.com', 'B00N0YYGIU');
INSERT INTO review VALUES ('R36DDY357OON8V', 'My Second One For Samsung Galaxy S4', 'I actually purchased two of these, one in January 2015 and one just a few days ago.  Last week I noticed the screen protector on the right edge of the home button was cracking, but barely noticeable to the naked eye.  I have no idea how I managed to crack it there, but I have knocked the phone off the nightstand a few times.  I liked the way this screen protector fit and installed, so I ordered another one.The replacement one I bought appeared to be identical to the first.  It arrived in a nice sturdy box that prevented shipping damage to the screen protector.  It included a cleaning cloth, dust absorbing sticker and two alignment stickers.  It did not include an alcohol wipe and dry wipe like some manufacturers are providing, but this really did not turn out to be a problem.  Actually, I recently used a wet/dry system on a different phone and it seemed to create more smudges.  The dust absorbing sticker worked well.  As a side note, I''ve found that good illumination with a flashlight or work light helps you see those pesky specks of dust.  I used the supplied alignment stickers to carefully align the screen and got it on the first try.  The dimensions were cut perfectly and it went on without any bubbles or halo around the edges.  A Magpul Field Case (great case by the way) fit with the screen protector in place.One minor complaint...make the print on the instructions bigger!Note on photos:#1.  The old screen protector cracked more when I took it off.  Initial cracks were about 4mm.  I don''t blame the manufacturer for the cracks on the first one, but figured some folks might want to see a photo of what the cracked screen looks like.#2.  The screen protector is cut perfectly for the home button.#3.  The Magpul case fits fine with the screen protector in place.', 5, 'eric10474@hotmail.com', 'B00N0YYGIU');
INSERT INTO review VALUES ('R1IXK6WFHMTQXK', 'Worth every cent!', 'This is the first tempered glass screen protector I''ve ever purchased. I bought it for my wife who has a history of phone abuse. According to design, a few weeks after it was installed, she dropped her S4 on the concrete. The tempered glass broke preserving the phone screen. This is an awesome product.', 5, 'chrisnicole35599@yahoo.com', 'B00N0YYGIU');
INSERT INTO review VALUES ('R3ROUYGENJCGCS', 'Perfect! Easy! Simple Instructions!', 'I have recently purchased three screen protectors. The first, a Spigen tempered glass protector for my new iPhone 6S+ which I gave a five-star rating. The second was a Spigen soft plastic protector that I bought for Mary''s Galaxy S4...Spigen apparently did not have tempered glass for that phone...and I just changed my review and gave it a two-stars rating. The third was this protector that I also give a five-star rating...it''s even better than the first Spigen tempered glass protector I first purchased.First, this came in a thin box that opened like a book with foam about ¼-inch thick all around between the covers. Opening revealed the merchandise in a thin foam envelope from which I extracted the protector and installation materials. The instructions were printed on the outside of the back "book cover" in very small print (I''m guessing 2-point type) that my 79-year-old 20/20 corrected eyes could not read. No problems, though, I simply took a photo, transferred it to my Mac Pro, enlarged it using Preview and it was clear as a bell, thanks to the great 6S+ camera.Once enlarged, I found the instructions very detailed in seven steps that were clear, concise and easy to follow. The directions shown in the photo provided state:1. How the screen protector enclosed in the package is comprised of two parts: the protector itself; a screen protector carrier with a tab for handling and later removal.2. Clean screen with microfiber cloth provided.3. Peel off a blue sticky film from a sheet and use the sticky side to remove any remaining dust from the screen.4. Place two locator tabs at opposite corners on top of the protector (opposite side from the side that will ultimately stick to the phone screen). These tabs easily pull off a carrier sheet and are placed exactly on the edge an', 5, 'sailor78217@gmail.com', 'B00N0YYGIU');
INSERT INTO review VALUES ('R1UH1HGGJ4LFW3', 'Strong, Beautiful', 'Size: When I ordered this, I was worried that the bracelet wouldn''t fit correctly. I couldn''t find any sizing anywhere on this page, but I decided to order it, anyways. If the bracelet was too big or too small, I could take out some beads or string them onto a longer string. When I got it, I put it on immediately, and it fit perfectly :) my wrist is 5.5 inches, so it is small, but the bracelet could fit a wrist that''s up to 6.5 or 7 inches, for the circumference of the bracelet is between 6.5 and 7 inches.Shipping: I ordered the bracelet on August 5th, and it came 10 days later! I wasn''t expecting it until the beginning of September. I live in California, so maybe if someone lived in a different state or country, the chipping speed could vary.', 5, 'richardw14827@hotmail.com', 'B01837LGGI');
INSERT INTO review VALUES ('R2CA2R15UP2C6T', 'Doesn''t feel cheap or plastic - band is good and I don''t think it will break easily', 'Bought this as a gift and he loves it. Doesn''t feel cheap or plastic - band is good and I don''t think it will break easily. It looks nice, especially the lighter colored beads. He immediately asked where I got it and where he could find more. I recommend it as a nice small gift.', 5, 'dsbeach27750@gmail.com', 'B01837LGGI');
INSERT INTO review VALUES ('R1RD6TNJ6PFSQD', 'Five Stars', 'Its a really good product and I thought it would be flimsy but it really wasnt its great!', 5, 'jhamalimccalla67807@gmail.com', 'B01837LGGI');
INSERT INTO review VALUES ('R1OLXNUXU4ARH9', 'It didn''t take more than a week and one of ...', 'It didn''t take more than a week and one of them broke already, you get what you pay for', 1, 'amazoncustomer86858@yahoo.com', 'B01837LGGI');
INSERT INTO review VALUES ('R2GPWKQM6TZZNO', 'Quality beads shotty thread.', 'Looked great out of the package and was pretty heavy for a bracelet. The only draw back was the elastic band holding it together. I beaded it on a new string with a clasp and now it''s perfect.', 4, 'edwardjones92169@gmail.com', 'B01837LGGI');
INSERT INTO review VALUES ('R1LVMPPEFJK92D', 'Very Nice', 'These bands are very nicely made for their price. They don''t look cheap and they are a good fit and nice colors. Yes I would recommend these to anyone as a good buy.', 5, 'flyby3942@gmail.com', 'B01837LGGI');
INSERT INTO review VALUES ('R3LJO4JSMT7E70', 'Bead Bracelet', 'I really love this bracelet!  I am a fan of lions and happen to see this bracelet because I wanted some kind of black beaded bracelet.  THIS BRACELET IS THE BOMB!!!  I am extremely satisfied with this purchase.', 5, 'eber48434@hotmail.com', 'B018231PW8');
INSERT INTO review VALUES ('R1HCF5OHZ7PTZU', 'One Star', 'Broke the second time I wore the dang thing! You get what you pay for!', 1, 'nothappy15475@hotmail.com', 'B018231PW8');
INSERT INTO review VALUES ('R35LI22EZAR9O3', 'Broke first day', 'At first though it was pretty nice. Comes as shown but the band is elastic which had me slightly worried. Sure enough, my first day wearing it, the band broke.', 3, 'amazoncustomer12589@yahoo.com', 'B018231PW8');
INSERT INTO review VALUES ('R36CNU21PEO2RE', 'Pretty enough to flash around!', 'The bracelet came on time, in a nice pouch. The item received is exactly as pictured on website. Only complain would be that the beads are smaller than I thought it would be.Each bead is unique with natural finish and that makes it pretty to flash around. Lava beads aren''t heavy too. Woven with an elastic, it fits tight on my large wrist. But no worries since I bought this for my little brother it fits him perfectly. I hope it last long.', 4, 'manuraghav6275@hotmail.com', 'B018231PW8');
INSERT INTO review VALUES ('R14RS3M1H0V5EH', 'Lava Rocks!', 'I bought this gift for my guy friend so this is a review written by him. It seems to be a pretty unique item and is a good conversation piece when you tell people that the bracelet is made from lava rocks. (Someone even asked me if I knew whether the lava rocks came from a famous volcano). I like the bracelet overall. It doesn''t seem to be too heavy or too light to wear on the wrist. It''s also a pretty good size although it feels a bit large for my wrist as it is just a bit too loose for me. (I have smaller wrists than most people). I wish they made it adjustable so that you can alter the number of lava rocks on the bracelet. There are some reviewers who said that their bracelet has been ruined because the elastic band holding everything together has broken. Luckily, mine is still intact after wearing it for a week. I like the black and gold color as it matches pretty well with most of the clothes that I wear. I especially like the details on the lion head. One of the cons of the bracelet would be the holes in the lava rocks. I understand that this is how it is supposed to be, but having holes on something just means that there''s an invitation to get dirt in there. I''ve been pretty careful about keeping the bracelet clean and I often take it off when I''m doing chores around the house. In regards to the healing power of the lava rocks, I can''t really verify whether or not it really heals you. I still feel the same with or without the bracelet on. For now, it’s a pretty unique item more for a fashion statement. Hopefully the healing power works on its own – I don’t need to feel or know it – just hope that it does right? For an honest review, this product was received at a discount.', 5, 'graceandkevin75585@yahoo.com', 'B018231PW8');
INSERT INTO review VALUES ('R1RVAS3JJJDTVV', 'The bracelet is cool looking and whatnot', 'The bracelet is cool looking and whatnot, but the elastic band is way too thin for the heavy lava stones. The day it arrive was the day it broke when I tossed a tennis ball for my dog. I wouldn''t recommend it to anyone, unless they switch over to thicker rubber bands.', 1, 'apop78156@gmail.com', 'B018231PW8');
INSERT INTO review VALUES ('R17B3NW5QG5UO5', 'You get what you pay for.', 'It''s inexpensive so don''t expect quality, obviously. The four gold-looking metal pieces turned to silver my first dip in the ocean. Other than that, it''s stylish and awesome to wear with a wristwatch.', 4, 'chadmatejcek47345@gmail.com', 'B018231PW8');
INSERT INTO review VALUES ('R27YDZ88480A0X', 'There is a good weight to this piece and quality of this is ...', 'This is just gorgeous!!!! We are yogis here and we have lots of malas and bracelets! I even have a few friends who make them!  But this is one of my very favorites!!! I received this at a discount in exchange for my unbiased review, although that doesn''t at all affect my opinion or review. There is a good weight to this piece and quality of this is really so nice. I purchased this as a gift for my mother in law ( who is also a yogi). BUT I really want to keep it for myself.  Overall I would give this and my experience 5 stars and 2 thumbs up!', 5, 'zachariaanddarbytropf30527@yahoo.com', 'B018231PW8');
INSERT INTO review VALUES ('R346UZCWLLAAQ9', 'Great quality!', 'I was so sad to retire my old wallet. I had it for years and it was starting to get pretty ugly.  Found this wallet and fell in love. Love that it''s not too bulky and closes with magnets. The animal print on the inside adds a nice touch to it as well. Comes with a coin pouch too. I''m not too sure about using the coin pouch though, there''s a zipper pocket on the back of the wallet that will do the job. Very nice and good quality! As you can see in the photos I spent no time changing out wallets. :)', 5, 'amazoncustomer62578@gmail.com', 'B01BFJ8JNO');
INSERT INTO review VALUES ('R1XJIPG4IOTBBO', 'Good size wallet and holds more credit cards than I ...', 'Good size wallet and holds more credit cards than I expected.  It comes with a small coin purse that fits inside the wallet which is a great feature I did not expect.  For the price, quality and style are good too. A word of caution, the wallet is long so you''ll need to carry a fairly large purse for it to fit or you could carry it as a purse.', 5, 'stlshopper57753@yahoo.com', 'B01BFJ8JNO');
INSERT INTO review VALUES ('R1AH107D65VI6A', 'The real thing!', 'This is such a great deal. I could have easily picked this up at an expensive department store for so much more money. I am so glad I purchased this here. I love it!', 5, 'amesue48455@yahoo.com', 'B01BFJ8JNO');
INSERT INTO review VALUES ('R16JVY463VRHJZ', 'Awesome', 'I absolutely love this wallet! It came fast &' || ' holds so much. Great quality for a great price.', 5, 'kitathediva45675@yahoo.com', 'B01BFJ8JNO');
INSERT INTO review VALUES ('R1B7JH4GR1EW2X', 'Just what I wanted', 'I purchased this wallet in Aug for myself.  One of my friends admired it and wanted one.  I just gifted this one to her over the weekend and she is delighted.  Knowing what it was before ordering helped this be a 5 star!!  I love the bright colors = easier to find in bags and not leave on counters or tables.  It is an efficient style with lots of pockets and easy access.', 5, 'annrwertz80879@yahoo.com', 'B01BFJ8JNO');
INSERT INTO review VALUES ('R3NW4XU5GAIGJD', 'Love love this wallet', 'Came as described well worth the money but Kenneth Cole  normally it I love how it''s so easy to open the magnets are in the inside of the leather/PVC material and how it''s got the change purse inside so much easier getting your change the using the back pocket true to color beautiful blue I have ordered every single blue Kenneth Cole wallets in the last two weeks and so far not disappointed might not be leather but made of PVC material and seem to be tough n with care will last a long while  plus there is a leather/ vinyl  conditioner U can buy to keep them from tearing or cracking!!!', 5, 'christinameadows90686@gmail.com', 'B01BFJ8JNO');
INSERT INTO review VALUES ('R3K3HXMFAEBJ7N', 'Strongly recommended', 'Cosmelan 2 is pricey but very effective in reducing pigments in very short time.First-time users should be warned that it creates irritation and redness with slight peeling of the skin,but the final results is good as the skin becomes very smooth and its texture and tone much improved. The irritation can be reduced by using Mesoestetic Hydra-Vital Factor K.', 5, 'elizalee97779@yahoo.com', 'B00B6T0EBY');
INSERT INTO review VALUES ('R1ADLHVQHHADYH', 'Brand name disappointed', 'Purchased this product for hyperpigmentation two years ago thru a physicians office and it was very effective.  In my excitement to find it available online,  I trusted in the brand name and ordered it in anticipation of receiving a great product.  It''s turned out to be most disappointing!  After applying three times a day to affected areas for well over a month the results are minimal at best.  The reviews indicated the formulation had changed...and to my loss in $$$......the reviews are correct!! For the price, quantity and repetitive application of the product it ''s not worth the investment.  Wouldn''t recommend nor purchase again.  The only reason I didn''t rate one star is because this is a cream like product and there isn''t a stinging or burning sensation when applying to skin which can be a risk if choosing a chemical for hyperpigmentation.', 2, 'savvybuyer19888@yahoo.com', 'B00B6T0EBY');
INSERT INTO review VALUES ('R2LFTTJG10ZEE3', 'Disappointed', 'I''ve bought this product before from my dermatologist and the one I got from Amazon is nothing like it. The appearance was totally different, both colour and texture differed from the Cosmelan 2 I used before. What is worse is that the effect was the opposite, instead of disappearing the spots, it gave me more. I compared the labels and the only difference is that they''re made by different laboratories. When I tried the Amazon product for the first time my face was really itchy and I couldn''t resist it, and so I wasn''t able to use it again. With the other product this didn''t happen. I lost the money and the effects were very serious. I''ve bought Cosmelan 2 again from my dermatologist and I confirmed the cream is definitely not the same.', 1, 'carmenza77603@hotmail.com', 'B00B6T0EBY');
INSERT INTO review VALUES ('R3VVKPB5Z0T8ZS', 'This is the one of the best moisturizes ever', 'This is the one of the best moisturizes ever. When my face is very dry i just use a little of this and my skin becomes flawless and super hydrated! Great seller! fast shipping.. I just loved! Thanks a lot!', 5, 'amazoncustomer33322@gmail.com', 'B002RLW5VW');
INSERT INTO review VALUES ('R2XL2OYFS4HQDP', 'Excellent!', 'One of if not the best facial moisturizers that I have ever used.  Clean, refreshing, soothing, non-greasy it does as it promises.', 5, 'sgrynkewich39962@hotmail.com', 'B002RLW5VW');
INSERT INTO review VALUES ('R1PRIQF3IKUMSD', 'good moisturizer', 'best moisturizer i''ve ever used. I used dermalogica before but after using this, I know i found my match.never oily and easily absorbed.', 5, 'joy67552@yahoo.com', 'B002RLW5VW');
INSERT INTO review VALUES ('R2JS1349FLQJZJ', 'nothing revolutionary but an overall good product. Probably a little pricey for what it', 'This is a decent moisturizer, nothing revolutionary but an overall good product. Probably a little pricey for what it is', 3, 'sylviakornicki10915@yahoo.com', 'B002RLW5VW');
INSERT INTO review VALUES ('R2CREO23KL4DSZ', 'Five Stars', 'I love this moisturizer. Blends in well with no greasy residue. Makes my skin appear flawless.', 5, 'serious95915@gmail.com', 'B002RLW5VW');
INSERT INTO review VALUES ('R1QE1ZZSAUS5MT', 'Five Stars', 'It is really good and essential to use together with cosmelan.', 5, 'flaviagontijo23238@yahoo.com', 'B002RLW5VW');
INSERT INTO review VALUES ('R2PNBA3P1YFBOP', 'A cream which makes you..', 'A cream which makes you looks youngerTry it you will know by yourself.There are so many products out there.', 5, 'lrd70927@hotmail.com', 'B002RLW5VW');
INSERT INTO review VALUES ('R3V7FEZRZ32RGV', 'Three Stars', 'I like them but they feel cheep', 3, 'amazoncustomer3183@hotmail.com', 'B00GP21EOS');
INSERT INTO review VALUES ('R3DX2IPIUTH3IW', 'just a little big but are perfect and', 'really was the footwear I expected, fair size, just a little big but are perfect and comfortable', 5, 'lerimarmarcano44312@gmail.com', 'B00GP21EOS');
INSERT INTO review VALUES ('R3ELT6817U8208', 'Love it!!!', 'Love!!!! Great quality at a great price!', 5, 'ashley45531@hotmail.com', 'B00GP21EOS');
INSERT INTO review VALUES ('R1SXU8BY2NB4TD', 'Love em!!', 'Love my boots!!!! Would def. buy again.', 5, 'milamarie36286@gmail.com', 'B00GP21EOS');
INSERT INTO review VALUES ('R1SE6XXX8G7I6T', 'One Star', 'very bad produto both shoes were left', 1, 'priscilainca54369@yahoo.com', 'B00GP21EOS');

INSERT INTO account VALUES ('lars42041@yahoo.com', 'Lars', 'e94918583558f35d34baacb3848c03847fc18455');
INSERT INTO account VALUES ('bluechip51814@hotmail.com', 'Blue Chip', 'bce9923229d7f07aeb11e6f2a4b10b032e1b41f6');
INSERT INTO account VALUES ('dustinjmeckley18115@hotmail.com', 'Dustin J. Meckley', '0ebadb0c598e2dfc1939f6a5bf5b6645769d2378');
INSERT INTO account VALUES ('amazoncustomer24899@yahoo.com', 'Amazon Customer', '65a27eb60ee2fd95dbd066c9914dc75182c70e99');
INSERT INTO account VALUES ('patrickagenonga46545@yahoo.com', 'Patrick Agenong''a', 'b0e4d43ba7ca739dc1900a938095b9dd64d1b10c');
INSERT INTO account VALUES ('amazoncustomer27821@gmail.com', 'Amazon Customer', 'f6d8265dd5e922e6ea509ac4722f7e5cb1c4fed4');
INSERT INTO account VALUES ('patriciahale2339@yahoo.com', 'Patricia Hale', '5eb4e39768b37a7ad280ee4ff63ca96a84acfbdd');
INSERT INTO account VALUES ('edwardk30243@hotmail.com', 'Edward K.', '79ab0b20b65f9c45550880f6cfc28c0894b092de');
INSERT INTO account VALUES ('ghulse40521@hotmail.com', 'G.Hulse', '377d9adc5ca45208d79c7cf47ac58eb67053de40');
INSERT INTO account VALUES ('tmmassage35551@yahoo.com', 'TM massage', '60de3d7581bff45509afd14ca0be1fc8faea4013');
INSERT INTO account VALUES ('darrenlevine53893@gmail.com', 'Darren Levine', '04d4d58ac863d1856b6c4b41b010d075c593ce91');
INSERT INTO account VALUES ('amazoncustomer22180@hotmail.com', 'Amazon Customer', 'aacd88423ec1b4dfc748286d879ab1bc01c1a08a');
INSERT INTO account VALUES ('adiscerningbuyer78588@gmail.com', 'A discerning buyer', 'a7dae27fa9a24589c2146505ee48dedb348873f6');
INSERT INTO account VALUES ('ashleemckim22738@hotmail.com', 'Ashlee McKim', '8470def946b047cd3781175e6159150a30a6bce4');
INSERT INTO account VALUES ('digster63723@yahoo.com', 'Digster', '47c8bcf05d1cffe89bacd3431a6fcfc5b33481c7');
INSERT INTO account VALUES ('amandasmith42373@hotmail.com', 'Amanda Smith', '8b1125196879e195ac98604d0c2f0f08bef2aa7c');
INSERT INTO account VALUES ('positiveserendipity39814@yahoo.com', 'PositiveSerendipity', 'a284892af754cbf76b95aea6fa2494beb768f913');
INSERT INTO account VALUES ('steve7036@yahoo.com', 'Steve', '1b5a4b7e26099353e7da5511030d027b3fe0d2be');
INSERT INTO account VALUES ('ewillyard77078@hotmail.com', 'E. Willyard', 'd66487b2911b8211c06564589782c0ece9b45061');
INSERT INTO account VALUES ('charles39638@hotmail.com', 'Charles', 'cb637ec12a0a6d3d7c427a6182c98b330bda1ad8');
INSERT INTO account VALUES ('btcruzr95300@gmail.com', 'BTCRUZR', '7a3d307d2cb95e8e6705629ad0fb83e54465f9f8');
INSERT INTO account VALUES ('rj32402@hotmail.com', 'RJ', 'c8416122ac40a4b134e8472f1acda90b4b2d2848');
INSERT INTO account VALUES ('mrrogernixon17914@hotmail.com', 'Mr. Roger Nixon', 'dc49c00db349b21e9ef62f396da512ba60dcdc94');
INSERT INTO account VALUES ('irvinquick59423@gmail.com', 'IrvinQuick', '0cf9580d6ec6c351169cbf140ca2d889f4cb41ef');
INSERT INTO account VALUES ('joshuanapier7853@gmail.com', 'Joshua Napier', '6bfa14f6bf1aea41e5472c808268a5e8f9af1b47');
INSERT INTO account VALUES ('lynnmukavitz87556@yahoo.com', 'Lynn Mukavitz', '007672557ed76c6ef6460bc22883771dff7068c2');
INSERT INTO account VALUES ('efyevan60698@hotmail.com', 'EFYevan', 'd62ffa8b393a994754a09030d902c17ef8494cb7');
INSERT INTO account VALUES ('amorybrown51045@hotmail.com', 'Amory Brown', '6a32c2586611181c0c67a78abe6fcb68d608345f');
INSERT INTO account VALUES ('sf44855@yahoo.com', 'SF', 'b7cb63e27852e2a3454e59d537ca13f93a6f9082');
INSERT INTO account VALUES ('zroberts9121@gmail.com', 'Z. Roberts', '5372671764ababe68930b9cbbf8406a0a4b7ed83');
INSERT INTO account VALUES ('rm4980@yahoo.com', 'R. M.', '522967efc7a12a9d61d550ccceeb92ddc01047a0');
INSERT INTO account VALUES ('npruss1@cub.uca.edu', 'Nicholas Pruss', 'ac54ca21a5b415e4000b78e45130a615b49c3e23');
INSERT INTO account VALUES ('amazoncustomer66508@yahoo.com', 'Amazon Customer', 'e2d63196a5219f03583a8bc8f35c0b2fa2d7fdb8');
INSERT INTO account VALUES ('michael11657@yahoo.com', 'Michael', '49bffb2e791ce2221ee717708c611eb6667febed');
INSERT INTO account VALUES ('lkfsdg36993@gmail.com', 'lkfsdg', '4f40d254e81022fabfcdbcb8bd7641df16f26d94');
INSERT INTO account VALUES ('tim75423@hotmail.com', 'Tim', 'c9db65cdd0bf83c637fcc8c1a452862acf67f3b7');
INSERT INTO account VALUES ('jonpgoodwin30233@hotmail.com', 'Jon P. Goodwin', '1fb4785a0343d99d5b9749bd1729f9c8fe3a560d');
INSERT INTO account VALUES ('captpostmod33021@yahoo.com', 'CaptPostMod', '53fa38d61deb7b884131f2af1a17366e9d00b65b');
INSERT INTO account VALUES ('deadhead15185@hotmail.com', 'Dead420Head', '5a4d9d076623a7bb1592bc5a0059ad82baf8e725');
INSERT INTO account VALUES ('starrr95963@yahoo.com', 'Starr R', '6e1a5092110f4fbbdcf16b48286c2436d70961cb');
INSERT INTO account VALUES ('thecrash92488@gmail.com', 'theCrash', '691d44c294dc6c6ab3716ecf944d868b02b5721d');
INSERT INTO account VALUES ('js41944@gmail.com', 'JS', '12e48f04872b2c01db96cef66a6a2bedd1bcb946');
INSERT INTO account VALUES ('chrisevans74993@yahoo.com', 'Chris Evans', 'e5a1323c37858d08055c09cd8775c71cb36411d0');
INSERT INTO account VALUES ('justing70885@gmail.com', 'Justin G.', '3e8af12f7cc90b761756107cb27aa7bc6bb3b12c');
INSERT INTO account VALUES ('docsteele95862@hotmail.com', 'Doc Steele', 'f2365cc27e2305526c0f184659b61dfd1725cd87');
INSERT INTO account VALUES ('christopherkboyle24347@yahoo.com', 'Christopher K Boyle', '57a276fe74d7f4ba8f581ae2f4a9dd4af7971a65');
INSERT INTO account VALUES ('colinishere42063@yahoo.com', 'ColinisHere', 'bfb22b39b9b07ba48ad60b280bb4e4d1099ba216');
INSERT INTO account VALUES ('dharmaking61448@hotmail.com', 'Dharma King', '86321ab468f6f4a06c9c320ee545e762d59b3e35');
INSERT INTO account VALUES ('nathanlabelle16832@gmail.com', 'Nathan labelle', 'c16f443237bfc42935636ae44446978a4daf147c');
INSERT INTO account VALUES ('milliemarkie90297@gmail.com', 'Millie Markie', '53fceaf5a61f07d9cc6fa97eee545e48a09efa19');
INSERT INTO account VALUES ('hollydukowitz60595@hotmail.com', 'Holly Dukowitz', '399f6c692adc593f2da5086c7da623fb416d2db4');
INSERT INTO account VALUES ('odcaveman82446@hotmail.com', 'ODCaveman', '4b2157f18328b4b904358dfd56c0c4db53ff3671');
INSERT INTO account VALUES ('rexwilgus12822@gmail.com', 'Rex Wilgus', 'ce4b5f508ac0b230ad532849e1c013e2ebbf8e87');
INSERT INTO account VALUES ('layneroach89169@hotmail.com', 'Layne Roach', '511ab05c820a9c7fe4100affa9377a59a2792737');
INSERT INTO account VALUES ('janellehunter87562@gmail.com', 'Janelle Hunter', '73d90cfc0cc7ac8d3cbdc1e3598a4fdf9c9e6d0d');
INSERT INTO account VALUES ('craiglthompson8926@yahoo.com', 'Craig L. Thompson', '11456e1c50ecc6caefc56c341a4b605fb8e92196');
INSERT INTO account VALUES ('robw27485@hotmail.com', 'Rob W.', '56de5644f5f031fbb2e2423399d9b6c9ab333ea1');
INSERT INTO account VALUES ('samitani56949@gmail.com', 'Sam itani', '14f52de5f032e1f891639cc90212c8326c51a270');
INSERT INTO account VALUES ('gerard62314@hotmail.com', 'Gerard', 'b69e621ff713de91ed336c4a30bc37ce09511f39');
INSERT INTO account VALUES ('amazoncustomer76516@hotmail.com', 'Amazon Customer', '52d1e0fdbdc4fdada90c0a3a2b1089dff5e9505f');
INSERT INTO account VALUES ('cduenas58763@hotmail.com', 'C. Duenas', 'abe625151ee5881ce11e8e198a57973ef6649257');
INSERT INTO account VALUES ('am25439@hotmail.com', 'A.M.', 'a64d8bd1368546b58a6dc1638a3b23fafa8694eb');
INSERT INTO account VALUES ('kyleb18302@yahoo.com', 'Kyle B', 'c3f674bd1fe5c0af68c66c624c2d8bd0938c1a5f');
INSERT INTO account VALUES ('amazoncustomer48195@hotmail.com', 'Amazon Customer', 'adcbdced5edb685b1fa7394abb4f49a0fb0377b9');
INSERT INTO account VALUES ('amazoncustomer6365@yahoo.com', 'Amazon Customer', 'e2ff5c0c802da58bb5b34cc4cc92a49f715fc09a');
INSERT INTO account VALUES ('eric10474@hotmail.com', 'Eric', 'ef43279b7284938caafa78e9a27295ad161b9098');
INSERT INTO account VALUES ('chrisnicole35599@yahoo.com', 'Chris &' || ' Nicole', 'e048ca832209fc99132a35a2388da4460fc7f607');
INSERT INTO account VALUES ('sailor78217@gmail.com', 'Sailor', '6fed460ebf1121a7cd9b9e7d3090336a2b8b9685');
INSERT INTO account VALUES ('jjohnson64@cub.uca.edu', 'Shane Johnson', '68566ffeb988ef49b88cb6242d3e404ae2495d7e');
INSERT INTO account VALUES ('richardw14827@hotmail.com', 'Richard W', 'd66908d3071157307841eb087a6454877ae86453');
INSERT INTO account VALUES ('dsbeach27750@gmail.com', 'Dsbeach', 'f01c6728c82d1aa2c1e6310e13b6b69422dbe3df');
INSERT INTO account VALUES ('jhamalimccalla67807@gmail.com', 'jhamali mccalla', '730fa477015aef429856f4db4a8406662801dc77');
INSERT INTO account VALUES ('amazoncustomer86858@yahoo.com', 'Amazon Customer', 'af6672e3d3370baac4cd56d797426a8df5696036');
INSERT INTO account VALUES ('edwardjones92169@gmail.com', 'Edward Jones', 'b19027baebcadb6eb889abbd9edb06258a456175');
INSERT INTO account VALUES ('flyby3942@gmail.com', 'Flyby711', 'e7b73454ce960eb7107e19313e16dfe8cb3275f7');
INSERT INTO account VALUES ('eber48434@hotmail.com', 'Eber2', '66aa79f93c8198219b57e10ab35ac3ef11c56332');
INSERT INTO account VALUES ('nothappy15475@hotmail.com', 'NOT HAPPY', '4123f2172a9926369ddd97644c808f190dd0dbcb');
INSERT INTO account VALUES ('amazoncustomer12589@yahoo.com', 'Amazon Customer', '37ad974380ff70b16f7eca287921001fc7f3b3fc');
INSERT INTO account VALUES ('manuraghav6275@hotmail.com', 'ManuRaghav', '7df1088345c8f33140f69bb3824066feaf5ae1ce');
INSERT INTO account VALUES ('graceandkevin75585@yahoo.com', 'Grace and Kevin', '71ebf57a4df8e9d042d4dacde6f26e8fa74e8759');
INSERT INTO account VALUES ('apop78156@gmail.com', 'apop', '1d2436326789e66a0114210d255ff2c816940bad');
INSERT INTO account VALUES ('chadmatejcek47345@gmail.com', 'Chad Matejcek', 'f00cfb955d49af32de4b493a59c493f7bdf5306d');
INSERT INTO account VALUES ('zachariaanddarbytropf30527@yahoo.com', 'Zacharia and Darby Tropf', 'c85b3c717b59632ac29d0a88971608e147d6e35c');
INSERT INTO account VALUES ('amazoncustomer62578@gmail.com', 'Amazon Customer', '3fac17e3aaa65589de232fb271eddda28a04a652');
INSERT INTO account VALUES ('stlshopper57753@yahoo.com', 'STL Shopper', '61a4e04aee8e2a2c70ae50be6130ed93032834b5');
INSERT INTO account VALUES ('amesue48455@yahoo.com', 'Amesue', '2477758ea13cdbcdb8bb741aa8e0c70a68abc849');
INSERT INTO account VALUES ('kitathediva45675@yahoo.com', 'KitaTheDiva', 'bf712ad82521521e0f72a7c176cffc99a3ed53d7');
INSERT INTO account VALUES ('annrwertz80879@yahoo.com', 'Ann R. Wertz', '4274922bf4640fe903cf36a49ebaad0c53371d72');
INSERT INTO account VALUES ('christinameadows90686@gmail.com', 'christina meadows', '5d6d30afe709268e86d7e4f4d34bf2ca38188450');
INSERT INTO account VALUES ('elizalee97779@yahoo.com', 'Eliza Lee', '88e498312a37652b3e0cbff2fbeb1420c2474177');
INSERT INTO account VALUES ('savvybuyer19888@yahoo.com', 'Savvybuyer', 'aaf767e795e8f1965d01a8b0de7b3920628447b8');
INSERT INTO account VALUES ('carmenza77603@hotmail.com', 'Carmenza', '56cf605b2b1db5cc5a03c69aa5854282b6252178');
INSERT INTO account VALUES ('amazoncustomer33322@gmail.com', 'Amazon Customer', '129bc3db3901c041080bc4f0060cb42d9c598bb6');
INSERT INTO account VALUES ('sgrynkewich39962@hotmail.com', 'S. Grynkewich', '6ddbed3c9aab332aa56bba7fc6ae578c6e38a900');
INSERT INTO account VALUES ('joy67552@yahoo.com', 'Joy', '3dd300ecd67fd150eed90ffd95533e554fd9b623');
INSERT INTO account VALUES ('sylviakornicki10915@yahoo.com', 'sylvia kornicki', '91c1e4e8e02ecc831c0c87c2984304a11b9ca05c');
INSERT INTO account VALUES ('serious95915@gmail.com', 'serious', '795a68b8e4fb1628c5bcc53609880099bf5345cf');
INSERT INTO account VALUES ('flaviagontijo23238@yahoo.com', 'Flavia Gontijo', 'bece54079334b1db7d6e9844bae3b6c0a6ecdec4');
INSERT INTO account VALUES ('lrd70927@hotmail.com', 'L. RD.', '36e3f8b8909f863f4501a9c1316e8dd706d98e97');
INSERT INTO account VALUES ('amazoncustomer3183@hotmail.com', 'Amazon Customer', '6285c0950e8048793a0055617c5f3a1b115dc22e');
INSERT INTO account VALUES ('lerimarmarcano44312@gmail.com', 'Lerimar Marcano', '0415470f8a8ef48f8b8f75e0d8c019b454efbe7a');
INSERT INTO account VALUES ('ashley45531@hotmail.com', 'ashley', 'ab0c6336bd444767494d3d5631400809fc18e503');
INSERT INTO account VALUES ('milamarie36286@gmail.com', 'Mila Marie', 'eaf819e1afb57c5d2af314a524d6a37709820cb3');
INSERT INTO account VALUES ('priscilainca54369@yahoo.com', 'Priscila inca', 'fa7dca06ca0ab680c0c346dde460bf657cbcc8af');
INSERT INTO account VALUES ('esaezbarrios1@cub.uca.edu', 'Edwin Saez', '02285037db67fb1c9903901eebc83c8567fc96e2');

INSERT INTO orders VALUES (11576494683395817, '22-JUL-16', 'Complete', 'npruss1@cub.uca.edu');
INSERT INTO orders VALUES (10582090927795818, '28-NOV-15', 'Complete', 'npruss1@cub.uca.edu');
INSERT INTO orders VALUES (10211679247601928, '3-OCT-15', 'Complete', 'npruss1@cub.uca.edu');
INSERT INTO orders VALUES (10268269285029182, '25-JUL-15', 'Complete', 'npruss1@cub.uca.edu');
INSERT INTO orders VALUES (10922019985938184, '27-AUG-16', 'Complete', 'npruss1@cub.uca.edu');
INSERT INTO orders VALUES (10925329490277833, '1-NOV-16', 'Complete', 'jjohnson64@cub.uca.edu');
INSERT INTO orders VALUES (10887699913180235, '15-OCT-16', 'Complete', 'jjohnson64@cub.uca.edu');
INSERT INTO orders VALUES (10819968231521832, '17-AUG-16', 'Complete', 'jjohnson64@cub.uca.edu');
INSERT INTO orders VALUES (10864849968079468, '8-AUG-16', 'Complete', 'jjohnson64@cub.uca.edu');
INSERT INTO orders VALUES (11390445781542559, '12-NOV-16', 'Complete', 'esaezbarrios1@cub.uca.edu');
INSERT INTO orders VALUES (11364702589494651, '13-NOV-16', 'Complete', 'esaezbarrios1@cub.uca.edu');
INSERT INTO orders VALUES (11372144445484652, '9-NOV-16', 'Complete', 'esaezbarrios1@cub.uca.edu');
INSERT INTO orders VALUES (10960624868941581, '26-APR-14', 'Complete', 'esaezbarrios1@cub.uca.edu');

INSERT INTO shipment VALUES (11576494683395817, '9374889679090056195817', 'USPS', '23-JUL-16', '260 L Dr', 'Conway', 'AR', 72628);
INSERT INTO shipment VALUES (10582090927795818, '1Z391BA50495713817', 'UPS', '28-NOV-15', '978 L Ave', 'Conway', 'AR', 72632);
INSERT INTO shipment VALUES (10211679247601928, '9491889694817050183712', 'USPS', '4-OCT-15', '978 L Ave', 'Conway', 'AR', 72632);
INSERT INTO shipment VALUES (10268269285029182, '9501895918510591759284', 'USPS', '11-SEP-15', '260 L Dr', 'Conway', 'AR', 72628);
INSERT INTO shipment VALUES (10922019985938184, '438183910291', 'FedEx', '28-AUG-16', '551 O Ave', 'Little Rock', 'AR', 72569);
INSERT INTO shipment VALUES (10887699913180235, '9274899993715907700300', 'USPS', '18-OCT-16', '846 J Ave', 'Conway', 'AR', 72286);
INSERT INTO shipment VALUES (10819968231521832, '9216498623497922286843', 'USPS', '27-AUG-16', '511 B St', 'North Little Rock', 'AR', 72386);
INSERT INTO shipment VALUES (10864849968079468, '9204573321254569895635', 'USPS', '9-AUG-16', '846 J Ave', 'Conway', 'AR', 72286);
INSERT INTO shipment VALUES (11390445781542559, '9015447836498785035478', 'FedEx', '13-NOV-16', '416 U Ave', 'North Little Rock', 'AR', 72317);
INSERT INTO shipment VALUES (11364702589494651, '9015482645648966518984', 'FedEx', '14-NOV-16', '416 U Ave', 'North Little Rock', 'AR', 72317);
INSERT INTO shipment VALUES (11372144445484652, '9374881541651321654815', 'USPS', '10-NOV-16', '995 I Rd', 'Little Rock', 'AR', 72462);
INSERT INTO shipment VALUES (10960624868941581, '8011616412161548973155', 'UPS', '27-APR-16', '135 G St', 'Little Rock', 'AR', 72713);

INSERT INTO credit_card VALUES (5863243221300457, 'American Express', 8764, 03, 19);
INSERT INTO credit_card VALUES (2363569869213103, 'MasterCard', 753, 08, 17);
INSERT INTO credit_card VALUES (3930503926653008, 'MasterCard', 306, 03, 21);
INSERT INTO credit_card VALUES (5172549466034258, 'Visa', 662, 03, 17);
INSERT INTO credit_card VALUES (6826103166061040, 'MasterCard', 211, 01, 18);
INSERT INTO credit_card VALUES (9948176206999766, 'Discover', 948, 07, 17);
INSERT INTO credit_card VALUES (4226466210959790, 'American Express', 7575, 02, 19);
INSERT INTO credit_card VALUES (4123709942448476, 'Visa', 034, 10, 19);
INSERT INTO credit_card VALUES (4222285416849372, 'Visa', 440, 08, 21);
INSERT INTO credit_card VALUES (1561054129271180, 'Visa', 961, 12, 17);
INSERT INTO credit_card VALUES (4066765931881071, 'Discover', 244, 07, 17);
INSERT INTO credit_card VALUES (4692462033475987, 'Visa', 720, 09, 19);
INSERT INTO credit_card VALUES (1648514673754709, 'Discover', 081, 04, 20);
INSERT INTO credit_card VALUES (4159934257927610, 'MasterCard', 039, 01, 20);
INSERT INTO credit_card VALUES (2364100294203998, 'American Express', 4552, 02, 18);
INSERT INTO credit_card VALUES (4450117646529611, 'Discover', 689, 10, 19);
INSERT INTO credit_card VALUES (6563914252556240, 'Discover', 641, 04, 21);
INSERT INTO credit_card VALUES (9379030724464347, 'Discover', 021, 04, 17);

INSERT INTO product_categorized_as VALUES ('0133970779', 283155);
INSERT INTO product_categorized_as VALUES ('0133970779', 5);
INSERT INTO product_categorized_as VALUES ('0133970779', 3652);
INSERT INTO product_categorized_as VALUES ('B00TSUGXKE', 172282);
INSERT INTO product_categorized_as VALUES ('B00TSUGXKE', 541966);
INSERT INTO product_categorized_as VALUES ('B014KP70F8', 172282);
INSERT INTO product_categorized_as VALUES ('B014KP70F8', 541966);
INSERT INTO product_categorized_as VALUES ('B014KP70F8', 2348628011);
INSERT INTO product_categorized_as VALUES ('B014KP70F8', 2348629011);
INSERT INTO product_categorized_as VALUES ('B014KP70F8', 3012929011);
INSERT INTO product_categorized_as VALUES ('B00IEYHMIM', 1055398);
INSERT INTO product_categorized_as VALUES ('B00IEYHMIM', 1063278);
INSERT INTO product_categorized_as VALUES ('B00IEYHMIM', 542938);
INSERT INTO product_categorized_as VALUES ('B00IEYHMIM', 3734911);
INSERT INTO product_categorized_as VALUES ('B00IEYHMIM', 509324);
INSERT INTO product_categorized_as VALUES ('B00KWFCSB2', 468642);
INSERT INTO product_categorized_as VALUES ('B00KWFCSB2', 8400376011);
INSERT INTO product_categorized_as VALUES ('B00KWFCSB2', 8400382011);
INSERT INTO product_categorized_as VALUES ('B00KWFCSB2', 8400392011);
INSERT INTO product_categorized_as VALUES ('B00IRVQ0F8', 172282);
INSERT INTO product_categorized_as VALUES ('B00IRVQ0F8', 541966);
INSERT INTO product_categorized_as VALUES ('B00IRVQ0F8', 3012292011);
INSERT INTO product_categorized_as VALUES ('B00IRVQ0F8', 3015427011);
INSERT INTO product_categorized_as VALUES ('B004RMK57U', 468642);
INSERT INTO product_categorized_as VALUES ('B004RMK57U', 14210751);
INSERT INTO product_categorized_as VALUES ('B004RMK57U', 7326756011);
INSERT INTO product_categorized_as VALUES ('B00ZB7QB1O', 5174);
INSERT INTO product_categorized_as VALUES ('B00ZB7QB1O', 37);
INSERT INTO product_categorized_as VALUES ('B01GUVOXIW', 2625373011);
INSERT INTO product_categorized_as VALUES ('B01GUVOXIW', 468374);
INSERT INTO product_categorized_as VALUES ('B01GUVOXIW', 14279371);
INSERT INTO product_categorized_as VALUES ('B01GUVOXIW', 14279381);
INSERT INTO product_categorized_as VALUES ('B00BKBCF38', 5174);
INSERT INTO product_categorized_as VALUES ('B00BKBCF38', 67207);
INSERT INTO product_categorized_as VALUES ('B00BKBCF38', 67215);
INSERT INTO product_categorized_as VALUES ('B00XUZBCVI', 468642);
INSERT INTO product_categorized_as VALUES ('B00XUZBCVI', 8400376011);
INSERT INTO product_categorized_as VALUES ('B00XUZBCVI', 8400377011);
INSERT INTO product_categorized_as VALUES ('B00XUZBCVI', 8400387011);
INSERT INTO product_categorized_as VALUES ('B01I5AI96S', 5174);
INSERT INTO product_categorized_as VALUES ('B01I5AI96S', 16);
INSERT INTO product_categorized_as VALUES ('B00N1G35MU', 2335752011);
INSERT INTO product_categorized_as VALUES ('B00N1G35MU', 2407760011);
INSERT INTO product_categorized_as VALUES ('B00N1G35MU', 3081461011);
INSERT INTO product_categorized_as VALUES ('B00N0YYGIU', 2335752011);
INSERT INTO product_categorized_as VALUES ('B00N0YYGIU', 2407755011);
INSERT INTO product_categorized_as VALUES ('B00N0YYGIU', 2407781011);
INSERT INTO product_categorized_as VALUES ('B01837LGGI', 7141123011);
INSERT INTO product_categorized_as VALUES ('B01837LGGI', 7147445011);
INSERT INTO product_categorized_as VALUES ('B01837LGGI', 2516784011);
INSERT INTO product_categorized_as VALUES ('B01837LGGI', 2516513011);
INSERT INTO product_categorized_as VALUES ('B018231PW8', 7141123011);
INSERT INTO product_categorized_as VALUES ('B018231PW8', 7147441011);
INSERT INTO product_categorized_as VALUES ('B018231PW8', 3887881);
INSERT INTO product_categorized_as VALUES ('B018231PW8', 3888081);
INSERT INTO product_categorized_as VALUES ('B01BFJ8JNO', 7141123011);
INSERT INTO product_categorized_as VALUES ('B01BFJ8JNO', 7147440011);
INSERT INTO product_categorized_as VALUES ('B01BFJ8JNO', 2474936011);
INSERT INTO product_categorized_as VALUES ('B01BFJ8JNO', 7072327011);
INSERT INTO product_categorized_as VALUES ('B01BFJ8JNO', 3420366011);
INSERT INTO product_categorized_as VALUES ('B016E448AS', 7141123011);
INSERT INTO product_categorized_as VALUES ('B016E448AS', 7147440011);
INSERT INTO product_categorized_as VALUES ('B016E448AS', 2474936011);
INSERT INTO product_categorized_as VALUES ('B016E448AS', 7072327011);
INSERT INTO product_categorized_as VALUES ('B016E448AS', 3420366011);
INSERT INTO product_categorized_as VALUES ('B00WL40SZ0', 7141123011);
INSERT INTO product_categorized_as VALUES ('B00WL40SZ0', 7147440011);
INSERT INTO product_categorized_as VALUES ('B00WL40SZ0', 2474936011);
INSERT INTO product_categorized_as VALUES ('B00WL40SZ0', 7072327011);
INSERT INTO product_categorized_as VALUES ('B00WL40SZ0', 3420366011);
INSERT INTO product_categorized_as VALUES ('B00B6T0EBY', 3760911);
INSERT INTO product_categorized_as VALUES ('B00B6T0EBY', 11060451);
INSERT INTO product_categorized_as VALUES ('B00B6T0EBY', 11060711);
INSERT INTO product_categorized_as VALUES ('B00B6T0EBY', 11062031);
INSERT INTO product_categorized_as VALUES ('B002RLW5VW', 3760911);
INSERT INTO product_categorized_as VALUES ('B002RLW5VW', 11060451);
INSERT INTO product_categorized_as VALUES ('B002RLW5VW', 11060711);
INSERT INTO product_categorized_as VALUES ('B002RLW5VW', 11061301);
INSERT INTO product_categorized_as VALUES ('B002RLW5VW', 7792272011);
INSERT INTO product_categorized_as VALUES ('B002RLW5VW', 7792274011);
INSERT INTO product_categorized_as VALUES ('B00GP21EOS', 7141123011);
INSERT INTO product_categorized_as VALUES ('B00GP21EOS', 7147440011);
INSERT INTO product_categorized_as VALUES ('B00GP21EOS', 679337011);
INSERT INTO product_categorized_as VALUES ('B00GP21EOS', 679380011);

INSERT INTO order_includes VALUES (11576494683395817, '0133970779');
INSERT INTO order_includes VALUES (10582090927795818, 'B00TSUGXKE');
INSERT INTO order_includes VALUES (10582090927795818, 'B014KP70F8');
INSERT INTO order_includes VALUES (10211679247601928, 'B00IEYHMIM');
INSERT INTO order_includes VALUES (10268269285029182, 'B00KWFCSB2');
INSERT INTO order_includes VALUES (10922019985938184, 'B00IRVQ0F8');
INSERT INTO order_includes VALUES (10925329490277833, 'B004RMK57U');
INSERT INTO order_includes VALUES (10887699913180235, 'B00ZB7QB1O');
INSERT INTO order_includes VALUES (10887699913180235, 'B01GUVOXIW');
INSERT INTO order_includes VALUES (10887699913180235, 'B00BKBCF38');
INSERT INTO order_includes VALUES (10887699913180235, 'B00XUZBCVI');
INSERT INTO order_includes VALUES (10819968231521832, 'B01I5AI96S');
INSERT INTO order_includes VALUES (10864849968079468, 'B00N1G35MU');
INSERT INTO order_includes VALUES (10864849968079468, 'B00N0YYGIU');
INSERT INTO order_includes VALUES (11390445781542559, 'B01837LGGI');
INSERT INTO order_includes VALUES (11390445781542559, 'B018231PW8');
INSERT INTO order_includes VALUES (11364702589494651, 'B01BFJ8JNO');
INSERT INTO order_includes VALUES (11364702589494651, 'B016E448AS');
INSERT INTO order_includes VALUES (11364702589494651, 'B00WL40SZ0');
INSERT INTO order_includes VALUES (11372144445484652, 'B00B6T0EBY');
INSERT INTO order_includes VALUES (11372144445484652, 'B002RLW5VW');
INSERT INTO order_includes VALUES (10960624868941581, 'B00GP21EOS');

INSERT INTO shipment_contains VALUES (11576494683395817, '9374889679090056195817', '0133970779');
INSERT INTO shipment_contains VALUES (10582090927795818, '1Z391BA50495713817', 'B00TSUGXKE');
INSERT INTO shipment_contains VALUES (10582090927795818, '1Z391BA50495713817', 'B014KP70F8');
INSERT INTO shipment_contains VALUES (10211679247601928, '9491889694817050183712', 'B00IEYHMIM');
INSERT INTO shipment_contains VALUES (10268269285029182, '9501895918510591759284', 'B00KWFCSB2');
INSERT INTO shipment_contains VALUES (10922019985938184, '438183910291', 'B00IRVQ0F8');
INSERT INTO shipment_contains VALUES (10887699913180235, '9274899993715907700300', 'B00ZB7QB1O');
INSERT INTO shipment_contains VALUES (10887699913180235, '9274899993715907700300', 'B01GUVOXIW');
INSERT INTO shipment_contains VALUES (10887699913180235, '9274899993715907700300', 'B00BKBCF38');
INSERT INTO shipment_contains VALUES (10887699913180235, '9274899993715907700300', 'B00XUZBCVI');
INSERT INTO shipment_contains VALUES (10819968231521832, '9216498623497922286843', 'B01I5AI96S');
INSERT INTO shipment_contains VALUES (10864849968079468, '9204573321254569895635', 'B00N1G35MU');
INSERT INTO shipment_contains VALUES (10864849968079468, '9204573321254569895635', 'B00N0YYGIU');
INSERT INTO shipment_contains VALUES (11390445781542559, '9015447836498785035478', 'B01837LGGI');
INSERT INTO shipment_contains VALUES (11390445781542559, '9015447836498785035478', 'B018231PW8');
INSERT INTO shipment_contains VALUES (11364702589494651, '9015482645648966518984', 'B01BFJ8JNO');
INSERT INTO shipment_contains VALUES (11364702589494651, '9015482645648966518984', 'B016E448AS');
INSERT INTO shipment_contains VALUES (11364702589494651, '9015482645648966518984', 'B00WL40SZ0');
INSERT INTO shipment_contains VALUES (11372144445484652, '9374881541651321654815', 'B00B6T0EBY');
INSERT INTO shipment_contains VALUES (11372144445484652, '9374881541651321654815', 'B002RLW5VW');
INSERT INTO shipment_contains VALUES (10960624868941581, '8011616412161548973155', 'B00GP21EOS');

INSERT INTO account_credit_cards VALUES ('npruss1@cub.uca.edu', 5863243221300457);
INSERT INTO account_credit_cards VALUES ('npruss1@cub.uca.edu', 2363569869213103);
INSERT INTO account_credit_cards VALUES ('npruss1@cub.uca.edu', 3930503926653008);
INSERT INTO account_credit_cards VALUES ('npruss1@cub.uca.edu', 5172549466034258);
INSERT INTO account_credit_cards VALUES ('npruss1@cub.uca.edu', 6826103166061040);
INSERT INTO account_credit_cards VALUES ('npruss1@cub.uca.edu', 9948176206999766);
INSERT INTO account_credit_cards VALUES ('jjohnson64@cub.uca.edu', 4226466210959790);
INSERT INTO account_credit_cards VALUES ('jjohnson64@cub.uca.edu', 4123709942448476);
INSERT INTO account_credit_cards VALUES ('jjohnson64@cub.uca.edu', 4222285416849372);
INSERT INTO account_credit_cards VALUES ('jjohnson64@cub.uca.edu', 1561054129271180);
INSERT INTO account_credit_cards VALUES ('jjohnson64@cub.uca.edu', 4066765931881071);
INSERT INTO account_credit_cards VALUES ('jjohnson64@cub.uca.edu', 4692462033475987);
INSERT INTO account_credit_cards VALUES ('esaezbarrios1@cub.uca.edu', 1648514673754709);
INSERT INTO account_credit_cards VALUES ('esaezbarrios1@cub.uca.edu', 4159934257927610);
INSERT INTO account_credit_cards VALUES ('esaezbarrios1@cub.uca.edu', 2364100294203998);
INSERT INTO account_credit_cards VALUES ('esaezbarrios1@cub.uca.edu', 4450117646529611);
INSERT INTO account_credit_cards VALUES ('esaezbarrios1@cub.uca.edu', 6563914252556240);
INSERT INTO account_credit_cards VALUES ('esaezbarrios1@cub.uca.edu', 9379030724464347);

INSERT INTO order_paid_with VALUES (11576494683395817, 9948176206999766);
INSERT INTO order_paid_with VALUES (10582090927795818, 6826103166061040);
INSERT INTO order_paid_with VALUES (10211679247601928, 5172549466034258);
INSERT INTO order_paid_with VALUES (10268269285029182, 5863243221300457);
INSERT INTO order_paid_with VALUES (10922019985938184, 3930503926653008);
INSERT INTO order_paid_with VALUES (10819968231521832, 4692462033475987);
INSERT INTO order_paid_with VALUES (10864849968079468, 4066765931881071);
INSERT INTO order_paid_with VALUES (11390445781542559, 4159934257927610);
INSERT INTO order_paid_with VALUES (11364702589494651, 6563914252556240);
INSERT INTO order_paid_with VALUES (11372144445484652, 4159934257927610);
INSERT INTO order_paid_with VALUES (10960624868941581, 1648514673754709);

INSERT INTO order_gift_cards VALUES (11576494683395817, 'M1YNFT29EU8ZLMM');
INSERT INTO order_gift_cards VALUES (10582090927795818, '4T6RN86PDAJK8EM');
INSERT INTO order_gift_cards VALUES (10211679247601928, 'M1YNFT29EU8ZLMM');
INSERT INTO order_gift_cards VALUES (10922019985938184, 'KE42MSOS2JBE93T');
INSERT INTO order_gift_cards VALUES (10925329490277833, 'SNTHLJJ4RV2GSN9');
INSERT INTO order_gift_cards VALUES (10887699913180235, 'KW4TWVJ9KVOAQH0');
INSERT INTO order_gift_cards VALUES (10819968231521832, 'KW4TWVJ9KVOAQH0');
INSERT INTO order_gift_cards VALUES (10864849968079468, 'LLWPNBGDGV7E4EP');
INSERT INTO order_gift_cards VALUES (11390445781542559, 'JYS9XMPV165YF2L');
INSERT INTO order_gift_cards VALUES (11364702589494651, 'RR0FEXIN1R3LHEO');
INSERT INTO order_gift_cards VALUES (11372144445484652, 'RR0FEXIN1R3LHEO');
INSERT INTO order_gift_cards VALUES (10960624868941581, 'RR0FEXIN1R3LHEO');

INSERT INTO account_gift_cards VALUES ('npruss1@cub.uca.edu', '4T6RN86PDAJK8EM');
INSERT INTO account_gift_cards VALUES ('npruss1@cub.uca.edu', 'KE42MSOS2JBE93T');
INSERT INTO account_gift_cards VALUES ('npruss1@cub.uca.edu', 'M1YNFT29EU8ZLMM');
INSERT INTO account_gift_cards VALUES ('jjohnson64@cub.uca.edu', 'SNTHLJJ4RV2GSN9');
INSERT INTO account_gift_cards VALUES ('jjohnson64@cub.uca.edu', 'D8UL5RC09Y4VAZO');
INSERT INTO account_gift_cards VALUES ('jjohnson64@cub.uca.edu', 'LLWPNBGDGV7E4EP');
INSERT INTO account_gift_cards VALUES ('jjohnson64@cub.uca.edu', 'KW4TWVJ9KVOAQH0');
INSERT INTO account_gift_cards VALUES ('jjohnson64@cub.uca.edu', 'SOGQYV1PUYSA47O');
INSERT INTO account_gift_cards VALUES ('jjohnson64@cub.uca.edu', 'HFGOED7MWIDH5CY');
INSERT INTO account_gift_cards VALUES ('esaezbarrios1@cub.uca.edu', 'RR0FEXIN1R3LHEO');
INSERT INTO account_gift_cards VALUES ('esaezbarrios1@cub.uca.edu', 'ZKYG3LUMZRZNPDV');
INSERT INTO account_gift_cards VALUES ('esaezbarrios1@cub.uca.edu', 'JYS9XMPV165YF2L');
INSERT INTO account_gift_cards VALUES ('esaezbarrios1@cub.uca.edu', 'ZJ23A2LF0N6DG9O');

INSERT INTO account_addresses VALUES ('npruss1@cub.uca.edu', '367 W Ave', 'Little Rock', 'AR', 72418);
INSERT INTO account_addresses VALUES ('npruss1@cub.uca.edu', '978 L Ave', 'Conway', 'AR', 72632);
INSERT INTO account_addresses VALUES ('npruss1@cub.uca.edu', '353 E Dr', 'Little Rock', 'AR', 72310);
INSERT INTO account_addresses VALUES ('npruss1@cub.uca.edu', '260 L Dr', 'Conway', 'AR', 72628);
INSERT INTO account_addresses VALUES ('npruss1@cub.uca.edu', '576 P St', 'Conway', 'AR', 72976);
INSERT INTO account_addresses VALUES ('npruss1@cub.uca.edu', '551 O Ave', 'Little Rock', 'AR', 72569);
INSERT INTO account_addresses VALUES ('jjohnson64@cub.uca.edu', '511 B St', 'North Little Rock', 'AR', 72386);
INSERT INTO account_addresses VALUES ('jjohnson64@cub.uca.edu', '919 Y St', 'Conway', 'AR', 72341);
INSERT INTO account_addresses VALUES ('jjohnson64@cub.uca.edu', '956 Y Dr', 'Little Rock', 'AR', 72939);
INSERT INTO account_addresses VALUES ('jjohnson64@cub.uca.edu', '582 C Dr', 'Little Rock', 'AR', 72436);
INSERT INTO account_addresses VALUES ('jjohnson64@cub.uca.edu', '846 J Ave', 'Conway', 'AR', 72286);
INSERT INTO account_addresses VALUES ('esaezbarrios1@cub.uca.edu', '416 U Ave', 'North Little Rock', 'AR', 72317);
INSERT INTO account_addresses VALUES ('esaezbarrios1@cub.uca.edu', '187 F Ave', 'Little Rock', 'AR', 72438);
INSERT INTO account_addresses VALUES ('esaezbarrios1@cub.uca.edu', '135 G St', 'Little Rock', 'AR', 72713);
INSERT INTO account_addresses VALUES ('esaezbarrios1@cub.uca.edu', '736 P Dr', 'Little Rock', 'AR', 72312);
INSERT INTO account_addresses VALUES ('esaezbarrios1@cub.uca.edu', '829 U Rd', 'Little Rock', 'AR', 72685);
INSERT INTO account_addresses VALUES ('esaezbarrios1@cub.uca.edu', '995 I Rd', 'Little Rock', 'AR', 72462);

/* Add the foreign keys. */

ALTER TABLE category
ADD CONSTRAINT category_subcategory_of_fk
FOREIGN KEY (Subcategory_Of) REFERENCES category (Category_ID);

ALTER TABLE review
ADD CONSTRAINT review_written_by_fk
FOREIGN KEY (Written_By) REFERENCES account (Email);

ALTER TABLE review
ADD CONSTRAINT review_written_about_fk
FOREIGN KEY (Written_About) REFERENCES product (ASIN);

ALTER TABLE orders
ADD CONSTRAINT orders_placed_by_fk
FOREIGN KEY (Placed_By) REFERENCES account (Email);

ALTER TABLE shipment
ADD CONSTRAINT shipment_order_number_fk
FOREIGN KEY (Order_Number) REFERENCES orders (Order_Number);

ALTER TABLE product_categorized_as
ADD CONSTRAINT product_cat_as_asin_fk
FOREIGN KEY (Product_ASIN) REFERENCES product (ASIN);

ALTER TABLE product_categorized_as
ADD CONSTRAINT product_cat_as_catid_fk
FOREIGN KEY (Category_ID) REFERENCES category (Category_ID);

ALTER TABLE order_includes
ADD CONSTRAINT order_includes_ordno_fk
FOREIGN KEY (Order_Number) REFERENCES orders (Order_Number);

ALTER TABLE order_includes
ADD CONSTRAINT order_includes_asin_fk
FOREIGN KEY (Product_ASIN) REFERENCES product (ASIN);

ALTER TABLE shipment_contains
ADD CONSTRAINT shipment_cont_ordno_trkno_fk
FOREIGN KEY (Order_Number, Tracking_Number) REFERENCES shipment (Order_Number, Tracking_Number);

ALTER TABLE shipment_contains
ADD CONSTRAINT shipment_cont_asin_fk
FOREIGN KEY (Product_ASIN) REFERENCES product (ASIN);

ALTER TABLE account_credit_cards
ADD CONSTRAINT account_ccs_email_fk
FOREIGN KEY (Account_Email) REFERENCES account (Email);

ALTER TABLE account_credit_cards
ADD CONSTRAINT account_ccs_cardno_fk
FOREIGN KEY (Credit_Card_Number) REFERENCES credit_card (Card_Number);

ALTER TABLE order_paid_with
ADD CONSTRAINT order_paid_with_ordno_fk
FOREIGN KEY (Order_Number) REFERENCES orders (Order_Number);

ALTER TABLE order_paid_with
ADD CONSTRAINT order_paid_with_cardno_fk
FOREIGN KEY (Credit_Card_Number) REFERENCES credit_card (Card_Number);

ALTER TABLE order_gift_cards
ADD CONSTRAINT order_gcs_ordno_fk
FOREIGN KEY (Order_Number) REFERENCES orders (Order_Number);

ALTER TABLE account_gift_cards
ADD CONSTRAINT account_gcs_email_fk
FOREIGN KEY (Account_Email) REFERENCES account (Email);

ALTER TABLE account_addresses
ADD CONSTRAINT account_addrs_email_fk
FOREIGN KEY (Account_Email) REFERENCES account (Email);