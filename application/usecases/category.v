module usecases

import domain.repositories
import domain.entities
import presentation.presenters

pub struct CategoryUsecase {
    presenter presenters.CategoryPresenter
    error_presenter presenters.ErrorPresenter
    repository repositories.CategoryRepository
    post_repository repositories.PostRepository
}

pub fn (usecase CategoryUsecase) usecase_show_category(category_slug string, page int) string {

    category := usecase.repository.get_category(category_slug) or { panic(err) }

    if category == entities.Category{} {
        return usecase.error_presenter.to_html('Category not found')
    }
    
    posts := usecase.post_repository.get_all_posts_from_category(category.id, page) or { panic(err) }

    posts_count := usecase.post_repository.get_count_posts_from_category(category.id) or { panic(err) }

    return usecase.presenter.to_html(category, posts, posts_count, page)
}