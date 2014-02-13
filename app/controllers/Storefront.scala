package controllers

import play.api.mvc._
import views._
import models._

/**
 * Created by GT on 1/24/14.
 */

object Storefront extends Controller {

  def index = Action {
    Ok(html.index("Happy Shopping"))
  }

  def catalog = Action { implicit request =>
    Ok(html.catalog(Product.findAll, "Search Results / Product Catalog"))
  }

  def product(id: Int) = Action {
    Ok(html.product("Product Number " + id))
  }

}