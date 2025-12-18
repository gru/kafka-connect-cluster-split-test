-- =========================
-- Create databases
-- =========================
CREATE DATABASE src;
CREATE DATABASE dst;

-- =========================
-- SRC tables
-- =========================
\connect src

CREATE TABLE tbl1  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl2  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl3  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl4  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl5  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl6  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl7  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl8  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl9  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl10 (id INT PRIMARY KEY, name VARCHAR(255));

-- =========================
-- DST tables
-- =========================
\connect dst

CREATE TABLE tbl1  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl2  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl3  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl4  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl5  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl6  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl7  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl8  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl9  (id INT PRIMARY KEY, name VARCHAR(255));
CREATE TABLE tbl10 (id INT PRIMARY KEY, name VARCHAR(255));

