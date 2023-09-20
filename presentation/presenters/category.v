module presenters

import domain.entities

pub struct CategoryPresenter {
    default_presenter DefaultPresenter
}

pub fn (category_presenter CategoryPresenter) to_html(category entities.Category, posts []entities.Post, posts_count int, page int) string {
    
    posts_content:=posts.clone()

    categories_layout:= category_presenter.default_presenter.categories

    mut link_after :=""
    mut content_link_after :=""
    mut link_before :=""
    mut content_link_before :=""

    if page > 1 {
        link_before='/category/' + category.slug + '?page=' + (page-1).str()
        content_link_before= $tmpl('../web/partials/_link_before.html')
    }

    if posts_count > (page * 3) {
        link_after='/category/' + category.slug + '?page=' + (page+1).str()
        content_link_after= $tmpl('../web/partials/_link_after.html')
    }

    content := $tmpl('../web/category/index.html')
	base := $tmpl('../web/layout.html')
    
    return base
}