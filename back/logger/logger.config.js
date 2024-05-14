const winston = require('winston');
const { ElasticsearchTransport } = require('winston-elasticsearch');
const { Client } = require('@elastic/elasticsearch');

const logOptions = {
    level : 'info',
    client : new Client({
        node: 'http://localhost:9200'
    }),
    index: 'flutter_movie_api',
    format : winston.format.combine(
        winston.format.timestamp(),
        winston.format.json()
    )
};

const logger = winston.createLogger({
    level: 'info',
    transports: [
        new ElasticsearchTransport(logOptions)
    ]
});

logger.add(
    new winston.transports.Console({
        format: winston.format.simple(),
    }),
)
module.exports = logger;