FROM python:3.7.5

RUN apt-get -y update

RUN apt-get install -y supervisor

ADD /rasa /src/app

ADD /supervisor /src/supervisor

RUN pip3 install --upgrade pip

RUN pip3 install ruamel.yaml

RUN pip3 install -r /src/app/requirements.txt --no-cache-dir


EXPOSE 5005

WORKDIR /src/app

RUN rasa train --fixed-model-name /src/app/models/demo-model

CMD ["supervisord","-c","/src/supervisor/service_script.conf"]