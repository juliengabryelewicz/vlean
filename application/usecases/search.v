module usecases

import domain.repositories
import presentation.presenters

pub struct SearchUsecase {
    presenter presenters.SearchPresenter
    repository repositories.PostRepository
}

pub fn (usecase SearchUsecase) usecase_show_search(q string, page int) string {

    posts := usecase.repository.get_all_posts_from_search(q, page) or {panic(err)}

    posts_count := usecase.repository.get_count_posts_from_search(q) or { 0 }

    return usecase.presenter.to_html(posts, posts_count, q, page)
}