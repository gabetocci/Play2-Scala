package controllers

import play.api._
import play.api.mvc._
import play.api.cache._

import play.api.Play.current
import play.api.db._
import anorm._

import views._
import models._
import play.api.libs.iteratee.Enumerator
import play.api.libs.json._

object ApplicationTest extends Controller {

  def index = Action {
    DB.withConnection { implicit c =>
      Ok(html.index("Your new application is ready. Successfully connected to database. "))
    }
  }

  def testRequest = Action { request => 
    Logger.info("Testing System Logger")
    Ok("received request ok! " + request )
  } 

  def testTodo = TODO //Redirect("/accounting")

  def testSimpleResult = Action {

    SimpleResult (
     header = ResponseHeader(200,Map(CONTENT_TYPE -> "text/plain")),
     body = Enumerator()
    )
  }

  def testXML = Action {
    Ok("<message>sending xml ok</message>").as(XML)
  }

  def testCookie = Action {
    Ok("cookie set ok").withCookies(
      Cookie("cookieName","cookieValue")
    )//.discardingCookies("cookieName")
  }

  //TODO Finish cache/cookie setup
  def cacheSnippets(user: User) = {

    Cache.set("user.key", user)

//    val maybeUser: Option[User] = Cache.getAs[User]("user.key")

//    val user: User = Cache.getOrElse[User]("user.key") {
//      Cache.getAs[User]("user.key")
//    }

    Cache.remove("user.key")

  }

  def testDatabase = Action {
    DB.withConnection { implicit c =>
    val firstRow = SQL("Select * from test_table").apply().head
      Ok("connected to database ok " + firstRow.toString())

    }
  }  

  def json1 = Action {
    
    val testDocument = new Document("test document",78)
    val json = Json.toJson(testDocument)
    Ok(json)    
  }

  def json2 = Action(parse.json) { request =>

    (request.body \ "age").asOpt[String].map { age =>
      
      val newAge = age.toInt +1      
      Ok(Json.toJson("age is: " + newAge))
      
    }.getOrElse { Ok("fail message") }
  }

  def testParameter(id: Int) = Action {
    if (id == 99) {
      Ok("parameter == 99")
    }else{
      Ok("parameter != 99")
    }
  }
  
}
