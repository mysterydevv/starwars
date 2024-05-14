class Response{
    constructor(status, message, data){
        this.status = status;
        this.message = message;
        this.data = data;
    }

    static success(data){
        return new Response(200, null, data);
    }
    static error(message){
        return new Response(400, message, null);
    }
    static unauthorized(message){
        return new Response(401, message, null);
    }
}

module.exports = Response;