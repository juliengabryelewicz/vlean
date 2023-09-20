module entities

import time

pub struct Post {
	id int [primary; sql: serial]
    pub:
        category_id int
        title string [nonull]
        text string [sql_type: 'TEXT']
        slug string [nonull]
        is_visible bool
        time time.Time
}