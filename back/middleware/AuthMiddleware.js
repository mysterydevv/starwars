const Response = require('../utils/Response');

const authMiddleware = (req, res, next) => {
    const token = req.headers.authorization;
    if (!token) {
        return res.send(Response.unauthorized('Unauthorized access, invalid or missing token'));
    }
    next();
}

module.exports = authMiddleware;