# File Management App

## Table of contents
- [Task Description](#task-description)
- [Set up guide](#set-up-guide)
- [How to use](#how-to-use)
- [Design choices](#design-choices)
- [Further improvements](#further-improvements)


## Task description
You will be required to create a Ruby on Rails / Typescript application with the following features below. The sample CSV data required for the test can be found in the project's root directory in test_data.csv.

Below is a list of user stories and requirements for each section of this application. 
### PART 1 
1. As a user, I should be able to upload this sample CSV and import the data into a database. 

**IMPORTER REQUIREMENTS**
a. The data needs to load into 3 tables. People, Locations and Affiliations. 
b. Person can belong to many Locations.
c. Person can belong to many Affiliations.
d. Person without an Affiliation should be skipped .
e. Person should have both a first_name and last_name. All fields need to be validated except for last_name, weapon and vehicle which are optional. 
f. Names and Locations should all be titlecased .

### PART 2 
1. As a user, I should be able to view these results from the importer in a table. 
2. As a user, I should be able to paginate through the results so that I can see a maximum of 10 results at a time. 
3. As a user, I want to type in a search box so that I can filter the results I want to see. 
4. As a user, I want to be able to click on a table column heading to reorder the visible results. 


## Set up guide
To follow this setup guide you should already have Ruby, Rails, RVM, Git, and Postgres installed. I built the project in a linux environment but the commands will be similar or the same on any machine.  

1. To setup first clone the [back-end git repository](https://github.com/AJLandry1000000000/file-management-backend) using the following:  
```git clone https://github.com/AJLandry1000000000/file-management-backend.git```  

2. Set your Ruby version to 3.4.1 using the Ruby Version Manager (RVM):  
```rvm use 3.4.1```  

3. Install the required gems. In the project root directory run:  
```bundle install```  

4. We now need to run our postgres service and create the database.  
    4a. Ensure that the postgres service is running (this command may be different for your machine):  
    ```sudo service postgresql start```  
    (Optional) You can now check the service status with: ```service postgresql status```  
    4b. Now create a ```.env``` file in your project's root directory. The ```.env``` should look something like the following (with your details substituted):  
    ```
        DB_NAME="file_management_backend_development"
        DB_HOST="localhost"
        DB_MY_USER="YOUR-DB-USER-NAME-HERE"
        DB_MY_PASSWORD="YOUR-DB-USER-PASSWORD-HERE" 
        DB_PORT="5432" 
        ENV="dev"
    ```
    Note: The database user you provide must already be a user in your Postgres service and they need database creation privileges. 
    4c. Create the database:  
    ```rails db:create```  
    4d. Finally, run the migrations to create our schema:  
    ```rails db:migrate```

5. With the database set up, you're ready to run the backend:
```rails server```


## How to use
Once you have got the [front-end](https://github.com/AJLandry1000000000/file-management-frontend) set up and running, you can use the application by going to: http://localhost:5173/  
Upload a file, such as the test_data.csv, then filter by Affiliation or Location by selecting them in the dropdown lists.  
You can then sort the people by selecting a column in the data grid (default sorting is by first name).  
Move through the pages with the page buttons at the bottom (data is paginated to show 10 items per page).


## Design choices
### Why React (Typescript) + Rails + Postgres?
I picked my technologies to emulate what I thought Decidr.ai would most likely have. That being Typescript and Rails. I decided to decouple the front-end and back-end since it is standard for large projects due to its scalability, flexibility, and performance options as opposed to using a full stack Rails application with embedded Typescript (though this may be the case at Decidr.ai. I haven't had a technical interview yet.).
My back-end uses Rails and my front-end uses React with Typescript.

Postgres is often used in large projects over other RDS options like SQLite3 so I chose this as it seemed most likely to be in the Decidr stack (also I like Postgres).
### Data validation
The CSV file must have a first name, species, and gender. Records without an affiliation are skipped.  
All record data must be alpha-numeric and can have hyphens, apostrophes, and spaces. All other characters are removed from the cell string. The cell string is then stripped of trailing/leading spaces and the first character is made uppercase.  

The CSV processing is done in the [back-end](https://github.com/AJLandry1000000000/file-management-backend) ```app/services/csv_importer.rb``` file.  


## Further improvements
If I kept adding features I would:
- Add more information on Locations and Affiliations in the CSV, then adjust the CSV processing and database to store them.
- Create additional grids for Location and Affiliation, if I added more Location and Affiliation data, I could display this data in the other grids.
- Add multi-location/multi-affiliation filtering with multi-column sorting. Currently filtering is simple, allowing only one location and affiliation at a time, and one column sorting at a time. Adding more of these, combined with multi-column sorting would give users much more control of which records they wanted to view. 
- Add a test suite for TDD.
- If the application where to scale to a point that it had massive amounts of data, pagination should be done on the back-end. Currently all the data is being given to the front-end at once to paginate and sort. This works fine if we have small amount of data. But for large amounts of data, passing data over in chunks is much better so the front-end doesn't get throttled.
