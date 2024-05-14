/**
 * @swagger
 * /upload:
 *   post:
 *     summary: Uploads an image file
 *     tags: [File]
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               file:
 *                 type: string
 *                 format: binary
 *                 description: Image file to be uploaded
 *     responses:
 *       200:
 *         description: Image uploaded successfully
 *       400:
 *         description: Bad request, incorrect file format or data
 *       500:
 *         description: Server error
 *
 * /image/{fileKey}:
 *   get:
 *     summary: Retrieves an image
 *     tags: [File]
 *     parameters:
 *       - in: path
 *         name: fileKey
 *         required: true
 *         schema:
 *           type: string
 *         description: The key of the file to retrieve
 *     responses:
 *       200:
 *         description: Image retrieved successfully
 *         content:
 *           image/png:
 *             schema:
 *               type: string
 *               format: binary
 *           image/jpeg:
 *             schema:
 *               type: string
 *               format: binary
 *       404:
 *         description: File not found
 *       500:
 *         description: Server error
 */




const fileController = require('../controllers/file.controller');
const express = require('express');
const multer = require('multer');
const router = express.Router();
const upload = multer({storage: multer.memoryStorage()});

router.post('/upload', upload.single('file'), fileController.uploadImage);
router.get('/image/:fileKey', fileController.getImage);

module.exports = router;