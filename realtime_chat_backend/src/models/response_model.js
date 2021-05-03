class ResponseModel {
    constructor(success, message, data, error) {
        this.success = success;
        this.message = message;
        this.data = data;
        this.error = error;
    }

    // Method that gets thedata as json.
    toJson() {
        return {
            'success': this.success,
            'message': this.message,
            'data': this.data,
            'error': this.error,
        };
    }
}

module.exports = ResponseModel;