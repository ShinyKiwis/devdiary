// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
import FooterModalController from "./footer_modal_controller"
import AccordionController from "./accordion_controller"
import EditorController from "./editor_controller"
import DeltaConverterController from "./delta_converter_controller"
import PreviewerController from "./previewer_controller"
import ModalController from "./modal_controller"

application.register("hello", HelloController)
application.register("footer-modal", FooterModalController)
application.register("modal", ModalController)
application.register("accordion", AccordionController)
application.register("editor", EditorController)
application.register("delta-converter", DeltaConverterController)
application.register("previewer", PreviewerController)
