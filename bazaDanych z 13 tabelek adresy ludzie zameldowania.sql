/*Baza danych dla ewidencki mieszkańców.*/

/*use Northwind
drop database AdresowanieLudzi
create database AdresowanieLudzi
use AdresowanieLudzi*/

--1 oznaczenie adresów określamy czy ulica, czy plac czy co.
create table RodzajeMiejscowek(IdRodzajeMiejscowek int PRIMARY KEY IDENTITY(1,1),NazwaMiejscowki VarChar (20),NazwaMiejscowkiDoWyswietlenia NvarChar (30))
INSERT INTO RodzajeMiejscowek VALUES
('ulica','ul.'),
('plac','pl.'),
('plac bez skrótu','plac'),
('skwer','skwer'),
('przy ulicy we wiosce',''),
('aleja','aleja'),
('aleje','Aleje'),
('rynek','Rynek'),
('osiedle','osiedle');
('rondo','rondo');

--2 oznaczenie nazw żeby nie było różnic związanych z literówkami albo jadna ulica kard. Wyszyńskiego a druga w innym mieście ks. kard. Stefana Wyszyńskiego.
create table NazwyAdresowe(IdNazwyAdresowe PRIMARY KEY IDENTITY(1,1),NvarChar (30))
INSERT INTO NazwyAdresowe VALUES
(''),/*np. dla wiosek*/
('kard. Stefana Wyszyńskiego'),
('Litewska');

--3 kody pocztowe
create table KodyPocztowe(IdKodyPocztowe PRIMARY KEY IDENTITY(1,1), NazwyKoduPocztowego VARCHAR (12))
INSERT INTO KodyPocztowe
('59-400');
create table Miejscowosci(IdMiejscowosci PRIMARY KEY IDENTIFIED(1,1), NazwyMiejscowosci NvarChar (30))
INSERT INTO Miejscowosci
('Jawor'),
('Kraków'),
('Zębowice'),
('Wetlina'),
('Warszawa'),
('Wrocław'),
('Łódź');

--4 województwa
create table Wojewodztwa(IdWojewodztwa PRIMARY KEY IDENTIFIED(1,1), NnarChar (20))
INSERT INTO Wojewodztwa
('DolnyoŚląskie'),
('Opolskie'),
('Śląskie'),
('Łudzkie'),
('Mazowiedzkie'),
('Lubuskie'),
('Lubelskie'),
('Podkarpackie'),
('Warmińsko-Mazurskie'),
('Zachodnio-Pomorskie'),
('Pomorskie'),
('Kujawsko-Pomorskie'),
('Podlaskie'),
('Świętokrzyskie'),
('Wielkopolskie'),
('Małopolskie');

--5 Lokacja czyli ulica; plac; aleja w konkretnym miejscu. Jeżeli ulica zmienia nazwę zmienia się tylko IdNazwyAdresowe
create table LokacjeAdresowe(IdLokacjeAdresowe PRIMARY KEY IDENTITY(1,1),IdKodyPocztowe INTEGER, IdNazwyAdresowe INTEGER)
INSERT INTO LokacjeAdresowe
(1,2),
(''),
(''),
(''),
('');

--6 Budynki
create table Budynki(IdBudynki PRIMARY KEY IDENTITY(1,1),IdLokacjeAdresowe INTEGER, NrBudynkow INTEGER, DlugosciGeograficzne INTEGER,
SzerokosciGeograficzne INTEGER )
INSERT INTO Budynki
(1,20,null,null);
--7 Mieszkania
create table Mieszkania(IdMieszkan PRIMARY KEY IDENTITY(1,1),IdBudynki INTEGER, NrMieszkan NVarChar(10))
INSERT INTO Mieszkania
(1,'c/13');

--8 Meldunki
create table Meldunki(IdMeldunkow PRIMARY KEY IDENTITY(1,1), IdOsby INTEGER, DatyZameldowan DATE NOT NULL,DatyWymeldowan DATE NULL,CzyStaleZameldowanie BOOLEAN)

--9 osoby
create table Osoby(IdOsoby INTEGER, PESEL INTEGER)

--10 imiona pierwsze, grugie, dziesiąte
create table Imiona(IdImiona INTEGER, NazwaImienia NVarChar(20))
INSERT INTO NazwiskaPojedyncze
('Merkury'),
('Aleksandra'),
('Anna'),
('Wioletta');
--11 NazwiskaPojedyncze plus spacja i myślnik jako jeden z nazwisk żeby Curuś Bachleda i Solorz-Żak się nie obrazili
create table NazwiskaPojedyncze(IdNazwiskaPojedyncze INTEGER, NazwyNazwiskPojedynczych NVarChar(30)) 
INSERT INTO NazwiskaPojedyncze
(' '),
('-'),
('Piekałkiewicz'),
('Curuś'),
('Bachleda'),
('Soloż'),
('Żak'),
('Nowak'),
('Kowalski'),
('Capanidis');

--12 Żeby można było mieć imion więcej niż jedno
create table OsobyImiona(IdOsby INTEGER, IdImiona INTEGER)

--13 Żeby można było mieć nazwiska wieloczłonowe to jedno tzw. nawzisko będzie ' ', a drugie '-'
create table OsobyNazwiskaPojedyncze( IdOsoby INTEGER, IdNazwiskaPojedyncze INTEGER )
