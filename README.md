# Companion backend app

## What and why
This is the backend part of a fullstack application. The full app is like AirBnB, but for renting out peoples' time instead of spaces. For example, a user can book someone to spend 4 hours with them. This app is inspired by the "loneliness industy" in Japan, where patrons - namely men - rent out a young woman's time for a couple of hours. The men usually request that the woman pretend to be their significant other, although there is no physicality. While I don't think this is the ideal solution to a loneliness epidemic, I do see this is a tool some will wish to utilize as this trend continues.

## Technology

Python & Postgres with a Flask API created with the SQLAlchemy ORM

## Steps to replicated

1. create a database called "companion" in pgadmin
2. use the SQL query tool to run the SQL found in the following two files:
   - ./sql/create-tables.sql
   - ./sql/seed-db.sql
3. ensure you have the required python packages installed in your environment (see requirements.txt and docker-compose.yml)

4) Start the API by executing "flask run" in ./flask/companion

## Database dump

A database dump created by pg_dump can be found in ./data

## Insomnia API Endpoint Export

An export of the test calls to the various API endpoints can be found at ./insomnia/insomnia-companion-export.json

## Entity relationship diagrams

Two entity relationship diagrams - one build with drawio and one auto-generated via gpadmin's ERD Tool - can be found in ./erd

# Limitations & Shortcomings

Here are a list of limitations/failures I had with this project

- No 1-1 or many-to-many relationships implemented
- Limited number of tables designed (I could not finish my full database schema in time)
- No data visualization component
- No database migration implemented (I tried but gave up)
- I never learned how to get SQLAlchemy to easily build and rebuild my schema, so I ended up using raw SQL alongside SQLAlchemy in development
- No index generated

# Notes

I got the API working, which I was happy about. I began to learn more about pgadmin and docker by doing this project, although I still have massive gaps in my conceptual understanding. The relationship between user_account and companion is good, with the cascade on deletion working correctly. Deleting a companion will not delete a user_account, but deleting a user_account will delete the correlative companion, if one exists.

This portfolio project was extremely challenging for me. Unlike my python project, I found very little joy in it. I think this has to do with the amount of "ad hoc" tooling involved. Everytime I stepped away from the project it took me a long time to get back into it. There are so many different tools and terminal commands, and so many ways to break or wrongly implement them. It required a lot of trial and error. This is one way to learn, but it's not enjoyable. I also had to keep looking back at the class notes, which are not easily accessed, because they are laid out in a small, non-descript fashion in the daskboard.

Ideally, we would not work with an ORM, and would instead work on raw SQL and create an API without an ORM. This is my second time using an ORM (the first is Sequelize via Node.js). The documentation is horrible for both, and the abstraction of the SQL makes understanding the table relationships complex and unwieldy. Most of my hours were spent trying to understand SQLAlchemy.
