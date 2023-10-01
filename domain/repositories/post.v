module repositories

import domain.entities
import infrastructure.db

import time

pub struct PostRepository {
    database db.Db
}

pub fn (repository PostRepository) get_all_posts(page int) ![]entities.Post {

    rows := repository.database.db.exec_param_many('
    select id, title, text, slug, time
    from Post
    where is_visible=1
    order by time desc
    limit ?, ?', [((page-1)*3).str(), '3'])!

	mut posts := []entities.Post{}
	for row in rows {
		id := row.vals[0]
		posts << entities.Post{
			id: id.int()
            title: row.vals[1]
            text: row.vals[2]
            slug: row.vals[3]
            time: time.unix(row.vals[4].int())
		}
	}
	return posts

}


pub fn (repository PostRepository) get_all_posts_from_category(category_id int, page int) ![]entities.Post {

    rows := repository.database.db.exec_param_many('
    select id, title, text, slug, time
    from Post
    where is_visible=1
    and category_id = ?
    order by time desc
    limit ?, ?', [category_id.str(), ((page-1)*3).str(), '3'])!

	mut posts := []entities.Post{}
	for row in rows {
		id := row.vals[0]
		posts << entities.Post{
			id: id.int()
            title: row.vals[1]
            text: row.vals[2]
            slug: row.vals[3]
            time: time.unix(row.vals[4].int())
		}
	}
	return posts

}

pub fn (repository PostRepository) get_all_posts_from_search(q string, page int) ![]entities.Post {

    rows := repository.database.db.exec_param_many("
    select id, title, text, slug, time
    from Post
    where is_visible=1
    and text LIKE '%${q}%'
    order by time desc
    limit ?, ?", [((page-1)*3).str(), '3'])!

	mut posts := []entities.Post{}
	for row in rows {
		id := row.vals[0]
		posts << entities.Post{
			id: id.int()
            title: row.vals[1]
            text: row.vals[2]
            slug: row.vals[3]
            time: time.unix(row.vals[4].int())
		}
	}
	return posts

}

pub fn (repository PostRepository) get_count_posts() !int {

    rows := repository.database.db.exec('
    select count(*)
    from Post
    where is_visible=1
    order by time desc')!

    if rows.len == 0 {
        return 0
    } else {
        return rows[0].vals[0].int()
    }

}


pub fn (repository PostRepository) get_count_posts_from_category(category_id int) !int {

    rows := repository.database.db.exec_param('
    select count(*)
    from Post
    where is_visible=1
    and category_id = ?
    order by time desc', category_id.str())!

    if rows.len == 0 {
        return 0
    } else {
        return rows[0].vals[0].int()
    }

}

pub fn (repository PostRepository) get_count_posts_from_search(q string) !int {

    rows := repository.database.db.exec("
    select count(*)
    from Post
    where is_visible=1
    and text LIKE '%${q}%'
    order by time desc")!

    if rows.len == 0 {
        return 0
    } else {
        return rows[0].vals[0].int()
    }

}

pub fn (repository PostRepository) get_post_from_slug(post_slug string) !entities.Post {

    rows := repository.database.db.exec_param('
    select id, title, text, time
    from Post
    where is_visible=1
    and slug = ?
    order by time desc', post_slug)!

    if rows.len == 0 {
        return entities.Post{}
    }

    post := entities.Post {
        id: rows[0].vals[0].int()
        title: rows[0].vals[1]
        text: rows[0].vals[2]
        time: time.unix(rows[0].vals[3].int())
    }

	return post

}
