FROM nginx

RUN rm /etc/nginx/nginx.conf

COPY ./nginxconf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 

CMD ["nginx", "-g", "daemon off;"]

