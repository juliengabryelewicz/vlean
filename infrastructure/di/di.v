module di

import application.usecases
import domain.repositories
import presentation.presenters
import infrastructure.db

pub struct Di {
    pub:
	    category_usecase usecases.CategoryUsecase
        category_presenter presenters.CategoryPresenter
        category_repository repositories.CategoryRepository
	    home_usecase usecases.HomeUsecase
        home_presenter presenters.HomePresenter
	    post_usecase usecases.PostUsecase
        post_presenter presenters.PostPresenter
        post_repository repositories.PostRepository
	    error_usecase usecases.ErrorUsecase
        error_presenter presenters.ErrorPresenter
}

pub fn generate_di(database db.Db) Di {

    category_repository := repositories.CategoryRepository { database }
    post_repository := repositories.PostRepository { database }

    default_presenter := presenters.DefaultPresenter { category_repository.get_categories() or { [] } }
    post_presenter := presenters.PostPresenter { default_presenter }
    home_presenter := presenters.HomePresenter { default_presenter }
    category_presenter := presenters.CategoryPresenter { default_presenter }
    error_presenter := presenters.ErrorPresenter { default_presenter }

    error_usecase := usecases.ErrorUsecase { error_presenter }
    category_usecase := usecases.CategoryUsecase { category_presenter, error_presenter, category_repository, post_repository }
    home_usecase := usecases.HomeUsecase { home_presenter, post_repository }
    post_usecase := usecases.PostUsecase { post_presenter, error_presenter, post_repository }

    return Di {
        category_presenter : category_presenter
        category_usecase : category_usecase
        category_repository : category_repository
        home_presenter : home_presenter
        home_usecase : home_usecase
        post_presenter : post_presenter
        post_usecase : post_usecase
        post_repository : post_repository
        error_presenter : error_presenter
        error_usecase : error_usecase
    }
}