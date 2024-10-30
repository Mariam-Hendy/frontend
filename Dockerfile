# Use Node.js image to build the Angular app
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod

# Use Nginx to serve the Angular app
FROM nginx:alpine
COPY --from=build /app/dist/hello-world /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
