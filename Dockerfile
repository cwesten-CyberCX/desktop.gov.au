FROM circleci/ruby:2.6.6-stretch

RUN sudo gem update --system

RUN sudo gem install bundler

RUN echo '#!/usr/bin/env bash \n\
\n\
cd /workdir \n\
sudo bundle install --path=vendor/bundle \n\
if [ -f _config-extras.yml ]; then \n\
    sudo JEKYLL_ENV=production bundle exec jekyll serve --config _config.yml,_config-extras.yml -H 0.0.0.0 --watch --drafts --destination ./_site \n\
else \n\
    sudo JEKYLL_ENV=production bundle exec jekyll serve -H 0.0.0.0 --watch --drafts --destination ./_site \n\
fi \n\
\n\
exec "$@"' > /tmp/start.sh

RUN chmod +x /tmp/start.sh

WORKDIR /workdir

ENTRYPOINT ["/tmp/start.sh"]
