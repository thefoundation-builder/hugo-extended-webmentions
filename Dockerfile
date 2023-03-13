FROM registry.gitlab.com/pages/hugo/hugo_extended
#docker run --rm -it registry.gitlab.com/pages/hugo/hugo_extended ash
RUN apk add git curl bash
RUN ( test -e /etc/webmention-static-ci || git clone https://gitlab.com/the-foundation/webmention-static-ci.git /etc/webmention-static-ci) && bash /etc/webmention-static-ci/run.sh PACKAGE_INSTALLER PACKAGE_INSTALLER
RUN which trafilatura
RUN which npm
RUN bash -c "test -e /etc/scripts/ || mkdir /etc/scripts/ ; test -e /etc/scripts/gitub.com_drivet_send-all-webmentions/tmp/.gitub.com_drivet_send-all-webmentions || (  git clone https://github.com/drivet/send-all-webmentions.git /etc/scripts/gitub.com_drivet_send-all-webmentions/tmp/.gitub.com_drivet_send-all-webmentions )"
RUN bash -c "cd /etc/scripts/gitub.com_drivet_send-all-webmentions/tmp/.gitub.com_drivet_send-all-webmentions && npm install"
RUN bash -c 'apk add cargo && cargo install webmention --bin webmention --features=cli'
RUN which webmention
