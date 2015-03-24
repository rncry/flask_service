__author__ = 'acarey'

import pytest

@pytest.fixture
def docker_client():
    """
    Fixture to interact with the docker daemon
    """
    from docker import Client
    dc = Client(base_url='unix://var/run/docker.sock')
    return dc


@pytest.fixture
def upload_container(request, docker_client):
    """
    Gives us the docker container object that we want to test against
    """

    def fin():
        print "Tearing down container fixture"
        docker_client.stop('flask_upload')
        print "Container stopped"
        docker_client.remove_container('flask_upload')
        print "Container deleted"

    # start the docker container
    container = docker_client.create_container(image='flask_service', name='flask_upload')
    response = docker_client.start(container=container, publish_all_ports=True, links=[('test_harness', 'test_harness')])
    print "Started container: " + str(response)

    request.addfinalizer(fin)


def test_root_query(upload_container, docker_client):
    """
    Basic hello world test
    """
    # get the ip address of the container
    result = docker_client.inspect_container('flask_upload')
    upload_ip_address = result['NetworkSettings']['IPAddress']
    print "Ipaddress of flask_upload: %s" % upload_ip_address

    import urllib2
    result = urllib2.urlopen("http://%s:5000/" % upload_ip_address).read()
    print result
    assert result == "Success"