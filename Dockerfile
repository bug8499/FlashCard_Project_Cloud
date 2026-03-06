# # ใช้ Node.js เป็น base image
# FROM node:18-alpine

# # ตั้ง working directory
# WORKDIR /app

# # คัดลอกไฟล์ package.json และ lock file ก่อน
# COPY package*.json ./

# # ติดตั้ง dependencies
# RUN npm install

# # คัดลอกโค้ดทั้งหมดเข้ามาใน container
# COPY . .

# # Build React app (Vite)
# RUN npm run build

# # ใช้ nginx serve ไฟล์ build
# FROM nginx:stable-alpine
# COPY --from=0 /app/dist /usr/share/nginx/html

# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
COPY .env .env
RUN npm run build
FROM nginx:stable-alpine
COPY --from=0 /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
