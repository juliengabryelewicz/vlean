module entities

import time

pub struct Category {
    pub:
        id int    [primary; sql: serial]
        title string [nonull]
        text string [sql_type: 'TEXT']
        slug string [nonull]
        is_visible bool
        time time.Time
        posts []Post [fkey: 'category_id']
}