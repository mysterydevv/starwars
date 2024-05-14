const actorService = require('../services/actor.service');
const Response = require('../utils/response');
const logger = require('../logger/logger.config');


const createActor = async (req, res) => {
    try {
        const {name,role,age,image,awards,movies,biography} = req.body;
        const actorId = await actorService.createActor(name,role,age,image,awards,movies,biography);
        res.send(Response.success(actorId))
    } catch (error) {
        res.send(Response.error(error.message));
    }
}

const getActor = async (req, res) => {
    try {
        const actorId = req.params.id;
        const actor = await actorService.getActor(actorId);
        res.send(Response.success(actor));
    } catch (error) {
        res.send(Response.error(error.message));
    }
}

const getAllActors = async (req, res) => {
    try {
        const actors = await actorService.getAllActors();
        logger.info('Get all actors');
        res.send(Response.success(actors));
    } catch (error) {
        res.send(Response.error(error.message));
    }
}

const updateActor = async (req, res) => {
    try {
        const {name,role,age,image,awards,movies,biography} = req.body;
        const actorId = req.params.id;
        await actorService.updateActor(actorId, name,role,age,image,awards,movies,biography);
        res.send(Response.success());
    } catch (error) {
        res.send(Response.error(error.message));
    }
}

const deleteActor = async (req, res) => {
    try {
        const actorId = req.params.id;
        await actorService.deleteActor(actorId);
        res.send(Response.success());
    } catch (error) {
        res.send(Response.error(error.message));
    }
}


module.exports = {
    createActor,
    getActor,
    getAllActors,
    updateActor,
    deleteActor
}