pluginManagement {
   plugins {
      id("us.ihmc.ihmc-build") version "1.3.0"
   }
}

buildscript {
   repositories {
      maven { url = uri("https://plugins.gradle.org/m2/") }
      maven { url = uri("https://robotlabfiles.ihmc.us/repository/") }
      mavenLocal()
   }
   dependencies {
      classpath("us.ihmc:ihmc-build:1.3.0")
   }
}

val ihmcSettingsConfigurator = us.ihmc.build.IHMCSettingsConfigurator(settings, logger, extra)
ihmcSettingsConfigurator.configureAsGroupOfProjects()
ihmcSettingsConfigurator.findAndIncludeCompositeBuilds()

// alex-mocap is a plain Gradle build, not an ihmc-build project, so findAndIncludeCompositeBuilds()
// above does not pick it up -- it looks for the ihmc-build marker. Including it by hand is enough:
// Gradle substitutes an included build for an external dependency by matching group:name, and
// alex-mocap's build.gradle.kts sets `group = "us.ihmc"` for exactly this reason.
//
// Without the group the substitution silently does not happen and Gradle goes looking for
// `us.ihmc:alex-mocap` in a remote repository, which fails as "artifact not found" -- a message that
// sends you to the wrong place entirely.
includeBuild("alex-mocap")
