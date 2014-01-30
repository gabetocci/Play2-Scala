package utils

import play.api.Play.current
import java.sql.Connection
import play.api.db.DB
import play.Logger

/**
 * Created by GT on 1/23/14.
 *
 */
object Database {

  val db: Connection = init

  def instance: String = {
    if ( play.Play.isProd ) { "tesp" }
    else { "tesd" }
  }

  def init: Connection = {

    val conn = DB.getConnection(instance)

    Logger.info(
      "You are successfully connected to: " + instance + " " +
      "Connection Data: " + conn)

    return conn
  }

}
