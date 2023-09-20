module main

import os
import vweb
import application.routes

const (
	http_port = 8081
)

fn main() {
	vweb.run(new_app(), http_port)
}

fn new_app() &routes.App {
	mut app := &routes.App{}
	app.mount_static_folder_at(os.resource_abs_path('./presentation/assets'), '/')
	return app
}