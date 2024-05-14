const {db} = require('../config');

const eventTable = db.collection('events');


const createEvent = async (userId,cinemaId,place,dateTime) => {
    const event = {
        userId,
        cinemaId,
        place,
        dateTime
    }
    const newEvent = await eventTable.add(event);
    return newEvent.id;
}


const getEvents = async (userId) => {
    const events = [];
    const snapshot = await eventTable.where('userId', '==', userId).get();
    snapshot.forEach(doc => {
        events.push({id: doc.id, ...doc.data()});
    });
    return events;
}

module.exports = {
    createEvent,
    getEvents
}


