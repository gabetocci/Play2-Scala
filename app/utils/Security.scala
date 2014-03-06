package utils

import models._
import play.api.mvc._
import play.cache._
import scala.concurrent.Future

class AuthenticatedRequest[A](val user: User, request: Request[A]) extends WrappedRequest[A](request)

//TODO test
/*
object Authenticated extends ActionBuilder[AuthenticatedRequest] {
  def invokeBlock[A](request: Request[A], block: (AuthenticatedRequest[A]) => Future[SimpleResult]) = {
    request.session.get("id").map { id => // Get id from the cookie, you have to set this on your post registration & post signin code.
      User.find(id.asInstanceOf[Int]).map { user =>
        block(new AuthenticatedRequest(user, request))
      } getOrElse {
        Future.successful(Results.Forbidden)
      }
    } getOrElse {
      //TODO redirect
      Future.successful(Results.Redirect("",1))
    }
  }
}
*/
object Session {

  def save(sessionId: String, userId: String, req: RequestHeader): String = {
    Cache.set(sessionId, userId.toString)
    sessionId
  }

  //def lookup(sessionId: String): Option[String] = {
    //Cache.getOrElse(sessionId, "", 2)
  //}

  def delete(sessionId: String) = {
    Cache.remove("user.key")
  }
}
