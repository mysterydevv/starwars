const eventController = require('../controllers/event.controller');


const router = require('express').Router();

router.get('/event/all/:userId', eventController.getEvents);
router.post('/event/create', eventController.createEvent);

module.exports = router;

