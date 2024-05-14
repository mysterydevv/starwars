const accountService = require('../services/account.service');
const Response = require('../utils/response');
const logger = require('../logger/logger.config');

const login = async (req, res) => {
    const { email,password} = req.body;
    try {
        const token = await accountService.login(email, password);
        logger.info('User logged in', { email });
        res.send(Response.success(token));
    }
    catch (error) {
        logger.error('Something went wrong', { error: error.message });
        res.send(Response.error(error.message));
    }
}

const register = async (req, res) => {
    const { email, password } = req.body;
    try {
        const user = await accountService.register(email, password);
        res.send(Response.success(user.uid));
    }
    catch (error) {
        res.send(Response.error(error.message));
    }
}

const userProfile = async (req, res) => {
    const token = req.headers.authorization;
    try {
        const user = await accountService.getUserByToken(token);
        res.send(Response.success(user));
    }
    catch (error) {
        res.send(Response.error(error.message));
        logger.error('Something went wrong', { error: error.message });
    }
}

module.exports = { login, register, userProfile };