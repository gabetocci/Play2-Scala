package controllers

import play.api.mvc._

import views._
import models._

object Storefront extends Controller {

  // TODO Move to Base Controller
  val Home = Redirect(routes.Storefront.index())


  def index = Action {
    Ok(html.index(Product.all, "Welcome to StealStation"))
  }

  def catalog = Action {
    Ok(html.catalog(Product.all, "Product Catalog"))
  }

  def product(url: String) = Action {
    Product.one(url).map { product =>
      Ok(html.product(product))
    }.getOrElse(Home)
  }

  def subCategories(url: String) = Action {
    val parent = Category.one(url).get
    Ok(html.subCategories(
        Category.subCategories(parent.id), parent.name
      ))
  }

  def category(url: String) = Action {
    Ok(html.catalog(Product.category(url), url))
  }

  def productSearch(searchTerms: String) = Action {
    Ok(html.catalog(Product.search(searchTerms), "Search Results: "+searchTerms))
  }


/*
  def url(url: String) = Action {
    Product.one(url).map { product =>
      Ok(html.product(product))
    }.getOrElse(
        Ok(html.catalog(Product.category(url), url))
      )
  }

  def product(id: Int) = Action {
    Product.one(id).map { product =>
      Ok(html.product(product))
    }.getOrElse(Home)
  }*/

  def cart = Action {
    Ok(html.cart())
  }

  def company = Action {
    Ok(html.company())
  }

}
