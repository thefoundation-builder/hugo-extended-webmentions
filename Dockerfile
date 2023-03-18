FROM registry.gitlab.com/pages/hugo/hugo_extended

#docker run --rm -it registry.gitlab.com/pages/hugo/hugo_extended ash
#npm nodejs
RUN sh -c '(which apk && apk add git curl bash make git  curl libc-dev gcc python3-dev libxslt-dev py3-pip python3  py3-libxml2 perl-app-cpanminus apkbuild-cpan perl-json perl-yaml perl-net-ssleay perl-dbd-sqlite perl-lwp-protocol-https perl-lwp-useragent-determined perl-xml-xpath perl-moox-types-mooselike perl-moox-types-mooselike-numeric composer php-xmlwriter php-tokenizer php-xml php-dom php-json php-curl icu-data-full perl-test2-suite perl-sub-info perl-test-deep perl-ipc-run perl-test-warn perl-test-output perl-namespace-autoclean perl-class-tiny perl-file-copy-recursive perl-test-without-module  perl-module-pluggable perl-term-table perl-sub-quote perl-html-tree perl-test-requiresinternet perl-datetime-timezone perl-class-inspector perl-datetime-format-builder perl-test-needs perl-perlio-utf8_strict perl-datetime perl-datetime-calendar-julian perl-datetime-format-builder perl-datetime-format-iso8601 perl-datetime-format-mail perl-datetime-format-natural perl-datetime-format-pg perl-datetime-format-strptime perl-datetime-format-w3cdtf perl-datetime-format-xsd perl-datetime-hires perl-datetime-locale perl-datetime-timezone perl-moosex-types-datetime perl-moo perl-moose perl-moosex perl-moosex-types perl-moosex-types-common perl-moosex-types-datetime perl-moosex-types-path-class perl-moosex-types-uri perl-moox-types-mooselike perl-moox-types-mooselike-numeric perl-mojolicious perl-digest-sha1 perl-test-warnings)||true ;' 
RUN sh -c '(which apt-get && apt-get update && apt-get -y --no-install-recommends install git curl libssl-dev bash && apt-get clean all) || true' && \
pip3 install trafilatura &&  id -un && \
bash -c "test -e /etc/scripts/ || mkdir /etc/scripts/ ; test -e /etc/scripts/gitub.com_drivet_send-all-webmentions/tmp/.gitub.com_drivet_send-all-webmentions || (  git clone https://github.com/drivet/send-all-webmentions.git /etc/scripts/gitub.com_drivet_send-all-webmentions/tmp/.gitub.com_drivet_send-all-webmentions )" 
RUN head -c 12 /dev/urandom >/etc/.tmp && ( test -e /etc/webmention-static-ci || git clone --recurse-submodules https://gitlab.com/the-foundation/webmention-static-ci.git /etc/webmention-static-ci) && \
 bash /etc/webmention-static-ci/run.sh PACKAGE_INSTALLER PACKAGE_INSTALLER && echo DONE && rm -rf /usr/share/doc /usr/share/man /root/.cpan /root/.cpanm /root/.cache/* || true && ( which apk && apk del gcc ; which apt-get && ( apt-get remove make gcc python3-wheel  && apt-get autoremove && apt-get clean all  ) || true  ) || true && \
test -e /etc/scripts/webmentions-php/mention-client-php/vendor || (cd /etc/scripts/webmentions-php/mention-client-php ; ls -lh1 ;composer install) && \
cd /etc/scripts/webmentions-php && ls /etc/scripts/webmentions-php/mention-client-php|grep vendor && php /etc/scripts/webmentions-php/send_pingback_webmention.php |grep "no_target_url"

RUN which trafilatura
RUN which whim

##RUST INSTALL AND CACHE


#export PATH="$CARGO_HOME/bin:$PATH"
#RUN bash -c 'export RUSTUP_HOME=/opt/.rustup && export CARGO_HOME=/opt/.cargo && export PATH="$CARGO_HOME/bin:$PATH"  && curl https://sh.rustup.rs -sSf >/tmp/rustup &&  sh /tmp/rustup  -y && ln -s /opt/.cargo/bin/* /usr/bin || true' && which cargo
#RUN mkdir /etc/.cargo
#RUN mkdir     -p /etc/scripts/rust-webmention && git clone https://github.com/benchonaut/webmention.git /etc/scripts/rust-webmention && cd /etc/scripts/rust-webmention && rustup default stable && bash -c "mkdir .cargo;cargo vendor > .cargo/config"
#RUN bash -c 'cd /etc/scripts/rust-webmention && cargo install webmention --bin webmention --features=cli --path . '
#RUN which webmention

RUN (du -m -s $(find //usr /var /lib  -type d -mindepth 2 -maxdepth 2 -xdev) |sort -n|tail -n 20 && du -m -s $(find / -type d -mindepth 2 -maxdepth 2 -xdev) |sort -n|tail -n 20 && du -m -s $(find / -type d -mindepth 1 -maxdepth 1 -xdev) |sort -n|tail -n 20)|sort -n -u -r 

RUN du -msx /etc/scripts

RUN du -msx /

