const mongoose = require('mongoose');

require('dotenv').config();

const Database = {
  connect: () => {
    mongoose
      .connect(process.env.MONGO_URI, {
        ssl: true,
        tls: true,
        tlsAllowInvalidCertificates: false,
        socketTimeoutMS: 45000,
        connectTimeoutMS: 30000,
      })
      .then(() => {
        console.log('🚀 Mongoose kết nối thành công 🚀');
      })
      .catch(error => {
        console.log('🚀 Mongoose kết nối thất bại 🚀', error);
        process.exit(1);
      });
  },
};

module.exports = Database;
