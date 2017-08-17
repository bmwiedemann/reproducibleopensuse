suseinstall:
	zypper -n install bsdtar osc build kvm build-compare perl-JSON perl-XML-Simple
debianinstall:
	apt-get install -y sudo bsdtar osc obs-build kvm libjson-perl libxml-simple-perl
