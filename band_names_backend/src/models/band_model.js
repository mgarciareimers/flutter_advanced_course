const { v4: uuidV4 } = require('uuid');

class BandModel {
    constructor(name) {
       this.id = uuidV4();
       this.name = name;
       this.vote = 0;
    }
}

module.exports = BandModel;