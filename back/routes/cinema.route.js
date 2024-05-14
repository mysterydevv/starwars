const cinemaController = require('../controllers/cinema.controller');
const express = require('express');
const router = express.Router();



router.get('/cinema/all', cinemaController.getAllCinemas);
router.get('/cinema/:id', cinemaController.getCinema);
router.post('/cinema/create', cinemaController.createCinema);
router.post('/cinema/updatePlace', cinemaController.updatePlace);

module.exports = router;