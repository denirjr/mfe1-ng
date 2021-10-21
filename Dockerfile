FROM node:15-alpine as builder

COPY package.json  ./

RUN yarn install 

RUN mkdir /mfe-app

RUN mv ./node_modules ./mfe-app

WORKDIR /mfe-app

COPY . .

RUN npm run ng build --prod --project=mfe1

FROM nginx
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /mfe-app/dist/mfe1 /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]