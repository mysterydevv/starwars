const fileService = require('../services/file.service');
const Response = require('../utils/response');

const uploadImage = async (req, res) => {
    try {
        const file = req.file;
        const imageUrl = await fileService.uploadImage(file);
        res.send(Response.success(imageUrl));
    } catch (error) {
        res.send(Response.error(error.message));
    }
}

const getImage = async (req, res) => {
    try {
        const fileKey = req.params.fileKey;
        const fileStream = await fileService.getFileStream(fileKey);
        res.send(Response.success(fileStream));
    } catch (error) {
        res.send(Response.error(error.message));
    }
}

module.exports = { uploadImage, getImage};