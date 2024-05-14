const newsService = require('../services/news.service');
const Response = require('../utils/response');


const getAllNews = async (req, res) => {
    try{
        const allNews = await newsService.getAllNews();
        res.send(Response.success(allNews));
    }
    catch (error) {
        res.send(Response.error(error.message));
    }
}


const getNewsById = async (req, res) => {
    try{
        const news = await newsService.getNewsById(req.params.id);
        res.send(Response.success(news));
    }
    catch (error) {
        res.send(Response.error(error.message));
    }
}

const createNews = async (req, res) => {
    try{
        const {title, content, author, date, image} = req.body;
        const news = await newsService.createNews(title, content, author, date, image);
        res.send(Response.success(news));
    }
    catch (error) {
        res.send(Response.error(error.message));
    }
}

const updateNews = async (req, res) => {
    try{
        const {title, content, author, date, image} = req.body;
        await newsService.updateNews(req.params.id, title, content, author, date, image);
        res.send(Response.success());
    }
    catch (error) {
        res.send(Response.error(error.message));
    }
}

const deleteNews = async (req, res) => {
    try{
        await newsService.deleteNews(req.params.id);
        res.send(Response.success());
    }
    catch (error) {
        res.send(Response.error(error.message));
    }
}

module.exports = { getAllNews, getNewsById, createNews, updateNews, deleteNews };