FROM phusion/passenger-ruby22:0.9.19

ENV APP_HOME=/home/app/webapp

RUN mkdir -p ${APP_HOME} && rm -f /etc/nginx/sites-enabled/default && rm -f /etc/service/nginx/down
ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf
ADD proxy.conf /etc/nginx/main.d/proxy.conf

ADD Gemfile ${APP_HOME}/
ADD Gemfile.lock ${APP_HOME}/
ADD config.ru ${APP_HOME}/
RUN chown -R app:app ${APP_HOME}

RUN su app -c "cd ${APP_HOME} && bundle install --deployment --without='development test'"


