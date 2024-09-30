// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import Flatpickr from "stimulus-flatpickr";

eagerLoadControllersFrom("controllers", application)
application.register('flatpickr', Flatpickr)
