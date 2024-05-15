const cinemaService = require('../services/cinema.service');
const Response = require('../utils/response');
const logger = require('../logger/logger.config');

const createCinema = async (req, res) => {
    try{
        const {name,address,phone,places,image,feedback} = req.body;
        const cinemaId = await cinemaService.createCinema(name,address,phone,places,image,feedback);
        res.send(Response.success(cinemaId));
    }
    catch (error){
        res.send(Response.error(error.message));
    }
}

const getCinema = async (req, res) => {
    try{
        const {id} = req.params;
        const cinema = await cinemaService.getCinema(id);
        res.send(Response.success(cinema));
    }
    catch (error){
        res.send(Response.error(error.message));
    }
}


const getAllCinemas = async (req, res) => {
    try{
        const cinemas = await cinemaService.getAllCinemas();
        res.send(Response.success(cinemas));
    }
    catch (error){
        res.send(Response.error(error.message));
    }
}

const updatePlace = async (req, res) => {
    try{
        const {id,place} = req.body;
        await cinemaService.updatePlace(id,place);
        res.send(Response.success(null));
    }
    catch (error){
        res.send(Response.error(error.message));
    }
}

const addFeedback = async (req, res) => {
    try{
        const {id,email,countOfStar,text} = req.body;
        await cinemaService.addFeedback(id,email,countOfStar,text);
        res.send(Response.success(null));
    }
    catch (error){
        res.send(Response.error(error.message));
    }

}

const removeFeedback = async (req, res) => {
    try{
        const {id,email,countOfStar,text} = req.body;
        await cinemaService.removeFeedBack(id,email,countOfStar,text);
        res.send(Response.success(null));
    }
    catch (error){
        res.send(Response.error(error.message));
        logger.error(`Error removing feedback: ${error}`);
    }

}


module.exports = {
    createCinema,
    getCinema,
    getAllCinemas,
    updatePlace,
    addFeedback,
    removeFeedback
}