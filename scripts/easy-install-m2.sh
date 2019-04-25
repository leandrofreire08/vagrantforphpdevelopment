#!/usr/bin/env bash

display_usage() {
  echo
  echo "Usage: $0"
  echo
  echo " -h, --help                 Display usage instructions"
  echo " -d, --database             Database name"
  echo " -f, --installation-folder  Directory to install, i.e: /var/www/html/magento"
  echo " -b, --base-url             Magento 2 Base Url"
  echo
  exit 0
}
print_message() {
  echo
  echo "Welcome to Bash case statements!"
  echo
}
raise_error() {
  local error_message="$@"
  echo "${error_message}" 1>&2;
}
argument="$1"
if [[ -z $argument ]] ; then
	raise_error "Expected argument to be present"
	display_usage
fi

case $argument in
    -h|--help)
      display_usage
      ;;
esac

while getopts d:f:b: option
do
	case "${option}"
	in
		d) db_name=${OPTARG};;
		f) install_dir=${OPTARG};;
		b) base_url=${OPTARG};;
	esac
done

#echo $db_name, $install_dir, $base_url

/usr/local/bin/n98m2 install --dbHost="127.0.0.1" --dbUser="root" --dbPass="root" --dbName="$db_name" --installSampleData=yes --useDefaultConfigParams=yes --installationFolder="$install_dir" --baseUrl="$base_url"
