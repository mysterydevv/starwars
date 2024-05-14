/**
 * @swagger
 * tags:
 *   name: Actor
 *   description: API for managing actors
 *
 * /actor/all:
 *   get:
 *     summary: Retrieves all actors
 *     tags: [Actor]
 *     responses:
 *       200:
 *         description: All actors retrieved successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Actor'
 *
 * /actor/{id}:
 *   get:
 *     summary: Retrieves a single actor by ID
 *     tags: [Actor]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: The ID of the actor to retrieve
 *     responses:
 *       200:
 *         description: Actor retrieved successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Actor'
 *       404:
 *         description: Actor not found
 *
 * /actor/create:
 *   post:
 *     summary: Creates a new actor
 *     tags: [Actor]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Actor'
 *     responses:
 *       201:
 *         description: Actor created successfully
 *       400:
 *         description: Bad request
 *
 * /actor/update/{id}:
 *   put:
 *     summary: Updates an existing actor
 *     tags: [Actor]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: The ID of the actor to update
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Actor'
 *     responses:
 *       200:
 *         description: Actor updated successfully
 *       404:
 *         description: Actor not found
 *       400:
 *         description: Bad request
 *
 * /actor/delete/{id}:
 *   delete:
 *     summary: Deletes an actor
 *     tags: [Actor]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: The ID of the actor to delete
 *     responses:
 *       200:
 *         description: Actor deleted successfully
 *       404:
 *         description: Actor not found
 *
 * components:
 *   schemas:
 *     Actor:
 *       type: object
 *       required:
 *         - name
 *         - role
 *         - age
 *         - image
 *         - awards
 *         - films
 *         - biography
 *       properties:
 *         name:
 *           type: string
 *           description: Name of the actor
 *         role:
 *           type: string
 *           description: Most known role of the actor
 *         age:
 *           type: integer
 *           format: int32
 *           description: Age of the actor
 *         image:
 *           type: string
 *           description: URL to an image of the actor
 *         awards:
 *           type: array
 *           items:
 *             type: string
 *           description: List of awards won by the actor
 *         films:
 *           type: array
 *           items:
 *             type: string
 *           description: List of films the actor has been in
 *         biography:
 *           type: string
 *           description: Biography of the actor
 */



const actorController = require('../controllers/actor.controller');
const express = require('express');
const router = express.Router();

router.get('/actor/all', actorController.getAllActors);
router.get('/actor/:id', actorController.getActor);
router.post('/actor/create', actorController.createActor);
router.put('/actor/update/:id', actorController.updateActor);
router.delete('/actor/delete/:id', actorController.deleteActor);


module.exports = router;