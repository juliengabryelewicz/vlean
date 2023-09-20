module home

import infrastructure.state

pub fn index(st state.State, query map[string]string) string {

    mut page:=query["page"].int()

    if page == 0 {
        page = 1
    }

    return st.di.home_usecase.usecase_show_home(page)
}