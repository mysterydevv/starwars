const {auth} = require('../config');
const bcrypt = require('bcrypt');
const logger = require('../logger/logger.config');
const jwt = require('jsonwebtoken');

const login = async (email,password) => {
    const user = await auth.getUserByEmail(email);
    if(!user){
        logger.warn('User not found, email: ' + email)
        throw new Error('User not found');
    }
    if(user.customClaims.password !== password){
        logger.warn('Invalid password, email: ' + email)
        throw new Error('Invalid password');
    }
    return await auth.createCustomToken(user.uid);
}

const register = async (email, password) => {
        const user =  await auth.createUser(
            {
                email: email,
                password: password,
                emailVerified: false,
                disabled: false,
            }
        );
        await auth.setCustomUserClaims(user.uid, {role: 'user', email: user.email, uid: user.uid,password: password});
        return user;
}

const getUserByToken = async (token) =>{
    const decodedToken = jwt.decode(token);
    logger.info('Decoded token', { decodedToken });
    const user = await auth.getUser(decodedToken.uid);
    logger.info('User found', { email: user.email });
    return {
        email: user.email,
        id: user.uid,
        role: user.customClaims.role,
        password: user.customClaims.password
    };
}


module.exports = { login, register, getUserByToken};