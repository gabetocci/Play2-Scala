package controllers

import play.api.mvc._
import views._
import models._

/**
 * Created by GT on 1/24/14.
 */
object Admin extends Controller {

  def index = Action {
    Ok(html.admin.admin("Hello Admin"))
  }

  def inventory = Action {
    Ok(html.admin.inventory(Product.all))
  }

}
