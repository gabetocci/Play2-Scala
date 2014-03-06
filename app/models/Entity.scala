package models

import play.api.db._
import play.api.Play.current

import anorm._
import anorm.SqlParser._

import scala.language.postfixOps

case class User(fname: String, username: String, password: String)

object User {

  // -- Parsers

  /**
   * Parse a User from a ResultSet
   */
  val simple = {
    get[String]("fname") ~
    get[String]("username") ~
    get[String]("password") map {
      case fname~name~password => User(fname, name, password)
    }
  }

  // -- Queries

  /**
   * Retrieve all users.
   */
  def findAll: Seq[User] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select entity.firstname     as fname,
                 useraccount.username as username,
                 useraccount.password as password
            from entity
            join useraccount on useraccount.entityid = entity.id
           where useraccount.isactive = 't'
        """
      ).as(User.simple *)
    }
  }

  def one(id: Int): Option[User] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select entity.firstname     as fname,
                 useraccount.username as username,
                 useraccount.password as password
            from entity
            join useraccount on useraccount.entityid = entity.id
           where useraccount.isactive = 't'
             and entity.id = {id}
        """
      ).on(
          'id -> id
        ).as(User.simple.singleOpt)
    }
  }

  /**
   * Retrieve a User from email.
   */
  def oneByEmail(email: String): Option[User] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select entity.firstname     as fname,
                 email.emailaddress   as emailaddres,
                 useraccount.username as username,
                 useraccount.password as password
            from entity
            join useraccount on useraccount.entityid = entity.id
            join email
                 on email.entityid = entity.id
                 and email.isprimary = 't'
           where useraccount.isactive = 't'
             and email.emailaddress = {email}
        """
      ).on(
        'email -> email
      ).as(User.simple.singleOpt)
    }
  }

  /**
   * Authenticate a User.
   */
  def authenticate(username: String, password: String): Option[User] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select entity.firstname     as fname,
                 useraccount.username as username,
                 useraccount.password as password
            from entity
            join useraccount on useraccount.entityid = entity.id
           where useraccount.isactive = 't'
             and useraccount.username = {username}
             and useraccount.password = {password}
        """
      ).on(
          'username -> username,
          'password -> password
        ).as(User.simple.singleOpt)
    }
  }

  /**
   * Create a UserAccount.
   */

  //TODO create entity and user objects

  def create(user: User): User = {
    DB.withConnection { implicit connection =>

      //TODO insert into entity table

      SQL(
        """
          insert into useraccount values (
            {email}, {username}, {password}
          )
        """
      ).on(
          'username -> user.username,
          'password -> user.password
        ).executeUpdate()

      return user

    }
  }

}