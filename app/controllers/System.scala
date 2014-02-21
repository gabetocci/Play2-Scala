package controllers

import views._
import models._
import play.api.mvc._
import play.api.data._
import play.api.data.Forms._
import play.api.data.validation.Constraints._
import play.api.libs.json.Json

object System extends Controller {

  def sitemap = Action {
    Ok( """
        <?xml version="1.0" encoding="UTF-8"?>
        <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
          <url>
            <loc>http://www.stealstation.com/</loc>
            <lastmod>2014-02-20</lastmod>
            <changefreq>monthly</changefreq>
            <priority>0.5</priority>
          </url>
        </urlset>
        """ ).as(XML)
  }



  def index = Action {
	Ok("Admin Controller-Index Action!")
  }

  def recordTypes = Action {
    Ok(html.admin.recordtypes(Table.findAll))
  }

  def recordTypeExists = Action(parse.json) { request =>
    
    (request.body \ "name").asOpt[String].map { name => // unused for now
      
      val exists = RecordType.findAll().contains(name);
      
      Ok(Json.toJson(exists))
            
    }.getOrElse { Ok("this failed!!") } //log error
    
  }
  
  def saveRecordType = Action {
    Ok
  }

  
  
  val recordTypeForm = Form(
      mapping(
          "id" -> optional(number),
          "typeCode" -> text.verifying(nonEmpty, maxLength(4)),
          "table" -> nonEmptyText,
          "name" -> optional(text),
          "description" -> optional(text),
          "active" -> checked("Thanks for checking the checkbox"),
          "modifyDate" -> optional(date)
          )(RecordType.apply)(RecordType.unapply)
      )
/*
  val tables = Table.findAll      
  
  def submitRecordType = Action { implicit request => 
    recordTypeForm.bindFromRequest.fold(
      formWithErrors => BadRequest(html.admin.recordtypes(formWithErrors, tables)),
      validRecordType => {
    	RecordType.insert(validRecordType)
    	Ok(html.admin.recordtypes(recordTypeForm, tables))
    		.flashing("successMessage" -> "Record Type %s has been created"
    			.format(validRecordType.description))
      }
    )
  }
*/  
}