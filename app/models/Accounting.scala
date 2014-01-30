package models

import play.api.Play.current

import anorm._
import play.api.db.DB
import anorm.SqlParser._

import java.util.Date

/************************************************************************
 * Account
 ************************************************************************/
case class Account (
  id: Option[Int],
  rtype: String,
  name: String,
  description: Option[String],
  modifiedDate: Option[Date]
)

object Account {

  val parseRow = {
    get[Option[Int]]("id") ~
    get[String]("rtype") ~
    get[String]("name") ~
    get[Option[String]]("description") ~ 
    get[Option[Date]]("modifiedDate") map {
      case id~rtype~name~description~modifiedDate => 
        Account(id, rtype, name, description, modifiedDate)
    }
  }

  def findAll(): Seq[Account] = {
    DB.withConnection { implicit connection =>
      SQL("select * from Accounting.Account").as(Account.parseRow *)
    }
  }
  
  def insert (account: Account) = {
    DB.withConnection { implicit connection =>
      SQL(
        """
    	insert into Accounting.Account values (
    	  null, {rtype}, {name}, {description}, now()
    	)
        """
      ).on(
        'rtype       -> account.rtype,
        'name        -> account.name,
        'description -> account.description
      ).executeUpdate()
    }
  }
    
}

/************************************************************************
 * Document
 ************************************************************************/

case class Document(
    description: String, 
    amountDue: Int
)

object Document {

  import play.api.libs.json._

  def insert(document: Document) = null
  
    implicit val documentFormat = Json.format[Document]

}

