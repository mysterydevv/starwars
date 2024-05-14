const {db}  = require('../config')

const newsTable = db.collection('news');

const getAllNews = async () => {
    const snapshot = await newsTable.get();
    const news = [];
    snapshot.forEach(doc => {
        news.push(doc.data());
    });
    return news;
}

const getNewsById = async (id) => {
    const snapshot = await newsTable.doc(id).get();
    return snapshot.data();
}
const createNews = async (title, content, author, date, image) => {
    const news = {title, content, author, date, image};
    const result = await newsTable.add(news);
    return result.id;
}

const updateNews = async (id, title, content, author, date, image) => {
    const news = {title, content, author, date, image};
    await newsTable.doc(id).set(news);
}

const deleteNews = async (id) => {
    await newsTable.doc(id).delete();
}


module.exports = { getAllNews, getNewsById, createNews, updateNews, deleteNews };

