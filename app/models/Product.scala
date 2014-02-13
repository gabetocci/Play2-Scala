package models

import play.api.db._
import play.api.Play.current

import anorm._
import anorm.SqlParser._

import java.math.BigDecimal

case class Product( id:          Int,
                    name:        String,
                    description: String,
                    price:       BigDecimal,
                    msrp:       BigDecimal,
                    brand:       String,
                    category:    String)

object Product {

  /**
   * Parse a Product from a ResultSet
   */
  val simple = {
    get[Int]("id") ~
    get[String]("name") ~
    get[String]("description") ~
    get[BigDecimal]("price") ~
    get[BigDecimal]("msrp") ~
    get[String]("brand") ~
    get[String]("category") map {
    case id~name~description~price~msrp~brand~category =>
      Product(id, name, description, price, msrp, brand, category)
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
          select productsku.id          as id,
                 productsku.name        as name,
                 productsku.description as description,
                 price.price            as price,
                 msrp.price             as msrp,
                 brand.name             as brand,
                 productcategory.name   as category
            from productsku
            left outer join skuprice as msrp
                 on msrp.skuid = productsku.id
                 and msrp.type = 'MSRP'
            left outer join skuprice as price
                 on price.skuid = productsku.id
                 and price.type = 'ACTIVE'
            left outer join brand
                 on brand.id = productsku.brandid
            left outer join productcategory
                 on productcategory.id = productsku.productcategoryid
        """
      ).as(Product.simple *)
    }
  }

  def find(id: Int): Option[Product] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select productsku.id            as id,
                 productsku.name          as name,
                 productsku.description   as description,
                 price.price              as price,
                 msrp.price               as msrp,
                 brand.name               as brand,
                 productcategory.name     as category
            from productsku
            left outer join skuprice as msrp
                 on msrp.skuid = productsku.id
                 and msrp.type = 'MSRP'
            left outer join skuprice as price
                 on price.skuid = productsku.id
                 and price.type = 'ACTIVE'
            left outer join brand
                 on brand.id = productsku.brandid
            left outer join productcategory
                 on productcategory.id = productsku.productcategoryid
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

    //TODO brand and cateogory name <> id

      SQL(
        """
          insert into productsku (
            productcategoryid,brandid,name,description)
          values (
            'ACTIVE',{productcategoryid},{brandid},{name},{description})
          )
        """
      ).on(
          'productcategoryid -> product.category,
          'brandid -> product.brand,
          'name -> product.name,
          'description -> product.description
        ).executeUpdate()

      return product

    }
  }

}