{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- Internship Portal Sample Data\
-- Created by Khawla Alneyadi\
\
USE internship_portal;\
\
-- Users\
INSERT INTO users (name, email, password, role) VALUES\
('Alice Student', 'alice@student.com', 'password123', 'student'),\
('Bob Student', 'bob@student.com', 'password123', 'student'),\
('Admin User', 'admin@portal.com', 'admin123', 'admin');\
\
-- Companies\
INSERT INTO companies (name, industry, website) VALUES\
('TechVision', 'Software', 'https://techvision.com'),\
('EduSmart', 'Education', 'https://edusmart.com'),\
('HealthCare Inc', 'Healthcare', 'https://healthcare.com');\
\
-- Internships\
INSERT INTO internships (company_id, title, description, location) VALUES\
(1, 'Java Developer Intern', 'Assist in building web apps with Java and SQL.', 'Abu Dhabi'),\
(2, 'Data Analyst Intern', 'Work with datasets, Weka, and ML models.', 'Dubai'),\
(3, 'Web Designer Intern', 'Design front-end interfaces using HTML/CSS.', 'Al Ain');\
\
-- Applications\
INSERT INTO applications (user_id, internship_id, status) VALUES\
(1, 1, 'pending'),\
(2, 2, 'pending'),\
(1, 3, 'accepted');\
\
-- Reviews\
INSERT INTO reviews (user_id, company_id, rating, comment) VALUES\
(1, 1, 5, 'Great experience, learned a lot about Java.'),\
(2, 2, 4, 'Good environment, but workload was heavy.'),\
(1, 3, 5, 'Friendly mentors and flexible schedule.');\
}