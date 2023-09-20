module state

import infrastructure.di
import infrastructure.db

pub struct State {
    pub:
	    di di.Di
}

pub fn generate_state() State {

    database := db.generate_db()

    database.create_tables()

    return State {
        di : di.generate_di(database)
    }
}