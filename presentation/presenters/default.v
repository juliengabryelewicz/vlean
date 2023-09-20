module presenters

import domain.entities

pub struct DefaultPresenter {
    pub:
        categories []entities.Category
}