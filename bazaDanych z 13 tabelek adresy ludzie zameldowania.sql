﻿/*Baza danych dla ewidencki mieszkańców.*/

/*use Northwind
drop database AdresowanieLudzi
create database AdresowanieLudzi
use AdresowanieLudzi*/

--1 oznaczenie adresów określamy czy ulica, czy plac czy co.
create table RodzajeMiejscowek(IdRodzajeMiejscowek int PRIMARY KEY IDENTITY(1,1),
NazwaMiejscowki VarChar (20),
NazwaMiejscowkiDoWyswietlenia NvarChar (30))
CONSTRAINT UC_RodzajeMiejscowek UNIQUE (NazwaMiejscowki,NazwaMiejscowkiDoWyswietlenia)
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
create table NazwyAdresowe(IdNazwyAdresowe int PRIMARY KEY IDENTITY(1,1), 
WpisyNazwAdresowych NOT NULL UNIQUE NvarChar (30))
INSERT INTO NazwyAdresowe VALUES
(N''),/*np. dla wiosek*/
(N'kard. Stefana Wyszyńskiego'),
(N'Litewska');

--3 kody pocztowe
create table KodyPocztowe(IdKodyPocztowe int PRIMARY KEY IDENTITY(1,1), 
NazwyKoduPocztowego NOT NULL UNIQUE  VARCHAR (12))
INSERT INTO KodyPocztowe
('59-400'),
('99-999');
create table Miejscowosci(IdMiejscowosci int PRIMARY KEY IDENTIFIED(1,1), 
NazwyMiejscowosci NOT NULL UNIQUE NvarChar (30))
INSERT INTO Miejscowosci
(N'Jawor'),
(N'Kraków'),
(N'Zębowice'),
(N'Wetlina'),
(N'Warszawa'),
(N'Wrocław'),
(N'Łódź');

--4 województwa
create table Wojewodztwa(IdWojewodztwa int PRIMARY KEY IDENTIFIED(1,1), 
NnarChar NOT NULL UNIQUE (20))
INSERT INTO Wojewodztwa
(N'DolnyoŚląskie'),
(N'Opolskie'),
(N'Śląskie'),
(N'Łudzkie'),
(N'Mazowiedzkie'),
(N'Lubuskie'),
(N'Lubelskie'),
(N'Podkarpackie'),
(N'Warmińsko-Mazurskie'),
(N'Zachodnio-Pomorskie'),
(N'Pomorskie'),
(N'Kujawsko-Pomorskie'),
(N'Podlaskie'),
(N'Świętokrzyskie'),
(N'Wielkopolskie'),
(N'Małopolskie');

--5 Lokacja czyli ulica; plac; aleja w konkretnym miejscu. Jeżeli ulica zmienia nazwę, zmienia się tylko IdNazwyAdresowe
create table LokacjeAdresowe(IdLokacjeAdresowe int PRIMARY KEY IDENTITY(1,1),
IdKodyPocztowe int, 
IdNazwyAdresowe int)
CONSTRAINT UC_LokacjeAdresowe UNIQUE (IdKodyPocztowe,IdNazwyAdresowe)

INSERT INTO LokacjeAdresowe
(1,2),
(2,3);

--6 Budynki położenie georgraficzne dla google maps to 2 cyfry stopni kąta kropka i chyba ułamek dzieśętny w ośmu cyfrach ja dodałem jeszcze jeden znaczek na dodatkowy opis jeśli ewentualnie developerowi będzie potrzebny
create table Budynki(IdBudynki int PRIMARY KEY IDENTITY(1,1),
IdLokacjeAdresowe int, 
NrBudynkow int, 
DlugosciGeograficzneGoogle VARCHAR(12),
SzerokosciGeograficzneGoogle VARCHAR(12))
CONSTRAINT UC_Budynki UNIQUE (IdLokacjeAdresowe,NrBudynkow)

INSERT INTO Budynki
(1,20,null,null),
(2,10,null,null);

--7 Mieszkania jedna osoba może wpisać swoją klatkę dużą literą, druga małą, a to będzie to soamo mieszkanie więc wpisy są zachowane a ich interprteacja może być przeprowadzana w dowolnym momencie działania aplikacji.
create table Mieszkania(IdMieszkan int PRIMARY KEY IDENTITY(1,1),
IdBudynki int, 
NrMieszkaniaWpis NVarChar(10), 
NrMieszkaniaInt int, 
NrKlatek int NULL)
CONSTRAINT UC_Mieszkania UNIQUE (IdBudynki,NrMieszkaniaWpis)

INSERT INTO Mieszkana
(1,'c/13',13,2),
(2,'26',26,null);

--8 Meldunki Można mieć tylko po jednym czyli stałym i czasowym. Więc trzeba byłoby narzucić klucz na IdOsoby i CzyStaleZameldowanie.
create table Meldunki(IdMeldunkow int, 
IdMieszkan int, 
IdOsoby int, 
DatyZameldowan DATE NOT NULL,
DatyWymeldowan DATE NULL,
CzyStaleZameldowanie BOOLEAN)
 CONSTRAINT UC_Meldunki UNIQUE (IdOsoby,CzyStaleZameldowanie)

--9 osoby. Pesel występuje tylko w 11. cyfrach jednak rekomendowane jest zapisywanie go w varchar nie mam pojęcia dlaczego.
create table Osoby(IdOsoby int PRIMARY KEY IDENTITY(1,1), 
PESEL NOT NULL UNIQUE int)
 
--10 imiona pierwsze, grugie, dziesiąte
create table Imiona(Imiona int PRIMARY KEY IDENTITY(1,1), 
NazwaImienia NOT NULL UNIQUE NVarChar(20))
INSERT INTO NazwiskaPojedyncze
(N'Merkury'),
(N'Aleksandra'),
(N'Anna'),
(N'Wioletta');
--11 NazwiskaPojedyncze plus spacja i myślnik jako jeden z nazwisk żeby Curuś Bachleda i Solorz-Żak się nie obrazili
create table NazwiskaPojedyncze(IdNazwiskaPojedyncze int PRIMARY KEY IDENTITY(1,1), 
NazwyNazwiskPojedynczych NOT NULL UNIQUE NVarChar(30)) 
INSERT INTO NazwiskaPojedyncze
(N' '),
(N'-'),
(N'Piekałkiewicz'),
(N'Curuś'),
(N'Bachleda'),
(N'Soloż'),
(N'Żak'),
(N'Nowak'),
(N'Kowalski'),
(N'Capanidis');

--12 Żeby można było mieć imion więcej niż jedno a NrImion mówi które to imie
create table OsobyImiona(IdOsby int PRIMARY KEY IDENTITY, 
IdImiona int, 
NrImion int)
CONSTRAINT UC_OsobyImiona UNIQUE (IdImiona,IdNazwiskaPojedyncze)

--13 Żeby można było mieć nazwiska wieloczłonowe to jedno tzw. nawzisko będzie ' ', a drugie '-', NrNazwiska mówi które to nazwisko danej osoby
create table OsobyNazwiskaPojedyncze( IdOsoby int, 
IdNazwiskaPojedyncze int, 
NrNazwisk int)
 CONSTRAINT UC_OsobyNazwiskaPojedyncze UNIQUE (IdOsoby,IdNazwiskaPojedyncze)

 --14 Zdrobnienia. Gdyby ktoś podawał zdrobnienie we wpisie to nich rejestrator osoby proponuje formę nie zdrobnioną
crate table Zdrobnienia (IdZdrobnienia int PRIMARY KEY IDENTITY(1,1), 
IdImiona int, 
NazwaZdrobnienia NOT NULL UNIQUE NvarChar(20))
INSERT INTO Zdrobnienia 
(1,N'Meruś'),
(1,N'Merek'),
(2,N'Ola'),
(2,N'Olunia'),
(3,N'Ania'),
(3,N'Anula'),
(3,N'Aneczka'),
(4,N'Wiola'),
(4,N'Wiolunia');