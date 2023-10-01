module routes

import vweb
import application.controllers.category
import application.controllers.error
import application.controllers.home
import application.controllers.post
import application.controllers.search
import infrastructure.state

pub struct App {
	vweb.Context
	state state.State = state.generate_state()
}

['/'; get]
pub fn (mut app App) index() ?vweb.Result {
	result := home.index(app.state, app.query)
	return app.html(result)
}

['/post/:post_slug'; get]
pub fn (mut app App) post(post_slug string) ?vweb.Result {
	result := post.index(app.state, post_slug)
	return app.html(result)
}

['/search'; get]
pub fn (mut app App) search() ?vweb.Result {
	result := search.index(app.state, app.query)
	return app.html(result)
}

['/category/:category_slug'; get]
pub fn (mut app App) category(category_slug string) ?vweb.Result {
	result := category.index(app.state, app.query, category_slug)
	return app.html(result)
}

pub fn (mut app App) not_found() ?vweb.Result {
    app.set_status(404, 'Not Found')
	result := error.index(app.state, 'Page not found')
    return app.html(result)
}