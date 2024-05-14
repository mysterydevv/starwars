const newsController = require('../controllers/news.controller');
const express = require('express');
const router = express.Router();



router.get('/news/all', newsController.getAllNews);
router.get('/news/:id', newsController.getNewsById);
router.post('/news/create', newsController.createNews);
router.put('/news/update/:id', newsController.updateNews);
router.delete('/news/delete/:id', newsController.deleteNews);

module.exports = router;