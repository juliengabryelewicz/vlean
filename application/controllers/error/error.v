module error

import infrastructure.state

pub fn index(st state.State, message string) string {
    return st.di.error_usecase.usecase_show_error(message)
}