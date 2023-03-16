FROM nginx

# Pull openssl
RUN apt-get update \
	&& apt-get install --no-install-recommends -y openssl \
	&& rm -rf /var/lib/apt/lists/*

# Create working directories
RUN mkdir -p /ssl
WORKDIR /ssl

# Copy configurations
COPY virtual-site.template /etc/nginx/conf.d/virtual-site.template
COPY entrypoint.sh /opt/entrypoint.sh

# Docker entrypoiny
CMD ["/bin/bash", "-c", "/opt/entrypoint.sh"]