FROM centos

# Add EPEL repos (for python-pip)
RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum -y update
RUN yum -y install python python-pip

RUN pip install apache-libcloud pika docker-py flask

ADD flask_service.py /opt/flask_service/flask_service.py

EXPOSE 5000

WORKDIR /opt/flask_service

ENTRYPOINT ["python", "flask_service.py"]


