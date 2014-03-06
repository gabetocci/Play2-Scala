package controllers

import play.api.mvc._
import play.api.data._
import play.api.data.Forms._

import views._
import models._

/**s
 * Created by GT on 3/5/14.
 */
object Authentication extends Controller{

  // -- Authentication

  val loginForm = Form(
    tuple(
      "email" -> text,
      "password" -> text
    ) verifying ("Invalid email or password", result => result match {
      case (email, password) => User.authenticate(email, password).isDefined
    })
  )

  /**
   * Login page.
   */

  def login = Action { implicit request =>
    //Ok(html.index(loginForm))
    Ok("TODO")
  }

  /**
   * Handle login form submission.
   */
  def authenticate = Action { implicit request =>
    /*
    loginForm.bindFromRequest.fold(
      formWithErrors => BadRequest(html.index(formWithErrors)),
      user => Redirect(routes.Storefront.index).withSession("email" -> user._1)
    )
    */
    Ok("TODO")
  }

  /**
   * Logout and clean the session.
   */
  def logout = Action {
    Redirect(routes.Storefront.index).withNewSession.flashing(
      "success" -> "You've been logged out"
    )
  }

}

trait Secured {

  /**
   * Retrieve the connected user email.
   */
  private def username(request: RequestHeader) = request.session.get("email")

  /**
   * Redirect to login if the user in not authorized.
   */
  private def onUnauthorized(request: RequestHeader) = Results.Redirect(routes.Admin.login)

  /**
   * Action for authenticated users.
   */
  def IsAuthenticated(f: => String => Request[AnyContent] => Result) =
    Security.Authenticated(username, onUnauthorized) { user =>
      Action(request => f(user)(request))
    }
}