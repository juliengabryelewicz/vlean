module usecases

import domain.repositories
import presentation.presenters

pub struct HomeUsecase {
    presenter presenters.HomePresenter
    repository repositories.PostRepository
}

pub fn (usecase HomeUsecase) usecase_show_home(page int) string {

    posts := usecase.repository.get_all_posts(page) or {panic(err)}

    posts_count := usecase.repository.get_count_posts() or { 0 }

    return usecase.presenter.to_html(posts, posts_count, page)
}