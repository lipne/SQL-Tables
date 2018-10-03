/*Baza danych dla aplikacji dla międzynarodowej szkoły średniej przedstawiającej plany lekcji dla wszystkich klas wcałej historii szkoły w zdefiniowanych językach. Zakładamy, że co roku plan lekcji zmianiał się dla każdej klasy.*/

/*use Northwind
drop database PlanyLekcyjne
create database PlanyLekcyjne
use PlanyLekcyjne*/

--Słownik 
create table Jezyki(IdJezyki int PRIMARY KEY IDENTITY(1,1), 
OjczystaNazwaJezyka NvarChar (20) not null, 
AngielskaNazwaJezyka Varchar (20))

INSERT INTO Jezyki VALUES
('Polski','Polish'),
('English','English');

--Z uwagi na synomimy homonimy i inne podawane w dwuch
create table Pojecia(IdPojecia int  PRIMARY KEY IDENTITY(1,1) , 
PolsaNazwaSlowa NvarChar (30) not null, 
AngielskaNazwaSlowa NvarChar (30))

INSERT INTO Pojecia VALUES
(N'poniedziałek', N'monday'),  
(N'wtorek',N'tuesday'),
(N'środa',N'wednesday'),
(N'czwartek',N'thursday'),
(N'piątek',N'friday'),
(N'J. polski',N'Polish'),
(N'Matematyka',N'Math'),
(N'Biologia',N'Biology'),
(N'Fizyka',N'Physics'),
(N'J. Angielski',N'English'),
(N'W-F',null),
(N'WOS',null),
(N'Przysposobienie Obronne',null),
(N'zamek',N'castle'),
(N'zamek',N'zippr');

create table PrzetlumaczonePojecia(IdPrzetlumaczonePojecia int IDENTITY(1,1) unique,
IdJezyki int references Jezyki(IdJezyki) not null, 
IdPojecia int references Pojecia(IdPojecia) not null,
Tlumaczenia NVarchar (30) not null
PRIMARY KEY (IdJezyki,IdPojecia));

INSERT INTO PrzetlumaczonePojecia VALUES
(1,1,'poniedziałek'),
(1,2,'wtorek'),
(1,3,'środa'),
(1,4,'czwartek'),
(1,5,'piątek'),
(2,1,'monday'),
(2,2,'tuesday'),
(2,3,'wednesday'),
(2,4,'thursday'),
(2,5,'friday');

create table DniTygodnia(IdDniTygodnia int primary key IDENTITY(1,1) ,
IdPojecia int references Pojecia(IdPojecia) not null unique) 
INSERT INTO DniTygodnia values
(1),
(2),
(3),
(4),
(5);

create table Godziny(IdGodziny int primary key IDENTITY(1,1), 
OznaczenieCyfrowe VarChar(20))

INSERT INTO Godziny values
('8:00	8:45'),
('8:55	9:40'),
('9:50	10:35'),
('10:45	11:30'),
('11:40	12:25'),
('12:40	13:25'),
('13:40	14:25'),
('14:35	15:20'),
('15:30	16:15'),
('16:25	17:10');

create table KomorkiPlanowLekcji(IdKomorkiPlanowLekjcji int IDENTITY(1,1) not null unique,
IdGodziny int references Godziny(IdGodziny) not null , 
IdDniTygodnia int references DniTygodnia(IdDniTygodnia) not null
PRIMARY KEY (IdGodziny,IdDniTygodnia))

--select * KomorkiPlanowLekcji 

INSERT INTO KomorkiPlanowLekcji values
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(1,2),
(2,2),
(4,2),
(5,2),
(1,3),
(2,3),
(3,3),
(4,3),
(5,3),
(1,4),
(2,4),
(3,4),
(4,4);

--Klasy
create table Roczniki(IdRoczniki int IDENTITY(1,1) not null unique, 
RokRozpoczeciaNaukiKlasy int not null,
RokWSzkole int not null
PRIMARY KEY (RokRozpoczeciaNaukiKlasy,RokWSzkole))
INSERT INTO Roczniki values
(2017,1),
(2016,2),
(2015,3),
(2014,4),
(1991,4);

create table OznaczeniaKlas(IdOznaczeniaKlas int IDENTITY(1,1) not null unique,
OznaczenieKlasy Nvarchar (15) not null 
PRIMARY KEY (OznaczenieKlasy))
INSERT INTO OznaczeniaKlas values
('A'),
('B'),
('C'),
('D'),
('E'),
('F'),
('A mat-fiz'),
('C bio-chem');

 create table Klasy(IdKlasy int IDENTITY(1,1) not null unique,
 IdRoczniki int references Roczniki(IdRoczniki) not null, 
 IdOznaczeniaKlas int references OznaczeniaKlas(IdOznaczeniaKlas) not null
 PRIMARY KEY (IdRoczniki,IdOznaczeniaKlas))
INSERT INTO Klasy values
(1,1),
(1,2),
(1,3),
(1,5),
(1,6),
(2,1),
(2,2),
(2,3),
(2,4),
(2,5),
(5,7),
(5,2),
(5,8),
(5,4),
(5,5);

create table WpisyWKomorkiPlanowLekcji(IdWpisyWKomorkiPlanowLekcji int IDENTITY(1,1) unique not null, 
IdKlasy int references Klasy(IdKlasy), 
IdPojecia int references Pojecia(IdPojecia), --Wpisywane będą dopiero po przetłumaczeniu. Jednak tutaj są składowane same pojecia, aby niepotrzebnie nie powtarzać dla każego języka
IdKomorkiPlanowLekcji int references KomorkiPlanowLekcji(IdKomorkiPlanowLekjcji)
PRIMARY KEY (IdKlasy,IdPojecia,IdKomorkiPlanowLekcji));

INSERT INTO WpisyWKomorkiPlanowLekcji VALUES
(1,7,1),
(1,8,2),
(1,12,3),
(1,8,4),
(1,9,5),
(1,10,6),
(1,11,7),
(1,7,8),
(1,12,9),
(1,11,10),
(1,10,11),
(1,11,12),
(1,13,13),
(1,12,14),
(1,8,15),
(1,9,16),
(1,11,17),
(1,12,18),
(1,8,19);
