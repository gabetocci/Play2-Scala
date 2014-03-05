package controllers

import play.api.mvc._
import play.api.data._
import play.api.data.Forms._

import views._
import models._

object Storefront extends Controller {

  // TODO Move to Base Controller
  val Home = Redirect(routes.Storefront.index())


  def index = Action {
    Ok(html.index(
      Product.category("popular-products").take(5),
      Product.category("sale-products").take(5)))
  }

  def catalog = Action {
    Ok(html.catalog(Product.all, "Product Catalog"))
  }

  def category(url: String) = Action {
    Ok(html.catalog(Product.category(url), Category.one(url).get.name))
  }

  def subCategories(url: String) = Action {
    val parent = Category.one(url).get
    Ok(html.subCategories(
      Category.subCategories(parent.id), parent.name
    ))
  }

  def brand(url: String) = Action {
    Ok(html.catalog(Product.brand(url), Brand.one(url).get.name))
  }

  def brands = Action {
    Ok(html.brands(Brand.all))
  }

  def productSearch = Action { implicit request =>
    val searchTerm = Form("searchTerms" -> text).bindFromRequest.get
    val products = Product.search(searchTerm)
    Ok(html.catalog(products, "You Searched For : "+searchTerm))
      //.flashing("productCount" -> products.size.toString)
  }

  def product(url: String) = Action {
    Product.one(url).map { product =>
      Ok(html.product(product))
    }.getOrElse(Home)
  }

  def cart = Action {
    Ok(html.cart())
  }

  def company = Action {
    Ok(html.company())
  }

}
