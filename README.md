# **Companion backend app**

## **What and why**

This is the backend part of a fullstack application. The full app is like AirBnB, but for renting out peoples' time instead of spaces. For example, a user can book someone to spend 4 hours with them. This app is inspired by the "loneliness industy" in Japan, where patrons - namely men - rent out a young woman's time for a couple of hours. The men usually request that the woman pretend to be their significant other, although there is no physicality. While I don't think this is the ideal solution to a loneliness epidemic, I do see this is a tool some will wish to utilize as this trend continues.

## **Technology**

Python & Postgres with a Flask API created with the SQLAlchemy ORM

## **Steps to replicated**

1. create a database called "companion" in pgadmin
2. use the SQL query tool to run the SQL found in the following two files:
   - `./sql/create-tables.sql`
   - `./sql/seed-db.sql`
3. ensure you have the required python packages installed in your environment (see `requirements.txt` and `docker-compose.yml`)

4) Start the API by executing `flask run` in `./flask/companion`

## **Retrospective**

1. **How did the project's design evolve over time?**
   Initially it was just user accounts, companions, and patrons. But then I extended it to include sexual orientations, meetings, cities, and countries. I never ended up implementing the latter, though. The aforementioned tables were only designed at the ERD stage, as well as in raw SQL schemas.

2. **Did you choose to use an ORM or raw SQL? Why?**
	To be honest I don't think I definitely chose either. I ended up using both because I wasn’t unable to understand how to correctly use SQLAlchemy and psycopg2. Had I known how, I would have just used SQLAlchemy and psycopg2 to generate my full database and seed it. Instead, I wrote all my tables in both SQL, and I wrote models for the user_account, companion, and patron tables in python via SQLAlchemy. In development I generated my database and injected the seeds using the raw SQL. I wish to avoid ORMs when possible. Their documentation is horrible and trying to understand how to implement table relationships within them is dreadful.

3. **What future improvements are in store, if any?**
   Yes, definitely. I have build some of the fullstack app in Node.js and Sequelize as the ORM. I think I will continue with that, but I might move from MySQL to Postgres, as I like the pgadmin GUI over MySQL Workbench. I enjoy working with python, but SQLAlchemy is just as bad as Sequelize when it comes to documentation and troubleshooting.

Meetings will be the hardest relationships to implement, because a meeting must belong to both one and only one companion and one and only one user.

## **API Endpoints Reference**

**Dev base_url: localhost:5000**

### **User_Account Table**

| METHOD | NAME               | PATH                                                     | RESULT                                           |
| ------ | ------------------ | -------------------------------------------------------- | ------------------------------------------------ |
| GET    | get all users      | base_url/users                                           | returns all recrods from the user_account table  |
| GET    | get single-user    | base_url/users/<span style="color:lightgreen">{id}<span> | returns single record based on id parameter      |
| POST   | create single user | base_url/users                                           | creates a new record based on valid JSON request |
| DELETE | delete single user | base_url/users/<span style="color:lightgreen">{id}<span> | deletes a record based on id parameter           |

Example of a valid post request:

```
{
  "email":"a@g.com",
  "password":"@my_secret_password_123",
  "phone_number":"9991234563",
  "birthday":"1999-06-06"
}
```

### **Companion Table**

| METHOD | NAME                    | PATH                                                          | RESULT                                           |
| ------ | ----------------------- | ------------------------------------------------------------- | ------------------------------------------------ |
| GET    | get all companions      | base_url/companions                                           | returns all recrods from the companion table     |
| GET    | get single companion    | base_url/companions/<span style="color:lightgreen">{id}<span> | returns single record based on id parameter      |
| POST   | create single companion | base_url/companions                                           | creates a new record based on valid JSON request |
| DELETE | delete single companion | base_url/companions/<span style="color:lightgreen">{id}<span> | deletes a record based on id parameter           |

Example of a valid post request:

```
{
	"name":"Sabrina",
    "sex":"female",
	"user_id": 4,
	"sexual_orientation_id": 1,
	"city_id": 1
}
```

### **Patron Table**

| METHOD | NAME                 | PATH                                                      | RESULT                                           |
| ------ | -------------------- | --------------------------------------------------------- | ------------------------------------------------ |
| GET    | get all patrons      | base_url/patron                                           | returns all recrods from the patron table        |
| GET    | get single patron    | base_url/patron/<span style="color:lightgreen">{id}<span> | returns single record based on id parameter      |
| POST   | create single patron | base_url/patron                                           | creates a new record based on valid JSON request |
| DELETE | delete single patron | base_url/patron/<span style="color:lightgreen">{id}<span> | deletes a record based on id parameter           |

Example of a valid post request:

```
{
	"name":"Adrian",
    "sex":"male",
	"user_id": 3,
	"city_id": 3
}
```

## **Database Dump**

A database dump created by pg_dump can be found in `./data`

## **Insomnia API Endpoint Export**

An export of the test calls to the various API endpoints can be found at `./insomnia/insomnia-companion-export.json`

## **Entity Relationship Diagrams**

Two entity relationship diagrams - one build with drawio and one auto-generated via gpadmin's ERD Tool - can be found in `./erd`

# **Limitations & Shortcomings**

Here are a list of limitations/failures I had with this project

- No 1-1 or many-to-many relationships implemented
- Limited number of tables designed (I could not finish my full database schema in time)
- No data visualization component
- No database migration implemented (I tried but gave up)
- I never learned how to get SQLAlchemy to easily build and rebuild my schema, so I ended up using raw SQL alongside SQLAlchemy in development
- No index generated
- No PATCH/PUT endpoints

# **Successes**

- [✔️] learned a little about docker
- [✔️] got API working
- [✔️] cascade deletion logic between user_accounts and other tables is sound
- [✔️] validation of email within user_account model
- [✔️] hashing of password within user_account model

# **Notes**

This portfolio project was extremely challenging for me. Unlike my python project, I found very little joy in it. I think this has to do with the amount of "ad hoc" tooling involved. Everytime I stepped away from the project it took me a long time to get back into it. There are so many different tools and terminal commands, and so many ways to break or wrongly implement them. It required a lot of trial and error. This is one way to learn, but it's not enjoyable. I also had to keep looking back at the class notes, which are not easily accessed, because they are laid out in a small, nondescript fashion in the daskboard.

Ideally, we would not work with an ORM, and would instead work on raw SQL and create an API without an ORM. This is my second time using an ORM (the first is Sequelize via Node.js). The documentation is horrible for both, and the abstraction of the SQL makes understanding the table relationships complex and unwieldy. Most of my hours were spent trying to understand SQLAlchemy.
