define sdkman::maven(
  $ensure = 'installed',
  $version = $name,
  $default = false
) {
  require sdkman::install

  exec { "install-maven-$name":
    command => "bash --login -c 'sdk install maven ${version}'",
    creates => "/Users/${::boxen_user}/.sdkman/candidates/maven/${version}"
  }

  if($default) {
    exec { "set-maven-default":
      command => "bash --login -c 'sdk default maven ${version}'",
      require => Exec["install-maven-$name"],
    }
  }
}
