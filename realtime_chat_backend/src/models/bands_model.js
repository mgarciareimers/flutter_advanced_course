const BandModel = require("./band_model");

class BandsModel {
    constructor() {
        this.bands = [];
    }

    addBand(band = BandModel()) {
        this.bands.push(band);
        return this.bands;
    }

    get() {
        return this.bands;
    }

    deleteBand(id = '') {
        this.bands = this.bands.filter(band => band.id !== id);
        return this.bands;
    }

    voteBand(id = '') {
        this.bands = this.bands.map(band => {
            if (band.id === id) {
                band.votes++;
            }

            return band;
        });

        return this.bands;
    }
}

module.exports = BandsModel;