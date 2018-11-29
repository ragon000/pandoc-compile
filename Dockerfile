FROM archlinux/base


RUN pacman -Syu --noconfirm pandoc pandoc-citeproc pandoc-crossref biber texlive-lang texlive-langextra texlive-most noto-fonts noto-fonts-extra noto-fonts-emoji noto-fonts-cjk ttf-font-awesome git
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
