module post

import infrastructure.state

pub fn index(st state.State, article_slug string) string {
    return st.di.post_usecase.usecase_show_post(article_slug)
}