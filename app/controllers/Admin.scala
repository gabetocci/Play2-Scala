package controllers

import play.api.mvc._
import views._

/**
 * Created by GT on 1/24/14.
 */
object Admin extends Controller {

  def index = Action {
    Ok(html.admin.admin("Hello Admin"))
  }

}
