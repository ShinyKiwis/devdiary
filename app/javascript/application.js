// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as JSHelper from "./helpers"

window.JSHelper = JSHelper
