package models

import play.api.db._
import play.api.Play.current

import anorm._
import anorm.SqlParser._

import java.math.BigDecimal

case class Product( id:          Int,
                    url:         String,
                    name:        String,
                    description: String,
                    price:       BigDecimal,
                    msrp:        BigDecimal,
                    brand:       String)

object Product {

   // -- Parse a Product from a ResultSet

   val simple = {
    get[Int]("id") ~
    get[String]("url") ~
    get[String]("name") ~
    get[String]("description") ~
    get[BigDecimal]("price") ~
    get[BigDecimal]("msrp") ~
    get[String]("brand") map {
    case id~url~name~description~price~msrp~brand =>
      Product(id, url, name, description, price, msrp, brand)
    }
  }

  // -- Queries

  def all: Seq[Product] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select sku.id                 as id,
                 sku.url                as url,
                 sku.name               as name,
                 sku.description        as description,
                 price.price            as price,
                 msrp.price             as msrp,
                 brand.name             as brand
            from sku
            left outer join skuprice as msrp
                 on msrp.skuid = sku.id
                 and msrp.type = 'MSRP'
            left outer join skuprice as price
                 on price.skuid = sku.id
                 and price.type = 'ACTIVE'
            left outer join brand
                 on brand.id = sku.brandid
        """
      ).as(Product.simple *)
    }
  }

  def category(url: String): Seq[Product] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select sku.id                 as id,
                 sku.url                as url,
                 sku.name               as name,
                 sku.description        as description,
                 price.price            as price,
                 msrp.price             as msrp,
                 brand.name             as brand
            from sku
            left outer join skuprice as msrp
                 on msrp.skuid = sku.id
                 and msrp.type = 'MSRP'
            left outer join skuprice as price
                 on price.skuid = sku.id
                 and price.type = 'ACTIVE'
            left outer join brand
                 on brand.id = sku.brandid
            left outer join skucategory
                 on skucategory.skuid = sku.id
            join category
              on category.id = skucategory.categoryid
           where category.url = {url}
        """
      ).on(
          'url -> url
        ).as(Product.simple *)
    }
  }

  def one(url: String): Option[Product] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select sku.id                   as id,
                 sku.url                  as url,
                 sku.name                 as name,
                 sku.description          as description,
                 price.price              as price,
                 msrp.price               as msrp,
                 brand.name               as brand
            from sku
            left outer join skuprice as msrp
                 on msrp.skuid = sku.id
                 and msrp.type = 'MSRP'
            left outer join skuprice as price
                 on price.skuid = sku.id
                 and price.type = 'ACTIVE'
            left outer join brand
                 on brand.id = sku.brandid
           where sku.url = {url}
        """
      ).on(
          'url -> url
        ).as(Product.simple.singleOpt)
    }
  }

  def search(searchTerms: String): Seq[Product] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select sku.id                   as id,
                 sku.url                  as url,
                 sku.name                 as name,
                 sku.description          as description,
                 price.price              as price,
                 msrp.price               as msrp,
                 brand.name               as brand
            from sku
            left outer join skuprice as msrp
                 on msrp.skuid = sku.id
                 and msrp.type = 'MSRP'
            left outer join skuprice as price
                 on price.skuid = sku.id
                 and price.type = 'ACTIVE'
            left outer join brand
                 on brand.id = sku.brandid
           where (upper(sku.name)        like upper('%{searchTerms}%') or
                  upper(brand.name)      like upper('%{searchTerms}%'));
        """
      ).on(
          'searchTerms -> searchTerms
        ).as(Product.simple *)
    }
  }

  // -- CRUD Operations

  /**
   *  Add a new Product
   * @param product
   * @return new product
   */
  def create(product: Product): Product = {
    DB.withConnection { implicit connection =>

    //TODO brand and category name <> id

      SQL(
        """
          insert into sku (
            brandid,name,description)
          values (
            'ACTIVE',{brandid},{name},{description})
          )
        """
      ).on(
          'brandid -> product.brand,
          'name -> product.name,
          'description -> product.description
        ).executeUpdate()

      return product

    }
  }

}