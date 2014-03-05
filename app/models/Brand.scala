package models

import play.api.db._
import play.api.Play.current

import anorm._
import anorm.SqlParser._

/**
 * Created by GT on 3/5/14.
 */

case class Brand( id:           Int,
                  url:          String,
                  name:         String,
                  productCount: Long)

object Brand {

  // -- Parsers

  val simple = {
    get[Int]("id") ~
    get[String]("url") ~
    get[String]("name") ~
    get[Long]("productCount") map {
      case id~url~name~productCount =>
        Brand(id, url, name, productCount)
      }
  }

  // -- Queries

  def all: Seq[Brand] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
        select brand.id                    as id,
               brand.url                   as url,
               brand.name                  as name,
               coalesce(pc.productCount,0) as productCount
          from brand
          left outer join
               (select count(*)    as productCount,
                       sku.brandid as brandid
                  from sku
                 group by sku.brandid) as pc
               on brand.id = pc.brandid
        """
      ).as(Brand.simple *)
    }
  }

  def one(url: String): Option[Brand] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
        select brand.id                    as id,
               brand.url                   as url,
               brand.name                  as name,
               coalesce(pc.productCount,0) as productCount
          from brand
          left outer join
               (select count(*)    as productCount,
                       sku.brandid as brandid
                  from sku
                 group by sku.brandid) as pc
               on brand.id = pc.brandid
         where brand.url = {url}
        """
      ).on('url -> url)
       .as(Brand.simple.singleOpt)
    }
  }

  // -- CRUD

}