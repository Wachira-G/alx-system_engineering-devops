#!/usr/bin/env bash
# server config upto 0x1A application server project. (web-01)

set -e
set -u
set -x

# ----------------------------------------------------------------------
# This section configures a webserver with nginx, adds basic html page,
# adds custome http header X-Serve-By with the value of the hostname

# Update the package repository
sudo apt update

# Install Nginx
sudo apt install -y nginx

# Start Nginx
sudo service nginx start

# Create an index.html file with "Hello World!"
echo "Hello World!" | sudo tee /var/www/html/index.html

# Configure redirection for /redirect_me
# shellcheck disable=SC1004

if grep -q "location /redirect_me" /etc/nginx/sites-available/default; then
	echo "skipping.. redirect_me exits"
else
	sudo sed -i '/server_name _;/a \
	\nlocation /redirect_me {\n\
	rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;\n\
	}\n' /etc/nginx/sites-available/default
fi

# Create a custom 404 HTML page
sudo echo "Ceci n'est pas une page" | sudo tee /var/www/html/custom_404.html

# Modify the Nginx configuration to use the custom 404 page
# shellcheck disable=SC1004

if grep -q "error_page 404 /custom_404.html" /etc/nginx/sites-available/default; then
        echo "skipping... custom 404 exist"
else
	sudo sed -i '/server_name _;/a \
	\nerror_page 404 /custom_404.html;\n\
	location /custom_404.html {\n\
	internal;\n\
	}\n' /etc/nginx/sites-available/default
fi

# Configure custom HTTP response header
if grep -q "add_header X-Served-By" /etc/nginx/conf.d/0-custom-header.conf; then
	echo "skipping... x-served-by header exists"
else
	sudo echo 'add_header X-Served-By $hostname;' | sudo tee /etc/nginx/conf.d/0-custom-header.conf
fi

#------------------------------------------------------ end of section
#############
# DEPLOYMENT#
# ###########
sudo mkdir -p /data/web_static/releases/test/

sudo mkdir -p /data/web_static/shared

sudo echo 'fake html file' | sudo tee /data/web_static/releases/test/index.html

sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

sudo chown -R ubuntu: /data/

# shellcheck disable=SC1004
if grep -q "location /hbnb_static" /etc/nginx/sites-available/default; then
	echo "skipping...hbnb_static exitst"
else
	sudo sed -i '/server_name _;/a \
	\n\nlocation /hbnb_static {\n\
	alias /data/web_static/current/;\n\
	}\n' /etc/nginx/sites-available/default
fi


################
# DATADOG CONFIG
#################

if command -v datadog-agent &> /dev/null
then
    echo "Datadog agent is already installed"
else
    echo "Datadog agent is not installed. Installing..."
    DD_API_KEY=$DD_API_KEY DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"

fi


####################
# APPLICATION SERVER
# ##################

# airbnb onepage - v2
if grep -q "location /airbnb-onepage/" /etc/nginx/sites-available/default; then
	echo "skipping ... /airbnb-onepage/ exists"
else
	sudo sed -i '/server_name _;/a \
	\n\nlocation /airbnb-onepage/ {\n\
	proxy_pass http://localhost:5000/airbnb-onepage/;\n\
	}\n' /etc/nginx/sites-available/default
fi

# airbnb-dynamic -v2
if grep -q "location /airbnb-dynamic/" /etc/nginx/sites-available/default; then
	echo "skipping ... /airbnb-dynamic/ exists"
else
	sudo sed -i '/server_name _;/a \
	\n\n\t\tlocation /airbnb-dynamic/ {\n\
        \t\tproxy_pass http://localhost:5001/;\n\
	\t}\n' /etc/nginx/sites-available/default
fi

# airbnb api - v3
if grep -q "location /api/" /etc/nginx/sites-available/default; then
	echo "skipping ... /api/ exists"
else
	sudo sed -i '/server_name _;/a \
	\n\n\t\tlocation /api/ {\n\
        \t\tproxy_pass http://localhost:5002/;\n\
	\t}\n' /etc/nginx/sites-available/default
fi


# airbnb web dynamic - v4
if grep -q "location / " /etc/nginx/sites-available/default; then
	sudo sed -i '/location \/ {/,/}/d' /etc/nginx/sites-available/default
	echo "removed initial '/' location block"

	sudo sed -i '/server_name _;/a \
	\n\n\t\tlocation / {\n\
	\t\tproxy_pass http://localhost:5003/;\n\
	\t}\n' /etc/nginx/sites-available/default

else
	sudo sed -i '/server_name _;/a \
	\n\n\t\tlocation / {\n\
	\t\tproxy_pass http://localhost:5003/;\n\
	\t}\n' /etc/nginx/sites-available/default
fi


if grep -q "location /static/" /etc/nginx/sites-available/default; then
	echo "skipping ... /static/ exists"
else
	sudo sed -i '/server_name _;/a \
        \n\n\t\tlocation /static/ {\n\
        \t\talias ~/AirBnB_clone_v4/web_dynamic/static/;\n\
        \t}\n' /etc/nginx/sites-available/default

fi

sudo service nginx restart
