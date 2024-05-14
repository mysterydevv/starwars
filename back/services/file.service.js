const {bucket} = require('../config');

const uploadImage = async (file) => {
    const {originalname, buffer} = file;
    const newFileName = `${Date.now()}_${originalname}`;
    const blob = bucket.file(newFileName);
    const blobWriter = blob.createWriteStream({
        metadata: {
            contentType: file.mimetype,

        }
    });
    blobWriter.end(buffer);
    return new Promise((resolve, reject) => {
        blobWriter.on('finish', () => {
            resolve(`${newFileName}`);
        });
        blobWriter.on('error', (err) => {
            reject(err);
        });
    });
}

const getFileStream = async (fileKey) => {
    const file = bucket.file(fileKey);
    const fileData = await file.download();
    const fileBuffer = fileData[0];
    return fileBuffer.toString('base64');
}


module.exports = {uploadImage, getFileStream};