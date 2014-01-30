package models

import play.api.Play.current

import play.api.db.DB
import anorm.SqlParser._
import anorm._

import java.util.Date
import java.math.BigInteger

case class Table (schema: String, name: String, rows: BigInteger, comment: String)

case class RecordType (
  id: Option[Int],
  typeCode: String,
  table: String,
  name: Option[String],
  description: Option[String],
  active: Boolean,
  modifyDate: Option[Date]
)

object Table {

  val parseRow = {
    get[String]("table_schema") ~
    get[String]("table_name") ~
    get[BigInteger]("table_rows") ~
    get[String]("table_comment") map {
      case table_schema~table_name~table_rows~table_comment => 
        Table(table_schema, table_name, table_rows, table_comment)
    }
  }
  
  def findAll(): Seq[Table] = {
    DB.withConnection { implicit connection =>
      SQL("""
    	  select table_schema, table_name, table_rows, table_comment
	        from information_schema.tables
	       where table_schema not in ('information_schema','pg_catalog');
          """
          ).as(Table.parseRow *)
    }
  }  
}

object RecordType {

  val parseRow = {
    get[Option[Int]]("id") ~
    get[String]("typeCode") ~
    get[String]("table") ~
    get[Option[String]]("name") ~
    get[Option[String]]("description") ~ 
    get[Boolean]("active") ~
    get[Option[Date]]("modifyDate") map {
      case id~typeCode~table~name~description~active~modifyDate => 
        RecordType(id,typeCode, table, name, description, active, modifyDate)
    }
  }

  def findAll(): Seq[RecordType] = {
    DB.withConnection { implicit connection =>
      SQL("select * from RecordType").as(RecordType.parseRow *)
    }
  }
  
  def insert(recordType: RecordType) = {
    DB.withConnection { implicit connection =>
      SQL(
        """
    	insert into RecordType values (
    	  null, {typeCode}, {table}, {name}, {description}, {active}, now()
    	)
        """
      ).on(
        'typeCode    -> recordType.typeCode,
        'table       -> recordType.table,
        'name        -> recordType.name,
        'description -> recordType.description,
        'active      -> recordType.active
      ).executeUpdate()
    }
  }

}