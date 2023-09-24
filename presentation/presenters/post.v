module presenters

import domain.entities

pub struct PostPresenter {
    default_presenter DefaultPresenter
}

pub fn (post_presenter PostPresenter) to_html(post entities.Post) string {

    post_content := post

    categories_layout:= post_presenter.default_presenter.categories
    title := post.title

	content := $tmpl('../web/post/index.html')
	base := $tmpl('../web/layout.html')

    return base
}