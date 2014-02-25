package models

import play.api.db._
import play.api.Play.current

import anorm._
import anorm.SqlParser._

case class Category(id:             Int,
                    url:            String,
                    name:           String,
                    description:    String,
                    parentCategory: Option[Int])

object Category {

  // -- Parse a Product from a ResultSet

  val simple = {
    get[Int]("id") ~
    get[String]("url") ~
    get[String]("name") ~
    get[String]("description") ~
    get[Option[Int]]("parentcategory") map {
    case id~url~name~description~parentCategory =>
      Category(id, url, name, description, parentCategory)
    }
  }

  // -- Queries

  def all: Seq[Category] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select category.id                 as id,
                 category.url                as url,
                 category.name               as name,
                 category.description        as description,
                 category.parentcategory     as parentcategory
            from category
        """
      ).as(Category.simple *)
    }
  }

  def one(url: String): Option[Category] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select category.id                 as id,
                 category.url                as url,
                 category.name               as name,
                 category.description        as description,
                 category.parentcategory     as parentcategory
            from category
           where category.url = {url}
        """
      ).on(
          'url -> url
        ).as(Category.simple.singleOpt)
    }
  }

  def subCategories(id: Int): Seq[Category] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select category.id                 as id,
                 category.url                as url,
                 category.name               as name,
                 category.description        as description,
                 category.parentcategory     as parentcategory
            from category
           where category.parentcategory = {id}
        """
      ).on(
          'id -> id
        ).as(Category.simple *)
    }
  }

  // -- CRUD Operations

  /**
   *  Add a new Category
   * @param category
   * @return new Category
   */
  def create(category: Category): Category = {
    DB.withConnection { implicit connection =>

    //TODO brand and cateogory name <> id

      SQL(
        """
          insert into category (
            type,url,name,description,parentcategory)
          values (
            'ACTIVE',{url},{name},{description},{parentcateogry})
          )
        """
      ).on(
          'url -> category.url,
          'name -> category.name,
          'description -> category.description,
          'parentcategory -> category.parentCategory
        ).executeUpdate()

      return category

    }
  }

}