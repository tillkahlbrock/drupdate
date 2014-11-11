FROM dockerfile/ansible

RUN apt-get update && apt-get install -y ruby make g++
RUN apt-get install -y ruby-dev sshpass

RUN echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"

ENV GEM_HOME /usr/local/bundle
ENV PATH $GEM_HOME/bin:$PATH
RUN gem install bundler \
  && bundle config --global path "$GEM_HOME" \
  && bundle config --global bin "$GEM_HOME/bin"

ENV BUNDLE_APP_CONFIG $GEM_HOME

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
WORKDIR /app
RUN bundle install

RUN rm -rf /app

ENV ANSIBLE_HOST_KEY_CHECKING False
