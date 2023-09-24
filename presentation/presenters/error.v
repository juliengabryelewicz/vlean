module presenters

pub struct ErrorPresenter {
    default_presenter DefaultPresenter
}

pub fn (error_presenter ErrorPresenter) to_html(message string) string {
    
    categories_layout:= error_presenter.default_presenter.categories
    title := message
    
    content := $tmpl('../web/error/index.html')
	base := $tmpl('../web/layout.html')
    
    return base
}