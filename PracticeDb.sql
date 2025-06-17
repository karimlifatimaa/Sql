create table Items(
    ItemID INTEGER PRIMARY KEY ,
    ItemName VARCHAR(255),
    Category VARCHAR(100),
    Cost DECIMAL(10,2)
);

create table Purchases (
    PurchaseID INTEGER primary key ,
    BuyerName VARCHAR(255),
    PurchaseDate DATE
);

create table PurchaseDetails (
    DetailID integer primary key ,
    PurchaseID  integer not null ,
    ItemID integer not null ,
    Amount integer,
    TotalCost decimal(10,2),
    foreign key (PurchaseID) references Purchases(PurchaseID),
    foreign key (ItemID) references Items(ItemID)
);

insert into Items (ItemID, ItemName, Category, Cost) values
(1, 'Laptop', 'Electronics', 1200.00),
(2, 'Headphones', 'Electronics', 150.00),
(3, 'Desk Chair', 'Furniture', 300.00),
(4, 'Notebook', 'Stationery', 5.50);

insert into Purchases (PurchaseID, BuyerName, PurchaseDate) values
(1, 'Fatime Kerimli', '2025-06-17'),
(2, 'Elvin Huseynov', '2025-06-16'),
(3, 'Leyla Mehdiyeva', '2025-06-15');

insert into PurchaseDetails(detailid, purchaseid, itemid, amount, totalcost) values
(1,2,3,2,600),
(2,1,2,1,150),
(3,3,4,3,16.50),
(4,3,1,1,1200);

select * from Items;
select * from purchases;
select * from PurchaseDetails;

--1
select * from Items order by Cost desc ;

--2
select it.Category, sum(pd.TotalCost)
from items it inner join PurchaseDetails pd on it.ItemID = pd.ItemID
group by it.Category;

--3
select PU.PurchaseID ,  PU.BuyerName , sum(PD.TotalCost) as total_cost
from Purchases PU
inner join PurchaseDetails PD on PU.PurchaseID = PD.PurchaseID
group by PU.PurchaseID, PU.BuyerName ;

--4
select category, min(Cost) as  min_cost , max(Items.Cost) as max_cost from items
group by category;

--5
select PU.purchaseid , PU.buyername , sum(PD.TotalCost) from purchases PU
inner join PurchaseDetails PD on PU.PurchaseID = PD.purchaseid
group by PU.purchaseid
having sum(pd.totalcost) > 1000;

--6
select pu.buyername, I.itemname , PD.amount from purchases pu
inner join PurchaseDetails PD on pu.PurchaseID = PD.PurchaseID
inner join Items I on I.ItemID = PD.ItemID ;

create table CustomersTest (
    CustomerID int primary key ,
    CustomerName varchar(255)
);

create table PaymentsTest (
    PaymentID int primary key ,
    CustomerID int ,
    PaymentAmount decimal(10,2)
);

insert into CustomersTest (CustomerID, CustomerName) values
(1, 'Fatime Kerimli'),
(2, 'Elvin Huseynov'),
(3, 'Leyla Mehdiyeva');

insert into PaymentsTest (PaymentID, CustomerID, PaymentAmount) values
(1, 1, 150.00),
(2, 2, 200.00),
(3, 4, 300.00);

select CT.CustomerName , PT.paymentid , PT.PaymentAmount from customerstest CT
full outer join PaymentsTest PT on CT.CustomerID = PT.CustomerID;

select CT.CustomerName , PT.paymentid , PT.PaymentAmount from customerstest CT
left join PaymentsTest PT on CT.CustomerID = PT.CustomerID;

select CT.CustomerID, CT.CustomerName , PT.paymentid , PT.PaymentAmount from customerstest CT
right join PaymentsTest PT on CT.CustomerID = PT.CustomerID;


