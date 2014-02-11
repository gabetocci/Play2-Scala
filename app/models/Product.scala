package models

import play.api.db._
import play.api.Play.current

import anorm._
import anorm.SqlParser._

import scala.language.postfixOps

case class Product(producttype: String, name: String)

object Product {

  /**
   * Parse a Product from a ResultSet
   */
  val simple = {
    get[String]("product.type") ~
    get[String]("product.name") map {
    case producttype~name => Product(producttype, name)
    }
  }

  /**
   * Retrieve all products
   * @return All Products
   */
  def findAll: Seq[Product] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select productsku.type,
                 productsku.name
            from productsku
        """
      ).as(Product.simple *)
    }
  }

  def find(id: Int): Option[Product] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select productsku.type,
                 productsku.name
            from productsku
           where productsku.id = {id}
        """
      ).on(
          'id -> id
        ).as(Product.simple.singleOpt)
    }
  }

  /**
   *  Add a new Product
   * @param product
   * @return new product
   */
  def create(product: Product): Product = {
    DB.withConnection { implicit connection =>

    //TODO insert into entity table

      SQL(
        """
          insert into productsku values (
            {type}, {name}
          )
        """
      ).on(
          'type -> product.producttype,
          'name -> product.name
        ).executeUpdate()

      return product

    }
  }

}