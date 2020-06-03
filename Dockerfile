FROM centos:7

MAINTAINER "Shubham Vaishnav"

ENV pip_packages "ansible"

# Install basic utilities
RUN yum makecache fast && \
	yum -y install deltarpm epel-release initscripts && \
	yum -y update && \
	yum -y install \
		sudo \
     	which \
     	python-pip && \
	yum clean all

# Install Ansible via Pip.
RUN pip install $pip_packages

# Disable requiretty.
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

CMD ["/usr/lib/systemd/systemd"]