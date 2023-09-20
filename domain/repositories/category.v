module repositories

import domain.entities
import infrastructure.db

pub struct CategoryRepository {
    database db.Db
}


pub fn (repository CategoryRepository) get_category(category_slug string) !entities.Category {

    rows := repository.database.db.exec_param('
    select id, title, text, slug
    from Category
    where is_visible=true
    and slug = ?
    order by time desc', category_slug)!

    if rows.len == 0 {
        return entities.Category{}
    }
    
    category := entities.Category {
        id: rows[0].vals[0].int()
        title: rows[0].vals[1]
        text: rows[0].vals[2]
        slug: rows[0].vals[3]
    }

	return category

}


pub fn (repository CategoryRepository) get_categories() ![]entities.Category {

    rows := repository.database.db.exec('
    select id, title, text, slug
    from Category
    where is_visible=true
    order by title desc')!

	mut categories := []entities.Category{}
	for row in rows {
		id := row.vals[0]
		categories << entities.Category{
			id: id.int()
            title: row.vals[1]
            text: row.vals[2]
            slug: row.vals[3]
		}
	}
	return categories

}
