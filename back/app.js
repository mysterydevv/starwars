const express = require('express');
const cookieParser = require('cookie-parser');
const cors = require("cors");
const accountRouter = require('./routes/account.route');
const stuffRouter = require('./routes/stuff.route');
const fileRouter = require('./routes/file.route');
const actorRouter = require('./routes/actor.route');
const newsRouter = require('./routes/news.route');
const cinemaRouter = require('./routes/cinema.route');
const eventRouter = require('./routes/event.route');
const swaggerUi = require('swagger-ui-express');
const swaggerJsdoc = require('swagger-jsdoc');
const app = express();

const swaggerOptions = {
    definition: {
        openapi: '3.0.0',
        info: {
            title: 'Flutter Movie API',
            version: '1.0.0',
            description: 'A simple Express Library API',
        },
        servers: [
            {
                url: 'http://localhost:3000',
            },
        ],
    },
    apis: ['./routes/*.js'], // Path to the API docs
};

const swaggerDocs = swaggerJsdoc(swaggerOptions);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocs));


app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cors())
app.use(cookieParser());
app.use(accountRouter);
app.use(stuffRouter);
app.use(fileRouter);
app.use(actorRouter);
app.use(newsRouter);
app.use(cinemaRouter);
app.use(eventRouter);
app.listen(
    3000,
    () => console.log('Server is running on http://localhost:3000')
)
