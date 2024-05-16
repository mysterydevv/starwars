const admin = require('firebase-admin');
const serviceAccount = require('./orbis2-d7481-firebase-adminsdk-weqc2-d9b6482e29.json');
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});
const db = admin.firestore();
const auth = admin.auth();
const bucket = admin.storage().bucket('gs://flutter-movie-8a79d.appspot.com');

module.exports = { db, auth,bucket};