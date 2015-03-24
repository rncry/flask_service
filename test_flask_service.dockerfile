FROM centos

# Add EPEL repos (for python-pip)
RUN rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum -y update
RUN yum -y install python python-pip

RUN pip install apache-libcloud pika docker-py flask pytest

ADD tests/test_helloworld.py /opt/flask_service/test_helloworld.py

WORKDIR /opt/flask_service

ENTRYPOINT ["py.test"]
