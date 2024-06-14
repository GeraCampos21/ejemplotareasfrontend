# etapa de compilacion. Uso Node 12.22.1 igual que el backend
FROM node:12.22.1-alpine AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install ajv ajv-keywords
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.17.10-alpine AS production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


# para crear la imagen ejecute
#sudo docker build -t mirepo/ejemplofrontend:latest .