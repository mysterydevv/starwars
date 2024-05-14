const {db} = require('../config');


const actorTable = db.collection('actor');


const createActor = async (name,role,age,image,awards,movies,biography) => {
    const actor = {name,role,age,image,awards,movies,biography};
    const ref = await actorTable.add(actor);
    return ref.id;
}

const getActor = async (actorId) => {
    const snapshot = await actorTable.doc(actorId).get();
    return snapshot.data();
}

const getAllActors = async () => {
    const snapshot = await actorTable.get();
    return snapshot.docs.map(doc => ({
        id: doc.id,
        ...doc.data()
    }));
}

const updateActor = async (actorId, name,role,age,image,awards,movies,biography) => {
    const actor = {name,role,age,image,awards,movies,biography};
    await actorTable.doc(actorId).update(actor);
}

const deleteActor = async (actorId) => {
    await actorTable.doc(actorId).delete();
}

module.exports = {
    createActor,
    getActor,
    getAllActors,
    updateActor,
    deleteActor
}