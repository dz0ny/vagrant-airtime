maintainer       "Janez Troha"
maintainer_email "janez.troha@gmail.com"
license          "Apache 2.0"
description      "Installs Airtime"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

recipe "airtime", "Installs Airtime"

%w{ ubuntu debian }.each do |os|
  supports os
end
