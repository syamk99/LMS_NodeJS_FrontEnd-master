FROM node:14-alpine as build
RUN mkdir /lms_frontend
WORKDIR /lms_frontend
COPY . /lms_frontend
RUN npm install
RUN npm run build --dev
FROM amazon/aws-cli
RUN mkdir /front
WORKDIR /front_app
COPY --from=build /lms_frontend/public /front_app
RUN aws s3 cp /front_app s3://lms-s3-7702 --recursive
EXPOSE 3000

