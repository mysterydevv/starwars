/**
 * @swagger
 * tags:
 *   name: Stuff
 *   description: API for managing stuff members
 *
 * /stuff/{memberId}:
 *   get:
 *     summary: Retrieve a specific member's stuff
 *     tags: [Stuff]
 *     parameters:
 *       - in: path
 *         name: memberId
 *         required: true
 *         schema:
 *           type: string
 *         description: The ID of the member to retrieve stuff for
 *     responses:
 *       200:
 *         description: A member's stuff retrieved successfully
 *       404:
 *         description: Member not found
 *
 * /stuff/all:
 *   get:
 *     summary: Retrieves all members
 *     tags: [Stuff]
 *     responses:
 *       200:
 *         description: All members retrieved successfully
 *
 *
 * /stuff/create:
 *   post:
 *     summary: Creates a new member
 *     tags: [Stuff]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - name
 *               - activity
 *               - image
 *             properties:
 *               name:
 *                 type: string
 *                 description: Name of the member
 *               activity:
 *                 type: string
 *                 description: Member's activity
 *               image:
 *                 type: string
 *                 description: URL path to the member's image
 *     responses:
 *       201:
 *         description: Member created successfully
 *       400:
 *         description: Bad request
 *
 * /stuff/update:
 *   put:
 *     summary: Updates a member
 *     tags: [Stuff]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - id
 *               - name
 *               - activity
 *               - image
 *             properties:
 *               id:
 *                 type: string
 *                 description: The ID of the member to update
 *               name:
 *                 type: string
 *                 description: Updated name of the member
 *               activity:
 *                 type: string
 *                 description: Updated activity of the member
 *               image:
 *                 type: string
 *                 description: Updated URL path to the member's image
 *     responses:
 *       200:
 *         description: Member updated successfully
 *       404:
 *         description: Member not found
 *       400:
 *         description: Bad request
 *
 * /stuff/delete/{id}:
 *   delete:
 *     summary: Deletes a member
 *     tags: [Stuff]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: The ID of the member to delete
 *     responses:
 *       200:
 *         description: Member deleted successfully
 *       404:
 *         description: Member not found
 */



const stuffController = require('../controllers/stuff.controller');

const express = require('express');

const router = express.Router();


router.get('/stuff/all', stuffController.getAllMembers);
router.get('/stuff/:memberId', stuffController.getStuffOfMember);
router.post('/stuff/create', stuffController.createStuffMember);
router.put('/stuff/update', stuffController.updateStuffMember);
router.delete('/stuff/delete/:id', stuffController.deleteStuffMember);

module.exports = router;