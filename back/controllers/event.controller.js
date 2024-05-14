const eventService = require('../services/event.service');

const Response = require('../utils/response');
const logger = require('../logger/logger.config');


const createEvent = async (req, res) => {
    const {userId,cinemaId,place,dateTime} = req.body;
    try {
        const eventId = await eventService.createEvent(userId,cinemaId,place,dateTime);
        logger.info(`Event created with id ${eventId}`);
        res.send(Response.success(eventId));
    } catch (error) {
        logger.error(`Error creating event: ${error}`);
        res.send(Response.error(error));
    }
}


const getEvents = async (req, res) => {
    const {userId} = req.params;
    try {
        const events = await eventService.getEvents(userId);
        Response.success(res, events);
    } catch (error) {
        Response.error(res, error);
    }
}


module.exports = {
    createEvent,
    getEvents
}

