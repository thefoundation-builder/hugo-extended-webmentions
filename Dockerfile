FROM registry.gitlab.com/pages/hugo/hugo_extended
#docker run --rm -it registry.gitlab.com/pages/hugo/hugo_extended ash
RUN sh -c '(which apk && apk add git curl bash)||true ;'
RUN sh -c '(which apt-get && apt-get update && apt-get -y --no-install-recommends install git curl libssl-dev bash && apt-get clean all) || true'
##RUST INSTALL AND CACHE


#export PATH="$CARGO_HOME/bin:$PATH"
#RUN bash -c 'export RUSTUP_HOME=/opt/.rustup && export CARGO_HOME=/opt/.cargo && export PATH="$CARGO_HOME/bin:$PATH"  && curl https://sh.rustup.rs -sSf >/tmp/rustup &&  sh /tmp/rustup  -y && ln -s /opt/.cargo/bin/* /usr/bin || true' && which cargo
#RUN mkdir /etc/.cargo
#RUN mkdir     -p /etc/scripts/rust-webmention && git clone https://github.com/benchonaut/webmention.git /etc/scripts/rust-webmention && cd /etc/scripts/rust-webmention && rustup default stable && bash -c "mkdir .cargo;cargo vendor > .cargo/config"
#RUN bash -c 'cd /etc/scripts/rust-webmention && cargo install webmention --bin webmention --features=cli --path . '
#RUN which webmention

RUN ( test -e /etc/webmention-static-ci || git clone https://gitlab.com/the-foundation/webmention-static-ci.git /etc/webmention-static-ci) && bash /etc/webmention-static-ci/run.sh PACKAGE_INSTALLER PACKAGE_INSTALLER && echo DONE && rm -rf /usr/share/doc /usr/share/man /root/.cpan /root/.cpanm /root/.cache/* || true && apt-get remove make gcc python3-wheel  && apt-get autoremove && apt-get clean all 
RUN which trafilatura
RUN which whim
RUN which npm
RUN bash -c "test -e /etc/scripts/ || mkdir /etc/scripts/ ; test -e /etc/scripts/gitub.com_drivet_send-all-webmentions/tmp/.gitub.com_drivet_send-all-webmentions || (  git clone https://github.com/drivet/send-all-webmentions.git /etc/scripts/gitub.com_drivet_send-all-webmentions/tmp/.gitub.com_drivet_send-all-webmentions )"
#RUN bash -c "cd /etc/scripts/gitub.com_drivet_send-all-webmentions/tmp/.gitub.com_drivet_send-all-webmentions && npm install"

RUN du -m -s $(find / -type d -mindepth 3 -maxdepth 3 -xdev) |sort -n|tail -n 20
RUN du -m -s $(find / -type d -mindepth 2 -maxdepth 2 -xdev) |sort -n|tail -n 20
RUN du -m -s $(find / -type d -mindepth 1 -maxdepth 1 -xdev) |sort -n|tail -n 20

RUN du -msx //etc/scripts

RUN du -msx /

