package fedu

class HomeController {

    def index() {
        return [projects: Project.list()]
    }
}
