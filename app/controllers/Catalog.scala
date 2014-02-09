package controllers

import play.api.mvc._
import views._

/**
 * Created by GT on 1/24/14.
 */

object Catalog extends Controller {

  def index = Action {
    Ok(html.index("Happy Shopping"))
  }

  def catalog = Action {
    Ok(html.catalog("Search Results / Product Catalog"))
  }

  def product(id: Int) = Action {
    Ok(html.product("Product Number " + id))
  }

}