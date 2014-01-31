package controllers

import play.api.data._
import play.api.data.Forms._
import scala.collection.immutable.Map

import play.api.libs.json._
import models._
import views._

import play.api.mvc._

object Accounting extends Controller {

/************************************************************************
 * Account
 ************************************************************************/  

  def accounts = Action {
    val rtypes = RecordType.findAll.filter(_.table.equals("Account"))
    Ok(html.admin.accounts(rtypes))
  }

  def accountsJs = Action {
    val accounts = Account.findAll.filter(_.rtype.equals("RTYPE"))
    
    val js = "aaData"

    Ok(js)
  }
  
  def saveAccount = Action(parse.json) { request =>

    (request.body \ "name").asOpt[String].map { name => // unused for now
      
      Ok(Json.toJson(request.body))

      //
      // save to db
      // evaluate success of db transaction
      // send and log response
      
    }.getOrElse { Ok("this failed!!") } //log error
  }
    
  
/************************************************************************
 * Document
 ************************************************************************/  
  
  val documentForm = Form(
    mapping(
      "description" -> nonEmptyText,
      "amountDue" -> number
    )(Document.apply)(Document.unapply)
  )

  val documentList = Map(
    1 -> Document("Document Order One", 100),
    2 -> Document("Document Order Two", 222),
    3 -> Document("Document Order Three", 3)  
  )
  
  def documents = Action {
    Ok(html.admin.documents( documentList ))
  }
  
  def createDocument = Action { implicit request =>
    Ok(html.admin.document_create(documentForm))
  }

  def submitDocument = Action { implicit request =>
    documentForm.bindFromRequest.fold(
      formWithErrors => BadRequest(html.admin.document_create(formWithErrors)),
      validDocument => {
    	Document.insert(validDocument)
        Ok(html.admin.document_create(documentForm))
    		.flashing("success" -> "Purchase order %s has been created"
    			.format(validDocument.description))
      }
    )
  }

}