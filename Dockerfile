FROM alpine


RUN apk add texlive-full
RUN wget https://github.com/jgm/pandoc/releases/download/2.3.1/pandoc-2.3.1-linux.tar.gz
RUN tar xvzf pandoc-2.3.1-linux.tar.gz --strip-components 1 -C /usr/local

WORKDIR /usr/bin

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY pandoc.sh ./

# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
CMD [ "./start.sh" ]
