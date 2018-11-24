FROM alpine


RUN apk add texlive-full git texlive-xetex texlive-luatex
RUN wget https://github.com/jgm/pandoc/releases/download/2.3.1/pandoc-2.3.1-linux.tar.gz
RUN tar xvzf pandoc-2.3.1-linux.tar.gz --strip-components 1 -C /usr/local
RUN git clone https://gitlab.com/benfrank/kvmap.git
RUN cd kvmap && luatex --shell-escape kvmap.dtx
RUN mkdir -p /usr/share/texmf-dist/tex/latex
RUN cp kvmap/kvmap.sty /usr/share/texmf-dist/tex/latex
RUN texhash 

WORKDIR /usr/bin

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY pandoc.sh ./

# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
CMD [ "./start.sh" ]
