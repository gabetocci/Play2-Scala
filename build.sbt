import play.Project._

name := "tess"

version := "1.0"

libraryDependencies ++= Seq(jdbc, anorm, cache, "org.postgresql" % "postgresql" % "9.3-1100-jdbc4")

playScalaSettings