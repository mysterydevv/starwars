const {db} = require('../config');
const cinemaCollection = db.collection('cinema');

const createCinema = async (name,address,phone,places,image,feedback,) => {
    const cinema = {
        name,
        address,
        phone,
        places,
        image,
        feedback,
    }
    const cinemaRef = await cinemaCollection.add(cinema);
    return cinemaRef.id;
}

const getCinema = async (id) => {
    const cinemaRef = await cinemaCollection.doc(id).get();
    return {id: cinemaRef.id, ...cinemaRef.data()};
}


const getAllCinemas = async () => {
    const cinemas = [];
    const snapshot = await cinemaCollection.get();
    snapshot.forEach(doc => {
        cinemas.push({
            id: doc.id,
            ...doc.data()
        });
    });
    return cinemas;
}


const addFeedback = async (id, username,countOfStar,text) => {
    const feedback = {
        username,
        countOfStar,
        text,
    }
    const cinemaRef = cinemaCollection.doc(id);
    await cinemaRef.update({
        feedback: [...feedback]
    });
}

const placeOrder = async (id,places) => {
    const cinemaRef = cinemaCollection.doc(id);
    await cinemaRef.update({
        places: [...places]
    });
}

const updatePlace = async (id,place) => {
    const cinemaRef = cinemaCollection.doc(id);

// Получаем текущие данные кинотеатра
    const cinemaDoc = await cinemaRef.get();
    const places = cinemaDoc.data().places;

// Находим место с нужным номером и обновляем его данные
    const updatedPlaces = places.map((item) => {
        if (item.number === place.number) {
            return {
                ...item,
                isOrdered: place.isOrdered,
                email: place.email
            };
        }
        return item;
    });

// Обновляем документ в Firestore с новым массивом мест
    await cinemaRef.update({
        places: updatedPlaces
    });
}

module.exports = {
    createCinema,
    getCinema,
    getAllCinemas,
    addFeedback,
    placeOrder,
    updatePlace
}