const Router = require('express').Router();
const messageController = require('../controller/Message.Controller');

Router.post('/upload', messageController.uploadMessage);
module.exports = Router;
