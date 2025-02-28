const express = require('express');
const router = express.Router();
const avesController = require('../controllers/avesController');

router.get('/', avesController.getAves);

module.exports = router;
