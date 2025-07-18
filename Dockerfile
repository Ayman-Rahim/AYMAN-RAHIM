# Step 1: Build React app
FROM node:22 as build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Step 2: Serve with a production web server
FROM node:22-slim

RUN npm install -g serve

WORKDIR /app
COPY --from=build /app/build ./build

EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]
