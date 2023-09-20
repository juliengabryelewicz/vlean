module db

import os

import db.mysql
import domain.entities
import thomaspeissl.dotenv

pub struct Db {
    pub:
	    db mysql.DB
}

pub fn generate_db() Db {

    dotenv.load()

    configuration := mysql.Config{
        username: os.getenv('VLEAN_USERNAME')
        password: os.getenv('VLEAN_PASSWORD')
        dbname: os.getenv('VLEAN_DBNAME')
    }

    return Db {
        db : mysql.connect(configuration) or { panic(err) }
    }
}

pub fn (db Db) create_tables() {

	sql db.db {
		create table entities.Post
	} or { panic(err) }

	sql db.db {
		create table entities.Category
	} or { panic(err) }

}