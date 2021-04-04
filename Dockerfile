FROM ruby:2.6.5

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                        nodejs

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn shared-mime-info

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

RUN mkdir /Shokku_Takku
WORKDIR /Shokku_Takku

ADD Gemfile /Shokku_Takku/Gemfile
ADD Gemfile.lock /Shokku_Takku/Gemfile.lock

RUN bundle install

ADD . /Shokku_Takku
