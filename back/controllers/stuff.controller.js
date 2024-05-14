const stuffService = require('../services/stuff.service');
const Response = require('../utils/response');
const getStuffOfMember = async (req, res) => {
    try {
        const memberId = req.params.memberId;
        const stuff = await stuffService.getStuffOfMember(memberId);
        res.send(Response.success(stuff));
    } catch (error) {
        res.send(Response.error(error.message));
    }
}

const getAllMembers = async (req, res) => {
    try {
        const stuff = await stuffService.getAllMembers();
        res.send(Response.success(stuff));
    } catch (error) {
        res.send(Response.error(error.message));
    }
}

const createStuffMember = async (req, res) => {
    try {
        const {name, activity, image, biography } = req.body;
        const stuffId = await stuffService.createStuffMember(name, activity, image,biography);
        res.send(Response.success(stuffId));
    } catch (error) {
        res.send(Response.error(error.message));
    }
}

const updateStuffMember = async (req, res) => {
    try {
        const { id, name, activity, image, biography } = req.body;
        await stuffService.updateStuffMember(id, name, activity, image,biography);
        res.send(Response.success(null));
    } catch (error) {
        res.send(Response.error(error.message));
    }
}

const deleteStuffMember = async (req, res) => {
    try {
        const id = req.params.id;
        await stuffService.deleteStuffMember(id);
        res.send(Response.success(null));
    } catch (error) {
        res.send(Response.error(error.message));
    }
}


module.exports = { getStuffOfMember, getAllMembers, createStuffMember, updateStuffMember, deleteStuffMember };