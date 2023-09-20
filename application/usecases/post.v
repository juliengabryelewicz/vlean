module usecases

import domain.entities
import domain.repositories
import presentation.presenters

pub struct PostUsecase {
    presenter presenters.PostPresenter
    error_presenter presenters.ErrorPresenter
    repository repositories.PostRepository
}

pub fn (usecase PostUsecase) usecase_show_post(post_slug string) string {

    post := usecase.repository.get_post_from_slug(post_slug) or { panic(err) }

    if post == entities.Post{} {
        return usecase.error_presenter.to_html('Post not found')
    }

    return usecase.presenter.to_html(post)
}