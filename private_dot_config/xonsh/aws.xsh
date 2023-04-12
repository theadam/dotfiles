import boto3
import botocore
import wrapt

def aws_paginate(client, service, key, **options):
    paginator = client.get_paginator(service)
    return [item for page in paginator.paginate(**options) for item in page[key]]


class Service(object):
    def __init__(self, client, cluster, arn):
        self.client = client
        self.cluster = cluster
        self.arn = arn

    @property
    def name(self):
        return self.arn.split('/')[-1]

    def describe(self):
        desc = self.client.describe_services(cluster=self.cluster.name, services=[self.arn])
        return desc['services'][0]

    def is_active(self):
        return self.describe()['desiredCount'] > 0

    def shutdown(self):
        if self.is_active():
            self.desired_count(0)
        else:
            raise Exception("Cannot shutdown an already shutdown service")

    def desired_count(self, c):
        self.client.update_service(cluster=self.cluster.name, service=self.arn, desiredCount=c)

    def start(self):
        if not self.is_active():
            self.desired_count(1)
        else:
            raise Exception("Cannot start an already started service")

    def __repr__(self):
        return f'Service: {self.cluster.name} - {self.name}'

    def __str__(self):
        return f'Service: {self.cluster.name} - {self.name}'



class Cluster(object):
    def __init__(self, name, client):
        self.name = name
        self.client = client

    def _services(self):
        return aws_paginate(self.client, 'list_services', 'serviceArns', cluster=self.name)

    def service_names(self):
        return [x.split('/')[-1] for x in self._services()]

    def services(self):
        return [Service(self.client, self, x) for x in self._services()]

    def service(self, name):
        for s in self.services():
            if s.name == name:
                return s


class ECSWrapper(wrapt.ObjectProxy):
    def cluster(self, cluster):
        return Cluster(cluster, self)


class KBS(object):
    @property
    def _session(self):
        return boto3.session.Session(profile_name='kbs-iam')
      
    @property
    def ecs(self):
        return ECSWrapper(self._session.client('ecs'))
        
kbs = KBS()

