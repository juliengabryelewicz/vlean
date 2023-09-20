module category

import infrastructure.state

pub fn index(st state.State, query map[string]string, category_slug string) string {

    mut page:=query["page"].int()

    if page == 0 {
        page = 1
    }

    return st.di.category_usecase.usecase_show_category(category_slug, page)
}