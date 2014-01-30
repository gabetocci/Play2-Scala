package models

import play.api.db._
import play.api.Play.current

import anorm._
import anorm.SqlParser._

import scala.language.postfixOps

case class User(email: String, username: String, password: String)

object User {

  // -- Parsers

  /**
   * Parse a User from a ResultSet
   */
  val simple = {
    get[String]("user.email") ~
    get[String]("user.username") ~
    get[String]("user.password") map {
      case email~name~password => User(email, name, password)
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
          select email.emailaddress,
                 useraccount.username,
                 useraccount.password
            from entity
            join useraccount on useraccount.entityid = entity.id
            join email on  email.entityid = entity.id
                       and email.isprimary = 't'
           where useraccount.isactive = 't'
        """
      ).as(User.simple *)
    }
  }

  def find(id: Int): Option[User] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select email.emailaddress,
                 useraccount.username,
                 useraccount.password
            from entity
            join useraccount on useraccount.entityid = entity.id
            join email on  email.entityid = entity.id
                       and email.isprimary = 't'
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
  def findByEmail(email: String): Option[User] = {
    DB.withConnection { implicit connection =>
      SQL(
        """
          select email.emailaddress,
                 useraccount.username,
                 useraccount.password
            from entity
            join useraccount on useraccount.entityid = entity.id
            join email on  email.entityid = entity.id
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
         select * from useraccount
          where username = {username}
            and password = {password}
            and isactive = 't'
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
          'email    -> user.email,
          'username -> user.username,
          'password -> user.password
        ).executeUpdate()

      user

    }
  }

}