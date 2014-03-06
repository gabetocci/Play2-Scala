package controllers

import play.api.mvc._
import play.api.data.Form
import play.api.data.Forms._

import views._
import models._

/**
 * Created by GT on 1/24/14.
 */
object Admin extends Controller with Secured {

  val loginForm = Form(
    tuple(
      "email" -> text,
      "password" -> text
    ) verifying ("Invalid email or password", result => result match {
      case (email, password) => User.authenticate(email, password).isDefined
    })
  )

  /**
   * Display the admin dashboard.
   */
  def index = IsAuthenticated { username => _ =>
      Ok(html.admin.index("Hello "+ username))
  }

  /**
   * Login page.
   */
  def login = Action { implicit request =>
    Ok(html.admin.login(loginForm))
  }

  def inventory = IsAuthenticated { username => _ =>
    Ok(html.admin.inventory(Product.all))
  }

  /**
   * Handle login form submission.
   */
  def authenticate = Action { implicit request =>
    loginForm.bindFromRequest.fold(
      formWithErrors => BadRequest(html.admin.login(formWithErrors)),
      user => Redirect(routes.Admin.index).withSession("email" -> user._1)
    )
  }

  /**
   * Logout and clean the session.
   */
  def logout = Action {
    Redirect(routes.Admin.login).withNewSession.flashing(
      "success" -> "You've been logged out"
    )
  }

}