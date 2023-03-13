FROM registry.gitlab.com/pages/hugo/hugo_extended
#docker run --rm -it registry.gitlab.com/pages/hugo/hugo_extended ash
RUN sh -c 'which apk && apk add git curl bash ; which apt-get && apt-get update && apt-get -y --no-install-recommends install git curl libssl-dev bash && apt-get clean all'
##RUST INSTALL AND CACHE
RUN bash -c 'curl https://sh.rustup.rs -sSf >/tmp/rustup &&  sh /tmp/rustup  -y && ln -s $HOME/.cargo/bin/* /usr/bin || true' && which cargo
RUN mkdir /etc/.cargo
RUN mkdir -p /etc/scripts/rust-webmention && git clone https://github.com/marinintim/webmention.git /etc/scripts/rust-webmention && cd /etc/scripts/rust-webmention && bash -c "cargo vendor > /etc/.cargo/config"

RUN cargo install webmention --bin webmention --features=cli
RUN ( test -e /etc/webmention-static-ci || git clone https://gitlab.com/the-foundation/webmention-static-ci.git /etc/webmention-static-ci) && bash /etc/webmention-static-ci/run.sh PACKAGE_INSTALLER PACKAGE_INSTALLER && echo DONE
RUN which trafilatura
RUN which npm
RUN bash -c "test -e /etc/scripts/ || mkdir /etc/scripts/ ; test -e /etc/scripts/gitub.com_drivet_send-all-webmentions/tmp/.gitub.com_drivet_send-all-webmentions || (  git clone https://github.com/drivet/send-all-webmentions.git /etc/scripts/gitub.com_drivet_send-all-webmentions/tmp/.gitub.com_drivet_send-all-webmentions )"
#RUN bash -c "cd /etc/scripts/gitub.com_drivet_send-all-webmentions/tmp/.gitub.com_drivet_send-all-webmentions && npm install"
RUN which webmention
RUN du -msx /
