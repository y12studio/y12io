#
# Lookback Hello Dockerfile
#
# sudo docker.io build -t="test/lbho" .
# sudo docker.io run -d -p 80:3000 test/lbho
# browser at http://localhost
# the generated API at  http://localhost/explorer
# 
# Pull base image.
# https://github.com/dockerfile/nodejs/blob/master/Dockerfile
FROM dockerfile/nodejs

# Install 
RUN npm install -g strong-cli
#RUN slc example && cd sls-sample-app

# Define default command.
#CMD cd /root/sls-sample-app && slc run
