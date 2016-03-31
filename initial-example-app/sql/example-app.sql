--Setup database
DROP DATABASE IF EXISTS akkaexampleapp;
CREATE DATABASE akkaexampleapp;
\c akkaexampleapp;

-- User Table
DROP TABLE IF EXISTS StoreUser;
CREATE TABLE StoreUser(
    id serial PRIMARY KEY,
    firstName varchar(100) NOT NULL,
    lastName varchar(100) NOT NULL,
    email varchar(100) NOT NULL,
    createTs timestamp NOT NULL,
    modifyTs timestamp NOT NULL DEFAULT current_timestamp
);

-- Book Table
DROP TABLE IF EXISTS Book;
CREATE TABLE Book(
    id serial PRIMARY KEY,
    title varchar(100) NOT NULL,
    author varchar(100) NOT NULL,
    cost decimal(10,2) NOT NULL DEFAULT 0.0,
    inventoryAmount INT NOT NULL DEFAULT 0,
    createTs timestamp NOT NULL,
    modifyTs timestamp NOT NULL DEFAULT current_timestamp
);

-- Book Tags Table
DROP TABLE IF EXISTS BookTag;
CREATE TABLE BookTag(
    bookId serial references Book(id),
    tag varchar(100) NOT NULL,
    PRIMARY KEY(bookId, tag)
);

-- Sales Order Header Table
DROP TABLE IF EXISTS SalesOrderHeader;
CREATE TABLE SalesOrderHeader(
    id serial PRIMARY KEY,
    userId INT NOT NULL REFERENCES StoreUser(id),
    totalCost decimal(10,2) NOT NULL,
    createTs timestamp NOT NULL,
    modifyTs timestamp NOT NULL DEFAULT current_timestamp
);

-- Sales Order Line Item Table
DROP TABLE IF EXISTS SalesOrderLineItem;
CREATE TABLE SalesOrderLineItem(
    id serial PRIMARY KEY,
    orderId int NOT NULL REFERENCES SalesOrderHeader(id),
    bookId int NOT NULL REFERENCES Book(id),
    quantity int NOT NULL,
    cost decimal(10,2) NOT NULL,
    createTs timestamp NOT NULL,
    modifyTs timestamp NOT NULL DEFAULT current_timestamp
);

