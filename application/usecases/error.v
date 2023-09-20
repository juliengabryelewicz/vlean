module usecases

import presentation.presenters

pub struct ErrorUsecase {
    presenter presenters.ErrorPresenter
}

pub fn (usecase ErrorUsecase) usecase_show_error(message string) string {

    return usecase.presenter.to_html(message)
}