module search

import infrastructure.state

pub fn index(st state.State, query map[string]string) string {

    mut page:=query["page"].int()
    q:=query["q"]

    if page == 0 {
        page = 1
    }

    return st.di.search_usecase.usecase_show_search(q, page)
}