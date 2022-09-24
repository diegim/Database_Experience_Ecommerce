
CREATE DATABASE Ecommerce;
USE Ecommerce;

CREATE TABLE clients(
	IDclient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
    constraint CPFunique unique (CPF)
    );

CREATE TABLE product(
	IDproduct int auto_increment primary key,
    Productname varchar(10) not null,
    ClassificationKids bool default False,
    Category enum('Electronics', 'Clothing', 'Toys', 'Food', 'Furniture') not null,
    Rating float default(0),
    Size varchar(20)
    );
    
CREATE TABLE payments(
	IDclientpayment int primary key,
    IDpayment int primary key,
    TypePayment enum('Credit Card', 'Debit Card'),
    LimitAvailable float
    );

CREATE TABLE orders(
	IDorder int auto_increment primary key,
    IDclientinOrder int,
    OrderStatus enum('Canceled','Confirmed','Processing') default 'Processing',
    OrderDescription varchar(255),
    ShippingCost float default 10,
	Payment int,
    constraint fk_idclientinorder foreign key (IDclientinorder) references clients (IDclient)
    );
    
CREATE TABLE productstorage(
	IDprodstorage int auto_increment primary key,
    Storagelocation varchar(255),
    Quantity int default(0)
    );
    
CREATE TABLE supplier(
	IDsupplier int auto_increment primary key,
    Suppliername  varchar(255) not null,
    CNPJ char(15) not null,
    SupplierPhone char(11) not null,
    constraint CNPJuniquesupplier unique (CNPJ)
    );

CREATE TABLE seller(
	IDseller int auto_increment primary key,
    Sellername varchar(255) not null,
    CNPJ char(15) not null,
    CPF char(11) not null,
    Location varchar(255),
    Sellerphone char(11) not null,
    constraint CNPJuniqueseller unique (CNPJ),
    constraint CPFuniqueseller unique (CPF)
    );
    
CREATE TABLE productSeller(
	IDseller int,
    IDproduct int,
    ProdQuantity int default 1,
    primary key (IDseller, IDproduct),
    constraint fk_product_seller foreign key (IDseller) references seller(IDseller),
    constraint fk_product_product foreign key (IDproduct) references product(IDproduct)
    );

CREATE TABLE productOrder(
	IDPOproduct int,
    IDPOorder int,
    POquantity int default 1,
    POstatus enum ('Available', 'Out of stock'),
    primary key (IDPOproduct, IDPOorder),
    constraint fk_productorder_seller foreign key (IDPOproduct) references product(IDproduct),
    constraint fk_productorder_product foreign key (IDPOproduct) references orders(IDorder)
    );
    
CREATE TABLE storagelocation(
	IDLproduct int,
    IDLstorage int,
    Location varchar(255) not null,
    primary key (IDLproduct, IDLstorage),
    constraint fk_storage_location_product foreign key (IDLproduct) references product(IDproduct),
    constraint fk_storage_location_storage foreign key (IDLproduct) references productstorage(IDprodstorage)
    );

CREATE TABLE productsupplier(
	IDPSsupplier int,
    IDPSproduct int,
    Quantity int not null,
    primary key (IDPSsupplier, IDPSproduct),
    constraint fk_product_supplier_supplier foreign key (IDPSsupplier) references supplier(IDsupplier),
    constraint fk_product_supplier_product foreign key (IDPSproduct) references product(IDproduct)
    );
    
 
    
    
