package controllers

import play.api.mvc._

import views._
import models._

object Storefront extends Controller {

  val Home = Redirect(routes.Storefront.index())

  def index = Action {
    Ok(html.index("Happy Shopping"))
  }

  def catalog = Action { implicit request =>
    Ok(html.catalog(Product.findAll, "Search Results / Product Catalog"))
  }

  def product(id: Int) = Action {
    Product.find(id).map { product =>
      Ok(html.product(product))
    }.getOrElse(Redirect(routes.Storefront.index()))
  }

}