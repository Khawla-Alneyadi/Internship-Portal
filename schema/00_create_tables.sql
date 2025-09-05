{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- Internship Portal Database Schema\
-- Created by Khawla Alneyadi\
\
CREATE DATABASE IF NOT EXISTS internship_portal;\
USE internship_portal;\
\
-- Users table: students + admins\
CREATE TABLE users (\
    user_id INT AUTO_INCREMENT PRIMARY KEY,\
    name VARCHAR(100) NOT NULL,\
    email VARCHAR(100) UNIQUE NOT NULL,\
    password VARCHAR(255) NOT NULL,\
    role ENUM('student', 'admin') DEFAULT 'student',\
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\
);\
\
-- Companies table\
CREATE TABLE companies (\
    company_id INT AUTO_INCREMENT PRIMARY KEY,\
    name VARCHAR(150) NOT NULL,\
    industry VARCHAR(100),\
    website VARCHAR(150),\
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP\
);\
\
-- Internships table\
CREATE TABLE internships (\
    internship_id INT AUTO_INCREMENT PRIMARY KEY,\
    company_id INT NOT NULL,\
    title VARCHAR(150) NOT NULL,\
    description TEXT,\
    location VARCHAR(100),\
    posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\
    FOREIGN KEY (company_id) REFERENCES companies(company_id) ON DELETE CASCADE\
);\
\
-- Applications table\
CREATE TABLE applications (\
    application_id INT AUTO_INCREMENT PRIMARY KEY,\
    user_id INT NOT NULL,\
    internship_id INT NOT NULL,\
    status ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending',\
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,\
    FOREIGN KEY (internship_id) REFERENCES internships(internship_id) ON DELETE CASCADE\
);\
\
-- Reviews table\
CREATE TABLE reviews (\
    review_id INT AUTO_INCREMENT PRIMARY KEY,\
    user_id INT NOT NULL,\
    company_id INT NOT NULL,\
    rating INT CHECK (rating BETWEEN 1 AND 5),\
    comment TEXT,\
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,\
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,\
    FOREIGN KEY (company_id) REFERENCES companies(company_id) ON DELETE CASCADE\
);\
}