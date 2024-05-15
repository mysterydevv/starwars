const admin = require('firebase-admin');
const serviceAccount = require('./flutter-movie-8a79d-firebase-adminsdk-8vl4z-24df37ccaa.json');
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});
const db = admin.firestore();
const auth = admin.auth();
const bucket = admin.storage().bucket('gs://flutter-movie-8a79d.appspot.com');

module.exports = { db, auth,bucket};