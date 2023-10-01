module presenters

import domain.entities

pub struct SearchPresenter {
    default_presenter DefaultPresenter
}

pub fn (home_presenter SearchPresenter) to_html(posts []entities.Post, posts_count int, q string, page int) string {

    posts_content:=posts.clone()

    categories_layout:= home_presenter.default_presenter.categories

    mut link_after :=""
    mut content_link_after :=""
    mut link_before :=""
    mut content_link_before :=""
    title := "Vlean - Search for "+q

    if page > 1 {
        link_before='/search?q=' + q + '&page=' + (page-1).str()
        content_link_before= $tmpl('../web/partials/_link_before.html')
    }

    if posts_count > (page * 3) {
        link_after='/search?q=' + q + '&page=' + (page+1).str()
        content_link_after= $tmpl('../web/partials/_link_after.html')
    }

	content := $tmpl('../web/search/index.html')
	base := $tmpl('../web/layout.html')

    return base
}