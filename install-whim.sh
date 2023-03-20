#!/bin/bash 
which whim   2>/dev/null  |grep /whim || ( 
        test -e /etc/scripts/whim && (
          cd /etc/scripts/whim && git pull &>/dev/null
        )
        test -e /etc/scripts/whim || (
          git clone https://github.com/jmacdotorg/whim.git /etc/scripts/whim

        )
                which cpan &>/dev/null && cpan LWP::Protocol::https IO::Socket::SSL Net::SSL
        _CPANM_OPTS="--notest --mirror https://cpan.metacpan.org/ --mirror http://mirrors.ibiblio.org/CPAN/ --mirror http://mirror.cogentco.com/pub/CPAN/";cpanm --quiet --showdeps Whim|   xargs -n 1 -P $( nproc ) cpanm ${_CPANM_OPTS}
        cd /etc/scripts/whim
        cpanm --installdeps .
        perl Makefile.PL
        make -j $(nproc)
        make install
      ) ## end whim

##
