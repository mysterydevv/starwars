/**
 * @swagger
 * /login:
 *   post:
 *     summary: Logs in a user
 *     tags: [Users]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - email
 *               - password
 *             properties:
 *               email:
 *                 type: string
 *                 format: email
 *                 description: User's email
 *               password:
 *                 type: string
 *                 format: password
 *                 description: User's password
 *     responses:
 *       200:
 *         description: User logged in successfully
 *       401:
 *         description: Invalid credentials
 *       500:
 *         description: Server error
 *
 * /register:
 *   post:
 *     summary: Registers a new user
 *     tags: [Users]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - email
 *               - password
 *             properties:
 *               email:
 *                 type: string
 *                 format: email
 *                 description: User's email
 *               password:
 *                 type: string
 *                 format: password
 *                 description: User's password
 *     responses:
 *       201:
 *         description: User registered successfully
 *       400:
 *         description: Bad request
 *       500:
 *         description: Server error
 *
 * /account:
 *   get:
 *     summary: Get full user profile
 *     description: Retrieve full information about the user based on the authentication token provided in the header.
 *     tags: [Users]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       '200':
 *         description: Successful retrieval of user profile
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 email:
 *                   type: string
 *                   description: User's email
 *                 uid:
 *                   type: string
 *                   description: User's unique id
 *                 role:
 *                   type: string
 *                   description: User's role
 *       '401':
 *         description: Unauthorized access, invalid or missing token
 *       '404':
 *         description: User not found
 *       '500':
 *         description: Internal server error
 *
 */

const accountController = require('../controllers/account.controller');
const authMiddleware = require('../middleware/AuthMiddleware');
const express = require('express');

const router = express.Router();

router.post('/login', accountController.login);
router.post('/register', accountController.register);
router.get('/account', authMiddleware, accountController.userProfile);

module.exports = router;